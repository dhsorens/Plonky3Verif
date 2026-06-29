# goldilocks — pre-extraction Rust source patch

`patches/p3_goldilocks.src.patch` is a **behaviour-preserving** rewrite applied to
`goldilocks/src/**` *only for the duration of a `cargo hax into lean` run*
(applied, extracted, reverted — see `../lean/extraction/build-proofs.sh`). Never
committed into the source tree; `git status` is clean before and after.

## What it does

Same recipe as `monty-31`/`mersenne-31` (see those for the full rationale). Every
`#[cfg]` that *selects* a SIMD packing — aarch64 NEON, x86_64 AVX2/AVX512, **wasm32
simd128** — gets `, not(hax)`; every `#[cfg]` selecting the portable path
(`not(any(…))` or the poseidon `not(target_arch = "aarch64")` fallbacks) is made
additionally true under `hax`. Under `--cfg hax` goldilocks therefore compiles as
the portable `type Packing = Self` field. Touched: `lib.rs`, `goldilocks.rs`,
`poseidon1.rs`, `poseidon2.rs`. (goldilocks has no DFT module.)

## Why behaviour-preserving

`cargo build`/`cargo test` never define `hax`, so `all(…, not(hax)) ≡ all(…)` and
`any(hax, X) ≡ X`. Every cfg evaluates exactly as before for a normal build; the
patch only changes what is selected **under `--cfg hax`** (extraction-only).

## Classification

**Class A** — adds nothing to the TCB beyond the fact that the extracted field
semantics are the portable path (not the SIMD packings). See `../lean/extraction/TCB.md`.
