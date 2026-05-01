import Hax
import p3_koala_bear.p3_field

namespace p3_monty_31.data_traits

--  MontyParameters contains the prime P along with constants needed to convert elements into and out of MONTY form.
--  The MONTY constant is assumed to be a power of 2.
class MontyParameters.AssociatedTypes (Self : Type) where
  [trait_constr_MontyParameters_i0 :
  core_models.marker.Copy.AssociatedTypes
  Self]
  [trait_constr_MontyParameters_i1 :
  core_models.default.Default.AssociatedTypes
  Self]
  [trait_constr_MontyParameters_i2 : core_models.fmt.Debug.AssociatedTypes Self]
  [trait_constr_MontyParameters_i3 : core_models.cmp.Eq.AssociatedTypes Self]
  [trait_constr_MontyParameters_i4 :
  core_models.cmp.PartialEq.AssociatedTypes
  Self
  Self]
  [trait_constr_MontyParameters_i5 :
  core_models.marker.Sync.AssociatedTypes
  Self]
  [trait_constr_MontyParameters_i6 :
  core_models.marker.Send.AssociatedTypes
  Self]
  [trait_constr_MontyParameters_i7 : core_models.hash.Hash.AssociatedTypes Self]

attribute [instance_reducible, instance]
  MontyParameters.AssociatedTypes.trait_constr_MontyParameters_i0

attribute [instance_reducible, instance]
  MontyParameters.AssociatedTypes.trait_constr_MontyParameters_i1

attribute [instance_reducible, instance]
  MontyParameters.AssociatedTypes.trait_constr_MontyParameters_i2

attribute [instance_reducible, instance]
  MontyParameters.AssociatedTypes.trait_constr_MontyParameters_i3

attribute [instance_reducible, instance]
  MontyParameters.AssociatedTypes.trait_constr_MontyParameters_i4

attribute [instance_reducible, instance]
  MontyParameters.AssociatedTypes.trait_constr_MontyParameters_i5

attribute [instance_reducible, instance]
  MontyParameters.AssociatedTypes.trait_constr_MontyParameters_i6

attribute [instance_reducible, instance]
  MontyParameters.AssociatedTypes.trait_constr_MontyParameters_i7

class MontyParameters (Self : Type)
  [associatedTypes : outParam (MontyParameters.AssociatedTypes (Self : Type))]
  where
  [trait_constr_MontyParameters_i0 : core_models.marker.Copy Self]
  [trait_constr_MontyParameters_i1 : core_models.default.Default Self]
  [trait_constr_MontyParameters_i2 : core_models.fmt.Debug Self]
  [trait_constr_MontyParameters_i3 : core_models.cmp.Eq Self]
  [trait_constr_MontyParameters_i4 : core_models.cmp.PartialEq Self Self]
  [trait_constr_MontyParameters_i5 : core_models.marker.Sync Self]
  [trait_constr_MontyParameters_i6 : core_models.marker.Send Self]
  [trait_constr_MontyParameters_i7 : core_models.hash.Hash Self]
  PRIME (Self) : u32
  MONTY_BITS (Self) : u32
  MONTY_MU (Self) : u32
  MONTY_MASK (Self) :u32 := sorry -- TODO commented out
    -- RustM.of_isOk
    --   (do
    --   (rust_primitives.hax.cast_op
    --     (← ((← ((1 : u64) <<<? (MontyParameters.MONTY_BITS Self)))
    --       -? (1 : u64))) :
    --     RustM u32))
    --   (by rfl)

attribute [instance_reducible, instance]
  MontyParameters.trait_constr_MontyParameters_i0

attribute [instance_reducible, instance]
  MontyParameters.trait_constr_MontyParameters_i1

attribute [instance_reducible, instance]
  MontyParameters.trait_constr_MontyParameters_i2

attribute [instance_reducible, instance]
  MontyParameters.trait_constr_MontyParameters_i3

attribute [instance_reducible, instance]
  MontyParameters.trait_constr_MontyParameters_i4

attribute [instance_reducible, instance]
  MontyParameters.trait_constr_MontyParameters_i5

attribute [instance_reducible, instance]
  MontyParameters.trait_constr_MontyParameters_i6

attribute [instance_reducible, instance]
  MontyParameters.trait_constr_MontyParameters_i7

end p3_monty_31.data_traits

-- #check p3_monty_31.data_traits.MontyParameters.AssociatedTypes
-- #check MontyParameters

namespace p3_monty_31.monty_31

structure MontyField31
  (MP : Type)
  [trait_constr_MontyField31_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_MontyField31_i0 : p3_monty_31.data_traits.MontyParameters MP ]
  where
  value : u32
  _phantom : (core_models.marker.PhantomData MP)

end p3_monty_31.monty_31

namespace p3_monty_31.data_traits

--  BarrettParameters contains constants needed for the Barrett reduction used in the MDS code.
class BarrettParameters.AssociatedTypes (Self : Type) where
  [trait_constr_BarrettParameters_i0 : MontyParameters.AssociatedTypes Self]

attribute [instance_reducible, instance]
  BarrettParameters.AssociatedTypes.trait_constr_BarrettParameters_i0

class BarrettParameters (Self : Type)
  [associatedTypes : outParam (BarrettParameters.AssociatedTypes (Self : Type))]
  where
  [trait_constr_BarrettParameters_i0 : MontyParameters Self]
  N (Self) :usize := (40 : usize)
  PRIME_I128 (Self) :i128 :=
    RustM.of_isOk
      (do sorry)
      -- (rust_primitives.hax.cast_op (MontyParameters.PRIME Self) : RustM i128))
      -- (by rfl)
      (by sorry)
  PSEUDO_INV (Self) :i64 :=
    RustM.of_isOk
      (do sorry)
      -- (rust_primitives.hax.cast_op
      --   (← ((← ((1 : i128)
      --       <<<? (← ((2 : usize) *? (BarrettParameters.N Self)))))
      --     /? (BarrettParameters.PRIME_I128 Self))) :
      --   RustM i64))
      -- (by rfl)
      (by sorry)
  MASK (Self) :i64 :=
    RustM.of_isOk
      (do (~? (← ((← ((1 : i64) <<<? (10 : i32))) -? (1 : i64)))))
      (by rfl)

attribute [instance_reducible, instance]
  BarrettParameters.trait_constr_BarrettParameters_i0


end p3_monty_31.data_traits

-- copied from p3_monty_31
namespace p3_monty_31.data_traits

--  An integer `D` such that `gcd(D, p - 1) = 1`.
class RelativelyPrimePower.AssociatedTypes (Self : Type) (D : u64) where

class RelativelyPrimePower (Self : Type) (D : u64)
  [associatedTypes : outParam (RelativelyPrimePower.AssociatedTypes (Self :
      Type) (D : u64))]
  where
  exp_root_d (Self) (D)
    (R : Type)
    [trait_constr_exp_root_d_associated_type_i1 :
      p3_field.field.PrimeCharacteristicRing.AssociatedTypes
      R]
    [trait_constr_exp_root_d_i1 : p3_field.field.PrimeCharacteristicRing R ] :
    (R -> RustM R)

end p3_monty_31.data_traits

-- copied from p3_monty_31
namespace p3_monty_31.monty_31

def Impl.new_array
    (MP : Type)
    (N : usize)
    [trait_constr_new_array_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_new_array_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (input : (RustArray u32 N)) :
    RustM (RustArray (MontyField31 MP) N) := sorry

def Impl.new_2d_array
    (MP : Type)
    (N : usize)
    (M : usize)
    [trait_constr_new_2d_array_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_new_2d_array_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (input : (RustArray (RustArray u32 N) M)) :
    RustM (RustArray (RustArray (MontyField31 MP) N) M) := sorry

def Impl.new
    (MP : Type)
    [trait_constr_new_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_new_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (value : u32) :
    RustM (MontyField31 MP) := sorry

end p3_monty_31.monty_31

-- copied from p3_monty_31
namespace p3_monty_31.data_traits

--  TwoAdicData contains constants needed to imply TwoAdicField for Monty31 fields.
class TwoAdicData.AssociatedTypes (Self : Type) where
  [trait_constr_TwoAdicData_i0 : MontyParameters.AssociatedTypes Self]
  ArrayLike : Type

attribute [instance_reducible, instance]
  TwoAdicData.AssociatedTypes.trait_constr_TwoAdicData_i0

attribute [reducible] TwoAdicData.AssociatedTypes.ArrayLike

abbrev TwoAdicData.ArrayLike :=
  TwoAdicData.AssociatedTypes.ArrayLike

class TwoAdicData (Self : Type)
  [associatedTypes : outParam (TwoAdicData.AssociatedTypes (Self : Type))]
  where
  [trait_constr_TwoAdicData_i0 : MontyParameters Self]
  [trait_constr_ArrayLike_associated_type_i1 :
    core_models.convert.AsRef.AssociatedTypes
    associatedTypes.ArrayLike
    (RustSlice (p3_monty_31.monty_31.MontyField31 Self))]
  [trait_constr_ArrayLike_i1 : core_models.convert.AsRef
    associatedTypes.ArrayLike
    (RustSlice (p3_monty_31.monty_31.MontyField31 Self))
    ]
  TWO_ADICITY (Self) : usize
  ODD_FACTOR (Self) :i32 := sorry
  TWO_ADIC_GENERATORS (Self) : associatedTypes.ArrayLike
  ROOTS_8 (Self) : associatedTypes.ArrayLike
  INV_ROOTS_8 (Self) : associatedTypes.ArrayLike
  ROOTS_16 (Self) : associatedTypes.ArrayLike
  INV_ROOTS_16 (Self) : associatedTypes.ArrayLike

attribute [instance_reducible, instance] TwoAdicData.trait_constr_TwoAdicData_i0

class BinomialExtensionData.AssociatedTypes (Self : Type) (DEG : usize) where
  [trait_constr_BinomialExtensionData_i0 : MontyParameters.AssociatedTypes Self]
  ArrayLike : Type

attribute [instance_reducible, instance]
  BinomialExtensionData.AssociatedTypes.trait_constr_BinomialExtensionData_i0

attribute [reducible] BinomialExtensionData.AssociatedTypes.ArrayLike

abbrev BinomialExtensionData.ArrayLike :=
  BinomialExtensionData.AssociatedTypes.ArrayLike

class BinomialExtensionData (Self : Type) (DEG : usize)
  [associatedTypes : outParam (BinomialExtensionData.AssociatedTypes (Self :
      Type) (DEG : usize))]
  where
  [trait_constr_BinomialExtensionData_i0 : MontyParameters Self]
  W (Self) (DEG) : (p3_monty_31.monty_31.MontyField31 Self)
  mul_w (Self) (DEG)
    (A : Type)
    [trait_constr_mul_w_associated_type_i1 :
      p3_field.field.Algebra.AssociatedTypes
      A
      (p3_monty_31.monty_31.MontyField31 Self)]
    [trait_constr_mul_w_i1 : p3_field.field.Algebra
      A
      (p3_monty_31.monty_31.MontyField31 Self)
      ] : (A -> RustM A)
  DTH_ROOT (Self) (DEG) : (p3_monty_31.monty_31.MontyField31 Self)
  EXT_GENERATOR (Self) (DEG) :
    (RustArray (p3_monty_31.monty_31.MontyField31 Self) DEG)
  EXT_TWO_ADICITY (Self) (DEG) : usize
  TWO_ADIC_EXTENSION_GENERATORS (Self) (DEG) : associatedTypes.ArrayLike

attribute [instance_reducible, instance]
  BinomialExtensionData.trait_constr_BinomialExtensionData_i0

class TrinomialQuinticData.AssociatedTypes (Self : Type) where
  [trait_constr_TrinomialQuinticData_i0 : MontyParameters.AssociatedTypes Self]
  ArrayLike : Type

attribute [instance_reducible, instance]
  TrinomialQuinticData.AssociatedTypes.trait_constr_TrinomialQuinticData_i0

attribute [reducible] TrinomialQuinticData.AssociatedTypes.ArrayLike

abbrev TrinomialQuinticData.ArrayLike :=
  TrinomialQuinticData.AssociatedTypes.ArrayLike

class TrinomialQuinticData (Self : Type)
  [associatedTypes : outParam (TrinomialQuinticData.AssociatedTypes (Self :
      Type))]
  where
  [trait_constr_TrinomialQuinticData_i0 : MontyParameters Self]
  EXT_GENERATOR (Self) : (RustArray (p3_monty_31.monty_31.MontyField31 Self) 5)
  EXT_TWO_ADICITY (Self) : usize
  FROBENIUS_COEFFS (Self) :
    (RustArray (RustArray (p3_monty_31.monty_31.MontyField31 Self) 5) 4)
  TWO_ADIC_EXTENSION_GENERATORS (Self) : associatedTypes.ArrayLike

attribute [instance_reducible, instance]
  TrinomialQuinticData.trait_constr_TrinomialQuinticData_i0

end p3_monty_31.data_traits
