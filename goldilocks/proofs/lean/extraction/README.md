# p3-goldilocks — Lean extraction (compiles)

Hax-extracted Lean for `p3-goldilocks` (the 64-bit prime field `F_p`,
`p = 2^64 - 2^32 + 1`, plus its quadratic/cubic extension fields), built with Lake.
`lake build` **succeeds** with `sorry` warnings — this **type-checks, it does not
verify** (see [`TCB.md`](TCB.md)).

## Build

```bash
cd goldilocks/proofs/lean/extraction
lake build              # compiles p3_goldilocks.lean (committed, already patched)
# or regenerate from Rust source first:
./build-proofs.sh
```

`build-proofs.sh` applies the pre-extraction **Rust source patch** → `cargo hax
into lean` (isolated target dir) → reverts the patch → snapshots pristine → applies
the **Lean patch** → `lake build`. The crate `src/` is git-clean before and after.

## Two patches (same recipe as monty-31 / mersenne-31)

| Patch | Path | Role |
|-------|------|------|
| Rust source | `../rust-patch/patches/p3_goldilocks.src.patch` | gates the SIMD modules (aarch64 NEON / x86_64 AVX2,AVX512 / **wasm32 simd128**) off under `--cfg hax`, forcing the portable `type Packing = Self` path. Behaviour-preserving for normal builds. See [`../rust-patch/README.md`](../rust-patch/README.md). |
| Lean output | `patches/p3_goldilocks.patch` | the hand-reconciliation: redirect imports to the stubs, strip bogus `with`-overrides, `(by rfl)`→`(by sorry)`, `Debug` `fmt`→`dbg_fmt`, `sorry` the dependency-trait instances, the forward-referencing arith/field instances & defs, and the constant tables; one cmp-trait reorder. Regenerate with `patches/update-patch.sh`. |

## Scope — field dependencies stubbed; no DFT

goldilocks implements the full `p3-field` hierarchy (incl. the quadratic/cubic
`ExtField` and the `complex`/cubic extension traits) and references
`p3-mds`/`p3-poseidon`/`p3-symmetric`, plus a `p3-dft` Radix-2 Bowers FFT for one
MDS permutation. Those dependency crates are **stubbed** (`p3_goldilocks/*.lean`),
not extracted. goldilocks's *own* types (`Goldilocks`, the extension fields, the
field-arith impls, the Poseidon layer params) **are** the real extraction — though
the large constant tables (`MATRIX_CIRC_MDS_*`, `GOLDILOCKS_POSEIDON2_RC_*`, …) and
a few 64-bit field helpers are `sorry`-d (see `TCB.md`). goldilocks has no DFT
*module* of its own.

## Layout

| Path | Role |
|------|------|
| `p3_goldilocks.lean` | hax output + Lean patch. |
| `p3_goldilocks/p3_field.lean` | stubbed `p3-field` hierarchy (incl. `ExtField`/`PackedExtField`, `complex.*`, cubic `CubicTrinomial*`/`HasTwoAdicCubicExtension`, `BasedVectorSpace`, `ExtensionField`). |
| `p3_goldilocks/{p3_mds,p3_dft,p3_symmetric,p3_poseidon1,p3_poseidon2,p3_challenger}.lean` | stubbed trait classes / Poseidon structs / Radix2Bowers / `apply_circulant_fft`. |
| `p3_goldilocks/p3_util.lean` | `p3-util` free fns (`branch_hint`, `gcd_inner`, `flatten_to_base`). |
| `p3_goldilocks/core_shims.lean` | proof-lib gaps: `overflowing_*`/`wrapping_*` (32/64-bit), 128-bit `Cast`, `Cast Bool u64`/`From u64 Bool`, `iter::{Sum,Product}`, `Iterator::{map,sum}`, `Ord::min`, `Hasher::write_{u32,u64}`, `Impl_3.MIN`, `Display {u32,u64}`. |
| `p3_goldilocks/{num_bigint,rand,serde}.lean` | minimal external-crate stubs. |
| `lakefile.toml`, `lean-toolchain`, `lake-manifest.json` | Lake package (lib `p3_goldilocks`; requires **Hax** only). |
| `build-proofs.sh`, `patches/` | regeneration pipeline + Lean patch + `update-patch.sh`. |

`.lake/` is gitignored; `.lake/packages` symlinks to koala-bear's built packages.
`cargo hax` also emits `wasm_bench.lean`/`wasm_smoke.lean` from `src/bin/`; these
are not part of the library and are gitignored.
