# Trusted computing base — keccak aeneas-backend extraction

What must be trusted, beyond the toolchain itself (hax `e11615541` frontend,
charon `nightly-2026.07.24`, aeneas `nightly-2026.08.18-ae2f343` [cryspen
fork], the `hax-lean` v0.3.0 + Aeneas Lean libraries, and Lean/Lake), for
theorems about this extraction to say something about the Rust.

## Axioms (hand-declared externals)

| Axiom | Models | Why trusted |
| --- | --- | --- |
| `tiny_keccak.keccak.Keccak` (type), `.v256`, `…Tiny_keccakHasher.update`, `…finalize` | the `tiny_keccak` crate's sponge | external crates.io dependency; not extracted |
| `tiny_keccak.keccakf.keccakf` | the Keccak-f[1600] permutation itself | external; **the core primitive is trusted, not verified** |
| `p3_util.apply_to_chunks` | `p3_util`'s chunked-feed combinator | dependency-crate fn the pipeline did not extract (used by `hash_iter`) |
| `core.intrinsics.transmute` | `&mut`-transmute in `fallback.rs` | no model in hax-lean/aeneas |
| `KeccakF/Keccak256Hash.Insts.CoreFmtDebug.fmt` | `derive(Debug)` formatters | aeneas emits `Unreachable` for derive bodies; irrelevant to hashing semantics |

## Hand-modeled trait declarations (TypesExternal.lean)

`p3_symmetric.permutation.Permutation` / `CryptographicPermutation` /
`p3_symmetric.hasher.CryptographicHasher` — the pipeline emits no declarations
for dependency-crate traits, so these structures are hand-written in aeneas's
trait encoding. Risk: a mismatch against what a future extracted
`p3_symmetric` would generate. `CryptographicHasher.hash_iter_slices` takes an
**extra explicit `Iterator` instance** (hax-lean's `IntoIterator` carries no
Iterator clause for its `IntoIter` type) — a deliberate signature deviation,
threaded by `patches/reconcile.py`.

## Reconciliation rewrites (patches/reconcile.py)

Deterministic post-extraction edits of generated code — semantics-preserving
by inspection, but they are edits of generated code: duplicate Clone-clause
field renames; the `hash_iter_slices` loop-cluster Iterator threading
(replaces an `aeneas type_var_id` `sorry` and a projection of a field the
proof-lib doesn't have); closure `call_mut`/`call_once` reshaped from aeneas's
backward-function encoding to CoreModels' state-threading encoding.

## Known defect (do not build proofs on it)

`KeccakF.Insts.P3_symmetricPermutationPermutationArrayArrayU64125.permute_mut`
(the `fallback.rs` `[[u64;1];25]` path) **discards the permuted state** — the
generator's `&mut`-transmute translation binds the writeback before the
permutation call. Generator defect, kept only so the file compiles. The scalar
`[u64;25]` path (`…PermutationArrayU6425.permute_mut`) is the correct one.

## Source patches (pre-extraction, behaviour-preserving)

`keccak`'s SIMD gating plus `p3-field`/`p3-symmetric` hax gates
(`*/proofs/rust-patch/patches/*.src.patch`) — all `#[cfg]`-based: a normal
build (no `hax` cfg) compiles the original code, so the extracted artifact
corresponds to the portable scalar path of the committed sources.

No `sorry` remains in the built package (`lake build` is green).
