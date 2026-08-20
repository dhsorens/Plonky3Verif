# p3-monty-31 — Lean extraction (compiles)

Hax-extracted Lean for `p3-monty-31` (the `MontyField31` backend shared by
`baby-bear` and `koala-bear`), built with Lake. `lake build` **succeeds** with
`sorry` warnings — this **type-checks, it does not verify** (see [`TCB.md`](TCB.md)).

## Build

```bash
cd monty-31/proofs/lean/extraction
lake build              # compiles p3_monty_31.lean (committed, already patched)
# or regenerate from Rust source first:
./build-proofs.sh
```

`build-proofs.sh` runs the full pipeline: apply the pre-extraction **Rust source
patch** → `cargo hax into lean` (isolated target dir) → revert the source patch →
snapshot the pristine output → apply the **Lean patch** → `lake build`. The crate
`src/` is git-clean before and after.

**Syncing with upstream:** governed by the repo-root
[`SYNC.md`](../../../../SYNC.md); this crate's re-extract/reconcile steps are in
[`SYNC.md`](SYNC.md).

## Two patches

Unlike `koala-bear` (which patches only the Lean output), monty-31 needs a small
**pre-extraction Rust source patch** as well, because monty-31 — unlike koala —
*extracts its own backend code*, including SIMD packings hax cannot model.

| Patch | Path | Role |
|-------|------|------|
| Rust source | `../rust-patch/patches/p3_monty_31.src.patch` | gates the SIMD modules (NEON/AVX2/AVX512) **and** the `dft` module off under `--cfg hax`, so extraction sees the portable `no_packing` path. Behaviour-preserving for normal builds. See [`../rust-patch/README.md`](../rust-patch/README.md). |
| Lean output | `patches/p3_monty_31.patch` | the hand-reconciliation: redirect imports to the stubs, `(by rfl)`→`(by sorry)` on opaque-transmute field constants, and `sorry` a handful of trait default / forward-referencing instance bodies. Regenerate with `patches/update-patch.sh`. |

## Scope — field dependencies are stubbed, not extracted

monty-31 implements the full `p3-field` trait hierarchy and references
`p3-mds`/`p3-poseidon`/`p3-symmetric`. Per the current goal we do **not** extract
those dependency crates (that's deferred); instead `p3_monty_31/*.lean` provides
hand-written **stubs** (trait classes with the correct arities + the handful of
associated types / methods actually projected). monty-31's *own* types
(`MontyField31`, `data_traits`, the Poseidon layer params, the field-arith impls)
**are** the real extraction.

## Layout

| Path | Role |
|------|------|
| `p3_monty_31.lean` | hax output + Lean patch (the real monty-31 extraction). |
| `p3_monty_31/p3_field.lean` | stubbed `p3-field` trait hierarchy (PrimeCharacteristicRing, Field, PrimeField{,32,64}, TwoAdicField, QuotientMap, the extension traits, …). |
| `p3_monty_31/{p3_mds,p3_symmetric,p3_poseidon1,p3_poseidon2,p3_challenger}.lean` | stubbed trait classes for those crates. |
| `p3_monty_31/core_shims.lean` | proof-lib gaps: `overflowing_sub`/`wrapping_add_signed`, the 128-bit `Cast` instances, `iter::{Sum,Product}`, `Display u32`. |
| `p3_monty_31/{num_bigint,rand,serde}.lean` | minimal stubs for those external crates' referenced items. |
| `p3_monty_31/dependencies.lean` | import aggregator (the generated file `import`s this). |
| `lakefile.toml`, `lean-toolchain`, `lake-manifest.json` | Lake package (lib `p3_monty_31`; requires **Hax** only). |
| `build-proofs.sh`, `patches/` | regeneration pipeline + Lean patch + `update-patch.sh`. |

`.lake/` is gitignored; `.lake/packages` symlinks to koala-bear's built packages
to reuse Hax. On a fresh checkout, `lake build` resolves Hax per the manifest.
