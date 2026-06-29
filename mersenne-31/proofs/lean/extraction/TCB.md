# mersenne-31 extraction — Trusted Computing Base

What you must trust **beyond** the usual base (hax frontend + engine, the Lean
kernel, the Hax proof-lib, Lake/toolchain pins). Crate-specific `sorry`s and
patches only. The extraction **type-checks; it does not verify.**

Snapshot: `p3_mersenne_31.lean` ≈ 5536 lines, **134 `sorry`**.
Source patch ≈ 164 lines; Lean patch ≈ 4399 lines (89 hunks).

## 1. Pre-extraction Rust source patch (`../rust-patch/`)

`p3_mersenne_31.src.patch` adds `not(hax)` / `any(hax, …)` terms to the `#[cfg]`s
selecting mersenne-31's SIMD packings (NEON/AVX2/AVX512) and gates the DFT modules
(`dft`, `radix_2_dit`) off, so under `--cfg hax` the crate compiles via the
portable `no_packing` path with no DFT. **Class A (behaviour-preserving)** — a
normal `cargo build` is unchanged. It adds to the TCB only that:

- the extracted field semantics are the **portable** path (`type Packing = Self`),
  not the SIMD packings (which are not extracted/verified);
- the **DFT is excluded from extraction** (it implements `p3-dft`'s
  `TwoAdicSubgroupDft` over `p3-matrix` — FFT machinery, not field arithmetic).

## 2. Field/dependency stubs (`p3_mersenne_31/*.lean`)

The `p3-field`, `p3-mds`, `p3-poseidon{1,2}`, `p3-symmetric` hierarchies are
**hand-written stubs**, not extractions, trusted to mirror the real crates'
interfaces (class arities, associated types `Field…Packing`,
`PrimeCharacteristicRing…PrimeSubfield`, `ExtensionField…ExtensionPacking`, and the
projected consts/methods). `ExtField`/`PackedExtField` (the Mersenne31 extension
field types) and the `complex.*` extension traits are opaque/empty stubs.
`num_bigint`, `rand`, `serde` are minimal stubs of referenced items.

## 3. `core_shims.lean` — proof-lib gaps

- `core_models.num.{Impl_8.overflowing_sub, Impl_8.wrapping_add_signed,
  Impl_9.overflowing_sub, Impl_2.overflowing_add}` — filtered out by the proof-lib;
  stubbed (overflow flag not modelled).
- **128-bit `Cast` instances** — proof-lib's cast macro stops at `usize`; the
  `u128`/`i128` casts here have **`sorry` cast values** (not faithful truncation).
- `iter::{Sum, Product}` and `Iterator::{map, sum}` — stubbed (the latter two are
  `sorry`, used in generic linear-layer default bodies).
- `Ord::min`, `Hasher::write_u32`, `Display u32` — small stubs (`sorry` bodies),
  irrelevant to field semantics.

## 4. `sorry`s in the Lean patch (`patches/p3_mersenne_31.patch`)

- **`(by rfl)` → `(by sorry)`** on opaque-transmute field constants.
- **Bogus `(associatedTypes := { … with … })` overrides stripped** (engine↔proof-lib
  skew on `IntoIterator`/`FnMut` associated types).
- **`Debug` instance field `fmt` → `dbg_fmt`** (engine↔proof-lib name skew; `Display`
  keeps `fmt`).
- **Dependency-trait instances `sorry`-d** (whole-instance `:= sorry`): every
  instance of a stubbed `p3-field`/`p3-mds`/`p3-poseidon`/`p3-symmetric`/`rand`/`serde`
  class whose body provided methods the empty stub lacks (e.g. `BasedVectorSpace`,
  `GenericPoseidon2LinearLayers`, `InternalLayer`, `QuotientMap`, `Distribution`,
  `Deserialize`, `Serialize`).
- **Arith / cmp / convert instances `sorry`-d** (whole-instance `:= sorry`): the
  `core_models.ops.arith.*`, `core_models.cmp.{PartialEq,Eq,PartialOrd,Ord}`,
  `core_models.convert.{Into,From}` impls for `Mersenne31`/`Mersenne31Complex`/`QM31`
  and their packed variants. These mutually forward-reference each other (Lean
  resolves instances top-to-bottom); sorrying the bodies breaks the cycle.
- **Forward-referencing `def` bodies `sorry`-d**: `Impl.new_array`,
  `Impl.EXT_TWO_ADIC_GENERATORS`, `from_u62`, `coeffs`, `packed_mul_by_w`,
  `permute_state`'s `permute_mut` — they call field/arith instances declared later
  in the file.
- **One reorder (not a `sorry`)**: the `PartialEq`/`Eq` `AssociatedTypes` instances
  for `Mersenne31` are moved before `PartialOrd`/`Ord` (which extend them), since
  Lean needs the supertrait `AssociatedTypes` in scope first.

Everything else in `p3_mersenne_31.lean` (the Mersenne31 field structure, the
complex/QM31 extension field structures, and the bulk of the arithmetic) is the
real hax extraction, trusted only as far as the hax toolchain itself.
