# p3-mersenne-31 — Lean extraction (compiles)

Hax-extracted Lean for `p3-mersenne-31` (the prime field `F_p`, `p = 2^31 - 1`,
plus its complex/quartic extension fields `Mersenne31Complex`/`QM31`), built with
Lake. `lake build` **succeeds** with `sorry` warnings — this **type-checks, it
does not verify** (see [`TCB.md`](TCB.md)).

## Build

```bash
cd mersenne-31/proofs/lean/extraction
lake build              # compiles p3_mersenne_31.lean (committed, already patched)
# or regenerate from Rust source first:
./build-proofs.sh
```

`build-proofs.sh` applies the pre-extraction **Rust source patch** → `cargo hax
into lean` (isolated target dir) → reverts the patch → snapshots the pristine
output → applies the **Lean patch** → `lake build`. The crate `src/` is git-clean
before and after. Note `cargo hax` exits non-zero here (HAX0001 / issue #1923 on
`qm31.rs`'s `from_basis_coefficients_*`) but still writes a usable file; the script
tolerates this and judges success from `lake build`.

**Syncing with upstream:** governed by the repo-root
[`SYNC.md`](../../../../SYNC.md); this crate's steps are in [`SYNC.md`](SYNC.md).

## Two patches (same recipe as monty-31)

| Patch | Path | Role |
|-------|------|------|
| Rust source | `../rust-patch/patches/p3_mersenne_31.src.patch` | gates the SIMD modules (NEON/AVX2/AVX512) **and** the DFT modules (`dft`, `radix_2_dit`) off under `--cfg hax`. Behaviour-preserving for normal builds. See [`../rust-patch/README.md`](../rust-patch/README.md). |
| Lean output | `patches/p3_mersenne_31.patch` | the hand-reconciliation: redirect imports to the stubs, strip bogus `with`-overrides, `(by rfl)`→`(by sorry)`, `Debug` `fmt`→`dbg_fmt`, and `sorry` the dependency-trait instances / forward-referencing arith & field bodies. Regenerate with `patches/update-patch.sh`. |

## Scope — field dependencies stubbed; DFT excluded

mersenne-31 implements the full `p3-field` hierarchy (incl. `BasedVectorSpace`,
`ExtensionField`, the `complex` extension traits) and references
`p3-mds`/`p3-poseidon`/`p3-symmetric`. Per the current goal those dependency
crates are **stubbed** (`p3_mersenne_31/*.lean`), not extracted. The DFT modules
(`dft`, `radix_2_dit`, which implement `p3-dft`'s `TwoAdicSubgroupDft` over
`p3-matrix`) are **excluded from extraction** by the source patch — FFT machinery,
not field arithmetic. mersenne-31's *own* types (`Mersenne31`, `Mersenne31Complex`,
`QM31`, the field-arith impls, the Poseidon layer params) **are** the real extraction.

## Layout

| Path | Role |
|------|------|
| `p3_mersenne_31.lean` | hax output + Lean patch (the real mersenne-31 extraction). |
| `p3_mersenne_31/p3_field.lean` | stubbed `p3-field` hierarchy (incl. `ExtField`/`PackedExtField`, `complex.*`, `BasedVectorSpace`, `ExtensionField`, `PackedFieldExtension`). |
| `p3_mersenne_31/{p3_mds,p3_symmetric,p3_poseidon1,p3_poseidon2,p3_challenger}.lean` | stubbed trait classes / Poseidon structs. |
| `p3_mersenne_31/p3_util.lean` | `p3-util` free fns (`as_base_slice`, `flatten_to_base`, `gcd_inversion_prime_field_32`, …). |
| `p3_mersenne_31/core_shims.lean` | proof-lib gaps: `overflowing_*`, 128-bit `Cast`, `iter::{Sum,Product}`, `Iterator::{map,sum}`, `Ord::min`, `Hasher::write_u32`, `Display u32`. |
| `p3_mersenne_31/{num_bigint,rand,serde}.lean` | minimal external-crate stubs. |
| `p3_mersenne_31/dependencies.lean` | import aggregator. |
| `lakefile.toml`, `lean-toolchain`, `lake-manifest.json` | Lake package (lib `p3_mersenne_31`; requires **Hax** only). |
| `build-proofs.sh`, `patches/` | regeneration pipeline + Lean patch + `update-patch.sh`. |

`.lake/` is gitignored; `.lake/packages` symlinks to koala-bear's built packages.
