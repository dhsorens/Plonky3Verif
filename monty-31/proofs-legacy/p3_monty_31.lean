
-- Experimental lean backend for Hax
-- The Hax prelude library can be found in hax/proof-libs/lean
import Hax
import p3_monty_31.dependencies
import Std.Tactic.Do
import Std.Do.Triple
import Std.Tactic.Do.Syntax
open Std.Do
open Std.Tactic

set_option mvcgen.warning false
set_option linter.unusedVariables false


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


namespace p3_monty_31.mds

--  A collection of circulant MDS matrices saved using their left most column.
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

@[instance] opaque Impl_14.AssociatedTypes
  (MU : Type)
  [trait_constr_Impl_14_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MU]
  [trait_constr_Impl_14_i0 : core_models.clone.Clone MU ]
  [trait_constr_Impl_14_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_14_i1 : MDSUtils MU ] :
  core_models.clone.Clone.AssociatedTypes (MdsMatrixMontyField31 MU) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_14
  (MU : Type)
  [trait_constr_Impl_14_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MU]
  [trait_constr_Impl_14_i0 : core_models.clone.Clone MU ]
  [trait_constr_Impl_14_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_14_i1 : MDSUtils MU ] :
  core_models.clone.Clone (MdsMatrixMontyField31 MU) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_15.AssociatedTypes
  (MU : Type)
  [trait_constr_Impl_15_associated_type_i0 :
    core_models.fmt.Debug.AssociatedTypes
    MU]
  [trait_constr_Impl_15_i0 : core_models.fmt.Debug MU ]
  [trait_constr_Impl_15_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_15_i1 : MDSUtils MU ] :
  core_models.fmt.Debug.AssociatedTypes (MdsMatrixMontyField31 MU) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_15
  (MU : Type)
  [trait_constr_Impl_15_associated_type_i0 :
    core_models.fmt.Debug.AssociatedTypes
    MU]
  [trait_constr_Impl_15_i0 : core_models.fmt.Debug MU ]
  [trait_constr_Impl_15_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_15_i1 : MDSUtils MU ] :
  core_models.fmt.Debug (MdsMatrixMontyField31 MU) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_16.AssociatedTypes
  (MU : Type)
  [trait_constr_Impl_16_associated_type_i0 :
    core_models.default.Default.AssociatedTypes
    MU]
  [trait_constr_Impl_16_i0 : core_models.default.Default MU ]
  [trait_constr_Impl_16_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_16_i1 : MDSUtils MU ] :
  core_models.default.Default.AssociatedTypes (MdsMatrixMontyField31 MU) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_16
  (MU : Type)
  [trait_constr_Impl_16_associated_type_i0 :
    core_models.default.Default.AssociatedTypes
    MU]
  [trait_constr_Impl_16_i0 : core_models.default.Default MU ]
  [trait_constr_Impl_16_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_16_i1 : MDSUtils MU ] :
  core_models.default.Default (MdsMatrixMontyField31 MU) :=
  by constructor <;> exact Inhabited.default

--  Instantiate convolution for "small" RHS vectors over a 31-bit MONTY_FIELD.
-- 
--  Here "small" means N = len(rhs) <= 16 and sum(r for r in rhs) <
--  2^24 (roughly), though in practice the sum will be less than 2^9.
structure SmallConvolveMontyField31 where
  -- no fields

--  Instantiate convolution for "large" RHS vectors over BabyBear.
-- 
--  Here "large" means the elements can be as big as the field
--  characteristic, and the size N of the RHS is <= 64.
structure LargeConvolveMontyField31 where
  -- no fields

@[instance] opaque Impl_17.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes LargeConvolveMontyField31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_17 :
  core_models.fmt.Debug LargeConvolveMontyField31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_18.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes LargeConvolveMontyField31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_18 :
  core_models.clone.Clone LargeConvolveMontyField31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_19.AssociatedTypes :
  core_models.default.Default.AssociatedTypes LargeConvolveMontyField31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_19 :
  core_models.default.Default LargeConvolveMontyField31 :=
  by constructor <;> exact Inhabited.default

end p3_monty_31.mds


namespace p3_monty_31.monty_31

def Impl_14.try_inverse.NUM_PRIME_BITS : u32 := (31 : u32)

end p3_monty_31.monty_31


namespace p3_monty_31.poseidon1

--  Generic Poseidon1 linear layers for MontyField31.
structure GenericPoseidon1LinearLayersMonty31 (FP : Type) (PRBP : Type) where
  _phantom1 : (core_models.marker.PhantomData FP)
  _phantom2 : (core_models.marker.PhantomData PRBP)

end p3_monty_31.poseidon1


namespace p3_monty_31.poseidon2

--  An implementation of the matrix multiplications in the internal and external layers of Poseidon2.
-- 
--  This can act on `[A; WIDTH]` for any ring implementing `Algebra<MontyField31<FP>>`.
--  This will usually be slower than the Poseidon2 permutation built from `Poseidon2InternalLayerMonty31` and
--  `Poseidon2ExternalLayerMonty31` but it does work in more cases.
structure GenericPoseidon2LinearLayersMonty31 (FP : Type) (ILBP : Type) where
  _phantom1 : (core_models.marker.PhantomData FP)
  _phantom2 : (core_models.marker.PhantomData ILBP)

end p3_monty_31.poseidon2


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
  MONTY_MASK (Self) :u32 := sorry

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

--  PackedMontyParameters contains constants needed for MONTY operations for packings of Monty31 fields.
class PackedMontyParameters.AssociatedTypes (Self : Type) where
  [trait_constr_PackedMontyParameters_i0 : MontyParameters.AssociatedTypes Self]

attribute [instance_reducible, instance]
  PackedMontyParameters.AssociatedTypes.trait_constr_PackedMontyParameters_i0

class PackedMontyParameters (Self : Type)
  [associatedTypes : outParam (PackedMontyParameters.AssociatedTypes (Self :
      Type))]
  where
  [trait_constr_PackedMontyParameters_i0 : MontyParameters Self]

attribute [instance_reducible, instance]
  PackedMontyParameters.trait_constr_PackedMontyParameters_i0

end p3_monty_31.data_traits


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


namespace p3_monty_31.mds

@[reducible] instance Impl_2.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_2_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_2_i1 : MDSUtils MU ] :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 8)
  where

instance Impl_2
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_2_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_2_i1 : MDSUtils MU ] :
  p3_symmetric.permutation.Permutation
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 8)
  where
  permute :=
    fun
      (self : (MdsMatrixMontyField31 MU))
      (input : (RustArray (p3_monty_31.monty_31.MontyField31 FP) 8)) => do
    (pure sorry)

@[reducible] instance Impl_3.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_3_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_3_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_3_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((8 : usize))
  where

instance Impl_3
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_3_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_3_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_3_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((8 : usize)) := sorry

@[reducible] instance Impl_4.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_4_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_4_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_4_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_4_i1 : MDSUtils MU ] :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 12)
  where

instance Impl_4
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_4_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_4_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_4_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_4_i1 : MDSUtils MU ] :
  p3_symmetric.permutation.Permutation
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 12)
  where
  permute :=
    fun
      (self : (MdsMatrixMontyField31 MU))
      (input : (RustArray (p3_monty_31.monty_31.MontyField31 FP) 12)) => do
    (pure sorry)

@[reducible] instance Impl_5.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_5_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_5_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_5_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_5_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((12 : usize))
  where

instance Impl_5
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_5_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_5_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_5_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_5_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((12 : usize)) := sorry

@[reducible] instance Impl_6.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_6_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_6_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_6_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_6_i1 : MDSUtils MU ] :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 16)
  where

instance Impl_6
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_6_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_6_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_6_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_6_i1 : MDSUtils MU ] :
  p3_symmetric.permutation.Permutation
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 16)
  where
  permute :=
    fun
      (self : (MdsMatrixMontyField31 MU))
      (input : (RustArray (p3_monty_31.monty_31.MontyField31 FP) 16)) => do
    (pure sorry)

@[reducible] instance Impl_7.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_7_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_7_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_7_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_7_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((16 : usize))
  where

instance Impl_7
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_7_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_7_i0 : p3_monty_31.data_traits.MontyParameters FP ]
  [trait_constr_Impl_7_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_7_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((16 : usize)) := sorry

end p3_monty_31.mds


namespace p3_monty_31.monty_31

@[instance] opaque Impl_31.AssociatedTypes
  (MP : Type)
  [trait_constr_Impl_31_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MP]
  [trait_constr_Impl_31_i0 : core_models.clone.Clone MP ]
  [trait_constr_Impl_31_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_31_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.clone.Clone.AssociatedTypes (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_31
  (MP : Type)
  [trait_constr_Impl_31_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MP]
  [trait_constr_Impl_31_i0 : core_models.clone.Clone MP ]
  [trait_constr_Impl_31_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_31_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.clone.Clone (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_32.AssociatedTypes
  (MP : Type)
  [trait_constr_Impl_32_associated_type_i0 :
    core_models.marker.Copy.AssociatedTypes
    MP]
  [trait_constr_Impl_32_i0 : core_models.marker.Copy MP ]
  [trait_constr_Impl_32_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_32_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.marker.Copy.AssociatedTypes (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_32
  (MP : Type)
  [trait_constr_Impl_32_associated_type_i0 :
    core_models.marker.Copy.AssociatedTypes
    MP]
  [trait_constr_Impl_32_i0 : core_models.marker.Copy MP ]
  [trait_constr_Impl_32_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_32_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.marker.Copy (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_33.AssociatedTypes
  (MP : Type)
  [trait_constr_Impl_33_associated_type_i0 :
    core_models.default.Default.AssociatedTypes
    MP]
  [trait_constr_Impl_33_i0 : core_models.default.Default MP ]
  [trait_constr_Impl_33_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_33_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.default.Default.AssociatedTypes (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_33
  (MP : Type)
  [trait_constr_Impl_33_associated_type_i0 :
    core_models.default.Default.AssociatedTypes
    MP]
  [trait_constr_Impl_33_i0 : core_models.default.Default MP ]
  [trait_constr_Impl_33_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_33_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.default.Default (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_35.AssociatedTypes
  (MP : Type)
  [trait_constr_Impl_35_associated_type_i0 :
    core_models.hash.Hash.AssociatedTypes
    MP]
  [trait_constr_Impl_35_i0 : core_models.hash.Hash MP ]
  [trait_constr_Impl_35_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_35_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.hash.Hash.AssociatedTypes (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_35
  (MP : Type)
  [trait_constr_Impl_35_associated_type_i0 :
    core_models.hash.Hash.AssociatedTypes
    MP]
  [trait_constr_Impl_35_i0 : core_models.hash.Hash MP ]
  [trait_constr_Impl_35_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_35_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.hash.Hash (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_36.AssociatedTypes
  (MP : Type)
  [trait_constr_Impl_36_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_36_i0 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.marker.StructuralPartialEq.AssociatedTypes (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_36
  (MP : Type)
  [trait_constr_Impl_36_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_36_i0 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.marker.StructuralPartialEq (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_37.AssociatedTypes
  (MP : Type)
  [trait_constr_Impl_37_associated_type_i0 :
    core_models.cmp.PartialEq.AssociatedTypes
    MP
    MP]
  [trait_constr_Impl_37_i0 : core_models.cmp.PartialEq MP MP ]
  [trait_constr_Impl_37_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_37_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.cmp.PartialEq.AssociatedTypes (MontyField31 MP) (MontyField31 MP)
  :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_37
  (MP : Type)
  [trait_constr_Impl_37_associated_type_i0 :
    core_models.cmp.PartialEq.AssociatedTypes
    MP
    MP]
  [trait_constr_Impl_37_i0 : core_models.cmp.PartialEq MP MP ]
  [trait_constr_Impl_37_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_37_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.cmp.PartialEq (MontyField31 MP) (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_34.AssociatedTypes
  (MP : Type)
  [trait_constr_Impl_34_associated_type_i0 : core_models.cmp.Eq.AssociatedTypes
    MP]
  [trait_constr_Impl_34_i0 : core_models.cmp.Eq MP ]
  [trait_constr_Impl_34_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_34_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.cmp.Eq.AssociatedTypes (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_34
  (MP : Type)
  [trait_constr_Impl_34_associated_type_i0 : core_models.cmp.Eq.AssociatedTypes
    MP]
  [trait_constr_Impl_34_i0 : core_models.cmp.Eq MP ]
  [trait_constr_Impl_34_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_34_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.cmp.Eq (MontyField31 MP) :=
  by constructor <;> exact Inhabited.default

--  Create a new field element from something already in MONTY form.
--  This is `pub(crate)` for tests and delayed reduction strategies. If you're using it outside of those, you're
--  likely doing something fishy.
@[spec]
def Impl.new_monty
    (MP : Type)
    [trait_constr_new_monty_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_new_monty_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (value : u32) :
    RustM (MontyField31 MP) := do
  (pure (MontyField31.mk
    (value := value)
    (_phantom := core_models.marker.PhantomData.mk)))

end p3_monty_31.monty_31


namespace p3_monty_31.mds

@[reducible] instance Impl.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  p3_mds.karatsuba_convolution.Convolve.AssociatedTypes
  SmallConvolveMontyField31
  (p3_monty_31.monty_31.MontyField31 FP)
  i64
  i64
  where

instance Impl
  (FP : Type)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  p3_mds.karatsuba_convolution.Convolve
  SmallConvolveMontyField31
  (p3_monty_31.monty_31.MontyField31 FP)
  i64
  i64 := sorry

end p3_monty_31.mds


namespace p3_monty_31.monty_31

@[reducible] instance Impl_6.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_6_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_6_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  rand.distr.distribution.Distribution.AssociatedTypes
  rand.distr.StandardUniform
  (MontyField31 FP)
  where

instance Impl_6
  (FP : Type)
  [trait_constr_Impl_6_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_6_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  rand.distr.distribution.Distribution
  rand.distr.StandardUniform
  (MontyField31 FP) := sorry

@[reducible] instance Impl_9.AssociatedTypes
  (MP : Type)
  [trait_constr_Impl_9_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_9_i0 : p3_monty_31.data_traits.MontyParameters MP ] :
  p3_field.packed.packed_traits.Packable.AssociatedTypes (MontyField31 MP)
  where

instance Impl_9
  (MP : Type)
  [trait_constr_Impl_9_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_9_i0 : p3_monty_31.data_traits.MontyParameters MP ] :
  p3_field.packed.packed_traits.Packable (MontyField31 MP) := sorry

@[reducible] instance Impl_30.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_30_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_30_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.iter.traits.accum.Sum.AssociatedTypes
  (MontyField31 FP)
  (MontyField31 FP)
  where

instance Impl_30
  (FP : Type)
  [trait_constr_Impl_30_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_30_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.iter.traits.accum.Sum (MontyField31 FP) (MontyField31 FP) := sorry

end p3_monty_31.monty_31


namespace p3_monty_31.poseidon1

--  Trait for Poseidon1 partial round scalar operations.
-- 
--  Provides compile-time dispatch between two partial round strategies:
-- 
--  - **Sparse decomposition** (`USE_TEXTBOOK = false`, default): Uses the sparse matrix
--    factorization from Appendix B of the Poseidon1 paper. Best for most field/width combos.
-- 
--  - **Textbook with scalar constants** (`USE_TEXTBOOK = true`): Keeps the fast MDS
--    permutation (e.g., Karatsuba convolution) per round, but folds `state[1..WIDTH]`
--    constants forward so only a scalar is added to `state[0]` each round. Best when
--    the MDS is very fast (e.g., BabyBear width-16 with power-of-2 Karatsuba).
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


namespace p3_monty_31.utils

--  Convert a u32 into MONTY form.
--  There are no constraints on the input.
--  The output will be a u32 in range `[0, P)`.
@[spec]
def to_monty
    (MP : Type)
    [trait_constr_to_monty_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_to_monty_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (x : u32) :
    RustM u32 := do
  (rust_primitives.hax.cast_op
    (← ((← ((← (rust_primitives.hax.cast_op x : RustM u64))
        <<<? (p3_monty_31.data_traits.MontyParameters.MONTY_BITS MP)))
      %? (← (rust_primitives.hax.cast_op
        (p3_monty_31.data_traits.MontyParameters.PRIME MP) :
        RustM u64)))) :
    RustM u32)

end p3_monty_31.utils


namespace p3_monty_31.monty_31

--  Create a new field element from any `u32`.
-- 
--  Any `u32` value is accepted and automatically converted to Montgomery form.
@[spec]
def Impl.new
    (MP : Type)
    [trait_constr_new_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_new_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (value : u32) :
    RustM (MontyField31 MP) := do
  (pure (MontyField31.mk
    (value := (← (p3_monty_31.utils.to_monty MP value)))
    (_phantom := core_models.marker.PhantomData.mk)))

end p3_monty_31.monty_31


namespace p3_monty_31.data_traits

--  FieldParameters contains constants and methods needed to imply PrimeCharacteristicRing, Field and PrimeField32 for MontyField31.
class FieldParameters.AssociatedTypes (Self : Type) where
  [trait_constr_FieldParameters_i0 : PackedMontyParameters.AssociatedTypes Self]

attribute [instance_reducible, instance]
  FieldParameters.AssociatedTypes.trait_constr_FieldParameters_i0

class FieldParameters (Self : Type)
  [associatedTypes : outParam (FieldParameters.AssociatedTypes (Self : Type))]
  where
  [trait_constr_FieldParameters_i0 : PackedMontyParameters Self]
  MONTY_ZERO (Self) :(p3_monty_31.monty_31.MontyField31 Self) :=
    RustM.of_isOk (do (p3_monty_31.monty_31.Impl.new Self (0 : u32))) (by sorry)
  MONTY_ONE (Self) :(p3_monty_31.monty_31.MontyField31 Self) :=
    RustM.of_isOk (do (p3_monty_31.monty_31.Impl.new Self (1 : u32))) (by sorry)
  MONTY_TWO (Self) :(p3_monty_31.monty_31.MontyField31 Self) :=
    RustM.of_isOk (do (p3_monty_31.monty_31.Impl.new Self (2 : u32))) (by sorry)
  MONTY_NEG_ONE (Self) :(p3_monty_31.monty_31.MontyField31 Self) :=
    RustM.of_isOk
      (do
      (p3_monty_31.monty_31.Impl.new Self
        (← ((MontyParameters.PRIME Self) -? (1 : u32)))))
      (by sorry)
  MONTY_GEN (Self) : (p3_monty_31.monty_31.MontyField31 Self)
  HALF_P_PLUS_1 (Self) :u32 :=
    RustM.of_isOk
      (do ((← ((MontyParameters.PRIME Self) +? (1 : u32))) >>>? (1 : i32)))
      (by sorry)

attribute [instance_reducible, instance]
  FieldParameters.trait_constr_FieldParameters_i0

end p3_monty_31.data_traits


namespace p3_monty_31.monty_31

--  Convert a `[u32; N]` array to an array of field elements.
-- 
--  Const version of `input.map(MontyField31::new)`.
@[spec]
def Impl.new_array
    (MP : Type)
    (N : usize)
    [trait_constr_new_array_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_new_array_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (input : (RustArray u32 N)) :
    RustM (RustArray (MontyField31 MP) N) := do
  let output : (RustArray (MontyField31 MP) N) ←
    (rust_primitives.hax.repeat (← (Impl.new_monty MP (0 : u32))) N);
  let i : usize := (0 : usize);
  let ⟨i, output⟩ ←
    (rust_primitives.hax.while_loop
      (fun ⟨i, output⟩ => (do (pure true) : RustM Bool))
      (fun ⟨i, output⟩ => (do (i <? N) : RustM Bool))
      (fun ⟨i, output⟩ =>
        (do
        (rust_primitives.hax.int.from_machine (0 : u32)) :
        RustM hax_lib.int.Int))
      (rust_primitives.hax.Tuple2.mk i output)
      (fun ⟨i, output⟩ =>
        (do
        let output : (RustArray (MontyField31 MP) N) ←
          (rust_primitives.hax.monomorphized_update_at.update_at_usize
            output
            i
            (← (Impl.new MP (← input[i]_?))));
        let i : usize ← (i +? (1 : usize));
        (pure (rust_primitives.hax.Tuple2.mk i output)) :
        RustM
        (rust_primitives.hax.Tuple2 usize (RustArray (MontyField31 MP) N)))));
  (pure output)

--  Convert a constant 2d u32 array into a constant 2d array of field elements.
--  Constant version of array.map(MontyField31::new_array).
@[spec]
def Impl.new_2d_array
    (MP : Type)
    (N : usize)
    (M : usize)
    [trait_constr_new_2d_array_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_new_2d_array_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (input : (RustArray (RustArray u32 N) M)) :
    RustM (RustArray (RustArray (MontyField31 MP) N) M) := do
  let output : (RustArray (RustArray (MontyField31 MP) N) M) ←
    (rust_primitives.hax.repeat
      (← (rust_primitives.hax.repeat (← (Impl.new_monty MP (0 : u32))) N))
      M);
  let i : usize := (0 : usize);
  let ⟨i, output⟩ ←
    (rust_primitives.hax.while_loop
      (fun ⟨i, output⟩ => (do (pure true) : RustM Bool))
      (fun ⟨i, output⟩ => (do (i <? M) : RustM Bool))
      (fun ⟨i, output⟩ =>
        (do
        (rust_primitives.hax.int.from_machine (0 : u32)) :
        RustM hax_lib.int.Int))
      (rust_primitives.hax.Tuple2.mk i output)
      (fun ⟨i, output⟩ =>
        (do
        let output : (RustArray (RustArray (MontyField31 MP) N) M) ←
          (rust_primitives.hax.monomorphized_update_at.update_at_usize
            output
            i
            (← (Impl.new_array MP (N) (← input[i]_?))));
        let i : usize ← (i +? (1 : usize));
        (pure (rust_primitives.hax.Tuple2.mk i output)) :
        RustM
        (rust_primitives.hax.Tuple2
          usize
          (RustArray (RustArray (MontyField31 MP) N) M)))));
  (pure output)

def Impl_1.HALF
  (FP : Type)
  [trait_constr_HALF_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_HALF_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  (MontyField31 FP)
  :=
  RustM.of_isOk
    (do
    (Impl.new FP (p3_monty_31.data_traits.FieldParameters.HALF_P_PLUS_1 FP)))
    (by sorry)

@[reducible] instance Impl_7.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_7_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_7_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  serde_core.ser.Serialize.AssociatedTypes (MontyField31 FP)
  where

instance Impl_7
  (FP : Type)
  [trait_constr_Impl_7_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_7_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  serde_core.ser.Serialize (MontyField31 FP) := sorry

@[reducible] instance Impl_8.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_8_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_8_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  serde_core.de.Deserialize.AssociatedTypes (MontyField31 FP)
  where

instance Impl_8
  (FP : Type)
  [trait_constr_Impl_8_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_8_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  serde_core.de.Deserialize (MontyField31 FP) := sorry

@[reducible] instance Impl_16.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_16_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_16_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap.AssociatedTypes (MontyField31 FP) u32
  where

instance Impl_16
  (FP : Type)
  [trait_constr_Impl_16_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_16_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap (MontyField31 FP) u32 := sorry

@[reducible] instance Impl_38.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_38_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_38_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap.AssociatedTypes (MontyField31 FP) u8
  where

instance Impl_38
  (FP : Type)
  [trait_constr_Impl_38_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_38_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap (MontyField31 FP) u8 := sorry

@[reducible] instance Impl_39.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_39_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_39_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap.AssociatedTypes (MontyField31 FP) u16
  where

instance Impl_39
  (FP : Type)
  [trait_constr_Impl_39_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_39_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap (MontyField31 FP) u16 := sorry

end p3_monty_31.monty_31


namespace p3_monty_31.poseidon1

class PartialRoundParameters.AssociatedTypes
  (Self : Type)
  (FP : Type)
  (WIDTH : usize)
  where
  [trait_constr_PartialRoundParameters_i0 :
  PartialRoundBaseParameters.AssociatedTypes
  Self
  FP
  (WIDTH)]
  [trait_constr_PartialRoundParameters_i1 :
  p3_monty_31.data_traits.FieldParameters.AssociatedTypes
  FP]

attribute [instance_reducible, instance]
  PartialRoundParameters.AssociatedTypes.trait_constr_PartialRoundParameters_i0

attribute [instance_reducible, instance]
  PartialRoundParameters.AssociatedTypes.trait_constr_PartialRoundParameters_i1

class PartialRoundParameters (Self : Type) (FP : Type) (WIDTH : usize)
  [associatedTypes : outParam (PartialRoundParameters.AssociatedTypes (Self :
      Type) (FP : Type) (WIDTH : usize))]
  where
  [trait_constr_PartialRoundParameters_i0 :
  PartialRoundBaseParameters
  Self
  FP
  (WIDTH)]
  [trait_constr_PartialRoundParameters_i1 :
  p3_monty_31.data_traits.FieldParameters
  FP]

attribute [instance_reducible, instance]
  PartialRoundParameters.trait_constr_PartialRoundParameters_i0

attribute [instance_reducible, instance]
  PartialRoundParameters.trait_constr_PartialRoundParameters_i1

@[reducible] instance Impl_2.AssociatedTypes
  (FP : Type)
  (PRBP : Type)
  (F : Type)
  (WIDTH : usize)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_2_associated_type_i1 :
    PartialRoundBaseParameters.AssociatedTypes
    PRBP
    FP
    (WIDTH)]
  [trait_constr_Impl_2_i1 : PartialRoundBaseParameters PRBP FP (WIDTH) ]
  [trait_constr_Impl_2_associated_type_i2 : p3_field.field.Field.AssociatedTypes
    F]
  [trait_constr_Impl_2_i2 : p3_field.field.Field F ] :
  p3_poseidon1.generic.GenericPoseidon1LinearLayers.AssociatedTypes
  (GenericPoseidon1LinearLayersMonty31 FP PRBP)
  F
  (WIDTH)
  where

instance Impl_2
  (FP : Type)
  (PRBP : Type)
  (F : Type)
  (WIDTH : usize)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_2_associated_type_i1 :
    PartialRoundBaseParameters.AssociatedTypes
    PRBP
    FP
    (WIDTH)]
  [trait_constr_Impl_2_i1 : PartialRoundBaseParameters PRBP FP (WIDTH) ]
  [trait_constr_Impl_2_associated_type_i2 : p3_field.field.Field.AssociatedTypes
    F]
  [trait_constr_Impl_2_i2 : p3_field.field.Field F ] :
  p3_poseidon1.generic.GenericPoseidon1LinearLayers
  (GenericPoseidon1LinearLayersMonty31 FP PRBP)
  F
  (WIDTH) := sorry

end p3_monty_31.poseidon1


namespace p3_monty_31.utils

--  Convert an i32 into MONTY form.
--  There are no constraints on the input.
--  The output will be a u32 in range `[0, P)`.
@[spec]
def to_monty_signed
    (MP : Type)
    [trait_constr_to_monty_signed_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_to_monty_signed_i0 : p3_monty_31.data_traits.MontyParameters
      MP
      ]
    (x : i32) :
    RustM u32 := do
  let red : i32 ←
    (rust_primitives.hax.cast_op
      (← ((← ((← (rust_primitives.hax.cast_op x : RustM i64))
          <<<? (p3_monty_31.data_traits.MontyParameters.MONTY_BITS MP)))
        %? (← (rust_primitives.hax.cast_op
          (p3_monty_31.data_traits.MontyParameters.PRIME MP) :
          RustM i64)))) :
      RustM i32);
  if (← (red >=? (0 : i32))) then do
    (rust_primitives.hax.cast_op red : RustM u32)
  else do
    (core_models.num.Impl_8.wrapping_add_signed
      (p3_monty_31.data_traits.MontyParameters.PRIME MP)
      red)

end p3_monty_31.utils


namespace p3_monty_31.monty_31

@[reducible] instance Impl_17.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_17_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_17_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap.AssociatedTypes (MontyField31 FP) i32
  where

instance Impl_17
  (FP : Type)
  [trait_constr_Impl_17_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_17_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap (MontyField31 FP) i32 := sorry

@[reducible] instance Impl_40.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_40_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_40_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap.AssociatedTypes (MontyField31 FP) i8
  where

instance Impl_40
  (FP : Type)
  [trait_constr_Impl_40_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_40_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap (MontyField31 FP) i8 := sorry

@[reducible] instance Impl_41.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_41_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_41_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap.AssociatedTypes (MontyField31 FP) i16
  where

instance Impl_41
  (FP : Type)
  [trait_constr_Impl_41_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_41_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap (MontyField31 FP) i16 := sorry

end p3_monty_31.monty_31


namespace p3_monty_31.utils

--  Convert a u64 into MONTY form.
--  There are no constraints on the input.
--  The output will be a u32 in range `[0, P)`.
@[spec]
def to_monty_64
    (MP : Type)
    [trait_constr_to_monty_64_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_to_monty_64_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (x : u64) :
    RustM u32 := do
  (rust_primitives.hax.cast_op
    (← ((← ((← (rust_primitives.hax.cast_op x : RustM u128))
        <<<? (p3_monty_31.data_traits.MontyParameters.MONTY_BITS MP)))
      %? (← (rust_primitives.hax.cast_op
        (p3_monty_31.data_traits.MontyParameters.PRIME MP) :
        RustM u128)))) :
    RustM u32)

end p3_monty_31.utils


namespace p3_monty_31.monty_31

def Impl_1.MONTY_POWERS_OF_TWO
  (FP : Type)
  [trait_constr_MONTY_POWERS_OF_TWO_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_MONTY_POWERS_OF_TWO_i0 : p3_monty_31.data_traits.FieldParameters
    FP
    ] :
  (RustArray (MontyField31 FP) 64)
  :=
  RustM.of_isOk
    (do
    let powers_of_two : (RustArray (MontyField31 FP) 64) ←
      (rust_primitives.hax.repeat
        (p3_monty_31.data_traits.FieldParameters.MONTY_ONE FP)
        (64 : usize));
    let i : usize := (1 : usize);
    let ⟨i, powers_of_two⟩ ←
      (rust_primitives.hax.while_loop
        (fun ⟨i, powers_of_two⟩ => (do (pure true) : RustM Bool))
        (fun ⟨i, powers_of_two⟩ => (do (i <? (64 : usize)) : RustM Bool))
        (fun ⟨i, powers_of_two⟩ =>
          (do
          (rust_primitives.hax.int.from_machine (0 : u32)) :
          RustM hax_lib.int.Int))
        (rust_primitives.hax.Tuple2.mk i powers_of_two)
        (fun ⟨i, powers_of_two⟩ =>
          (do
          let powers_of_two : (RustArray (MontyField31 FP) 64) ←
            (rust_primitives.hax.monomorphized_update_at.update_at_usize
              powers_of_two
              i
              (← (Impl.new_monty FP
                (← (p3_monty_31.utils.to_monty_64 FP
                  (← ((1 : u64) <<<? i)))))));
          let i : usize ← (i +? (1 : usize));
          (pure (rust_primitives.hax.Tuple2.mk i powers_of_two)) :
          RustM
          (rust_primitives.hax.Tuple2
            usize
            (RustArray (MontyField31 FP) 64)))));
    (pure powers_of_two))
    (by sorry)

@[reducible] instance Impl_18.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_18_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_18_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap.AssociatedTypes (MontyField31 FP) u64
  where

instance Impl_18
  (FP : Type)
  [trait_constr_Impl_18_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_18_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap (MontyField31 FP) u64 := sorry

@[reducible] instance Impl_20.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_20_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_20_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap.AssociatedTypes (MontyField31 FP) u128
  where

instance Impl_20
  (FP : Type)
  [trait_constr_Impl_20_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_20_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap (MontyField31 FP) u128 := sorry

end p3_monty_31.monty_31


namespace p3_monty_31.utils

--  Convert an i64 into MONTY form.
--  There are no constraints on the input.
--  The output will be a u32 in range `[0, P)`.
@[spec]
def to_monty_64_signed
    (MP : Type)
    [trait_constr_to_monty_64_signed_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_to_monty_64_signed_i0 :
      p3_monty_31.data_traits.MontyParameters
      MP
      ]
    (x : i64) :
    RustM u32 := do
  let red : i32 ←
    (rust_primitives.hax.cast_op
      (← ((← ((← (rust_primitives.hax.cast_op x : RustM i128))
          <<<? (p3_monty_31.data_traits.MontyParameters.MONTY_BITS MP)))
        %? (← (rust_primitives.hax.cast_op
          (p3_monty_31.data_traits.MontyParameters.PRIME MP) :
          RustM i128)))) :
      RustM i32);
  if (← (red >=? (0 : i32))) then do
    (rust_primitives.hax.cast_op red : RustM u32)
  else do
    (core_models.num.Impl_8.wrapping_add_signed
      (p3_monty_31.data_traits.MontyParameters.PRIME MP)
      red)

end p3_monty_31.utils


namespace p3_monty_31.monty_31

@[reducible] instance Impl_19.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_19_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_19_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap.AssociatedTypes (MontyField31 FP) i64
  where

instance Impl_19
  (FP : Type)
  [trait_constr_Impl_19_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_19_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap (MontyField31 FP) i64 := sorry

@[reducible] instance Impl_21.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_21_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_21_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap.AssociatedTypes (MontyField31 FP) i128
  where

instance Impl_21
  (FP : Type)
  [trait_constr_Impl_21_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_21_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.integers.QuotientMap (MontyField31 FP) i128 := sorry

end p3_monty_31.monty_31


namespace p3_monty_31.utils

--  Add two integers modulo `P = MP::PRIME`.
-- 
--  Assumes that `P` is less than `2^31` and `a + b <= 2P` for all array pairs `a, b`.
--  If the inputs are not in this range, the result may be incorrect.
--  The result will be in the range `[0, P]` and equal to `(a + b) mod P`.
--  It will be equal to `P` if and only if `a + b = 2P` so provided `a + b < 2P`
--  the result is guaranteed to be less than `P`.
@[spec]
def add
    (MP : Type)
    [trait_constr_add_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_add_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (lhs : u32)
    (rhs : u32) :
    RustM u32 := do
  let sum : u32 ← (lhs +? rhs);
  let ⟨corr_sum, over⟩ ←
    (core_models.num.Impl_8.overflowing_sub
      sum
      (p3_monty_31.data_traits.MontyParameters.PRIME MP));
  let sum : u32 ←
    if (← (!? over)) then do
      let sum : u32 := corr_sum;
      (pure sum)
    else do
      (pure sum);
  (pure sum)

end p3_monty_31.utils


namespace p3_monty_31.monty_31

@[reducible] instance Impl_26.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_26_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_26_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.ops.arith.Add.AssociatedTypes (MontyField31 FP) (MontyField31 FP)
  where
  Output := (MontyField31 FP)

instance Impl_26
  (FP : Type)
  [trait_constr_Impl_26_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_26_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.ops.arith.Add (MontyField31 FP) (MontyField31 FP)
  where
  add := fun (self : (MontyField31 FP)) (rhs : (MontyField31 FP)) => do
    (Impl.new_monty FP
      (← (p3_monty_31.utils.add FP
        (MontyField31.value self)
        (MontyField31.value rhs))))

@[reducible] instance Impl_42.AssociatedTypes
  (MP : Type)
  (T : Type)
  [trait_constr_Impl_42_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_42_i0 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_42_associated_type_i1 :
    core_models.convert.Into.AssociatedTypes
    T
    (MontyField31 MP)]
  [trait_constr_Impl_42_i1 : core_models.convert.Into T (MontyField31 MP) ] :
  core_models.ops.arith.AddAssign.AssociatedTypes (MontyField31 MP) T
  where

instance Impl_42
  (MP : Type)
  (T : Type)
  [trait_constr_Impl_42_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_42_i0 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_42_associated_type_i1 :
    core_models.convert.Into.AssociatedTypes
    T
    (MontyField31 MP)]
  [trait_constr_Impl_42_i1 : core_models.convert.Into T (MontyField31 MP) ] :
  core_models.ops.arith.AddAssign (MontyField31 MP) T
  where
  add_assign := fun (self : (MontyField31 MP)) (rhs : T) => do
    let self : (MontyField31 MP) ←
      (core_models.ops.arith.Add.add
        (MontyField31 MP)
        (MontyField31 MP)
        self
        (← (core_models.convert.Into.into T (MontyField31 MP) rhs)));
    (pure self)

end p3_monty_31.monty_31


namespace p3_monty_31.utils

--  Subtract two integers modulo `P = MP::PRIME`.
-- 
--  Assumes that `P` is less than `2^31` and `|a - b| <= P` for all array pairs `a, b`.
--  If the inputs are not in this range, the result may be incorrect.
--  The result will be in the range `[0, P]` and equal to `(a - b) mod P`.
--  It will be equal to `P` if and only if `a - b = P` so provided `a - b < P`
--  the result is guaranteed to be less than `P`.
@[spec]
def sub
    (MP : Type)
    [trait_constr_sub_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_sub_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (lhs : u32)
    (rhs : u32) :
    RustM u32 := do
  let ⟨diff, over⟩ ← (core_models.num.Impl_8.overflowing_sub lhs rhs);
  let corr : u32 ←
    if over then do
      (pure (p3_monty_31.data_traits.MontyParameters.PRIME MP))
    else do
      (pure (0 : u32));
  let diff : u32 ← (core_models.num.Impl_8.wrapping_add diff corr);
  (pure diff)

end p3_monty_31.utils


namespace p3_monty_31.monty_31

@[reducible] instance Impl_27.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_27_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_27_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.ops.arith.Sub.AssociatedTypes (MontyField31 FP) (MontyField31 FP)
  where
  Output := (MontyField31 FP)

instance Impl_27
  (FP : Type)
  [trait_constr_Impl_27_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_27_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.ops.arith.Sub (MontyField31 FP) (MontyField31 FP)
  where
  sub := fun (self : (MontyField31 FP)) (rhs : (MontyField31 FP)) => do
    (Impl.new_monty FP
      (← (p3_monty_31.utils.sub FP
        (MontyField31.value self)
        (MontyField31.value rhs))))

@[reducible] instance Impl_43.AssociatedTypes
  (MP : Type)
  (T : Type)
  [trait_constr_Impl_43_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_43_i0 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_43_associated_type_i1 :
    core_models.convert.Into.AssociatedTypes
    T
    (MontyField31 MP)]
  [trait_constr_Impl_43_i1 : core_models.convert.Into T (MontyField31 MP) ] :
  core_models.ops.arith.SubAssign.AssociatedTypes (MontyField31 MP) T
  where

instance Impl_43
  (MP : Type)
  (T : Type)
  [trait_constr_Impl_43_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_43_i0 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_43_associated_type_i1 :
    core_models.convert.Into.AssociatedTypes
    T
    (MontyField31 MP)]
  [trait_constr_Impl_43_i1 : core_models.convert.Into T (MontyField31 MP) ] :
  core_models.ops.arith.SubAssign (MontyField31 MP) T
  where
  sub_assign := fun (self : (MontyField31 MP)) (rhs : T) => do
    let self : (MontyField31 MP) ←
      (core_models.ops.arith.Sub.sub
        (MontyField31 MP)
        (MontyField31 MP)
        self
        (← (core_models.convert.Into.into T (MontyField31 MP) rhs)));
    (pure self)

end p3_monty_31.monty_31


namespace p3_monty_31.utils

--  Given an element `x` from a 31 bit field `F` compute `x/2`.
--  The input must be in `[0, P)`.
--  The output will also be in `[0, P)`.
@[spec]
def halve_u32
    (FP : Type)
    [trait_constr_halve_u32_associated_type_i0 :
      p3_monty_31.data_traits.FieldParameters.AssociatedTypes
      FP]
    [trait_constr_halve_u32_i0 : p3_monty_31.data_traits.FieldParameters FP ]
    (input : u32) :
    RustM u32 := do
  let shr : u32 ← (input >>>? (1 : i32));
  let lo_bit : u32 ← (input &&&? (1 : u32));
  let shr_corr : u32 ←
    (shr +? (p3_monty_31.data_traits.FieldParameters.HALF_P_PLUS_1 FP));
  if (← (lo_bit ==? (0 : u32))) then do (pure shr) else do (pure shr_corr)

--  Montgomery reduction of a value in `0..P << MONTY_BITS`.
-- 
--  The input must be in `[0, MONTY * P)`.
--  The output will be in `[0, P)`.
@[spec]
def monty_reduce
    (MP : Type)
    [trait_constr_monty_reduce_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_monty_reduce_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (x : u64) :
    RustM u32 := do
  let t : u64 ←
    ((← (core_models.num.Impl_9.wrapping_mul
        x
        (← (rust_primitives.hax.cast_op
          (p3_monty_31.data_traits.MontyParameters.MONTY_MU MP) :
          RustM u64))))
      &&&? (← (rust_primitives.hax.cast_op
        (p3_monty_31.data_traits.MontyParameters.MONTY_MASK MP) :
        RustM u64)));
  let u : u64 ←
    (t
      *? (← (rust_primitives.hax.cast_op
        (p3_monty_31.data_traits.MontyParameters.PRIME MP) :
        RustM u64)));
  let ⟨x_sub_u, over⟩ ← (core_models.num.Impl_9.overflowing_sub x u);
  let x_sub_u_hi : u32 ←
    (rust_primitives.hax.cast_op
      (← (x_sub_u >>>? (p3_monty_31.data_traits.MontyParameters.MONTY_BITS MP)))
      :
      RustM u32);
  let corr : u32 ←
    if over then do
      (pure (p3_monty_31.data_traits.MontyParameters.PRIME MP))
    else do
      (pure (0 : u32));
  (core_models.num.Impl_8.wrapping_add x_sub_u_hi corr)

end p3_monty_31.utils


namespace p3_monty_31.monty_31

@[reducible] instance Impl_29.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_29_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_29_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.ops.arith.Mul.AssociatedTypes (MontyField31 FP) (MontyField31 FP)
  where
  Output := (MontyField31 FP)

instance Impl_29
  (FP : Type)
  [trait_constr_Impl_29_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_29_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.ops.arith.Mul (MontyField31 FP) (MontyField31 FP)
  where
  mul := fun (self : (MontyField31 FP)) (rhs : (MontyField31 FP)) => do
    let long_prod : u64 ←
      ((← (rust_primitives.hax.cast_op (MontyField31.value self) : RustM u64))
        *? (← (rust_primitives.hax.cast_op
          (MontyField31.value rhs) :
          RustM u64)));
    (Impl.new_monty FP (← (p3_monty_31.utils.monty_reduce FP long_prod)))

@[reducible] instance Impl_44.AssociatedTypes
  (FP : Type)
  (T : Type)
  [trait_constr_Impl_44_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_44_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_44_associated_type_i1 :
    core_models.convert.Into.AssociatedTypes
    T
    (MontyField31 FP)]
  [trait_constr_Impl_44_i1 : core_models.convert.Into T (MontyField31 FP) ] :
  core_models.ops.arith.MulAssign.AssociatedTypes (MontyField31 FP) T
  where

instance Impl_44
  (FP : Type)
  (T : Type)
  [trait_constr_Impl_44_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_44_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_44_associated_type_i1 :
    core_models.convert.Into.AssociatedTypes
    T
    (MontyField31 FP)]
  [trait_constr_Impl_44_i1 : core_models.convert.Into T (MontyField31 FP) ] :
  core_models.ops.arith.MulAssign (MontyField31 FP) T
  where
  mul_assign := fun (self : (MontyField31 FP)) (rhs : T) => do
    let self : (MontyField31 FP) ←
      (core_models.ops.arith.Mul.mul
        (MontyField31 FP)
        (MontyField31 FP)
        self
        (← (core_models.convert.Into.into T (MontyField31 FP) rhs)));
    (pure self)

end p3_monty_31.monty_31


namespace p3_monty_31.utils

--  Convert a u32 out of MONTY form.
--  There are no constraints on the input.
--  The output will be a u32 in range `[0, P)`.
@[spec]
def from_monty
    (MP : Type)
    [trait_constr_from_monty_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_from_monty_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (x : u32) :
    RustM u32 := do
  (monty_reduce MP (← (rust_primitives.hax.cast_op x : RustM u64)))

end p3_monty_31.utils


namespace p3_monty_31.monty_31

--  Produce a u32 in range [0, P) from a field element corresponding to the true value.
@[spec]
def Impl.to_u32
    (MP : Type)
    [trait_constr_to_u32_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_to_u32_i0 : p3_monty_31.data_traits.MontyParameters MP ]
    (elem : (MontyField31 MP)) :
    RustM u32 := do
  (p3_monty_31.utils.from_monty MP (MontyField31.value elem))

@[reducible] instance Impl_4.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_4_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_4_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.fmt.Display.AssociatedTypes (MontyField31 FP)
  where

instance Impl_4
  (FP : Type)
  [trait_constr_Impl_4_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_4_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.fmt.Display (MontyField31 FP)
  where
  fmt := fun (self : (MontyField31 FP)) (f : core_models.fmt.Formatter) => do
    let ⟨tmp0, out⟩ ←
      (core_models.fmt.Display.fmt u32 (← (Impl.to_u32 FP self)) f);
    let f : core_models.fmt.Formatter := tmp0;
    let
      hax_temp_output : (core_models.result.Result
        rust_primitives.hax.Tuple0
        core_models.fmt.Error) :=
      out;
    (pure (rust_primitives.hax.Tuple2.mk f hax_temp_output))

@[reducible] instance Impl_5.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_5_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_5_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.fmt.Debug.AssociatedTypes (MontyField31 FP)
  where

instance Impl_5
  (FP : Type)
  [trait_constr_Impl_5_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_5_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.fmt.Debug (MontyField31 FP)
  where
  dbg_fmt := fun (self : (MontyField31 FP)) (f : core_models.fmt.Formatter) => do
    let ⟨tmp0, out⟩ ←
      (core_models.fmt.Debug.dbg_fmt u32 (← (Impl.to_u32 FP self)) f);
    let f : core_models.fmt.Formatter := tmp0;
    let
      hax_temp_output : (core_models.result.Result
        rust_primitives.hax.Tuple0
        core_models.fmt.Error) :=
      out;
    (pure (rust_primitives.hax.Tuple2.mk f hax_temp_output))

end p3_monty_31.monty_31


namespace p3_monty_31.utils

--  Montgomery reduction of a value in `0..P << MONTY_BITS`.
--  The input must be in [0, 2 * MONTY * P).
--  The output will be in [0, P).
-- 
--  This is slower than `monty_reduce` but has a larger input range.
@[spec]
def large_monty_reduce
    (MP : Type)
    [trait_constr_large_monty_reduce_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_large_monty_reduce_i0 :
      p3_monty_31.data_traits.MontyParameters
      MP
      ]
    (x : u64) :
    RustM u32 := do
  let t : u64 ←
    ((← (core_models.num.Impl_9.wrapping_mul
        x
        (← (rust_primitives.hax.cast_op
          (p3_monty_31.data_traits.MontyParameters.MONTY_MU MP) :
          RustM u64))))
      &&&? (← (rust_primitives.hax.cast_op
        (p3_monty_31.data_traits.MontyParameters.MONTY_MASK MP) :
        RustM u64)));
  let u : u64 ←
    (t
      *? (← (rust_primitives.hax.cast_op
        (p3_monty_31.data_traits.MontyParameters.PRIME MP) :
        RustM u64)));
  let ⟨x_prime, over⟩ ←
    (core_models.num.Impl_9.overflowing_sub
      x
      (← ((← (rust_primitives.hax.cast_op
          (p3_monty_31.data_traits.MontyParameters.PRIME MP) :
          RustM u64))
        <<<? (p3_monty_31.data_traits.MontyParameters.MONTY_BITS MP))));
  let x_corr : u64 ← if over then do (pure x) else do (pure x_prime);
  let ⟨x_sub_u, over⟩ ← (core_models.num.Impl_9.overflowing_sub x_corr u);
  let x_sub_u_hi : u32 ←
    (rust_primitives.hax.cast_op
      (← (x_sub_u >>>? (p3_monty_31.data_traits.MontyParameters.MONTY_BITS MP)))
      :
      RustM u32);
  let corr : u32 ←
    if over then do
      (pure (p3_monty_31.data_traits.MontyParameters.PRIME MP))
    else do
      (pure (0 : u32));
  (core_models.num.Impl_8.wrapping_add x_sub_u_hi corr)

--  Montgomery reduction of a 128-bit value, returning `x * R^{-1} mod P`.
-- 
--  where `R = 2^MONTY_BITS = 2^32`.
-- 
--  # Preconditions
-- 
--  - Input must satisfy `x < 2^96`.
--  - Output is in `[0, P)`.
@[spec]
def monty_reduce_u128
    (MP : Type)
    [trait_constr_monty_reduce_u128_associated_type_i0 :
      p3_monty_31.data_traits.MontyParameters.AssociatedTypes
      MP]
    [trait_constr_monty_reduce_u128_i0 : p3_monty_31.data_traits.MontyParameters
      MP
      ]
    (x : u128) :
    RustM u32 := do
  let _ ←
    if true then do
      let _ ← (hax_lib.assert (← (x <? (← ((1 : u128) <<<? (96 : i32))))));
      (pure rust_primitives.hax.Tuple0.mk)
    else do
      (pure rust_primitives.hax.Tuple0.mk);
  let lo : u64 ← (rust_primitives.hax.cast_op x : RustM u64);
  let hi : u32 ←
    (rust_primitives.hax.cast_op (← (x >>>? (64 : i32))) : RustM u32);
  let two_rp : u64 ←
    ((← ((← (rust_primitives.hax.cast_op
          (p3_monty_31.data_traits.MontyParameters.PRIME MP) :
          RustM u64))
        <<<? (p3_monty_31.data_traits.MontyParameters.MONTY_BITS MP)))
      <<<? (1 : i32));
  let lo_reduced : u64 ←
    if (← (lo >=? two_rp)) then do (lo -? two_rp) else do (pure lo);
  let r : u32 ← (large_monty_reduce MP lo_reduced);
  let hi_r_mod_p : u32 ← (to_monty MP hi);
  (add MP hi_r_mod_p r)

end p3_monty_31.utils


namespace p3_monty_31.no_packing.poseidon1

--  The internal (partial round) layer of the Poseidon1 permutation for Monty31 fields.
structure Poseidon1InternalLayerMonty31
  (MP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Poseidon1InternalLayerMonty31_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Poseidon1InternalLayerMonty31_i0 :
    p3_monty_31.data_traits.MontyParameters
    MP
    ]
  [trait_constr_Poseidon1InternalLayerMonty31_associated_type_i1 :
    p3_monty_31.poseidon1.PartialRoundBaseParameters.AssociatedTypes
    ILP
    MP
    (WIDTH)]
  [trait_constr_Poseidon1InternalLayerMonty31_i1 :
    p3_monty_31.poseidon1.PartialRoundBaseParameters
    ILP
    MP
    (WIDTH)
    ]
  where
  internal_constants : (p3_poseidon1.internal.PartialRoundConstants
      (p3_monty_31.monty_31.MontyField31 MP)
      (WIDTH))
  _phantom : (core_models.marker.PhantomData ILP)

@[instance] opaque Impl_2.AssociatedTypes
  (MP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    core_models.fmt.Debug.AssociatedTypes
    MP]
  [trait_constr_Impl_2_i0 : core_models.fmt.Debug MP ]
  [trait_constr_Impl_2_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_2_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_2_associated_type_i2 :
    core_models.fmt.Debug.AssociatedTypes
    ILP]
  [trait_constr_Impl_2_i2 : core_models.fmt.Debug ILP ]
  [trait_constr_Impl_2_associated_type_i3 :
    p3_monty_31.poseidon1.PartialRoundBaseParameters.AssociatedTypes
    ILP
    MP
    (WIDTH)]
  [trait_constr_Impl_2_i3 : p3_monty_31.poseidon1.PartialRoundBaseParameters
    ILP
    MP
    (WIDTH)
    ] :
  core_models.fmt.Debug.AssociatedTypes
  (Poseidon1InternalLayerMonty31 MP (WIDTH) ILP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_2
  (MP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    core_models.fmt.Debug.AssociatedTypes
    MP]
  [trait_constr_Impl_2_i0 : core_models.fmt.Debug MP ]
  [trait_constr_Impl_2_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_2_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_2_associated_type_i2 :
    core_models.fmt.Debug.AssociatedTypes
    ILP]
  [trait_constr_Impl_2_i2 : core_models.fmt.Debug ILP ]
  [trait_constr_Impl_2_associated_type_i3 :
    p3_monty_31.poseidon1.PartialRoundBaseParameters.AssociatedTypes
    ILP
    MP
    (WIDTH)]
  [trait_constr_Impl_2_i3 : p3_monty_31.poseidon1.PartialRoundBaseParameters
    ILP
    MP
    (WIDTH)
    ] :
  core_models.fmt.Debug (Poseidon1InternalLayerMonty31 MP (WIDTH) ILP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_3.AssociatedTypes
  (MP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MP]
  [trait_constr_Impl_3_i0 : core_models.clone.Clone MP ]
  [trait_constr_Impl_3_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_3_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_3_associated_type_i2 :
    core_models.clone.Clone.AssociatedTypes
    ILP]
  [trait_constr_Impl_3_i2 : core_models.clone.Clone ILP ]
  [trait_constr_Impl_3_associated_type_i3 :
    p3_monty_31.poseidon1.PartialRoundBaseParameters.AssociatedTypes
    ILP
    MP
    (WIDTH)]
  [trait_constr_Impl_3_i3 : p3_monty_31.poseidon1.PartialRoundBaseParameters
    ILP
    MP
    (WIDTH)
    ] :
  core_models.clone.Clone.AssociatedTypes
  (Poseidon1InternalLayerMonty31 MP (WIDTH) ILP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_3
  (MP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MP]
  [trait_constr_Impl_3_i0 : core_models.clone.Clone MP ]
  [trait_constr_Impl_3_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_3_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_3_associated_type_i2 :
    core_models.clone.Clone.AssociatedTypes
    ILP]
  [trait_constr_Impl_3_i2 : core_models.clone.Clone ILP ]
  [trait_constr_Impl_3_associated_type_i3 :
    p3_monty_31.poseidon1.PartialRoundBaseParameters.AssociatedTypes
    ILP
    MP
    (WIDTH)]
  [trait_constr_Impl_3_i3 : p3_monty_31.poseidon1.PartialRoundBaseParameters
    ILP
    MP
    (WIDTH)
    ] :
  core_models.clone.Clone (Poseidon1InternalLayerMonty31 MP (WIDTH) ILP) :=
  by constructor <;> exact Inhabited.default

--  The external (full round) layer of the Poseidon1 permutation for Monty31 fields.
structure Poseidon1ExternalLayerMonty31
  (MP : Type)
  (MU : Type)
  (WIDTH : usize)
  [trait_constr_Poseidon1ExternalLayerMonty31_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Poseidon1ExternalLayerMonty31_i0 :
    p3_monty_31.data_traits.MontyParameters
    MP
    ]
  [trait_constr_Poseidon1ExternalLayerMonty31_associated_type_i1 :
    p3_monty_31.mds.MDSUtils.AssociatedTypes
    MU]
  [trait_constr_Poseidon1ExternalLayerMonty31_i1 : p3_monty_31.mds.MDSUtils MU ]
  where
  external_constants : (p3_poseidon1.external.FullRoundConstants
      (p3_monty_31.monty_31.MontyField31 MP)
      (WIDTH))
  _mds : (core_models.marker.PhantomData MU)

@[instance] opaque Impl_4.AssociatedTypes
  (MP : Type)
  (MU : Type)
  (WIDTH : usize)
  [trait_constr_Impl_4_associated_type_i0 :
    core_models.fmt.Debug.AssociatedTypes
    MP]
  [trait_constr_Impl_4_i0 : core_models.fmt.Debug MP ]
  [trait_constr_Impl_4_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_4_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_4_associated_type_i2 :
    core_models.fmt.Debug.AssociatedTypes
    MU]
  [trait_constr_Impl_4_i2 : core_models.fmt.Debug MU ]
  [trait_constr_Impl_4_associated_type_i3 :
    p3_monty_31.mds.MDSUtils.AssociatedTypes
    MU]
  [trait_constr_Impl_4_i3 : p3_monty_31.mds.MDSUtils MU ] :
  core_models.fmt.Debug.AssociatedTypes
  (Poseidon1ExternalLayerMonty31 MP MU (WIDTH)) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_4
  (MP : Type)
  (MU : Type)
  (WIDTH : usize)
  [trait_constr_Impl_4_associated_type_i0 :
    core_models.fmt.Debug.AssociatedTypes
    MP]
  [trait_constr_Impl_4_i0 : core_models.fmt.Debug MP ]
  [trait_constr_Impl_4_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_4_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_4_associated_type_i2 :
    core_models.fmt.Debug.AssociatedTypes
    MU]
  [trait_constr_Impl_4_i2 : core_models.fmt.Debug MU ]
  [trait_constr_Impl_4_associated_type_i3 :
    p3_monty_31.mds.MDSUtils.AssociatedTypes
    MU]
  [trait_constr_Impl_4_i3 : p3_monty_31.mds.MDSUtils MU ] :
  core_models.fmt.Debug (Poseidon1ExternalLayerMonty31 MP MU (WIDTH)) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_5.AssociatedTypes
  (MP : Type)
  (MU : Type)
  (WIDTH : usize)
  [trait_constr_Impl_5_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MP]
  [trait_constr_Impl_5_i0 : core_models.clone.Clone MP ]
  [trait_constr_Impl_5_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_5_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_5_associated_type_i2 :
    core_models.clone.Clone.AssociatedTypes
    MU]
  [trait_constr_Impl_5_i2 : core_models.clone.Clone MU ]
  [trait_constr_Impl_5_associated_type_i3 :
    p3_monty_31.mds.MDSUtils.AssociatedTypes
    MU]
  [trait_constr_Impl_5_i3 : p3_monty_31.mds.MDSUtils MU ] :
  core_models.clone.Clone.AssociatedTypes
  (Poseidon1ExternalLayerMonty31 MP MU (WIDTH)) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_5
  (MP : Type)
  (MU : Type)
  (WIDTH : usize)
  [trait_constr_Impl_5_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MP]
  [trait_constr_Impl_5_i0 : core_models.clone.Clone MP ]
  [trait_constr_Impl_5_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_5_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_5_associated_type_i2 :
    core_models.clone.Clone.AssociatedTypes
    MU]
  [trait_constr_Impl_5_i2 : core_models.clone.Clone MU ]
  [trait_constr_Impl_5_associated_type_i3 :
    p3_monty_31.mds.MDSUtils.AssociatedTypes
    MU]
  [trait_constr_Impl_5_i3 : p3_monty_31.mds.MDSUtils MU ] :
  core_models.clone.Clone (Poseidon1ExternalLayerMonty31 MP MU (WIDTH)) :=
  by constructor <;> exact Inhabited.default

@[reducible] instance Impl.AssociatedTypes
  (FP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_associated_type_i1 :
    p3_monty_31.poseidon1.PartialRoundBaseParameters.AssociatedTypes
    ILP
    FP
    (WIDTH)]
  [trait_constr_Impl_i1 : p3_monty_31.poseidon1.PartialRoundBaseParameters
    ILP
    FP
    (WIDTH)
    ] :
  p3_poseidon1.internal.PartialRoundLayerConstructor.AssociatedTypes
  (Poseidon1InternalLayerMonty31 FP (WIDTH) ILP)
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  where

instance Impl
  (FP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_associated_type_i1 :
    p3_monty_31.poseidon1.PartialRoundBaseParameters.AssociatedTypes
    ILP
    FP
    (WIDTH)]
  [trait_constr_Impl_i1 : p3_monty_31.poseidon1.PartialRoundBaseParameters
    ILP
    FP
    (WIDTH)
    ] :
  p3_poseidon1.internal.PartialRoundLayerConstructor
  (Poseidon1InternalLayerMonty31 FP (WIDTH) ILP)
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH) := sorry

@[reducible] instance Impl_1.AssociatedTypes
  (FP : Type)
  (MU : Type)
  (WIDTH : usize)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_1_associated_type_i1 :
    p3_monty_31.mds.MDSUtils.AssociatedTypes
    MU]
  [trait_constr_Impl_1_i1 : p3_monty_31.mds.MDSUtils MU ] :
  p3_poseidon1.external.FullRoundLayerConstructor.AssociatedTypes
  (Poseidon1ExternalLayerMonty31 FP MU (WIDTH))
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  where

instance Impl_1
  (FP : Type)
  (MU : Type)
  (WIDTH : usize)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_1_associated_type_i1 :
    p3_monty_31.mds.MDSUtils.AssociatedTypes
    MU]
  [trait_constr_Impl_1_i1 : p3_monty_31.mds.MDSUtils MU ] :
  p3_poseidon1.external.FullRoundLayerConstructor
  (Poseidon1ExternalLayerMonty31 FP MU (WIDTH))
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH) := sorry

end p3_monty_31.no_packing.poseidon1


namespace p3_monty_31.no_packing.poseidon2

--  The external layers of the Poseidon2 permutation for Monty31 fields.
structure Poseidon2ExternalLayerMonty31
  (MP : Type)
  (WIDTH : usize)
  [trait_constr_Poseidon2ExternalLayerMonty31_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Poseidon2ExternalLayerMonty31_i0 :
    p3_monty_31.data_traits.MontyParameters
    MP
    ]
  where
  external_constants : (p3_poseidon2.external.ExternalLayerConstants
      (p3_monty_31.monty_31.MontyField31 MP)
      (WIDTH))

@[instance] opaque Impl_4.AssociatedTypes
  (MP : Type)
  (WIDTH : usize)
  [trait_constr_Impl_4_associated_type_i0 :
    core_models.fmt.Debug.AssociatedTypes
    MP]
  [trait_constr_Impl_4_i0 : core_models.fmt.Debug MP ]
  [trait_constr_Impl_4_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_4_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.fmt.Debug.AssociatedTypes
  (Poseidon2ExternalLayerMonty31 MP (WIDTH)) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_4
  (MP : Type)
  (WIDTH : usize)
  [trait_constr_Impl_4_associated_type_i0 :
    core_models.fmt.Debug.AssociatedTypes
    MP]
  [trait_constr_Impl_4_i0 : core_models.fmt.Debug MP ]
  [trait_constr_Impl_4_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_4_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.fmt.Debug (Poseidon2ExternalLayerMonty31 MP (WIDTH)) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_5.AssociatedTypes
  (MP : Type)
  (WIDTH : usize)
  [trait_constr_Impl_5_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MP]
  [trait_constr_Impl_5_i0 : core_models.clone.Clone MP ]
  [trait_constr_Impl_5_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_5_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.clone.Clone.AssociatedTypes
  (Poseidon2ExternalLayerMonty31 MP (WIDTH)) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_5
  (MP : Type)
  (WIDTH : usize)
  [trait_constr_Impl_5_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MP]
  [trait_constr_Impl_5_i0 : core_models.clone.Clone MP ]
  [trait_constr_Impl_5_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_5_i1 : p3_monty_31.data_traits.MontyParameters MP ] :
  core_models.clone.Clone (Poseidon2ExternalLayerMonty31 MP (WIDTH)) :=
  by constructor <;> exact Inhabited.default

end p3_monty_31.no_packing.poseidon2


namespace p3_monty_31.poseidon2

@[reducible] instance Impl_1.AssociatedTypes
  (FP : Type)
  (WIDTH : usize)
  (D : u64)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_1_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_1_i1 : p3_monty_31.data_traits.RelativelyPrimePower
    FP
    (D)
    ] :
  p3_poseidon2.external.ExternalLayer.AssociatedTypes
  (p3_monty_31.no_packing.poseidon2.Poseidon2ExternalLayerMonty31 FP (WIDTH))
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  (D)
  where

instance Impl_1
  (FP : Type)
  (WIDTH : usize)
  (D : u64)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_1_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_1_i1 : p3_monty_31.data_traits.RelativelyPrimePower
    FP
    (D)
    ] :
  p3_poseidon2.external.ExternalLayer
  (p3_monty_31.no_packing.poseidon2.Poseidon2ExternalLayerMonty31 FP (WIDTH))
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  (D) := sorry

end p3_monty_31.poseidon2


namespace p3_monty_31.no_packing.poseidon2

@[reducible] instance Impl_1.AssociatedTypes
  (FP : Type)
  (WIDTH : usize)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_poseidon2.external.ExternalLayerConstructor.AssociatedTypes
  (Poseidon2ExternalLayerMonty31 FP (WIDTH))
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  where

instance Impl_1
  (FP : Type)
  (WIDTH : usize)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_poseidon2.external.ExternalLayerConstructor
  (Poseidon2ExternalLayerMonty31 FP (WIDTH))
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH) := sorry

end p3_monty_31.no_packing.poseidon2


namespace p3_monty_31.no_packing

--  Multiplication by a base field element in a binomial extension field.
@[spec]
def base_mul_packed
    (FP : Type)
    (WIDTH : usize)
    [trait_constr_base_mul_packed_associated_type_i0 :
      p3_monty_31.data_traits.FieldParameters.AssociatedTypes
      FP]
    [trait_constr_base_mul_packed_i0 : p3_monty_31.data_traits.FieldParameters
      FP
      ]
    (a : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH))
    (b : (p3_monty_31.monty_31.MontyField31 FP))
    (res : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH)) :
    RustM (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH) := do
  (pure res)

end p3_monty_31.no_packing


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
      (do
      (rust_primitives.hax.cast_op (MontyParameters.PRIME Self) : RustM i128))
      (by sorry)
  PSEUDO_INV (Self) :i64 := sorry
  MASK (Self) :i64 := sorry

attribute [instance_reducible, instance]
  BarrettParameters.trait_constr_BarrettParameters_i0

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

--  TODO: This should be deleted long term once we have improved our API for defining extension fields.
--  This allows us to implement Binomial Extensions over Monty31 fields.
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
  [trait_constr_ArrayLike_associated_type_i1 :
    core_models.convert.AsRef.AssociatedTypes
    associatedTypes.ArrayLike
    (RustSlice (RustArray (p3_monty_31.monty_31.MontyField31 Self) DEG))]
  [trait_constr_ArrayLike_i1 : core_models.convert.AsRef
    associatedTypes.ArrayLike
    (RustSlice (RustArray (p3_monty_31.monty_31.MontyField31 Self) DEG))
    ]
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
      ] (a : A) :RustM A := sorry
  DTH_ROOT (Self) (DEG) : (p3_monty_31.monty_31.MontyField31 Self)
  EXT_GENERATOR (Self) (DEG) :
    (RustArray (p3_monty_31.monty_31.MontyField31 Self) DEG)
  EXT_TWO_ADICITY (Self) (DEG) : usize
  TWO_ADIC_EXTENSION_GENERATORS (Self) (DEG) : associatedTypes.ArrayLike

attribute [instance_reducible, instance]
  BinomialExtensionData.trait_constr_BinomialExtensionData_i0

--  Data for a quintic extension using the trinomial polynomial `X^5 + X^2 - 1`.
-- 
--  This is required for fields where 5 does not divide `(P - 1)`, making simple
--  binomial extensions `X^5 - W` impossible.
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
  [trait_constr_ArrayLike_associated_type_i1 :
    core_models.convert.AsRef.AssociatedTypes
    associatedTypes.ArrayLike
    (RustSlice (RustArray (p3_monty_31.monty_31.MontyField31 Self) 5))]
  [trait_constr_ArrayLike_i1 : core_models.convert.AsRef
    associatedTypes.ArrayLike
    (RustSlice (RustArray (p3_monty_31.monty_31.MontyField31 Self) 5))
    ]
  EXT_GENERATOR (Self) : (RustArray (p3_monty_31.monty_31.MontyField31 Self) 5)
  EXT_TWO_ADICITY (Self) : usize
  FROBENIUS_COEFFS (Self) :
    (RustArray (RustArray (p3_monty_31.monty_31.MontyField31 Self) 5) 4)
  TWO_ADIC_EXTENSION_GENERATORS (Self) : associatedTypes.ArrayLike

attribute [instance_reducible, instance]
  TrinomialQuinticData.trait_constr_TrinomialQuinticData_i0

end p3_monty_31.data_traits


namespace p3_monty_31.monty_31

@[reducible] instance Impl_3.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_3_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.cmp.PartialOrd.AssociatedTypes (MontyField31 FP) (MontyField31 FP)
  where

instance Impl_3
  (FP : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_3_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.cmp.PartialOrd (MontyField31 FP) (MontyField31 FP)
  where
  partial_cmp := sorry

@[reducible] instance Impl_2.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.cmp.Ord.AssociatedTypes (MontyField31 FP)
  where

instance Impl_2
  (FP : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i0 : p3_monty_31.data_traits.MontyParameters FP ] :
  core_models.cmp.Ord (MontyField31 FP)
  where
  cmp := fun (self : (MontyField31 FP)) (other : (MontyField31 FP)) => do
    (core_models.cmp.Ord.cmp
      u32 (← (Impl.to_u32 FP self)) (← (Impl.to_u32 FP other)))

end p3_monty_31.monty_31


namespace p3_monty_31.poseidon2

--  Trait which handles the Poseidon2 internal layers.
-- 
--  Everything needed to compute multiplication by a `WIDTH x WIDTH` diffusion matrix whose monty form is `1 + Diag(vec)`.
--  vec is assumed to be of the form `[-2, ...]` with all entries after the first being small powers of `2`.
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
  generic_internal_linear_layer (Self) (MP) (WIDTH)
    (R : Type)
    [trait_constr_generic_internal_linear_layer_associated_type_i1 :
      p3_field.field.PrimeCharacteristicRing.AssociatedTypes
      R]
    [trait_constr_generic_internal_linear_layer_i1 :
      p3_field.field.PrimeCharacteristicRing
      R
      ] (state : (RustArray R WIDTH)) :RustM (RustArray R WIDTH) := sorry

attribute [instance_reducible, instance]
  InternalLayerBaseParameters.trait_constr_InternalLayerBaseParameters_i0

attribute [instance_reducible, instance]
  InternalLayerBaseParameters.trait_constr_InternalLayerBaseParameters_i1

attribute [instance_reducible, instance]
  InternalLayerBaseParameters.trait_constr_InternalLayerBaseParameters_i2

end p3_monty_31.poseidon2


namespace p3_monty_31.mds

--  Given |x| < 2^80 compute x' such that:
--  |x'| < 2**50
--  x' = x mod p
--  x' = x mod 2^10
--  See Thm 1 (Below function) for a proof that this function is correct.
@[spec]
def barrett_red_monty31
    (BP : Type)
    [trait_constr_barrett_red_monty31_associated_type_i0 :
      p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
      BP]
    [trait_constr_barrett_red_monty31_i0 :
      p3_monty_31.data_traits.BarrettParameters
      BP
      ]
    (input : i128) :
    RustM i64 := do
  let input_high : i64 ←
    (rust_primitives.hax.cast_op
      (← (input >>>? (p3_monty_31.data_traits.BarrettParameters.N BP))) :
      RustM i64);
  let quot : i64 ←
    (rust_primitives.hax.cast_op
      (← ((← ((← (rust_primitives.hax.cast_op input_high : RustM i128))
          *? (← (rust_primitives.hax.cast_op
            (p3_monty_31.data_traits.BarrettParameters.PSEUDO_INV BP) :
            RustM i128))))
        >>>? (p3_monty_31.data_traits.BarrettParameters.N BP))) :
      RustM i64);
  let quot_2adic : i64 ←
    (quot &&&? (p3_monty_31.data_traits.BarrettParameters.MASK BP));
  let sub : i128 ←
    ((← (rust_primitives.hax.cast_op quot_2adic : RustM i128))
      *? (p3_monty_31.data_traits.BarrettParameters.PRIME_I128 BP));
  (rust_primitives.hax.cast_op (← (input -? sub)) : RustM i64)

@[reducible] instance Impl_1.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.BarrettParameters FP ] :
  p3_mds.karatsuba_convolution.Convolve.AssociatedTypes
  LargeConvolveMontyField31
  (p3_monty_31.monty_31.MontyField31 FP)
  i64
  i64
  where

instance Impl_1
  (FP : Type)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.BarrettParameters FP ] :
  p3_mds.karatsuba_convolution.Convolve
  LargeConvolveMontyField31
  (p3_monty_31.monty_31.MontyField31 FP)
  i64
  i64 := sorry

@[reducible] instance Impl_8.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_8_associated_type_i0 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_8_i0 : MDSUtils MU ]
  [trait_constr_Impl_8_associated_type_i1 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_8_i1 : p3_monty_31.data_traits.BarrettParameters FP ] :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 24)
  where

instance Impl_8
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_8_associated_type_i0 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_8_i0 : MDSUtils MU ]
  [trait_constr_Impl_8_associated_type_i1 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_8_i1 : p3_monty_31.data_traits.BarrettParameters FP ] :
  p3_symmetric.permutation.Permutation
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 24)
  where
  permute :=
    fun
      (self : (MdsMatrixMontyField31 MU))
      (input : (RustArray (p3_monty_31.monty_31.MontyField31 FP) 24)) => do
    (pure sorry)

@[reducible] instance Impl_9.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_9_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_9_i0 : p3_monty_31.data_traits.BarrettParameters FP ]
  [trait_constr_Impl_9_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_9_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((24 : usize))
  where

instance Impl_9
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_9_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_9_i0 : p3_monty_31.data_traits.BarrettParameters FP ]
  [trait_constr_Impl_9_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_9_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((24 : usize)) := sorry

@[reducible] instance Impl_10.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_10_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_10_i0 : p3_monty_31.data_traits.BarrettParameters FP ]
  [trait_constr_Impl_10_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_10_i1 : MDSUtils MU ] :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 32)
  where

instance Impl_10
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_10_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_10_i0 : p3_monty_31.data_traits.BarrettParameters FP ]
  [trait_constr_Impl_10_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_10_i1 : MDSUtils MU ] :
  p3_symmetric.permutation.Permutation
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 32)
  where
  permute :=
    fun
      (self : (MdsMatrixMontyField31 MU))
      (input : (RustArray (p3_monty_31.monty_31.MontyField31 FP) 32)) => do
    (pure sorry)

@[reducible] instance Impl_11.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_11_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_11_i0 : p3_monty_31.data_traits.BarrettParameters FP ]
  [trait_constr_Impl_11_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_11_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((32 : usize))
  where

instance Impl_11
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_11_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_11_i0 : p3_monty_31.data_traits.BarrettParameters FP ]
  [trait_constr_Impl_11_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_11_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((32 : usize)) := sorry

@[reducible] instance Impl_12.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_12_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_12_i0 : p3_monty_31.data_traits.BarrettParameters FP ]
  [trait_constr_Impl_12_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_12_i1 : MDSUtils MU ] :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 64)
  where

instance Impl_12
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_12_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_12_i0 : p3_monty_31.data_traits.BarrettParameters FP ]
  [trait_constr_Impl_12_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_12_i1 : MDSUtils MU ] :
  p3_symmetric.permutation.Permutation
  (MdsMatrixMontyField31 MU)
  (RustArray (p3_monty_31.monty_31.MontyField31 FP) 64)
  where
  permute :=
    fun
      (self : (MdsMatrixMontyField31 MU))
      (input : (RustArray (p3_monty_31.monty_31.MontyField31 FP) 64)) => do
    (pure sorry)

@[reducible] instance Impl_13.AssociatedTypes
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_13_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_13_i0 : p3_monty_31.data_traits.BarrettParameters FP ]
  [trait_constr_Impl_13_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_13_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation.AssociatedTypes
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((64 : usize))
  where

instance Impl_13
  (FP : Type)
  (MU : Type)
  [trait_constr_Impl_13_associated_type_i0 :
    p3_monty_31.data_traits.BarrettParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_13_i0 : p3_monty_31.data_traits.BarrettParameters FP ]
  [trait_constr_Impl_13_associated_type_i1 : MDSUtils.AssociatedTypes MU]
  [trait_constr_Impl_13_i1 : MDSUtils MU ] :
  p3_mds.MdsPermutation
  (MdsMatrixMontyField31 MU)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((64 : usize)) := sorry

end p3_monty_31.mds


namespace p3_monty_31.poseidon2

class InternalLayerParameters.AssociatedTypes
  (Self : Type)
  (FP : Type)
  (WIDTH : usize)
  where
  [trait_constr_InternalLayerParameters_i0 :
  InternalLayerBaseParameters.AssociatedTypes
  Self
  FP
  (WIDTH)]
  [trait_constr_InternalLayerParameters_i1 :
  p3_monty_31.data_traits.FieldParameters.AssociatedTypes
  FP]

attribute [instance_reducible, instance]
  InternalLayerParameters.AssociatedTypes.trait_constr_InternalLayerParameters_i0

attribute [instance_reducible, instance]
  InternalLayerParameters.AssociatedTypes.trait_constr_InternalLayerParameters_i1

class InternalLayerParameters (Self : Type) (FP : Type) (WIDTH : usize)
  [associatedTypes : outParam (InternalLayerParameters.AssociatedTypes (Self :
      Type) (FP : Type) (WIDTH : usize))]
  where
  [trait_constr_InternalLayerParameters_i0 :
  InternalLayerBaseParameters
  Self
  FP
  (WIDTH)]
  [trait_constr_InternalLayerParameters_i1 :
  p3_monty_31.data_traits.FieldParameters
  FP]

attribute [instance_reducible, instance]
  InternalLayerParameters.trait_constr_InternalLayerParameters_i0

attribute [instance_reducible, instance]
  InternalLayerParameters.trait_constr_InternalLayerParameters_i1

@[reducible] instance Impl_2.AssociatedTypes
  (FP : Type)
  (ILBP : Type)
  (WIDTH : usize)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_2_associated_type_i1 :
    InternalLayerBaseParameters.AssociatedTypes
    ILBP
    FP
    (WIDTH)]
  [trait_constr_Impl_2_i1 : InternalLayerBaseParameters ILBP FP (WIDTH) ] :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers.AssociatedTypes
  (GenericPoseidon2LinearLayersMonty31 FP ILBP)
  (WIDTH)
  where

instance Impl_2
  (FP : Type)
  (ILBP : Type)
  (WIDTH : usize)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_2_associated_type_i1 :
    InternalLayerBaseParameters.AssociatedTypes
    ILBP
    FP
    (WIDTH)]
  [trait_constr_Impl_2_i1 : InternalLayerBaseParameters ILBP FP (WIDTH) ] :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers
  (GenericPoseidon2LinearLayersMonty31 FP ILBP)
  (WIDTH) := sorry

end p3_monty_31.poseidon2


namespace p3_monty_31.no_packing.poseidon2

--  The internal layers of the Poseidon2 permutation for Monty31 fields.
structure Poseidon2InternalLayerMonty31
  (MP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Poseidon2InternalLayerMonty31_associated_type_i0 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Poseidon2InternalLayerMonty31_i0 :
    p3_monty_31.data_traits.MontyParameters
    MP
    ]
  [trait_constr_Poseidon2InternalLayerMonty31_associated_type_i1 :
    p3_monty_31.poseidon2.InternalLayerBaseParameters.AssociatedTypes
    ILP
    MP
    (WIDTH)]
  [trait_constr_Poseidon2InternalLayerMonty31_i1 :
    p3_monty_31.poseidon2.InternalLayerBaseParameters
    ILP
    MP
    (WIDTH)
    ]
  where
  internal_constants : (alloc.vec.Vec
      (p3_monty_31.monty_31.MontyField31 MP)
      alloc.alloc.Global)
  _phantom : (core_models.marker.PhantomData ILP)

@[instance] opaque Impl_2.AssociatedTypes
  (MP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    core_models.fmt.Debug.AssociatedTypes
    MP]
  [trait_constr_Impl_2_i0 : core_models.fmt.Debug MP ]
  [trait_constr_Impl_2_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_2_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_2_associated_type_i2 :
    core_models.fmt.Debug.AssociatedTypes
    ILP]
  [trait_constr_Impl_2_i2 : core_models.fmt.Debug ILP ]
  [trait_constr_Impl_2_associated_type_i3 :
    p3_monty_31.poseidon2.InternalLayerBaseParameters.AssociatedTypes
    ILP
    MP
    (WIDTH)]
  [trait_constr_Impl_2_i3 : p3_monty_31.poseidon2.InternalLayerBaseParameters
    ILP
    MP
    (WIDTH)
    ] :
  core_models.fmt.Debug.AssociatedTypes
  (Poseidon2InternalLayerMonty31 MP (WIDTH) ILP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_2
  (MP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    core_models.fmt.Debug.AssociatedTypes
    MP]
  [trait_constr_Impl_2_i0 : core_models.fmt.Debug MP ]
  [trait_constr_Impl_2_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_2_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_2_associated_type_i2 :
    core_models.fmt.Debug.AssociatedTypes
    ILP]
  [trait_constr_Impl_2_i2 : core_models.fmt.Debug ILP ]
  [trait_constr_Impl_2_associated_type_i3 :
    p3_monty_31.poseidon2.InternalLayerBaseParameters.AssociatedTypes
    ILP
    MP
    (WIDTH)]
  [trait_constr_Impl_2_i3 : p3_monty_31.poseidon2.InternalLayerBaseParameters
    ILP
    MP
    (WIDTH)
    ] :
  core_models.fmt.Debug (Poseidon2InternalLayerMonty31 MP (WIDTH) ILP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_3.AssociatedTypes
  (MP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MP]
  [trait_constr_Impl_3_i0 : core_models.clone.Clone MP ]
  [trait_constr_Impl_3_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_3_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_3_associated_type_i2 :
    core_models.clone.Clone.AssociatedTypes
    ILP]
  [trait_constr_Impl_3_i2 : core_models.clone.Clone ILP ]
  [trait_constr_Impl_3_associated_type_i3 :
    p3_monty_31.poseidon2.InternalLayerBaseParameters.AssociatedTypes
    ILP
    MP
    (WIDTH)]
  [trait_constr_Impl_3_i3 : p3_monty_31.poseidon2.InternalLayerBaseParameters
    ILP
    MP
    (WIDTH)
    ] :
  core_models.clone.Clone.AssociatedTypes
  (Poseidon2InternalLayerMonty31 MP (WIDTH) ILP) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_3
  (MP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    core_models.clone.Clone.AssociatedTypes
    MP]
  [trait_constr_Impl_3_i0 : core_models.clone.Clone MP ]
  [trait_constr_Impl_3_associated_type_i1 :
    p3_monty_31.data_traits.MontyParameters.AssociatedTypes
    MP]
  [trait_constr_Impl_3_i1 : p3_monty_31.data_traits.MontyParameters MP ]
  [trait_constr_Impl_3_associated_type_i2 :
    core_models.clone.Clone.AssociatedTypes
    ILP]
  [trait_constr_Impl_3_i2 : core_models.clone.Clone ILP ]
  [trait_constr_Impl_3_associated_type_i3 :
    p3_monty_31.poseidon2.InternalLayerBaseParameters.AssociatedTypes
    ILP
    MP
    (WIDTH)]
  [trait_constr_Impl_3_i3 : p3_monty_31.poseidon2.InternalLayerBaseParameters
    ILP
    MP
    (WIDTH)
    ] :
  core_models.clone.Clone (Poseidon2InternalLayerMonty31 MP (WIDTH) ILP) :=
  by constructor <;> exact Inhabited.default

end p3_monty_31.no_packing.poseidon2


namespace p3_monty_31.poseidon2

@[reducible] instance Impl.AssociatedTypes
  (FP : Type)
  (WIDTH : usize)
  (P2P : Type)
  (D : u64)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_i1 : p3_monty_31.data_traits.RelativelyPrimePower FP (D) ]
  [trait_constr_Impl_associated_type_i2 :
    InternalLayerParameters.AssociatedTypes
    P2P
    FP
    (WIDTH)]
  [trait_constr_Impl_i2 : InternalLayerParameters P2P FP (WIDTH) ] :
  p3_poseidon2.internal.InternalLayer.AssociatedTypes
  (p3_monty_31.no_packing.poseidon2.Poseidon2InternalLayerMonty31
    FP
    (WIDTH)
    P2P)
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  (D)
  where

instance Impl
  (FP : Type)
  (WIDTH : usize)
  (P2P : Type)
  (D : u64)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_i1 : p3_monty_31.data_traits.RelativelyPrimePower FP (D) ]
  [trait_constr_Impl_associated_type_i2 :
    InternalLayerParameters.AssociatedTypes
    P2P
    FP
    (WIDTH)]
  [trait_constr_Impl_i2 : InternalLayerParameters P2P FP (WIDTH) ] :
  p3_poseidon2.internal.InternalLayer
  (p3_monty_31.no_packing.poseidon2.Poseidon2InternalLayerMonty31
    FP
    (WIDTH)
    P2P)
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  (D) := sorry

end p3_monty_31.poseidon2


namespace p3_monty_31.no_packing.poseidon2

@[reducible] instance Impl.AssociatedTypes
  (FP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_associated_type_i1 :
    p3_monty_31.poseidon2.InternalLayerBaseParameters.AssociatedTypes
    ILP
    FP
    (WIDTH)]
  [trait_constr_Impl_i1 : p3_monty_31.poseidon2.InternalLayerBaseParameters
    ILP
    FP
    (WIDTH)
    ] :
  p3_poseidon2.internal.InternalLayerConstructor.AssociatedTypes
  (Poseidon2InternalLayerMonty31 FP (WIDTH) ILP)
  (p3_monty_31.monty_31.MontyField31 FP)
  where

instance Impl
  (FP : Type)
  (WIDTH : usize)
  (ILP : Type)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_associated_type_i1 :
    p3_monty_31.poseidon2.InternalLayerBaseParameters.AssociatedTypes
    ILP
    FP
    (WIDTH)]
  [trait_constr_Impl_i1 : p3_monty_31.poseidon2.InternalLayerBaseParameters
    ILP
    FP
    (WIDTH)
    ] :
  p3_poseidon2.internal.InternalLayerConstructor
  (Poseidon2InternalLayerMonty31 FP (WIDTH) ILP)
  (p3_monty_31.monty_31.MontyField31 FP) := sorry

end p3_monty_31.no_packing.poseidon2


namespace p3_monty_31.monty_31

@[reducible] instance Impl_11.AssociatedTypes
  (FP : Type)
  (D : u64)
  [trait_constr_Impl_11_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_11_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_11_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_11_i1 : p3_monty_31.data_traits.RelativelyPrimePower
    FP
    (D)
    ] :
  p3_field.field.InjectiveMonomial.AssociatedTypes (MontyField31 FP) (D)
  where

instance Impl_11
  (FP : Type)
  (D : u64)
  [trait_constr_Impl_11_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_11_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_11_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_11_i1 : p3_monty_31.data_traits.RelativelyPrimePower
    FP
    (D)
    ] :
  p3_field.field.InjectiveMonomial (MontyField31 FP) (D) := sorry

@[reducible] instance Impl_12.AssociatedTypes
  (FP : Type)
  (D : u64)
  [trait_constr_Impl_12_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_12_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_12_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_12_i1 : p3_monty_31.data_traits.RelativelyPrimePower
    FP
    (D)
    ] :
  p3_field.field.PermutationMonomial.AssociatedTypes (MontyField31 FP) (D)
  where

instance Impl_12
  (FP : Type)
  (D : u64)
  [trait_constr_Impl_12_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_12_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_12_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_12_i1 : p3_monty_31.data_traits.RelativelyPrimePower
    FP
    (D)
    ] :
  p3_field.field.PermutationMonomial (MontyField31 FP) (D) := sorry

end p3_monty_31.monty_31


namespace p3_monty_31.no_packing

--  If no packings are available, we use the generic trinomial extension multiplication function.
@[spec]
def quintic_mul_packed_trinomial
    (FP : Type)
    [trait_constr_quintic_mul_packed_trinomial_associated_type_i0 :
      p3_monty_31.data_traits.FieldParameters.AssociatedTypes
      FP]
    [trait_constr_quintic_mul_packed_trinomial_i0 :
      p3_monty_31.data_traits.FieldParameters
      FP
      ]
    (a : (RustArray (p3_monty_31.monty_31.MontyField31 FP) 5))
    (b : (RustArray (p3_monty_31.monty_31.MontyField31 FP) 5))
    (res : (RustArray (p3_monty_31.monty_31.MontyField31 FP) 5)) :
    RustM (RustArray (p3_monty_31.monty_31.MontyField31 FP) 5) := do
  let res : (RustArray (p3_monty_31.monty_31.MontyField31 FP) 5) ←
    (p3_field.extension.quintic_extension.trinomial_quintic_mul
      (p3_monty_31.monty_31.MontyField31 FP) a b res);
  (pure res)

end p3_monty_31.no_packing


namespace p3_monty_31.extension

@[reducible] instance Impl_3.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    p3_monty_31.data_traits.TrinomialQuinticData.AssociatedTypes
    FP]
  [trait_constr_Impl_3_i0 : p3_monty_31.data_traits.TrinomialQuinticData FP ]
  [trait_constr_Impl_3_associated_type_i1 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_3_i1 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.ExtensionAlgebra.AssociatedTypes
  (p3_monty_31.monty_31.MontyField31 FP)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((5 : usize))
  p3_field.extension.QuinticTrinomial
  where

instance Impl_3
  (FP : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    p3_monty_31.data_traits.TrinomialQuinticData.AssociatedTypes
    FP]
  [trait_constr_Impl_3_i0 : p3_monty_31.data_traits.TrinomialQuinticData FP ]
  [trait_constr_Impl_3_associated_type_i1 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_3_i1 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.ExtensionAlgebra
  (p3_monty_31.monty_31.MontyField31 FP)
  (p3_monty_31.monty_31.MontyField31 FP)
  ((5 : usize))
  p3_field.extension.QuinticTrinomial := sorry

end p3_monty_31.extension


namespace p3_monty_31.monty_31

@[reducible] instance Impl_47.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_47_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_47_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  core_models.ops.arith.DivAssign.AssociatedTypes
  (MontyField31 FP)
  (MontyField31 FP)
  where

instance Impl_47
  (FP : Type)
  [trait_constr_Impl_47_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_47_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  core_models.ops.arith.DivAssign (MontyField31 FP) (MontyField31 FP)
  where
  div_assign := sorry

@[reducible] instance Impl_46.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_46_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_46_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  core_models.ops.arith.Div.AssociatedTypes (MontyField31 FP) (MontyField31 FP)
  where
  Output := (MontyField31 FP)

instance Impl_46
  (FP : Type)
  [trait_constr_Impl_46_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_46_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  core_models.ops.arith.Div (MontyField31 FP) (MontyField31 FP)
  where
  div := sorry

@[reducible] instance Impl_45.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_45_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_45_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  core_models.iter.traits.accum.Product.AssociatedTypes
  (MontyField31 FP)
  (MontyField31 FP)
  where

instance Impl_45
  (FP : Type)
  [trait_constr_Impl_45_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_45_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  core_models.iter.traits.accum.Product (MontyField31 FP) (MontyField31 FP) := sorry

@[reducible] instance Impl_28.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_28_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_28_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  core_models.ops.arith.Neg.AssociatedTypes (MontyField31 FP)
  where
  Output := (MontyField31 FP)

instance Impl_28
  (FP : Type)
  [trait_constr_Impl_28_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_28_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  core_models.ops.arith.Neg (MontyField31 FP)
  where
  neg := sorry

@[reducible] instance Impl_24.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_24_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_24_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.PrimeField32.AssociatedTypes (MontyField31 FP)
  where

instance Impl_24
  (FP : Type)
  [trait_constr_Impl_24_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_24_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.PrimeField32 (MontyField31 FP) := sorry

@[reducible] instance Impl_23.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_23_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_23_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.PrimeField64.AssociatedTypes (MontyField31 FP)
  where

instance Impl_23
  (FP : Type)
  [trait_constr_Impl_23_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_23_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.PrimeField64 (MontyField31 FP) := sorry

@[reducible] instance Impl_22.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_22_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_22_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.PrimeField.AssociatedTypes (MontyField31 FP)
  where

instance Impl_22
  (FP : Type)
  [trait_constr_Impl_22_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_22_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.PrimeField (MontyField31 FP) := sorry

@[reducible] instance Impl_14.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_14_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_14_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.Field.AssociatedTypes (MontyField31 FP)
  where
  Packing := (MontyField31 FP)

instance Impl_14
  (FP : Type)
  [trait_constr_Impl_14_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_14_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.Field (MontyField31 FP) := sorry

@[reducible] instance Impl_13.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_13_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_13_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.RawDataSerializable.AssociatedTypes (MontyField31 FP)
  where

instance Impl_13
  (FP : Type)
  [trait_constr_Impl_13_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_13_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.RawDataSerializable (MontyField31 FP) := sorry

@[reducible] instance Impl_10.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_10_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_10_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.PrimeCharacteristicRing.AssociatedTypes (MontyField31 FP)
  where
  PrimeSubfield := (MontyField31 FP)

instance Impl_10
  (FP : Type)
  [trait_constr_Impl_10_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_10_i0 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.field.PrimeCharacteristicRing (MontyField31 FP) := sorry

end p3_monty_31.monty_31


namespace p3_monty_31.extension

@[reducible] instance Impl_4.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_4_associated_type_i0 :
    p3_monty_31.data_traits.TrinomialQuinticData.AssociatedTypes
    FP]
  [trait_constr_Impl_4_i0 : p3_monty_31.data_traits.TrinomialQuinticData FP ]
  [trait_constr_Impl_4_associated_type_i1 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_4_i1 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.QuinticTrinomialExtendable.AssociatedTypes
  (p3_monty_31.monty_31.MontyField31 FP)
  where

instance Impl_4
  (FP : Type)
  [trait_constr_Impl_4_associated_type_i0 :
    p3_monty_31.data_traits.TrinomialQuinticData.AssociatedTypes
    FP]
  [trait_constr_Impl_4_i0 : p3_monty_31.data_traits.TrinomialQuinticData FP ]
  [trait_constr_Impl_4_associated_type_i1 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_4_i1 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.QuinticTrinomialExtendable
  (p3_monty_31.monty_31.MontyField31 FP) := sorry

end p3_monty_31.extension


namespace p3_monty_31.poseidon1

@[reducible] instance Impl.AssociatedTypes
  (FP : Type)
  (WIDTH : usize)
  (P1P : Type)
  (D : u64)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_i1 : p3_monty_31.data_traits.RelativelyPrimePower FP (D) ]
  [trait_constr_Impl_associated_type_i2 : PartialRoundParameters.AssociatedTypes
    P1P
    FP
    (WIDTH)]
  [trait_constr_Impl_i2 : PartialRoundParameters P1P FP (WIDTH) ] :
  p3_poseidon1.internal.PartialRoundLayer.AssociatedTypes
  (p3_monty_31.no_packing.poseidon1.Poseidon1InternalLayerMonty31
    FP
    (WIDTH)
    P1P)
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  (D)
  where

instance Impl
  (FP : Type)
  (WIDTH : usize)
  (P1P : Type)
  (D : u64)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_i1 : p3_monty_31.data_traits.RelativelyPrimePower FP (D) ]
  [trait_constr_Impl_associated_type_i2 : PartialRoundParameters.AssociatedTypes
    P1P
    FP
    (WIDTH)]
  [trait_constr_Impl_i2 : PartialRoundParameters P1P FP (WIDTH) ] :
  p3_poseidon1.internal.PartialRoundLayer
  (p3_monty_31.no_packing.poseidon1.Poseidon1InternalLayerMonty31
    FP
    (WIDTH)
    P1P)
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  (D) := sorry

@[reducible] instance Impl_1.AssociatedTypes
  (FP : Type)
  (MU : Type)
  (WIDTH : usize)
  (D : u64)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_1_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_1_i1 : p3_monty_31.data_traits.RelativelyPrimePower
    FP
    (D)
    ]
  [trait_constr_Impl_1_associated_type_i2 :
    p3_monty_31.mds.MDSUtils.AssociatedTypes
    MU]
  [trait_constr_Impl_1_i2 : p3_monty_31.mds.MDSUtils MU ]
  [trait_constr_Impl_1_associated_type_i3 :
    core_models.default.Default.AssociatedTypes
    MU]
  [trait_constr_Impl_1_i3 : core_models.default.Default MU ]
  [trait_constr_Impl_1_associated_type_i4 :
    p3_symmetric.permutation.Permutation.AssociatedTypes
    (p3_monty_31.mds.MdsMatrixMontyField31 MU)
    (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH)]
  [trait_constr_Impl_1_i4 : p3_symmetric.permutation.Permutation
    (p3_monty_31.mds.MdsMatrixMontyField31 MU)
    (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH)
    ] :
  p3_poseidon1.external.FullRoundLayer.AssociatedTypes
  (p3_monty_31.no_packing.poseidon1.Poseidon1ExternalLayerMonty31 FP MU (WIDTH))
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  (D)
  where

instance Impl_1
  (FP : Type)
  (MU : Type)
  (WIDTH : usize)
  (D : u64)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_1_associated_type_i1 :
    p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
    FP
    (D)]
  [trait_constr_Impl_1_i1 : p3_monty_31.data_traits.RelativelyPrimePower
    FP
    (D)
    ]
  [trait_constr_Impl_1_associated_type_i2 :
    p3_monty_31.mds.MDSUtils.AssociatedTypes
    MU]
  [trait_constr_Impl_1_i2 : p3_monty_31.mds.MDSUtils MU ]
  [trait_constr_Impl_1_associated_type_i3 :
    core_models.default.Default.AssociatedTypes
    MU]
  [trait_constr_Impl_1_i3 : core_models.default.Default MU ]
  [trait_constr_Impl_1_associated_type_i4 :
    p3_symmetric.permutation.Permutation.AssociatedTypes
    (p3_monty_31.mds.MdsMatrixMontyField31 MU)
    (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH)]
  [trait_constr_Impl_1_i4 : p3_symmetric.permutation.Permutation
    (p3_monty_31.mds.MdsMatrixMontyField31 MU)
    (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH)
    ] :
  p3_poseidon1.external.FullRoundLayer
  (p3_monty_31.no_packing.poseidon1.Poseidon1ExternalLayerMonty31 FP MU (WIDTH))
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  (D) := sorry

end p3_monty_31.poseidon1


namespace p3_monty_31.no_packing

--  If no packings are available, we use the generic binomial extension multiplication functions.
@[spec]
def quartic_mul_packed
    (FP : Type)
    (WIDTH : usize)
    [trait_constr_quartic_mul_packed_associated_type_i0 :
      p3_monty_31.data_traits.FieldParameters.AssociatedTypes
      FP]
    [trait_constr_quartic_mul_packed_i0 :
      p3_monty_31.data_traits.FieldParameters
      FP
      ]
    [trait_constr_quartic_mul_packed_associated_type_i1 :
      p3_monty_31.data_traits.BinomialExtensionData.AssociatedTypes
      FP
      (WIDTH)]
    [trait_constr_quartic_mul_packed_i1 :
      p3_monty_31.data_traits.BinomialExtensionData
      FP
      (WIDTH)
      ]
    (a : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH))
    (b : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH))
    (res : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH)) :
    RustM (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH) := do
  let res : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH) ←
    (p3_field.extension.binomial_extension.quartic_mul
      (p3_monty_31.monty_31.MontyField31 FP)
      (p3_monty_31.monty_31.MontyField31 FP)
      (p3_monty_31.monty_31.MontyField31 FP)
      (WIDTH)
      a
      b
      res
      (p3_monty_31.data_traits.BinomialExtensionData.W FP (WIDTH)));
  (pure res)

--  If no packings are available, we use the generic binomial extension multiplication functions.
@[spec]
def quintic_mul_packed
    (FP : Type)
    (WIDTH : usize)
    [trait_constr_quintic_mul_packed_associated_type_i0 :
      p3_monty_31.data_traits.FieldParameters.AssociatedTypes
      FP]
    [trait_constr_quintic_mul_packed_i0 :
      p3_monty_31.data_traits.FieldParameters
      FP
      ]
    [trait_constr_quintic_mul_packed_associated_type_i1 :
      p3_monty_31.data_traits.BinomialExtensionData.AssociatedTypes
      FP
      (WIDTH)]
    [trait_constr_quintic_mul_packed_i1 :
      p3_monty_31.data_traits.BinomialExtensionData
      FP
      (WIDTH)
      ]
    (a : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH))
    (b : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH))
    (res : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH)) :
    RustM (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH) := do
  let res : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH) ←
    (p3_field.extension.binomial_extension.quintic_mul
      (p3_monty_31.monty_31.MontyField31 FP)
      (p3_monty_31.monty_31.MontyField31 FP)
      (p3_monty_31.monty_31.MontyField31 FP)
      (WIDTH)
      a
      b
      res
      (p3_monty_31.data_traits.BinomialExtensionData.W FP (WIDTH)));
  (pure res)

--  If no packings are available, we use the generic binomial extension multiplication functions.
@[spec]
def octic_mul_packed
    (FP : Type)
    (WIDTH : usize)
    [trait_constr_octic_mul_packed_associated_type_i0 :
      p3_monty_31.data_traits.FieldParameters.AssociatedTypes
      FP]
    [trait_constr_octic_mul_packed_i0 : p3_monty_31.data_traits.FieldParameters
      FP
      ]
    [trait_constr_octic_mul_packed_associated_type_i1 :
      p3_monty_31.data_traits.BinomialExtensionData.AssociatedTypes
      FP
      (WIDTH)]
    [trait_constr_octic_mul_packed_i1 :
      p3_monty_31.data_traits.BinomialExtensionData
      FP
      (WIDTH)
      ]
    (a : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH))
    (b : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH))
    (res : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH)) :
    RustM (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH) := do
  let res : (RustArray (p3_monty_31.monty_31.MontyField31 FP) WIDTH) ←
    (p3_field.extension.binomial_extension.octic_mul
      (p3_monty_31.monty_31.MontyField31 FP)
      (p3_monty_31.monty_31.MontyField31 FP)
      (p3_monty_31.monty_31.MontyField31 FP)
      (WIDTH)
      a
      b
      res
      (p3_monty_31.data_traits.BinomialExtensionData.W FP (WIDTH)));
  (pure res)

end p3_monty_31.no_packing


namespace p3_monty_31.extension

@[reducible] instance Impl_1.AssociatedTypes
  (WIDTH : usize)
  (FP : Type)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.BinomialExtensionData.AssociatedTypes
    FP
    (WIDTH)]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.BinomialExtensionData
    FP
    (WIDTH)
    ]
  [trait_constr_Impl_1_associated_type_i1 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i1 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.BinomiallyExtendable.AssociatedTypes
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  where

instance Impl_1
  (WIDTH : usize)
  (FP : Type)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_monty_31.data_traits.BinomialExtensionData.AssociatedTypes
    FP
    (WIDTH)]
  [trait_constr_Impl_1_i0 : p3_monty_31.data_traits.BinomialExtensionData
    FP
    (WIDTH)
    ]
  [trait_constr_Impl_1_associated_type_i1 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_1_i1 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.BinomiallyExtendable
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH) := sorry

@[reducible] instance Impl.AssociatedTypes
  (WIDTH : usize)
  (FP : Type)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.BinomialExtensionData.AssociatedTypes
    FP
    (WIDTH)]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.BinomialExtensionData
    FP
    (WIDTH)
    ]
  [trait_constr_Impl_associated_type_i1 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i1 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.ExtensionAlgebra.AssociatedTypes
  (p3_monty_31.monty_31.MontyField31 FP)
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  (p3_field.extension.Binomial (p3_monty_31.monty_31.MontyField31 FP))
  where

instance Impl
  (WIDTH : usize)
  (FP : Type)
  [trait_constr_Impl_associated_type_i0 :
    p3_monty_31.data_traits.BinomialExtensionData.AssociatedTypes
    FP
    (WIDTH)]
  [trait_constr_Impl_i0 : p3_monty_31.data_traits.BinomialExtensionData
    FP
    (WIDTH)
    ]
  [trait_constr_Impl_associated_type_i1 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_i1 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.ExtensionAlgebra
  (p3_monty_31.monty_31.MontyField31 FP)
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  (p3_field.extension.Binomial (p3_monty_31.monty_31.MontyField31 FP)) := sorry

end p3_monty_31.extension


namespace p3_monty_31.monty_31

@[reducible] instance Impl_25.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_25_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_25_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_25_associated_type_i1 :
    p3_monty_31.data_traits.TwoAdicData.AssociatedTypes
    FP]
  [trait_constr_Impl_25_i1 : p3_monty_31.data_traits.TwoAdicData FP ] :
  p3_field.field.TwoAdicField.AssociatedTypes (MontyField31 FP)
  where

instance Impl_25
  (FP : Type)
  [trait_constr_Impl_25_associated_type_i0 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_25_i0 : p3_monty_31.data_traits.FieldParameters FP ]
  [trait_constr_Impl_25_associated_type_i1 :
    p3_monty_31.data_traits.TwoAdicData.AssociatedTypes
    FP]
  [trait_constr_Impl_25_i1 : p3_monty_31.data_traits.TwoAdicData FP ] :
  p3_field.field.TwoAdicField (MontyField31 FP) := sorry

--  A square root of this field element, if one exists.
-- 
--  This specializes the generic [`Field::try_sqrt`] for two-adic Monty-31
--  fields: it seeds Tonelli–Shanks from the precomputed
--  [`TwoAdicField::two_adic_generator`] instead of recomputing `GENERATOR^q`.
--  As an inherent method it shadows the trait method for concrete field types
--  such as `BabyBear` and `KoalaBear`; generic `Field` callers still use the
--  trait default.
-- 
--  See [`Field::try_sqrt`] for the returned-root semantics.
@[spec]
def Impl_15.try_sqrt
    (FP : Type)
    [trait_constr_try_sqrt_associated_type_i0 :
      p3_monty_31.data_traits.FieldParameters.AssociatedTypes
      FP]
    [trait_constr_try_sqrt_i0 : p3_monty_31.data_traits.FieldParameters FP ]
    [trait_constr_try_sqrt_associated_type_i1 :
      p3_monty_31.data_traits.TwoAdicData.AssociatedTypes
      FP]
    [trait_constr_try_sqrt_i1 : p3_monty_31.data_traits.TwoAdicData FP ]
    (self : (MontyField31 FP)) :
    RustM (core_models.option.Option (MontyField31 FP)) := do
  (p3_field.sqrt.tonelli_shanks_two_adic (MontyField31 FP) self)

end p3_monty_31.monty_31


namespace p3_monty_31.extension

@[reducible] instance Impl_2.AssociatedTypes
  (WIDTH : usize)
  (FP : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_monty_31.data_traits.BinomialExtensionData.AssociatedTypes
    FP
    (WIDTH)]
  [trait_constr_Impl_2_i0 : p3_monty_31.data_traits.BinomialExtensionData
    FP
    (WIDTH)
    ]
  [trait_constr_Impl_2_associated_type_i1 :
    p3_monty_31.data_traits.TwoAdicData.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i1 : p3_monty_31.data_traits.TwoAdicData FP ]
  [trait_constr_Impl_2_associated_type_i2 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i2 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.HasTwoAdicBinomialExtension.AssociatedTypes
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH)
  where

instance Impl_2
  (WIDTH : usize)
  (FP : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_monty_31.data_traits.BinomialExtensionData.AssociatedTypes
    FP
    (WIDTH)]
  [trait_constr_Impl_2_i0 : p3_monty_31.data_traits.BinomialExtensionData
    FP
    (WIDTH)
    ]
  [trait_constr_Impl_2_associated_type_i1 :
    p3_monty_31.data_traits.TwoAdicData.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i1 : p3_monty_31.data_traits.TwoAdicData FP ]
  [trait_constr_Impl_2_associated_type_i2 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_2_i2 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.HasTwoAdicBinomialExtension
  (p3_monty_31.monty_31.MontyField31 FP)
  (WIDTH) := sorry

@[reducible] instance Impl_5.AssociatedTypes
  (FP : Type)
  [trait_constr_Impl_5_associated_type_i0 :
    p3_monty_31.data_traits.TrinomialQuinticData.AssociatedTypes
    FP]
  [trait_constr_Impl_5_i0 : p3_monty_31.data_traits.TrinomialQuinticData FP ]
  [trait_constr_Impl_5_associated_type_i1 :
    p3_monty_31.data_traits.TwoAdicData.AssociatedTypes
    FP]
  [trait_constr_Impl_5_i1 : p3_monty_31.data_traits.TwoAdicData FP ]
  [trait_constr_Impl_5_associated_type_i2 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_5_i2 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.HasTwoAdicQuinticExtension.AssociatedTypes
  (p3_monty_31.monty_31.MontyField31 FP)
  where

instance Impl_5
  (FP : Type)
  [trait_constr_Impl_5_associated_type_i0 :
    p3_monty_31.data_traits.TrinomialQuinticData.AssociatedTypes
    FP]
  [trait_constr_Impl_5_i0 : p3_monty_31.data_traits.TrinomialQuinticData FP ]
  [trait_constr_Impl_5_associated_type_i1 :
    p3_monty_31.data_traits.TwoAdicData.AssociatedTypes
    FP]
  [trait_constr_Impl_5_i1 : p3_monty_31.data_traits.TwoAdicData FP ]
  [trait_constr_Impl_5_associated_type_i2 :
    p3_monty_31.data_traits.FieldParameters.AssociatedTypes
    FP]
  [trait_constr_Impl_5_i2 : p3_monty_31.data_traits.FieldParameters FP ] :
  p3_field.extension.HasTwoAdicQuinticExtension
  (p3_monty_31.monty_31.MontyField31 FP) := sorry

end p3_monty_31.extension

