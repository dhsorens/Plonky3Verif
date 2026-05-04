import Hax
import p3_koala_bear.p3_field

-- Hax library extensions for ARM NEON intrinsics.
namespace core_models.core_arch.arm_shared.neon

opaque uint32x4_t : Type
opaque int32x4_t : Type

end core_models.core_arch.arm_shared.neon

namespace core_models.intrinsics

opaque transmute (A : Type) (B : Type) (a : A) : RustM B

end core_models.intrinsics

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

-- copied from p3_monty_31
namespace p3_monty_31.mds

class MDSUtils.AssociatedTypes (Self : Type) where
  [trait_constr_MDSUtils_i0 : core_models.clone.Clone.AssociatedTypes Self]
  [trait_constr_MDSUtils_i1 : core_models.marker.Sync.AssociatedTypes Self]

attribute [instance_reducible, instance]
  MDSUtils.AssociatedTypes.trait_constr_MDSUtils_i0

attribute [instance_reducible, instance]
  MDSUtils.AssociatedTypes.trait_constr_MDSUtils_i1

class MDSUtils (Self : Type)
  [associatedTypes : outParam (MDSUtils.AssociatedTypes (Self : Type))]
  where
  [trait_constr_MDSUtils_i0 : core_models.clone.Clone Self]
  [trait_constr_MDSUtils_i1 : core_models.marker.Sync Self]
  MATRIX_CIRC_MDS_8_COL (Self) : (RustArray i64 8)
  MATRIX_CIRC_MDS_12_COL (Self) : (RustArray i64 12)
  MATRIX_CIRC_MDS_16_COL (Self) : (RustArray i64 16)
  MATRIX_CIRC_MDS_24_COL (Self) : (RustArray i64 24)
  MATRIX_CIRC_MDS_32_COL (Self) : (RustArray i64 32)
  MATRIX_CIRC_MDS_64_COL (Self) : (RustArray i64 64)

attribute [instance_reducible, instance] MDSUtils.trait_constr_MDSUtils_i0

attribute [instance_reducible, instance] MDSUtils.trait_constr_MDSUtils_i1

structure MdsMatrixMontyField31
  (MU : Type)
  [trait_constr_MdsMatrixMontyField31_associated_type_i0 :
    MDSUtils.AssociatedTypes
    MU]
  [trait_constr_MdsMatrixMontyField31_i0 : MDSUtils MU ]
  where
  _phantom : (core_models.marker.PhantomData MU)

@[instance] opaque Impl.AssociatedTypes
  (MU : Type)
  [trait_constr_Impl_associated_type_i0 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_i0 : MDSUtils MU ] :
  core_models.default.Default.AssociatedTypes (MdsMatrixMontyField31 MU) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl
  (MU : Type)
  [trait_constr_Impl_associated_type_i0 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_i0 : MDSUtils MU ] :
  core_models.default.Default (MdsMatrixMontyField31 MU) :=
  by constructor <;> exact Inhabited.default

end p3_monty_31.mds

-- copied from p3_monty_31
namespace p3_monty_31.poseidon1

structure GenericPoseidon1LinearLayersMonty31 (FP : Type) (PRBP : Type) where
  _phantom1 : (core_models.marker.PhantomData FP)
  _phantom2 : (core_models.marker.PhantomData PRBP)

class PartialRoundBaseParameters.AssociatedTypes
  (Self : Type)
  (MP : Type)
  (WIDTH : usize)
  where
  [trait_constr_PartialRoundBaseParameters_i0 :
  core_models.clone.Clone.AssociatedTypes
  Self]
  [trait_constr_PartialRoundBaseParameters_i1 :
  core_models.marker.Sync.AssociatedTypes
  Self]
  [trait_constr_PartialRoundBaseParameters_i2 :
  p3_monty_31.data_traits.MontyParameters.AssociatedTypes
  MP]

attribute [instance_reducible, instance]
  PartialRoundBaseParameters.AssociatedTypes.trait_constr_PartialRoundBaseParameters_i0

attribute [instance_reducible, instance]
  PartialRoundBaseParameters.AssociatedTypes.trait_constr_PartialRoundBaseParameters_i1

attribute [instance_reducible, instance]
  PartialRoundBaseParameters.AssociatedTypes.trait_constr_PartialRoundBaseParameters_i2

class PartialRoundBaseParameters (Self : Type) (MP : Type) (WIDTH : usize)
  [associatedTypes : outParam (PartialRoundBaseParameters.AssociatedTypes (Self
      : Type) (MP : Type) (WIDTH : usize))]
  where
  [trait_constr_PartialRoundBaseParameters_i0 : core_models.clone.Clone Self]
  [trait_constr_PartialRoundBaseParameters_i1 : core_models.marker.Sync Self]
  [trait_constr_PartialRoundBaseParameters_i2 :
  p3_monty_31.data_traits.MontyParameters
  MP]
  USE_TEXTBOOK (Self) (MP) (WIDTH) :Bool := false
  mds_permute (Self) (MP) (WIDTH)
    (_state : (RustArray (p3_monty_31.monty_31.MontyField31 MP) WIDTH)) :RustM
    (RustArray (p3_monty_31.monty_31.MontyField31 MP) WIDTH) := do
    (pure _state)

attribute [instance_reducible, instance]
  PartialRoundBaseParameters.trait_constr_PartialRoundBaseParameters_i0

attribute [instance_reducible, instance]
  PartialRoundBaseParameters.trait_constr_PartialRoundBaseParameters_i1

attribute [instance_reducible, instance]
  PartialRoundBaseParameters.trait_constr_PartialRoundBaseParameters_i2

end p3_monty_31.poseidon1

-- copied from p3_monty_31
namespace p3_monty_31.aarch64_neon.poseidon1

structure Poseidon1InternalLayerMonty31
  (PMP : Type)
  (WIDTH : usize)
  (ILP : Type)
  where
  _phantom1 : (core_models.marker.PhantomData PMP)
  _phantom2 : (core_models.marker.PhantomData ILP)

structure Poseidon1ExternalLayerMonty31
  (PMP : Type)
  (MU : Type)
  (WIDTH : usize)
  where
  _phantom1 : (core_models.marker.PhantomData PMP)
  _phantom2 : (core_models.marker.PhantomData MU)

end p3_monty_31.aarch64_neon.poseidon1

-- copied from p3_monty_31
namespace p3_monty_31.poseidon2

structure GenericPoseidon2LinearLayersMonty31 (FP : Type) (ILBP : Type) where
  _phantom1 : (core_models.marker.PhantomData FP)
  _phantom2 : (core_models.marker.PhantomData ILBP)

class InternalLayerBaseParameters.AssociatedTypes
  (Self : Type)
  (MP : Type)
  (WIDTH : usize)
  where
  [trait_constr_InternalLayerBaseParameters_i0 :
  core_models.clone.Clone.AssociatedTypes
  Self]
  [trait_constr_InternalLayerBaseParameters_i1 :
  core_models.marker.Sync.AssociatedTypes
  Self]
  [trait_constr_InternalLayerBaseParameters_i2 :
  p3_monty_31.data_traits.MontyParameters.AssociatedTypes
  MP]

attribute [instance_reducible, instance]
  InternalLayerBaseParameters.AssociatedTypes.trait_constr_InternalLayerBaseParameters_i0

attribute [instance_reducible, instance]
  InternalLayerBaseParameters.AssociatedTypes.trait_constr_InternalLayerBaseParameters_i1

attribute [instance_reducible, instance]
  InternalLayerBaseParameters.AssociatedTypes.trait_constr_InternalLayerBaseParameters_i2

class InternalLayerBaseParameters (Self : Type) (MP : Type) (WIDTH : usize)
  [associatedTypes : outParam (InternalLayerBaseParameters.AssociatedTypes (Self
      : Type) (MP : Type) (WIDTH : usize))]
  where
  [trait_constr_InternalLayerBaseParameters_i0 : core_models.clone.Clone Self]
  [trait_constr_InternalLayerBaseParameters_i1 : core_models.marker.Sync Self]
  [trait_constr_InternalLayerBaseParameters_i2 :
  p3_monty_31.data_traits.MontyParameters
  MP]
  internal_layer_mat_mul (Self) (MP) (WIDTH)
    (R : Type)
    [trait_constr_internal_layer_mat_mul_associated_type_i1 :
      p3_field.field.PrimeCharacteristicRing.AssociatedTypes
      R]
    [trait_constr_internal_layer_mat_mul_i1 :
      p3_field.field.PrimeCharacteristicRing
      R
      ] :
    ((RustArray R WIDTH) -> R -> RustM (RustArray R WIDTH))

attribute [instance_reducible, instance]
  InternalLayerBaseParameters.trait_constr_InternalLayerBaseParameters_i0

attribute [instance_reducible, instance]
  InternalLayerBaseParameters.trait_constr_InternalLayerBaseParameters_i1

attribute [instance_reducible, instance]
  InternalLayerBaseParameters.trait_constr_InternalLayerBaseParameters_i2

end p3_monty_31.poseidon2

-- copied from p3_monty_31
namespace p3_monty_31.aarch64_neon.poseidon2

structure Poseidon2ExternalLayerMonty31
  (PMP : Type)
  (WIDTH : usize)
  where
  _phantom : (core_models.marker.PhantomData PMP)

structure Poseidon2InternalLayerMonty31
  (PMP : Type)
  (WIDTH : usize)
  (ILP : Type)
  where
  _phantom1 : (core_models.marker.PhantomData PMP)
  _phantom2 : (core_models.marker.PhantomData ILP)

end p3_monty_31.aarch64_neon.poseidon2

-- copied from p3_monty_31
namespace p3_monty_31.aarch64_neon.packing

class MontyParametersNeon.AssociatedTypes (Self : Type) where

class MontyParametersNeon (Self : Type)
  [associatedTypes : outParam (MontyParametersNeon.AssociatedTypes (Self :
      Type))]
  where
  PACKED_P (Self) : core_models.core_arch.arm_shared.neon.uint32x4_t
  PACKED_MU (Self) : core_models.core_arch.arm_shared.neon.int32x4_t

opaque PackedMontyField31Neon (PMP : Type) : Type

end p3_monty_31.aarch64_neon.packing

-- copied from p3_monty_31
namespace p3_monty_31.data_traits

class PackedMontyParameters.AssociatedTypes (Self : Type) where
  [trait_constr_PackedMontyParameters_i0 :
  p3_monty_31.aarch64_neon.packing.MontyParametersNeon.AssociatedTypes
  Self]
  [trait_constr_PackedMontyParameters_i1 : MontyParameters.AssociatedTypes Self]

attribute [instance_reducible, instance]
  PackedMontyParameters.AssociatedTypes.trait_constr_PackedMontyParameters_i0

attribute [instance_reducible, instance]
  PackedMontyParameters.AssociatedTypes.trait_constr_PackedMontyParameters_i1

class PackedMontyParameters (Self : Type)
  [associatedTypes : outParam (PackedMontyParameters.AssociatedTypes (Self :
      Type))]
  where
  [trait_constr_PackedMontyParameters_i0 :
  p3_monty_31.aarch64_neon.packing.MontyParametersNeon
  Self]
  [trait_constr_PackedMontyParameters_i1 : MontyParameters Self]

attribute [instance_reducible, instance]
  PackedMontyParameters.trait_constr_PackedMontyParameters_i0

attribute [instance_reducible, instance]
  PackedMontyParameters.trait_constr_PackedMontyParameters_i1

class FieldParameters.AssociatedTypes (Self : Type) where
  [trait_constr_FieldParameters_i0 : PackedMontyParameters.AssociatedTypes Self]

attribute [instance_reducible, instance]
  FieldParameters.AssociatedTypes.trait_constr_FieldParameters_i0

class FieldParameters (Self : Type)
  [associatedTypes : outParam (FieldParameters.AssociatedTypes (Self : Type))]
  where
  [trait_constr_FieldParameters_i0 : PackedMontyParameters Self]
  MONTY_GEN (Self) : (p3_monty_31.monty_31.MontyField31 Self)

attribute [instance_reducible, instance]
  FieldParameters.trait_constr_FieldParameters_i0

end p3_monty_31.data_traits

-- copied from p3_monty_31
namespace p3_monty_31.aarch64_neon.poseidon1

class PartialRoundParametersNeon.AssociatedTypes
  (Self : Type)
  (PMP : Type)
  (WIDTH : usize)
  where

class PartialRoundParametersNeon (Self : Type) (PMP : Type) (WIDTH : usize)
  [associatedTypes : outParam (PartialRoundParametersNeon.AssociatedTypes (Self
      : Type) (PMP : Type) (WIDTH : usize))]
  where

end p3_monty_31.aarch64_neon.poseidon1

-- copied from p3_monty_31
namespace p3_monty_31.poseidon1

class PartialRoundParameters.AssociatedTypes
  (Self : Type)
  (FP : Type)
  (WIDTH : usize)
  where

class PartialRoundParameters (Self : Type) (FP : Type) (WIDTH : usize)
  [associatedTypes : outParam (PartialRoundParameters.AssociatedTypes (Self :
      Type) (FP : Type) (WIDTH : usize))]
  where

end p3_monty_31.poseidon1

-- copied from p3_monty_31
namespace p3_monty_31.aarch64_neon.poseidon2

class InternalLayerParametersNeon.AssociatedTypes
  (Self : Type)
  (PMP : Type)
  (WIDTH : usize)
  where
  ArrayLike : Type

attribute [reducible] InternalLayerParametersNeon.AssociatedTypes.ArrayLike

abbrev InternalLayerParametersNeon.ArrayLike :=
  InternalLayerParametersNeon.AssociatedTypes.ArrayLike

class InternalLayerParametersNeon (Self : Type) (PMP : Type) (WIDTH : usize)
  [associatedTypes : outParam (InternalLayerParametersNeon.AssociatedTypes (Self
      : Type) (PMP : Type) (WIDTH : usize))]
  where
  diagonal_mul_remainder (Self) (PMP) (WIDTH) :
    (associatedTypes.ArrayLike -> RustM associatedTypes.ArrayLike)
  NUM_POS (Self) (PMP) (WIDTH) : usize

end p3_monty_31.aarch64_neon.poseidon2

-- copied from p3_monty_31
namespace p3_monty_31.poseidon2

class InternalLayerParameters.AssociatedTypes
  (Self : Type)
  (FP : Type)
  (WIDTH : usize)
  where

class InternalLayerParameters (Self : Type) (FP : Type) (WIDTH : usize)
  [associatedTypes : outParam (InternalLayerParameters.AssociatedTypes (Self :
      Type) (FP : Type) (WIDTH : usize))]
  where

end p3_monty_31.poseidon2

-- copied from p3_monty_31
namespace p3_monty_31.aarch64_neon.utils

opaque mul_2exp_neg_n_neon
    (MP : Type)
    [trait_constr_mul_2exp_neg_n_neon_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_mul_2exp_neg_n_neon_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (n : i32)
    (val : core_models.core_arch.arm_shared.neon.uint32x4_t) :
    RustM core_models.core_arch.arm_shared.neon.uint32x4_t

opaque mul_2exp_neg_two_adicity_neon
    (MP : Type)
    [trait_constr_mul_2exp_neg_two_adicity_neon_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_mul_2exp_neg_two_adicity_neon_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (n : i32)
    (m : i32)
    (val : core_models.core_arch.arm_shared.neon.uint32x4_t) :
    RustM core_models.core_arch.arm_shared.neon.uint32x4_t

end p3_monty_31.aarch64_neon.utils
