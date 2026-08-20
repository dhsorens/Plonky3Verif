# monty-31 extraction — Trusted Computing Base

What you must trust **beyond** the usual base (hax frontend + engine, the Lean
kernel, the Hax proof-lib, Lake/toolchain pins). This file lists only the
crate-specific `sorry`s and patches. The extraction **type-checks; it does not
verify** — every `sorry` is an unproven hole.

Snapshot: `p3_monty_31.lean` ≈ 4264 lines, **73 `sorry`** (≈99 `sorry` warnings).
Source patch ≈ 243 lines; Lean patch ≈ 2261 lines.

## 1. Pre-extraction Rust source patch (`../rust-patch/`)

`p3_monty_31.src.patch` adds `not(hax)` / `any(hax, …)` terms to the `#[cfg]`s
selecting monty-31's SIMD packings (aarch64 NEON, x86_64 AVX2/AVX512) and the
`dft` module, so that under `--cfg hax` the crate compiles via the portable
`no_packing` path. **Class A (behaviour-preserving)** — does not change a normal
`cargo build` (`any(hax,X)≡X`, `all(…,not(hax))≡all(…)` when `hax` is unset). It
adds nothing to the TCB beyond the fact that **the extracted field semantics are
those of the portable path** (`type Packing = Self`), not the SIMD packings:

- The hand-written SIMD packings are **not extracted or verified.** They are an
  optimization of the portable path; any proof about `p3_monty_31.lean` says
  nothing about the NEON/AVX code actually run on those targets.
- The **`dft` module is excluded from extraction entirely** (it pulls in
  `tracing`, `Arc`, `RwLock` — none modellable by hax, and it is a parallel-FFT
  performance feature, not field arithmetic). monty-31's DFT is **not** in the
  trusted surface here.

## 2. Field/dependency stubs (`p3_monty_31/*.lean`)

The `p3-field`, `p3-mds`, `p3-poseidon{1,2}`, `p3-symmetric` trait hierarchies are
**hand-written stubs**, not extractions. We trust that these stub signatures
(class arities, the associated types `Field.AssociatedTypes.Packing`,
`PrimeCharacteristicRing.AssociatedTypes.PrimeSubfield`, and the few projected
consts/methods) **faithfully mirror the real crates' Lean extraction**. They have
no bodies — any monty-31 code that calls into them is trusted, not checked.
Likewise `num_bigint`, `rand`, `serde` are minimal stubs of referenced items.

## 3. `core_shims.lean` — proof-lib gaps

- `core_models.num.Impl_{8,9}.overflowing_sub`, `Impl_8.wrapping_add_signed` —
  the proof-lib filters these out; stubbed to return the value with a `false`
  overflow flag / the input unchanged. **The overflow flag is not modelled.**
- **128-bit `Cast` instances** (`u128`/`i128` ↔ {u32,u64,usize,i32,i64}): the
  proof-lib's cast macro stops at `usize`. These instances exist so the wide
  Montgomery/Barrett reduction elaborates, but their **cast value is `sorry`** —
  not a faithful truncation. Trusted, unmodelled.
- `iter::traits::accum::{Sum,Product}` classes and `Display u32` instance —
  stubbed markers / `sorry` body (formatting and accumulator bounds; irrelevant
  to field semantics).

## 4. `sorry`s in the Lean patch (`patches/p3_monty_31.patch`)

- **`(by rfl)` → `(by sorry)`** on every opaque-`transmute`/`of_isOk` field
  constant the engine emits (12 sites). The constant *values* are therefore
  unproven.
- **Trait default-method bodies sorried** (they reference sibling trait items via
  `Trait.item Self`, which cannot synthesize the self-instance inside a class
  definition, or use iterator combinators the proof-lib lacks):
  `MontyParameters.MONTY_MASK`, `BarrettParameters.{PSEUDO_INV,MASK}`,
  `ODD_FACTOR`, `BinomialExtensionData.mul_w`,
  `InternalLayerBaseParameters.generic_internal_linear_layer`.
- **Forward-referencing instance bodies sorried** (they call a `MontyField31`
  trait instance declared *later* in the file — Lean resolves instances
  top-to-bottom): the `Div.div`, `DivAssign.div_assign`, `Neg.neg`,
  `PartialOrd.partial_cmp`, and `iter…Product` impls for `MontyField31`.
- One engine↔proof-lib skew fixed in the patch (not a `sorry`): the `Debug`
  instance field renamed `fmt` → `dbg_fmt` to match the proof-lib's class.

Everything else in `p3_monty_31.lean` (Montgomery field structure, `data_traits`,
the Poseidon layer parameter types, and the bulk of the arithmetic) is the real
hax extraction, trusted only as far as the hax toolchain itself.

## Shared dependency stubs (consumed by baby-bear / koala-bear)

`p3_monty_31/*.lean` is also the **shared lower-dep stub layer** for the field crates
that `require` this package (baby-bear; koala-bear). It is maintained as the *union*
of consumer needs, so it carries a few symbols monty-31's own extraction does not use
(additive; monty-31 still builds green):
- `p3_field.field.PrimeCharacteristicRing.{double, halve, div_2exp_u64}` — declared
  with `:= sorry`/identity **defaults** so monty-31's own instances are unaffected.
- `p3_symmetric.permutation.Permutation.permute_mut` (default body).
- `p3_mds.util.first_row_to_first_col`.
- `p3_poseidon1.{Poseidon1, Poseidon1Constants, Impl_1.new, generic.*}` and
  `p3_poseidon2.{Poseidon2, Impl.new, external.Impl_4.new}` (struct + constructor stubs).

Consumer-/field-specific items (e.g. a per-field `exp_<n>` constant, a blanket
`AsRef (RustArray T N) (RustSlice T)`) live in the consumer's own supplementary stub,
not here.
