# monty-31 — pre-extraction Rust source patch

`patches/p3_monty_31.src.patch` is a **behaviour-preserving** rewrite applied to
`monty-31/src/**` *only for the duration of a `cargo hax into lean` run* (applied,
extracted, reverted — see `../lean/extraction/build-proofs.sh`). It is never
committed into the source tree; `git status` is clean before and after a build.

## What it does

monty-31 ships hand-written SIMD packings of `MontyField31` — `aarch64_neon/`,
`x86_64_avx2/`, `x86_64_avx512/` — plus a portable `no_packing/` fallback. The
SIMD modules use vendor intrinsics (`uint32x4_t`, `vld1q_u32`, …) that hax cannot
model. On the aarch64 extraction host the `neon` path is the *active* one, so hax
would either choke on the intrinsics or emit hundreds of unbuildable references.

The patch adds a `not(hax)` term to every SIMD-**selecting** `#[cfg]` and makes
every **portable-selecting** `#[cfg]` additionally true under `hax`, so that
during extraction (where `cargo hax` always passes `--cfg hax`) the crate
compiles as if no SIMD target feature were enabled — i.e. the `no_packing` path.

The five cfg shapes rewritten (uniformly, across `lib.rs`, `data_traits.rs`,
`monty_31.rs`, `poseidon1.rs`, `poseidon2.rs`, `dft/forward.rs`):

| original | rewritten |
|----------|-----------|
| `#[cfg(all(…neon))]` | `#[cfg(all(…neon, not(hax)))]` |
| `#[cfg(all(…avx2, not(avx512f)))]` | `… , not(hax)))]` |
| `#[cfg(all(…avx512f))]` | `#[cfg(all(…avx512f, not(hax)))]` |
| `#[cfg(not(any(…neon/avx…)))]` (no_packing) | `#[cfg(any(hax, not(any(…))))]` |
| `#[cfg(not(all(…neon)))]` (dft fallback) | `#[cfg(any(hax, not(all(…))))]` |

## Why it is behaviour-preserving

`cargo build` / `cargo test` never define the `hax` cfg, so:
- `all(…, not(hax))` ≡ `all(…)` (since `not(hax)` ≡ `not(false)` ≡ `true`), and
- `any(hax, X)` ≡ `any(false, X)` ≡ `X`.

Every cfg therefore evaluates exactly as before for a normal build. The patch
only changes what gets selected **under `--cfg hax`**, which is extraction-only.
It is regenerated with `git diff -- monty-31/src` after editing the cfgs; the
mechanical transform lives in the build/notes, not committed as a script.

## Classification

This is a **Class A** rewrite (behaviour-preserving, stays in safe Rust) — it does
**not** add anything to the trusted computing base. It only drops code paths that
were already unused on the extraction target. The dropped SIMD packings are an
optimization of the portable path; the field semantics extracted are those of
`no_packing` (`type Packing = Self`).
