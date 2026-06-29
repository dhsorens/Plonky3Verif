# goldilocks extraction — Trusted Computing Base

What you must trust **beyond** the usual base (hax frontend + engine, Lean kernel,
Hax proof-lib, Lake/toolchain pins). Crate-specific `sorry`s and patches only. The
extraction **type-checks; it does not verify.**

Snapshot: `p3_goldilocks.lean` ≈ 1694 lines, **110 `sorry`**.
Source patch ≈ 258 lines; Lean patch ≈ 5918 lines (the large size is mostly
*deletions* of sorried constant tables).

## 1. Pre-extraction Rust source patch (`../rust-patch/`)

`p3_goldilocks.src.patch` adds `not(hax)` / `any(hax, …)` terms to the `#[cfg]`s
selecting goldilocks's SIMD packings (aarch64 NEON / x86_64 AVX2,AVX512 / wasm32
simd128) so under `--cfg hax` the crate compiles via the portable
`type Packing = Self` path. **Class A (behaviour-preserving).** Adds to the TCB
only that the extracted field semantics are the **portable** path (not the SIMD
packings, which are not extracted/verified).

## 2. Field/dependency stubs (`p3_goldilocks/*.lean`)

The `p3-field`, `p3-mds`, `p3-dft`, `p3-poseidon{1,2}`, `p3-symmetric` hierarchies
are **hand-written stubs**, not extractions, trusted to mirror the real crates'
interfaces (class arities, associated types `Field…Packing`,
`PrimeCharacteristicRing…PrimeSubfield`, `ExtensionField…ExtensionPacking`, and the
projected consts/methods). `ExtField`/`PackedExtField`, the `complex.*` and cubic
extension traits, and `p3_dft.radix_2_bowers.Radix2Bowers` are opaque/empty stubs.
`num_bigint`, `rand`, `serde` are minimal stubs.

## 3. `core_shims.lean` — proof-lib gaps

- `core_models.num.{overflowing_sub, overflowing_add, wrapping_add_signed,
  wrapping_neg}` (32- and 64-bit) and `Impl_3.MIN` — filtered out / absent in the
  proof-lib; stubbed (overflow flag not modelled; `MIN` is `sorry`).
- **128-bit `Cast` instances** and **`Cast Bool u64` / `From u64 Bool`** — the
  proof-lib's cast macro stops at `usize` and lacks bool conversions; these have
  **`sorry` values**.
- `iter::{Sum, Product}`, `Iterator::{map, sum}`, `Ord::min`,
  `Hasher::write_{u32,u64}`, `Display {u32,u64}` — stubbed (`sorry` where bodied),
  irrelevant to field semantics.

## 4. `sorry`s in the Lean patch (`patches/p3_goldilocks.patch`)

- **`(by rfl)` → `(by sorry)`** on opaque-transmute field constants.
- **Bogus `(associatedTypes := { … with … })` overrides stripped.**
- **`Debug` instance field `fmt` → `dbg_fmt`** (engine↔proof-lib name skew; `Display`
  keeps `fmt`).
- **Dependency-trait instances `sorry`-d** (whole-instance `:= sorry`): instances of
  the stubbed `p3-field`/`p3-mds`/`p3-poseidon`/`p3-symmetric`/`rand`/`serde` classes
  whose bodies provided methods the empty stubs lack.
- **Arith / cmp / convert instances `sorry`-d**: the `core_models.ops.arith.*`,
  `core_models.cmp.{PartialEq,Eq,PartialOrd,Ord}`, `core_models.convert.{Into,From}`
  impls for `Goldilocks` and its extension/packed variants — they mutually
  forward-reference each other; whole-instance `:= sorry` breaks the cycle.
- **Forward-referencing / data `def` bodies `sorry`-d** (≈47): the constant tables
  (`MATRIX_CIRC_MDS_*`, `MATRIX_DIAG_*`, `GOLDILOCKS_POSEIDON{1,2}_RC_*`,
  `*.permute.*`, `Impl_2.{new_array, new_2d_array, NEG_ORDER, POWERS_OF_TWO,
  TWO_ADIC_GENERATORS}`, …) and field helpers (`reduce128`, `const_add`,
  `from_unusual_int`, `add_no_canonicalize_trashing_input`, `gcd_inversion`,
  `internal_layer_mat_mul_goldilocks_{8,12,16}`). These either forward-reference
  helpers/instances declared later or use the generic `Algebra`-bound `Dup`/`Add`/
  `Sub` operations the empty stub doesn't carry. **The constant tables and these
  helpers are therefore NOT part of the verified surface** — a key caveat for
  goldilocks: more of its arithmetic is `sorry`-d than for monty-31.
- **One reorder (not a `sorry`)**: the `PartialEq`/`Eq` `AssociatedTypes` instances
  for `Goldilocks` are moved before `PartialOrd`/`Ord` (which extend them).

Everything else (the `Goldilocks` field structure, the extension field structures,
and the non-tabular arithmetic) is the real hax extraction, trusted only as far as
the hax toolchain itself.
