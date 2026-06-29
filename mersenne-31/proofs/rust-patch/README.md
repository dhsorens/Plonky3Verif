# mersenne-31 — pre-extraction Rust source patch

`patches/p3_mersenne_31.src.patch` is a **behaviour-preserving** rewrite applied to
`mersenne-31/src/**` *only for the duration of a `cargo hax into lean` run*
(applied, extracted, reverted — see `../lean/extraction/build-proofs.sh`). It is
never committed into the source tree; `git status` is clean before and after.

## What it does

Same recipe as `monty-31` (see that crate's `rust-patch/README.md` for the full
rationale). Two groups of edits, both gated on the `hax` cfg that
`cargo hax into lean` always sets:

1. **SIMD packings** (`aarch64_neon/`, `x86_64_avx2/`, `x86_64_avx512/`): every
   `#[cfg]` that *selects* a SIMD path gets `, not(hax)`; every `#[cfg]` that
   selects the portable `no_packing` path (`not(any(…))`) is wrapped `any(hax, …)`.
   Under `--cfg hax` the crate therefore compiles as the portable
   `type Packing = Self` field. Touched: `lib.rs`, `mersenne_31.rs`,
   `poseidon1.rs`, `poseidon2.rs` (incl. the neon-only
   `batched_columnwise_dot_product` trait-default override, which falls back to
   the trait default when dropped).

2. **DFT modules** (`dft`, `radix_2_dit`): gated `#[cfg(not(hax))]` on their `mod`
   declarations and `pub use` re-exports. These implement `p3_dft`'s
   `TwoAdicSubgroupDft` over `p3_matrix` types — FFT machinery, not field
   arithmetic — so excluding them from extraction avoids stubbing the whole
   `p3-dft`/`p3-matrix` surface. (`complex` and `qm31`, the Mersenne31 complex /
   quartic *extension fields*, are kept and extracted.)

## Why it is behaviour-preserving

`cargo build`/`cargo test` never define the `hax` cfg, so `all(…, not(hax)) ≡
all(…)` and `any(hax, X) ≡ X` and `cfg(not(hax))` items are always present. Every
cfg evaluates exactly as before for a normal build; the patch only changes what is
selected **under `--cfg hax`** (extraction-only).

## Classification

**Class A** (behaviour-preserving, safe Rust) — adds nothing to the TCB beyond the
facts that the extracted field semantics are the *portable* path (not the SIMD
packings) and that the *DFT* is excluded from extraction. See `../lean/extraction/TCB.md`.
