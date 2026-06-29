import Hax

/-! Stubs for the `p3-field` trait hierarchy that monty-31 implements/consumes.
    monty-31 is the MontyField31 backend, so it implements the whole hierarchy;
    those `impl` blocks are converted to `:= sorry` instances in p3_monty_31.lean
    (see TCB.md), so here we only need: the classes with correct ARITY (+ their
    `AssociatedTypes` companions) to satisfy bounds/synthesis, the handful of
    consts/methods actually CALLED from free functions, and the free helper fns.
    Field deps are stubbed, not extracted (deferred). -/

namespace p3_field.field

class PrimeCharacteristicRing.AssociatedTypes (R : Type) where
  PrimeSubfield : Type

class PrimeCharacteristicRing (R : Type)
  [associatedTypes : outParam (PrimeCharacteristicRing.AssociatedTypes R)]
  where
  ZERO (R) : RustM R
  ONE (R) : RustM R

class Field.AssociatedTypes (Self : Type) where
  Packing : Type

class Field (Self : Type)
  [associatedTypes : outParam (Field.AssociatedTypes Self)]
  where
  inverse (Self) (self : Self) : RustM Self

class PrimeField.AssociatedTypes (Self : Type) where
class PrimeField (Self : Type)
  [associatedTypes : outParam (PrimeField.AssociatedTypes Self)] where

class PrimeField32.AssociatedTypes (Self : Type) where
class PrimeField32 (Self : Type)
  [associatedTypes : outParam (PrimeField32.AssociatedTypes Self)]
  where
  ORDER_U32 (Self) : u32
  as_canonical_u32 (Self) (self : Self) : RustM u32
  to_unique_u32 (Self) (self : Self) : RustM u32

class PrimeField64.AssociatedTypes (Self : Type) where
class PrimeField64 (Self : Type)
  [associatedTypes : outParam (PrimeField64.AssociatedTypes Self)] where

class TwoAdicField.AssociatedTypes (Self : Type) where
class TwoAdicField (Self : Type)
  [associatedTypes : outParam (TwoAdicField.AssociatedTypes Self)] where

class RawDataSerializable.AssociatedTypes (Self : Type) where
class RawDataSerializable (Self : Type)
  [associatedTypes : outParam (RawDataSerializable.AssociatedTypes Self)] where

class InjectiveMonomial.AssociatedTypes (Self : Type) (D : u64) where
class InjectiveMonomial (Self : Type) (D : u64)
  [associatedTypes : outParam (InjectiveMonomial.AssociatedTypes Self D)] where

class PermutationMonomial.AssociatedTypes (Self : Type) (D : u64) where
class PermutationMonomial (Self : Type) (D : u64)
  [associatedTypes : outParam (PermutationMonomial.AssociatedTypes Self D)] where

class Algebra.AssociatedTypes (Self : Type) (F : Type) where
class Algebra (Self : Type) (F : Type)
  [associatedTypes : outParam (Algebra.AssociatedTypes Self F)] where

class BasedVectorSpace.AssociatedTypes (Self : Type) (F : Type) where
class BasedVectorSpace (Self : Type) (F : Type)
  [associatedTypes : outParam (BasedVectorSpace.AssociatedTypes Self F)] where
  as_basis_coefficients_slice (Self) (F) (self : Self) : RustM (RustSlice F)

class ExtensionField.AssociatedTypes (Self : Type) (F : Type) where
  ExtensionPacking : Type
class ExtensionField (Self : Type) (F : Type)
  [associatedTypes : outParam (ExtensionField.AssociatedTypes Self F)] where

end p3_field.field

namespace p3_field.integers

class QuotientMap.AssociatedTypes (Self : Type) (Int : Type) where
class QuotientMap (Self : Type) (Int : Type)
  [associatedTypes : outParam (QuotientMap.AssociatedTypes Self Int)] where

end p3_field.integers

namespace p3_field.packed.packed_traits

class Packable.AssociatedTypes (Self : Type) where
class Packable (Self : Type)
  [associatedTypes : outParam (Packable.AssociatedTypes Self)] where

class PackedFieldExtension.AssociatedTypes (Self : Type) (BaseF : Type) (ExtF : Type) where
class PackedFieldExtension (Self : Type) (BaseF : Type) (ExtF : Type)
  [associatedTypes : outParam (PackedFieldExtension.AssociatedTypes Self BaseF ExtF)] where

end p3_field.packed.packed_traits

namespace p3_field.dup

class Dup.AssociatedTypes (Self : Type) where
class Dup (Self : Type)
  [associatedTypes : outParam (Dup.AssociatedTypes Self)]
  where
  dup (Self) (self : Self) : RustM Self

end p3_field.dup

namespace p3_field.extension

class ExtensionAlgebra.AssociatedTypes (Self : Type) (F : Type) (N : usize) (S : Type) where
class ExtensionAlgebra (Self : Type) (F : Type) (N : usize) (S : Type)
  [associatedTypes : outParam (ExtensionAlgebra.AssociatedTypes Self F N S)] where

class BinomiallyExtendable.AssociatedTypes (Self : Type) (WIDTH : usize) where
class BinomiallyExtendable (Self : Type) (WIDTH : usize)
  [associatedTypes : outParam (BinomiallyExtendable.AssociatedTypes Self WIDTH)] where

class HasTwoAdicBinomialExtension.AssociatedTypes (Self : Type) (WIDTH : usize) where
class HasTwoAdicBinomialExtension (Self : Type) (WIDTH : usize)
  [associatedTypes : outParam (HasTwoAdicBinomialExtension.AssociatedTypes Self WIDTH)] where

class HasTwoAdicQuinticExtension.AssociatedTypes (Self : Type) where
class HasTwoAdicQuinticExtension (Self : Type)
  [associatedTypes : outParam (HasTwoAdicQuinticExtension.AssociatedTypes Self)] where

class QuinticTrinomialExtendable.AssociatedTypes (Self : Type) where
class QuinticTrinomialExtendable (Self : Type)
  [associatedTypes : outParam (QuinticTrinomialExtendable.AssociatedTypes Self)] where

-- Extension-strategy tag types. `Binomial` is parameterised by the base field.
opaque Binomial (F : Type) : Type
opaque QuinticTrinomial : Type

-- Mersenne31's complex / quartic extension field type: `ExtField Base D Strategy BaseF`.
opaque ExtField (Base : Type) (D : usize) (S : Type) (BaseF : Type) : Type
opaque PackedExtField (Base : Type) (BaseF : Type) (D : usize) (S : Type) : Type

-- ExtField constructors (`new` from coefficient arrays). Arities differ per impl.
opaque Impl_7.new (Base : Type) (BaseF : Type) (D : usize) (S : Type)
  (value : RustArray Base D) : RustM (ExtField Base D S BaseF)
opaque Impl_6.new (Base : Type) (D : usize) (S : Type)
  (value : RustArray Base D) : RustM (ExtField Base D S Base)

end p3_field.extension

namespace p3_field.extension.complex

class ComplexExtendable.AssociatedTypes (Self : Type) where
class ComplexExtendable (Self : Type)
  [associatedTypes : outParam (ComplexExtendable.AssociatedTypes Self)] where

class HasComplexBinomialExtension.AssociatedTypes (Self : Type) (WIDTH : usize) where
class HasComplexBinomialExtension (Self : Type) (WIDTH : usize)
  [associatedTypes : outParam (HasComplexBinomialExtension.AssociatedTypes Self WIDTH)] where

class HasTwoAdicComplexBinomialExtension.AssociatedTypes (Self : Type) (WIDTH : usize) where
class HasTwoAdicComplexBinomialExtension (Self : Type) (WIDTH : usize)
  [associatedTypes : outParam (HasTwoAdicComplexBinomialExtension.AssociatedTypes Self WIDTH)] where

end p3_field.extension.complex

namespace p3_field.exponentiation

-- per-field exponentiation helper (the numeric suffix is field-specific).
opaque exp_1717986917 (R : Type) (val : R) : RustM R

end p3_field.exponentiation

namespace p3_field.batch_inverse

opaque invert_packed_extension (Base : Type) (Ext : Type) (x : Ext) : RustM Ext

end p3_field.batch_inverse

namespace p3_field.extension.binomial_extension

opaque quartic_mul (F : Type) (G : Type) (H : Type) (N : usize)
  (a : RustArray F N) (b : RustArray F N) (res : RustArray F N) (w : F) :
  RustM (RustArray F N)

opaque quintic_mul (F : Type) (G : Type) (H : Type) (N : usize)
  (a : RustArray F N) (b : RustArray F N) (res : RustArray F N) (w : F) :
  RustM (RustArray F N)

opaque octic_mul (F : Type) (G : Type) (H : Type) (N : usize)
  (a : RustArray F N) (b : RustArray F N) (res : RustArray F N) (w : F) :
  RustM (RustArray F N)

end p3_field.extension.binomial_extension

namespace p3_field.extension.quintic_extension

opaque trinomial_quintic_mul (F : Type) {N : usize}
  (a : RustArray F N) (b : RustArray F N) (res : RustArray F N) :
  RustM (RustArray F N)

end p3_field.extension.quintic_extension

namespace p3_field.helpers

opaque field_to_array (F : Type) (N : usize) (val : F) : RustM (RustArray F N)

end p3_field.helpers

namespace p3_field.sqrt

opaque tonelli_shanks_two_adic (F : Type) (self : F) :
  RustM (core_models.option.Option F)

end p3_field.sqrt
