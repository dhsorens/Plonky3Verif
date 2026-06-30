# koala-bear — pre-extraction Rust source patch

`patches/p3_koala_bear.src.patch` gates koala-bear's SIMD modules (aarch64 NEON,
x86_64 AVX2/AVX512) off under the `hax` cfg, applied/reverted around extraction by
`../lean/extraction/build-proofs.sh`. Behaviour-preserving for a normal build
(`all(…, not(hax)) ≡ all(…)` when `hax` is unset). Same recipe as monty-31/baby-bear.

**Important:** `build-proofs.sh` applies BOTH this patch AND
`monty-31/proofs/rust-patch/patches/p3_monty_31.src.patch` during extraction.
`cargo hax into lean` only passes `--cfg hax` to the primary crate (koala-bear), so
the monty-31 dependency would otherwise compile with SIMD enabled — its
`data_traits` would then require the `MontyParametersNeon` supertrait that
koala-bear's (gated) `aarch64_neon` module used to satisfy, breaking the build. With
both gated, the whole build takes the portable path and koala-bear's extraction
references monty-31's portable namespaces (matching the monty-31 Lean package).

**Class A** (behaviour-preserving). Adds to the TCB only that the extracted field
semantics are the portable path (not the SIMD packings). See `../lean/extraction/TCB.md`.

(Historical note: before depending on the extracted monty-31, koala-bear's
extraction kept the SIMD/NEON references and stubbed them in a hand-written
`p3_monty_31` stub. It now drops SIMD and consumes the real monty-31 package.)
