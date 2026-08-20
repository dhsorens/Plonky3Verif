import Hax

-- Numeric ops that hax's Lean proof-lib deliberately filters out
-- (`core-models/hax.sh`: `-core_models::num::**::overflowing_sub`), plus
-- `wrapping_add_signed`. monty-31's Montgomery reduction calls them. Stubbed to
-- type-check only (the `bool` overflow flag is not modelled).
namespace core_models.num

def Impl_8.overflowing_sub (x : u32) (_y : u32) : RustM (u32 × Bool) :=
  pure (x, false)

def Impl_8.wrapping_add_signed (x : u32) (_y : i32) : RustM u32 :=
  pure x

def Impl_9.overflowing_sub (x : u64) (_y : u64) : RustM (u64 × Bool) :=
  pure (x, false)

end core_models.num

-- `core::iter::{Sum, Product}` (the proof-lib filters these out). Used only as
-- trait bounds on the field element type; no methods are invoked here.
namespace core_models.iter.traits.accum

class Sum.AssociatedTypes (Self : Type) (T : Type) where

class Sum (Self : Type) (T : Type)
  [associatedTypes : outParam (Sum.AssociatedTypes Self T)]
  where

class Product.AssociatedTypes (Self : Type) (T : Type) where

class Product (Self : Type) (T : Type)
  [associatedTypes : outParam (Product.AssociatedTypes Self T)]
  where

end core_models.iter.traits.accum

-- The proof-lib's `declare_Hax_cast_instances` macro only covers integer widths
-- up to usize; it omits the 128-bit width entirely. monty-31's wide Montgomery
-- reduction (`monty_reduce`, Barrett reduction) casts to/from u128/i128, so we
-- supply the missing `Cast` instances. The 128-bit constructors in the proof-lib
-- need bound proofs (`UInt128.ofNatLT`) / differ by sign, so — consistent with
-- this extraction being type-check-only (Montgomery arithmetic is already
-- `sorry`-d) — the cast VALUE is `sorry`. See TCB.md. The instances exist so the
-- field-arithmetic call sites elaborate; no cast value is relied upon.
@[spec] instance : Cast u128 u64  where cast _ := pure sorry
@[spec] instance : Cast u128 u32  where cast _ := pure sorry
@[spec] instance : Cast u128 i128 where cast _ := pure sorry
@[spec] instance : Cast u64  u128 where cast _ := pure sorry
@[spec] instance : Cast u32  u128 where cast _ := pure sorry
@[spec] instance : Cast u32  i128 where cast _ := pure sorry
@[spec] instance : Cast usize u128 where cast _ := pure sorry
@[spec] instance : Cast i128 i64  where cast _ := pure sorry
@[spec] instance : Cast i128 i32  where cast _ := pure sorry
@[spec] instance : Cast i128 u128 where cast _ := pure sorry
@[spec] instance : Cast i64  i128 where cast _ := pure sorry
@[spec] instance : Cast i32  i128 where cast _ := pure sorry

-- monty-31's `Display`/`Debug` impls for MontyField31 delegate to the u32
-- formatter; the proof-lib provides `Debug u32` but not `Display u32`. Stub it
-- (formatting is irrelevant to field semantics — type-check only).
@[reducible] instance : core_models.fmt.Display.AssociatedTypes u32 where
@[spec] instance : core_models.fmt.Display u32 where fmt := sorry
