# keccak — pre-extraction Rust source patch

`patches/p3_keccak.src.patch` is a **behaviour-preserving** rewrite applied to
`keccak/src/**` *only for the duration of a `cargo hax into lean` run* (applied,
extracted, reverted — see `../lean/extraction/build-lean.sh`). It is never
committed into the source tree; `git status` is clean before and after a build.

Added 2026-07-27, replacing the old `-C target-feature=-sha3` mechanism.

## What it does

keccak ships several hand-written SIMD backends of the Keccak-f permutation —
`neon_sha3.rs`, `neon.rs` (aarch64), `avx512.rs`, `avx2.rs`, `sse2.rs` (x86_64) —
plus a portable `fallback.rs` that just calls `tiny_keccak::keccakf`. The SIMD
modules use vendor intrinsics (`uint64x2_t`, `veorq_u64`, …) and
`unsafe { transmute(…) }` that hax cannot model.

The patch adds a `not(hax)` term to every SIMD-**selecting** `#[cfg]` and makes
the **portable-selecting** `#[cfg]` additionally true under `hax`, so that during
extraction (where `cargo hax` always passes `--cfg hax`) the crate compiles as if
neither `neon` nor any x86 SIMD feature were available — i.e. the `fallback` path.

The cfg shapes rewritten (all in `src/lib.rs`, each appearing twice — once for
`mod`, once for `pub use`):

| original | rewritten |
|----------|-----------|
| `#[cfg(all(…x86_64, avx512f))]` | `#[cfg(all(…x86_64, avx512f, not(hax)))]` |
| `#[cfg(all(…x86_64, avx2, not(avx512f)))]` | `… , not(hax)))]` |
| `#[cfg(all(…x86_64, not(avx2)))]` | `#[cfg(all(…x86_64, not(avx2), not(hax)))]` |
| `#[cfg(all(…aarch64, neon, sha3))]` | `… , not(hax)))]` |
| `#[cfg(all(…aarch64, neon, not(sha3)))]` | `… , not(hax)))]` |
| `#[cfg(not(any(all(aarch64, neon), x86_64)))]` (fallback) | `#[cfg(any(hax, not(any(…))))]` |

## Why it is behaviour-preserving

`cargo build` / `cargo test` never define the `hax` cfg, so:
- `all(…, not(hax))` ≡ `all(…)` (since `not(hax)` ≡ `not(false)` ≡ `true`), and
- `any(hax, X)` ≡ `any(false, X)` ≡ `X`.

Every cfg therefore evaluates exactly as before for a normal build; on this
aarch64 host `neon` is still a default target feature, so normal builds still take
the NEON path. The patch only changes what gets selected **under `--cfg hax`**,
which is extraction-only.

(Under the patch, a *normal* build does emit 12 cosmetic
`unexpected cfg condition name: hax` warnings — but since the patch is reverted
before the build ends, the committed tree never produces them.)

## Why not `-C target-feature=…`

Until upstream [#1925](https://github.com/Plonky3/Plonky3/pull/1925) it was enough
to extract with `-C target-feature=-sha3`: that made the `neon+sha3` gate false
and fell through to `fallback`. #1925 added a plain-NEON, non-SHA3 aarch64 backend
(`src/neon.rs`), so `-sha3` alone now selects *that* instead.

Extending it to `-C target-feature=-sha3,-neon` does reach `fallback`, but rustc
then emits

```
warning: target feature `neon` must be enabled to ensure that the ABI of the
         current target can be implemented correctly
note: ... will become a hard error in a future release!
```

and hax's frontend driver treats that future-incompat diagnostic as fatal
(`ERROR rustc emitted an error, aborting hax custom driver`) — no `.lean` is
written. Hence the source patch, which is also robust to upstream adding further
backends.

## Regenerating

Edit the cfgs in `keccak/src/lib.rs` per the table above, then:

```sh
git diff -- keccak/src > keccak/proofs/rust-patch/patches/p3_keccak.src.patch
git checkout -- keccak/src
```
