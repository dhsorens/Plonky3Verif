
-- Experimental lean backend for Hax
-- The Hax prelude library can be found in hax/proof-libs/lean
import Hax
import p3_goldilocks.dependencies
import Std.Tactic.Do
import Std.Do.Triple
import Std.Tactic.Do.Syntax
open Std.Do
open Std.Tactic

set_option mvcgen.warning false
set_option linter.unusedVariables false


namespace p3_goldilocks.goldilocks

--  The Goldilocks prime
def P : u64 := (18446744069414584321 : u64)

--  The prime field known as Goldilocks, defined as `F_p` where `p = 2^64 - 2^32 + 1`.
-- 
--  The serde encoding is canonical: every field element has exactly one valid byte representation.
structure Goldilocks where
  value : u64

@[instance] opaque Impl_29.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes Goldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_29 :
  core_models.clone.Clone Goldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_28.AssociatedTypes :
  core_models.marker.Copy.AssociatedTypes Goldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_28 :
  core_models.marker.Copy Goldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_30.AssociatedTypes :
  core_models.default.Default.AssociatedTypes Goldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_30 :
  core_models.default.Default Goldilocks :=
  by constructor <;> exact Inhabited.default

--  Create a new field element from any `u64`.
-- 
--  Any `u64` value is accepted. No reduction is performed since
--  Goldilocks uses a non-canonical internal representation.
@[spec]
def Impl_2.new (value : u64) : RustM Goldilocks := do
  (pure (Goldilocks.mk (value := value)))

@[reducible] instance Impl_1.AssociatedTypes :
  serde_core.de.Deserialize.AssociatedTypes Goldilocks
  where

instance Impl_1 : serde_core.de.Deserialize Goldilocks := sorry

@[reducible] instance Impl_11.AssociatedTypes :
  rand.distr.distribution.Distribution.AssociatedTypes
  rand.distr.StandardUniform
  Goldilocks
  where

instance Impl_11 :
  rand.distr.distribution.Distribution rand.distr.StandardUniform Goldilocks
  := sorry

@[reducible] instance Impl_12.AssociatedTypes :
  p3_challenger.duplex_challenger.UniformSamplingField.AssociatedTypes
  Goldilocks
  where

instance Impl_12 :
  p3_challenger.duplex_challenger.UniformSamplingField Goldilocks
  := sorry

def Impl_13.halve.HALF_P_PLUS_1 : u64 := sorry

def Impl_13.dot_product.OFFSET : u128 := sorry

def Impl_19.from_canonical_checked.POS_BOUND : i64 := sorry

def Impl_19.from_canonical_checked.NEG_BOUND : i64 := sorry

@[spec]
def split (x : u128) : RustM (rust_primitives.hax.Tuple2 u64 u64) := do
  (pure (rust_primitives.hax.Tuple2.mk
    (← (rust_primitives.hax.cast_op x : RustM u64))
    (← (rust_primitives.hax.cast_op (← (x >>>? (64 : i32))) : RustM u64))))

def gcd_inversion.ROUND_SIZE : usize := (63 : usize)

end p3_goldilocks.goldilocks


namespace p3_goldilocks.mds

structure MdsMatrixGoldilocks where
  -- no fields

@[instance] opaque Impl_15.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes MdsMatrixGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_15 :
  core_models.clone.Clone MdsMatrixGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_16.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes MdsMatrixGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_16 :
  core_models.fmt.Debug MdsMatrixGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_17.AssociatedTypes :
  core_models.default.Default.AssociatedTypes MdsMatrixGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_17 :
  core_models.default.Default MdsMatrixGoldilocks :=
  by constructor <;> exact Inhabited.default

--  Instantiate convolution for "small" RHS vectors over Goldilocks.
-- 
--  Here "small" means N = len(rhs) <= 16 and sum(r for r in rhs) <
--  2^51, though in practice the sum will be less than 2^9.
structure SmallConvolveGoldilocks where
  -- no fields

@[instance] opaque Impl_18.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes SmallConvolveGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_18 :
  core_models.fmt.Debug SmallConvolveGoldilocks :=
  by constructor <;> exact Inhabited.default

def FFT_ALGO : p3_dft.radix_2_bowers.Radix2Bowers := sorry

def MATRIX_CIRC_MDS_8_SML_ROW : (RustArray i64 8) := sorry

def MATRIX_CIRC_MDS_8_COL : (RustArray i64 8) := sorry

@[reducible] instance Impl_1.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 8)
  where

instance Impl_1 :
  p3_symmetric.permutation.Permutation
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 8)
  := sorry

def Impl_1.permute.MATRIX_CIRC_MDS_8_SML_COL : (RustArray i64 8) := sorry

@[reducible] instance Impl_2.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((8 : usize))
  where

instance Impl_2 :
  p3_mds.MdsPermutation
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((8 : usize))
  where

def MATRIX_CIRC_MDS_12_SML_ROW : (RustArray i64 12) := sorry

def MATRIX_CIRC_MDS_12_COL : (RustArray i64 12) := sorry

@[reducible] instance Impl_3.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 12)
  where

instance Impl_3 :
  p3_symmetric.permutation.Permutation
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 12)
  := sorry

def Impl_3.permute.MATRIX_CIRC_MDS_12_SML_COL : (RustArray i64 12) := sorry

@[reducible] instance Impl_4.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((12 : usize))
  where

instance Impl_4 :
  p3_mds.MdsPermutation
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((12 : usize))
  where

def MATRIX_CIRC_MDS_16_SML_ROW : (RustArray i64 16) := sorry

@[reducible] instance Impl_5.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 16)
  where

instance Impl_5 :
  p3_symmetric.permutation.Permutation
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 16)
  := sorry

def Impl_5.permute.MATRIX_CIRC_MDS_16_SML_COL : (RustArray i64 16) := sorry

@[reducible] instance Impl_6.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((16 : usize))
  where

instance Impl_6 :
  p3_mds.MdsPermutation
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((16 : usize))
  where

def MATRIX_CIRC_MDS_24_GOLDILOCKS : (RustArray u64 24) := sorry

def MATRIX_CIRC_MDS_32_GOLDILOCKS : (RustArray u64 32) := sorry

def Impl_9.permute.ENTRIES : (RustArray u64 32) := sorry

def MATRIX_CIRC_MDS_64_GOLDILOCKS : (RustArray u64 64) := sorry

def Impl_11.permute.ENTRIES : (RustArray u64 64) := sorry

def MATRIX_CIRC_MDS_68_GOLDILOCKS : (RustArray u64 68) := sorry

end p3_goldilocks.mds


namespace p3_goldilocks.poseidon2

--  Number of full rounds per half for Goldilocks Poseidon2 (`RF / 2`).
-- 
--  The total number of full rounds is `RF = 8` (4 beginning + 4 ending).
--  Follows the Poseidon2 paper's security analysis with a +2 RF margin.
def GOLDILOCKS_POSEIDON2_HALF_FULL_ROUNDS : usize := (4 : usize)

--  Number of partial rounds for Goldilocks Poseidon2 (width 8).
-- 
--  Derived from the interpolation bound in the Poseidon paper (Eq. 3):
-- 
--    R_interp ≥ ⌈min{κ,n}/log_2(α)⌉ + ⌈log_α(t)⌉ − 5
--             = ⌈64/log_2(7)⌉ + ⌈log_7(8)⌉ − 5 = 23 + 2 − 5 = 20
-- 
--  With the +7.5% security margin: ⌈1.075 × 20⌉ = 22.
def GOLDILOCKS_POSEIDON2_PARTIAL_ROUNDS_8 : usize := (22 : usize)

--  Number of partial rounds for Goldilocks Poseidon2 (width 12).
-- 
--  Same interpolation bound as width 8:
-- 
--    R_interp ≥ ⌈64/log_2(7)⌉ + ⌈log_7(12)⌉ − 5 = 23 + 2 − 5 = 20
-- 
--  With the +7.5% security margin: ⌈1.075 × 20⌉ = 22.
def GOLDILOCKS_POSEIDON2_PARTIAL_ROUNDS_12 : usize := (22 : usize)

--  Number of partial rounds for Goldilocks Poseidon2 (width 16).
-- 
--  The official round number script yields R_P = 22 for this configuration
--  (matching the Grain LFSR parameters used to generate the round constants below).
def GOLDILOCKS_POSEIDON2_PARTIAL_ROUNDS_16 : usize := (22 : usize)

@[spec]
def internal_layer_mat_mul_goldilocks_8
    (A : Type)
    [trait_constr_internal_layer_mat_mul_goldilocks_8_associated_type_i0 :
      p3_field.field.Algebra.AssociatedTypes
      A
      p3_goldilocks.goldilocks.Goldilocks]
    [trait_constr_internal_layer_mat_mul_goldilocks_8_i0 :
      p3_field.field.Algebra
      A
      p3_goldilocks.goldilocks.Goldilocks
      ]
    (state : (RustArray A 8)) :
    RustM (RustArray A 8) := sorry

@[spec]
def internal_layer_mat_mul_goldilocks_12
    (A : Type)
    [trait_constr_internal_layer_mat_mul_goldilocks_12_associated_type_i0 :
      p3_field.field.Algebra.AssociatedTypes
      A
      p3_goldilocks.goldilocks.Goldilocks]
    [trait_constr_internal_layer_mat_mul_goldilocks_12_i0 :
      p3_field.field.Algebra
      A
      p3_goldilocks.goldilocks.Goldilocks
      ]
    (state : (RustArray A 12)) :
    RustM (RustArray A 12) := sorry

structure Poseidon2InternalLayerGoldilocks where
  internal_constants : (alloc.vec.Vec
      p3_goldilocks.goldilocks.Goldilocks
      alloc.alloc.Global)

@[instance] opaque Impl_11.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes Poseidon2InternalLayerGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_11 :
  core_models.fmt.Debug Poseidon2InternalLayerGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_12.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes Poseidon2InternalLayerGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_12 :
  core_models.clone.Clone Poseidon2InternalLayerGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_13.AssociatedTypes :
  core_models.default.Default.AssociatedTypes Poseidon2InternalLayerGoldilocks
  :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_13 :
  core_models.default.Default Poseidon2InternalLayerGoldilocks :=
  by constructor <;> exact Inhabited.default

@[reducible] instance Impl.AssociatedTypes :
  p3_poseidon2.internal.InternalLayerConstructor.AssociatedTypes
  Poseidon2InternalLayerGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  where

instance Impl :
  p3_poseidon2.internal.InternalLayerConstructor
  Poseidon2InternalLayerGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  := sorry

@[reducible] instance Impl_1.AssociatedTypes
  (A : Type)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_field.field.Algebra.AssociatedTypes
    A
    p3_goldilocks.goldilocks.Goldilocks]
  [trait_constr_Impl_1_i0 : p3_field.field.Algebra
    A
    p3_goldilocks.goldilocks.Goldilocks
    ]
  [trait_constr_Impl_1_associated_type_i1 :
    p3_field.field.InjectiveMonomial.AssociatedTypes
    A
    ((7 : u64))]
  [trait_constr_Impl_1_i1 : p3_field.field.InjectiveMonomial A ((7 : u64)) ] :
  p3_poseidon2.internal.InternalLayer.AssociatedTypes
  Poseidon2InternalLayerGoldilocks
  A
  ((8 : usize))
  ((7 : u64))
  where

instance Impl_1
  (A : Type)
  [trait_constr_Impl_1_associated_type_i0 :
    p3_field.field.Algebra.AssociatedTypes
    A
    p3_goldilocks.goldilocks.Goldilocks]
  [trait_constr_Impl_1_i0 : p3_field.field.Algebra
    A
    p3_goldilocks.goldilocks.Goldilocks
    ]
  [trait_constr_Impl_1_associated_type_i1 :
    p3_field.field.InjectiveMonomial.AssociatedTypes
    A
    ((7 : u64))]
  [trait_constr_Impl_1_i1 : p3_field.field.InjectiveMonomial A ((7 : u64)) ] :
  p3_poseidon2.internal.InternalLayer
  Poseidon2InternalLayerGoldilocks
  A
  ((8 : usize))
  ((7 : u64))
  := sorry

@[reducible] instance Impl_2.AssociatedTypes
  (A : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_field.field.Algebra.AssociatedTypes
    A
    p3_goldilocks.goldilocks.Goldilocks]
  [trait_constr_Impl_2_i0 : p3_field.field.Algebra
    A
    p3_goldilocks.goldilocks.Goldilocks
    ]
  [trait_constr_Impl_2_associated_type_i1 :
    p3_field.field.InjectiveMonomial.AssociatedTypes
    A
    ((7 : u64))]
  [trait_constr_Impl_2_i1 : p3_field.field.InjectiveMonomial A ((7 : u64)) ] :
  p3_poseidon2.internal.InternalLayer.AssociatedTypes
  Poseidon2InternalLayerGoldilocks
  A
  ((12 : usize))
  ((7 : u64))
  where

instance Impl_2
  (A : Type)
  [trait_constr_Impl_2_associated_type_i0 :
    p3_field.field.Algebra.AssociatedTypes
    A
    p3_goldilocks.goldilocks.Goldilocks]
  [trait_constr_Impl_2_i0 : p3_field.field.Algebra
    A
    p3_goldilocks.goldilocks.Goldilocks
    ]
  [trait_constr_Impl_2_associated_type_i1 :
    p3_field.field.InjectiveMonomial.AssociatedTypes
    A
    ((7 : u64))]
  [trait_constr_Impl_2_i1 : p3_field.field.InjectiveMonomial A ((7 : u64)) ] :
  p3_poseidon2.internal.InternalLayer
  Poseidon2InternalLayerGoldilocks
  A
  ((12 : usize))
  ((7 : u64))
  := sorry

@[reducible] instance Impl_3.AssociatedTypes
  (A : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    p3_field.field.Algebra.AssociatedTypes
    A
    p3_goldilocks.goldilocks.Goldilocks]
  [trait_constr_Impl_3_i0 : p3_field.field.Algebra
    A
    p3_goldilocks.goldilocks.Goldilocks
    ]
  [trait_constr_Impl_3_associated_type_i1 :
    p3_field.field.InjectiveMonomial.AssociatedTypes
    A
    ((7 : u64))]
  [trait_constr_Impl_3_i1 : p3_field.field.InjectiveMonomial A ((7 : u64)) ] :
  p3_poseidon2.internal.InternalLayer.AssociatedTypes
  Poseidon2InternalLayerGoldilocks
  A
  ((16 : usize))
  ((7 : u64))
  where

instance Impl_3
  (A : Type)
  [trait_constr_Impl_3_associated_type_i0 :
    p3_field.field.Algebra.AssociatedTypes
    A
    p3_goldilocks.goldilocks.Goldilocks]
  [trait_constr_Impl_3_i0 : p3_field.field.Algebra
    A
    p3_goldilocks.goldilocks.Goldilocks
    ]
  [trait_constr_Impl_3_associated_type_i1 :
    p3_field.field.InjectiveMonomial.AssociatedTypes
    A
    ((7 : u64))]
  [trait_constr_Impl_3_i1 : p3_field.field.InjectiveMonomial A ((7 : u64)) ] :
  p3_poseidon2.internal.InternalLayer
  Poseidon2InternalLayerGoldilocks
  A
  ((16 : usize))
  ((7 : u64))
  := sorry

@[reducible] instance Impl_4.AssociatedTypes
  (A : Type)
  [trait_constr_Impl_4_associated_type_i0 :
    p3_field.field.Algebra.AssociatedTypes
    A
    p3_goldilocks.goldilocks.Goldilocks]
  [trait_constr_Impl_4_i0 : p3_field.field.Algebra
    A
    p3_goldilocks.goldilocks.Goldilocks
    ]
  [trait_constr_Impl_4_associated_type_i1 :
    p3_field.field.InjectiveMonomial.AssociatedTypes
    A
    ((7 : u64))]
  [trait_constr_Impl_4_i1 : p3_field.field.InjectiveMonomial A ((7 : u64)) ] :
  p3_poseidon2.internal.InternalLayer.AssociatedTypes
  Poseidon2InternalLayerGoldilocks
  A
  ((20 : usize))
  ((7 : u64))
  where

instance Impl_4
  (A : Type)
  [trait_constr_Impl_4_associated_type_i0 :
    p3_field.field.Algebra.AssociatedTypes
    A
    p3_goldilocks.goldilocks.Goldilocks]
  [trait_constr_Impl_4_i0 : p3_field.field.Algebra
    A
    p3_goldilocks.goldilocks.Goldilocks
    ]
  [trait_constr_Impl_4_associated_type_i1 :
    p3_field.field.InjectiveMonomial.AssociatedTypes
    A
    ((7 : u64))]
  [trait_constr_Impl_4_i1 : p3_field.field.InjectiveMonomial A ((7 : u64)) ] :
  p3_poseidon2.internal.InternalLayer
  Poseidon2InternalLayerGoldilocks
  A
  ((20 : usize))
  ((7 : u64))
  := sorry

structure Poseidon2ExternalLayerGoldilocks (WIDTH : usize) where
  external_constants : (p3_poseidon2.external.ExternalLayerConstants
      p3_goldilocks.goldilocks.Goldilocks
      (WIDTH))

--  An implementation of the Poseidon2 hash function for the Goldilocks field.
-- 
--  It acts on arrays of the form `[Goldilocks; WIDTH]`.
abbrev Poseidon2Goldilocks (WIDTH : usize) :
  Type :=
  (p3_poseidon2.Poseidon2
    p3_goldilocks.goldilocks.Goldilocks
    (Poseidon2ExternalLayerGoldilocks (WIDTH))
    Poseidon2InternalLayerGoldilocks
    (WIDTH)
    ((7 : u64)))

@[instance] opaque Impl_14.AssociatedTypes (WIDTH : usize) :
  core_models.clone.Clone.AssociatedTypes
  (Poseidon2ExternalLayerGoldilocks (WIDTH)) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_14 (WIDTH : usize) :
  core_models.clone.Clone (Poseidon2ExternalLayerGoldilocks (WIDTH)) :=
  by constructor <;> exact Inhabited.default

@[reducible] instance Impl_5.AssociatedTypes (WIDTH : usize) :
  p3_poseidon2.external.ExternalLayerConstructor.AssociatedTypes
  (Poseidon2ExternalLayerGoldilocks (WIDTH))
  p3_goldilocks.goldilocks.Goldilocks
  (WIDTH)
  where

instance Impl_5 (WIDTH : usize) :
  p3_poseidon2.external.ExternalLayerConstructor
  (Poseidon2ExternalLayerGoldilocks (WIDTH))
  p3_goldilocks.goldilocks.Goldilocks
  (WIDTH)
  := sorry

@[reducible] instance Impl_6.AssociatedTypes
  (A : Type)
  (WIDTH : usize)
  [trait_constr_Impl_6_associated_type_i0 :
    p3_field.field.Algebra.AssociatedTypes
    A
    p3_goldilocks.goldilocks.Goldilocks]
  [trait_constr_Impl_6_i0 : p3_field.field.Algebra
    A
    p3_goldilocks.goldilocks.Goldilocks
    ]
  [trait_constr_Impl_6_associated_type_i1 :
    p3_field.field.InjectiveMonomial.AssociatedTypes
    A
    ((7 : u64))]
  [trait_constr_Impl_6_i1 : p3_field.field.InjectiveMonomial A ((7 : u64)) ] :
  p3_poseidon2.external.ExternalLayer.AssociatedTypes
  (Poseidon2ExternalLayerGoldilocks (WIDTH))
  A
  (WIDTH)
  ((7 : u64))
  where

instance Impl_6
  (A : Type)
  (WIDTH : usize)
  [trait_constr_Impl_6_associated_type_i0 :
    p3_field.field.Algebra.AssociatedTypes
    A
    p3_goldilocks.goldilocks.Goldilocks]
  [trait_constr_Impl_6_i0 : p3_field.field.Algebra
    A
    p3_goldilocks.goldilocks.Goldilocks
    ]
  [trait_constr_Impl_6_associated_type_i1 :
    p3_field.field.InjectiveMonomial.AssociatedTypes
    A
    ((7 : u64))]
  [trait_constr_Impl_6_i1 : p3_field.field.InjectiveMonomial A ((7 : u64)) ] :
  p3_poseidon2.external.ExternalLayer
  (Poseidon2ExternalLayerGoldilocks (WIDTH))
  A
  (WIDTH)
  ((7 : u64))
  := sorry

structure GenericPoseidon2LinearLayersGoldilocks where
  -- no fields

@[instance] opaque Impl_15.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes GenericPoseidon2LinearLayersGoldilocks
  :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_15 :
  core_models.clone.Clone GenericPoseidon2LinearLayersGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_16.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes GenericPoseidon2LinearLayersGoldilocks
  :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_16 :
  core_models.fmt.Debug GenericPoseidon2LinearLayersGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_17.AssociatedTypes :
  core_models.default.Default.AssociatedTypes
  GenericPoseidon2LinearLayersGoldilocks :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_17 :
  core_models.default.Default GenericPoseidon2LinearLayersGoldilocks :=
  by constructor <;> exact Inhabited.default

end p3_goldilocks.poseidon2


namespace p3_goldilocks.poseidon1

--  S-box degree for Goldilocks Poseidon1.
-- 
--  The S-box raises each element to this power. The Goldilocks prime
--  factors as `p - 1 = 2^32 * 3 * 5 * 17 * 257 * 65537`. Neither 3 nor 5
--  are coprime to `p - 1`, so the smallest valid exponent is 7.
def GOLDILOCKS_S_BOX_DEGREE : u64 := (7 : u64)

--  Number of full rounds per half for Goldilocks Poseidon (`RF / 2`).
-- 
--  The total number of full rounds is `RF = 8` (4 beginning + 4 ending).
--  Follows the Poseidon paper's security analysis (Section 5.4) with a +2 RF margin.
def GOLDILOCKS_POSEIDON_HALF_FULL_ROUNDS : usize := (4 : usize)

--  Number of partial rounds for Goldilocks Poseidon (width 8).
-- 
--  Derived from the interpolation bound in the Poseidon paper (Eq. 3):
-- 
--    R_interp ≥ ⌈min{κ,n}/log_2(α)⌉ + ⌈log_α(t)⌉ − 5
--             = ⌈64/log_2(7)⌉ + ⌈log_7(8)⌉ − 5 = 23 + 2 − 5 = 20
-- 
--  With the +7.5% security margin (Section 5.4): ⌈1.075 × 20⌉ = 22.
def GOLDILOCKS_POSEIDON_PARTIAL_ROUNDS_8 : usize := (22 : usize)

--  Number of partial rounds for Goldilocks Poseidon (width 12).
-- 
--  Same interpolation bound as width 8:
-- 
--    R_interp ≥ ⌈64/log_2(7)⌉ + ⌈log_7(12)⌉ − 5 = 23 + 2 − 5 = 20
-- 
--  With the +7.5% security margin: ⌈1.075 × 20⌉ = 22.
def GOLDILOCKS_POSEIDON_PARTIAL_ROUNDS_12 : usize := (22 : usize)

--  Generic (non-fused) Poseidon1 permutation for Goldilocks.
-- 
--  Uses the platform-independent Poseidon1 implementation with Karatsuba
--  MDS convolution. Used directly for widths not supported by the fused
--  type (e.g. 16, 24) and as the non-aarch64 fallback for widths 8 and 12.
abbrev Poseidon1GoldilocksGeneric (WIDTH : usize) :
  Type :=
  (p3_poseidon1.Poseidon1
    p3_goldilocks.goldilocks.Goldilocks
    (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
      p3_goldilocks.goldilocks.Goldilocks
      p3_goldilocks.mds.MdsMatrixGoldilocks
      (WIDTH))
    (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
      p3_goldilocks.goldilocks.Goldilocks
      (WIDTH))
    (WIDTH)
    ((7 : u64)))

--  Unified Poseidon1 permutation for Goldilocks.
-- 
--  On aarch64, resolves to the fused ASM-optimized implementation that
--  uses inline assembly and dual-lane NEON processing.
-- 
--  On all other platforms, resolves to the generic implementation with
--  Karatsuba MDS convolution.
-- 
--  Supports both scalar and packed state representations transparently.
abbrev Poseidon1Goldilocks (WIDTH : usize) :
  Type :=
  (p3_poseidon1.Poseidon1
    p3_goldilocks.goldilocks.Goldilocks
    (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
      p3_goldilocks.goldilocks.Goldilocks
      p3_goldilocks.mds.MdsMatrixGoldilocks
      (WIDTH))
    (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
      p3_goldilocks.goldilocks.Goldilocks
      (WIDTH))
    (WIDTH)
    ((7 : u64)))

end p3_goldilocks.poseidon1


namespace p3_goldilocks.mds

@[reducible] instance Impl.AssociatedTypes :
  p3_mds.karatsuba_convolution.Convolve.AssociatedTypes
  SmallConvolveGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  i128
  i64
  where

instance Impl :
  p3_mds.karatsuba_convolution.Convolve
  SmallConvolveGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  i128
  i64
  := sorry

end p3_goldilocks.mds


namespace p3_goldilocks.poseidon2

--  Round constants for width-8 Poseidon2 on Goldilocks.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=7 (exp_flag=0), n=64, t=8, R_F=8, R_P=22
-- 
--  Generated by `poseidon2/generate_constants.py --field goldilocks --width 8`.
-- 
--  Layout: external_initial (4 rounds × 8 elements).
def GOLDILOCKS_POSEIDON2_RC_8_EXTERNAL_INITIAL :
  (RustArray (RustArray p3_goldilocks.goldilocks.Goldilocks 8) 4)
  := sorry

def GOLDILOCKS_POSEIDON2_RC_8_EXTERNAL_FINAL :
  (RustArray (RustArray p3_goldilocks.goldilocks.Goldilocks 8) 4)
  := sorry

def GOLDILOCKS_POSEIDON2_RC_8_INTERNAL :
  (RustArray p3_goldilocks.goldilocks.Goldilocks 22)
  := sorry

def GOLDILOCKS_POSEIDON2_RC_12_EXTERNAL_INITIAL :
  (RustArray (RustArray p3_goldilocks.goldilocks.Goldilocks 12) 4)
  := sorry

def GOLDILOCKS_POSEIDON2_RC_12_EXTERNAL_FINAL :
  (RustArray (RustArray p3_goldilocks.goldilocks.Goldilocks 12) 4)
  := sorry

def GOLDILOCKS_POSEIDON2_RC_12_INTERNAL :
  (RustArray p3_goldilocks.goldilocks.Goldilocks 22)
  := sorry

def GOLDILOCKS_POSEIDON2_RC_16_EXTERNAL_INITIAL :
  (RustArray (RustArray p3_goldilocks.goldilocks.Goldilocks 16) 4)
  := sorry

def GOLDILOCKS_POSEIDON2_RC_16_EXTERNAL_FINAL :
  (RustArray (RustArray p3_goldilocks.goldilocks.Goldilocks 16) 4)
  := sorry

def GOLDILOCKS_POSEIDON2_RC_16_INTERNAL :
  (RustArray p3_goldilocks.goldilocks.Goldilocks 22)
  := sorry

def MATRIX_DIAG_8_GOLDILOCKS :
  (RustArray p3_goldilocks.goldilocks.Goldilocks 8)
  := sorry

def MATRIX_DIAG_12_GOLDILOCKS :
  (RustArray p3_goldilocks.goldilocks.Goldilocks 12)
  := sorry

def MATRIX_DIAG_16_GOLDILOCKS :
  (RustArray p3_goldilocks.goldilocks.Goldilocks 16)
  := sorry

def MATRIX_DIAG_20_GOLDILOCKS :
  (RustArray p3_goldilocks.goldilocks.Goldilocks 20)
  := sorry

@[spec]
def internal_layer_mat_mul_goldilocks_16
    (A : Type)
    [trait_constr_internal_layer_mat_mul_goldilocks_16_associated_type_i0 :
      p3_field.field.Algebra.AssociatedTypes
      A
      p3_goldilocks.goldilocks.Goldilocks]
    [trait_constr_internal_layer_mat_mul_goldilocks_16_i0 :
      p3_field.field.Algebra
      A
      p3_goldilocks.goldilocks.Goldilocks
      ]
    (state : (RustArray A 16)) :
    RustM (RustArray A 16) := sorry

@[reducible] instance Impl_7.AssociatedTypes :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers.AssociatedTypes
  GenericPoseidon2LinearLayersGoldilocks
  ((8 : usize))
  where

instance Impl_7 :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers
  GenericPoseidon2LinearLayersGoldilocks
  ((8 : usize))
  := sorry

@[reducible] instance Impl_8.AssociatedTypes :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers.AssociatedTypes
  GenericPoseidon2LinearLayersGoldilocks
  ((12 : usize))
  where

instance Impl_8 :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers
  GenericPoseidon2LinearLayersGoldilocks
  ((12 : usize))
  := sorry

@[reducible] instance Impl_9.AssociatedTypes :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers.AssociatedTypes
  GenericPoseidon2LinearLayersGoldilocks
  ((16 : usize))
  where

instance Impl_9 :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers
  GenericPoseidon2LinearLayersGoldilocks
  ((16 : usize))
  := sorry

@[reducible] instance Impl_10.AssociatedTypes :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers.AssociatedTypes
  GenericPoseidon2LinearLayersGoldilocks
  ((20 : usize))
  where

instance Impl_10 :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers
  GenericPoseidon2LinearLayersGoldilocks
  ((20 : usize))
  := sorry

end p3_goldilocks.poseidon2


namespace p3_goldilocks.extension

@[reducible] instance Impl_3.AssociatedTypes :
  p3_field.extension.ExtensionAlgebra.AssociatedTypes
  p3_goldilocks.goldilocks.Goldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((3 : usize))
  p3_field.extension.CubicTrinomial
  where

instance Impl_3 :
  p3_field.extension.ExtensionAlgebra
  p3_goldilocks.goldilocks.Goldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((3 : usize))
  p3_field.extension.CubicTrinomial
  := sorry

end p3_goldilocks.extension


namespace p3_goldilocks.goldilocks

--  Convert a `[[u64; N]; M]` array to a 2D array of field elements.
-- 
--  Const version of `input.map(Goldilocks::new_array)`.
@[spec]
def Impl_2.new_2d_array (N : usize) (M : usize)
    (input : (RustArray (RustArray u64 N) M)) :
    RustM (RustArray (RustArray Goldilocks N) M) := sorry

@[reducible] instance Impl_14.AssociatedTypes :
  p3_field.field.InjectiveMonomial.AssociatedTypes Goldilocks ((7 : u64))
  where

instance Impl_14 : p3_field.field.InjectiveMonomial Goldilocks ((7 : u64)) where

end p3_goldilocks.goldilocks


namespace p3_goldilocks.mds

@[reducible] instance Impl_7.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 24)
  where

instance Impl_7 :
  p3_symmetric.permutation.Permutation
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 24)
  := sorry

@[reducible] instance Impl_9.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 32)
  where

instance Impl_9 :
  p3_symmetric.permutation.Permutation
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 32)
  := sorry

@[reducible] instance Impl_11.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 64)
  where

instance Impl_11 :
  p3_symmetric.permutation.Permutation
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 64)
  := sorry

@[reducible] instance Impl_13.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 68)
  where

instance Impl_13 :
  p3_symmetric.permutation.Permutation
  MdsMatrixGoldilocks
  (RustArray p3_goldilocks.goldilocks.Goldilocks 68)
  := sorry

end p3_goldilocks.mds


namespace p3_goldilocks.poseidon2

--  Create a default width-8 Poseidon2 permutation for Goldilocks.
@[spec]
def default_goldilocks_poseidon2_8 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon2.Poseidon2
      p3_goldilocks.goldilocks.Goldilocks
      (Poseidon2ExternalLayerGoldilocks ((8 : usize)))
      Poseidon2InternalLayerGoldilocks
      ((8 : usize))
      ((7 : u64)))
    := do
  (p3_poseidon2.Impl.new
    p3_goldilocks.goldilocks.Goldilocks
    (Poseidon2ExternalLayerGoldilocks ((8 : usize)))
    Poseidon2InternalLayerGoldilocks
    ((8 : usize))
    ((7 : u64))
    (← (p3_poseidon2.external.Impl_4.new
      p3_goldilocks.goldilocks.Goldilocks
      ((8 : usize))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_goldilocks.goldilocks.Goldilocks 8)
        (← (rust_primitives.unsize
          GOLDILOCKS_POSEIDON2_RC_8_EXTERNAL_INITIAL))))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_goldilocks.goldilocks.Goldilocks 8)
        (← (rust_primitives.unsize
          GOLDILOCKS_POSEIDON2_RC_8_EXTERNAL_FINAL))))))
    (← (alloc.slice.Impl.to_vec p3_goldilocks.goldilocks.Goldilocks
      (← (rust_primitives.unsize GOLDILOCKS_POSEIDON2_RC_8_INTERNAL)))))

--  Create a default width-12 Poseidon2 permutation for Goldilocks.
@[spec]
def default_goldilocks_poseidon2_12 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon2.Poseidon2
      p3_goldilocks.goldilocks.Goldilocks
      (Poseidon2ExternalLayerGoldilocks ((12 : usize)))
      Poseidon2InternalLayerGoldilocks
      ((12 : usize))
      ((7 : u64)))
    := do
  (p3_poseidon2.Impl.new
    p3_goldilocks.goldilocks.Goldilocks
    (Poseidon2ExternalLayerGoldilocks ((12 : usize)))
    Poseidon2InternalLayerGoldilocks
    ((12 : usize))
    ((7 : u64))
    (← (p3_poseidon2.external.Impl_4.new
      p3_goldilocks.goldilocks.Goldilocks
      ((12 : usize))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_goldilocks.goldilocks.Goldilocks 12)
        (← (rust_primitives.unsize
          GOLDILOCKS_POSEIDON2_RC_12_EXTERNAL_INITIAL))))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_goldilocks.goldilocks.Goldilocks 12)
        (← (rust_primitives.unsize
          GOLDILOCKS_POSEIDON2_RC_12_EXTERNAL_FINAL))))))
    (← (alloc.slice.Impl.to_vec p3_goldilocks.goldilocks.Goldilocks
      (← (rust_primitives.unsize GOLDILOCKS_POSEIDON2_RC_12_INTERNAL)))))

--  Create a default width-16 Poseidon2 permutation for Goldilocks.
@[spec]
def default_goldilocks_poseidon2_16 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon2.Poseidon2
      p3_goldilocks.goldilocks.Goldilocks
      (Poseidon2ExternalLayerGoldilocks ((16 : usize)))
      Poseidon2InternalLayerGoldilocks
      ((16 : usize))
      ((7 : u64)))
    := do
  (p3_poseidon2.Impl.new
    p3_goldilocks.goldilocks.Goldilocks
    (Poseidon2ExternalLayerGoldilocks ((16 : usize)))
    Poseidon2InternalLayerGoldilocks
    ((16 : usize))
    ((7 : u64))
    (← (p3_poseidon2.external.Impl_4.new
      p3_goldilocks.goldilocks.Goldilocks
      ((16 : usize))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_goldilocks.goldilocks.Goldilocks 16)
        (← (rust_primitives.unsize
          GOLDILOCKS_POSEIDON2_RC_16_EXTERNAL_INITIAL))))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_goldilocks.goldilocks.Goldilocks 16)
        (← (rust_primitives.unsize
          GOLDILOCKS_POSEIDON2_RC_16_EXTERNAL_FINAL))))))
    (← (alloc.slice.Impl.to_vec p3_goldilocks.goldilocks.Goldilocks
      (← (rust_primitives.unsize GOLDILOCKS_POSEIDON2_RC_16_INTERNAL)))))

end p3_goldilocks.poseidon2


namespace p3_goldilocks.mds

@[reducible] instance Impl_8.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((24 : usize))
  where

instance Impl_8 :
  p3_mds.MdsPermutation
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((24 : usize))
  where

@[reducible] instance Impl_10.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((32 : usize))
  where

instance Impl_10 :
  p3_mds.MdsPermutation
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((32 : usize))
  where

@[reducible] instance Impl_12.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((64 : usize))
  where

instance Impl_12 :
  p3_mds.MdsPermutation
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((64 : usize))
  where

@[reducible] instance Impl_14.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((68 : usize))
  where

instance Impl_14 :
  p3_mds.MdsPermutation
  MdsMatrixGoldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((68 : usize))
  where

end p3_goldilocks.mds


namespace p3_goldilocks.poseidon1

--  Round constants for width-8 Poseidon1 on Goldilocks.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=7 (exp_flag=0), n=64, t=8, R_F=8, R_P=22
-- 
--  Generated by `poseidon/generate_constants.py --field goldilocks --width 8`.
-- 
--  Layout: [initial_full (4 rounds), partial (22 rounds), terminal_full (4 rounds)].
def GOLDILOCKS_POSEIDON1_RC_8 :
  (RustArray (RustArray p3_goldilocks.goldilocks.Goldilocks 8) 30)
  := sorry

def GOLDILOCKS_POSEIDON1_RC_12 :
  (RustArray (RustArray p3_goldilocks.goldilocks.Goldilocks 12) 30)
  := sorry

end p3_goldilocks.poseidon1


namespace p3_goldilocks.goldilocks

@[reducible] instance Impl_15.AssociatedTypes :
  p3_field.field.PermutationMonomial.AssociatedTypes Goldilocks ((7 : u64))
  where

instance Impl_15 :
  p3_field.field.PermutationMonomial Goldilocks ((7 : u64))
  := sorry

@[spec]
def reduce128 (x : u128) : RustM Goldilocks := sorry

@[spec]
def gcd_inversion (input : Goldilocks) : RustM Goldilocks := sorry

@[spec]
def from_unusual_int (int : i64) : RustM Goldilocks := sorry

@[spec]
def const_add (lhs : Goldilocks) (rhs : Goldilocks) : RustM Goldilocks := sorry

@[spec]
def add_no_canonicalize_trashing_input (x : u64) (y : u64) : RustM u64 := sorry

@[reducible] instance Impl_44.AssociatedTypes :
  core_models.ops.arith.DivAssign.AssociatedTypes Goldilocks Goldilocks
  where

instance Impl_44 : core_models.ops.arith.DivAssign Goldilocks Goldilocks := sorry

@[reducible] instance Impl_43.AssociatedTypes :
  core_models.ops.arith.Div.AssociatedTypes Goldilocks Goldilocks
  where
  Output := Goldilocks

instance Impl_43 : core_models.ops.arith.Div Goldilocks Goldilocks := sorry

@[reducible] instance Impl_42.AssociatedTypes :
  core_models.iter.traits.accum.Product.AssociatedTypes Goldilocks Goldilocks
  where

instance Impl_42 :
  core_models.iter.traits.accum.Product Goldilocks Goldilocks
  := sorry

@[reducible] instance Impl_41.AssociatedTypes
  (T : Type)
  [trait_constr_Impl_41_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Goldilocks]
  [trait_constr_Impl_41_i0 : core_models.convert.Into T Goldilocks ] :
  core_models.ops.arith.MulAssign.AssociatedTypes Goldilocks T
  where

instance Impl_41
  (T : Type)
  [trait_constr_Impl_41_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Goldilocks]
  [trait_constr_Impl_41_i0 : core_models.convert.Into T Goldilocks ] :
  core_models.ops.arith.MulAssign Goldilocks T
  := sorry

@[reducible] instance Impl_40.AssociatedTypes
  (T : Type)
  [trait_constr_Impl_40_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Goldilocks]
  [trait_constr_Impl_40_i0 : core_models.convert.Into T Goldilocks ] :
  core_models.ops.arith.SubAssign.AssociatedTypes Goldilocks T
  where

instance Impl_40
  (T : Type)
  [trait_constr_Impl_40_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Goldilocks]
  [trait_constr_Impl_40_i0 : core_models.convert.Into T Goldilocks ] :
  core_models.ops.arith.SubAssign Goldilocks T
  := sorry

@[reducible] instance Impl_39.AssociatedTypes
  (T : Type)
  [trait_constr_Impl_39_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Goldilocks]
  [trait_constr_Impl_39_i0 : core_models.convert.Into T Goldilocks ] :
  core_models.ops.arith.AddAssign.AssociatedTypes Goldilocks T
  where

instance Impl_39
  (T : Type)
  [trait_constr_Impl_39_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Goldilocks]
  [trait_constr_Impl_39_i0 : core_models.convert.Into T Goldilocks ] :
  core_models.ops.arith.AddAssign Goldilocks T
  := sorry

@[reducible] instance Impl_38.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Goldilocks i128
  where

instance Impl_38 : p3_field.integers.QuotientMap Goldilocks i128 := sorry

@[reducible] instance Impl_37.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Goldilocks u128
  where

instance Impl_37 : p3_field.integers.QuotientMap Goldilocks u128 := sorry

@[reducible] instance Impl_36.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Goldilocks i32
  where

instance Impl_36 : p3_field.integers.QuotientMap Goldilocks i32 := sorry

@[reducible] instance Impl_35.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Goldilocks i16
  where

instance Impl_35 : p3_field.integers.QuotientMap Goldilocks i16 := sorry

@[reducible] instance Impl_34.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Goldilocks i8
  where

instance Impl_34 : p3_field.integers.QuotientMap Goldilocks i8 := sorry

@[reducible] instance Impl_33.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Goldilocks u32
  where

instance Impl_33 : p3_field.integers.QuotientMap Goldilocks u32 := sorry

@[reducible] instance Impl_32.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Goldilocks u16
  where

instance Impl_32 : p3_field.integers.QuotientMap Goldilocks u16 := sorry

@[reducible] instance Impl_31.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Goldilocks u8
  where

instance Impl_31 : p3_field.integers.QuotientMap Goldilocks u8 := sorry

@[reducible] instance Impl_27.AssociatedTypes :
  core_models.iter.traits.accum.Sum.AssociatedTypes Goldilocks Goldilocks
  where

instance Impl_27 : core_models.iter.traits.accum.Sum Goldilocks Goldilocks := sorry

@[reducible] instance Impl_26.AssociatedTypes :
  core_models.ops.arith.Mul.AssociatedTypes Goldilocks Goldilocks
  where
  Output := Goldilocks

instance Impl_26 : core_models.ops.arith.Mul Goldilocks Goldilocks := sorry

@[reducible] instance Impl_25.AssociatedTypes :
  core_models.ops.arith.Neg.AssociatedTypes Goldilocks
  where
  Output := Goldilocks

instance Impl_25 : core_models.ops.arith.Neg Goldilocks := sorry

@[reducible] instance Impl_24.AssociatedTypes :
  core_models.ops.arith.Sub.AssociatedTypes Goldilocks Goldilocks
  where
  Output := Goldilocks

instance Impl_24 : core_models.ops.arith.Sub Goldilocks Goldilocks := sorry

@[reducible] instance Impl_23.AssociatedTypes :
  core_models.ops.arith.Add.AssociatedTypes Goldilocks Goldilocks
  where
  Output := Goldilocks

instance Impl_23 : core_models.ops.arith.Add Goldilocks Goldilocks := sorry

@[reducible] instance Impl_22.AssociatedTypes :
  p3_field.field.TwoAdicField.AssociatedTypes Goldilocks
  where

instance Impl_22 : p3_field.field.TwoAdicField Goldilocks := sorry

@[reducible] instance Impl_21.AssociatedTypes :
  p3_field.field.PrimeField64.AssociatedTypes Goldilocks
  where

instance Impl_21 : p3_field.field.PrimeField64 Goldilocks := sorry

@[reducible] instance Impl_20.AssociatedTypes :
  p3_field.field.PrimeField.AssociatedTypes Goldilocks
  where

instance Impl_20 : p3_field.field.PrimeField Goldilocks := sorry

@[reducible] instance Impl_19.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Goldilocks i64
  where

instance Impl_19 : p3_field.integers.QuotientMap Goldilocks i64 := sorry

@[reducible] instance Impl_18.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Goldilocks u64
  where

instance Impl_18 : p3_field.integers.QuotientMap Goldilocks u64 := sorry

@[reducible] instance Impl_17.AssociatedTypes :
  p3_field.field.Field.AssociatedTypes Goldilocks
  where
  Packing := Goldilocks

instance Impl_17 : p3_field.field.Field Goldilocks := sorry

@[reducible] instance Impl_16.AssociatedTypes :
  p3_field.field.RawDataSerializable.AssociatedTypes Goldilocks
  where

instance Impl_16 : p3_field.field.RawDataSerializable Goldilocks := sorry

@[reducible] instance Impl_13.AssociatedTypes :
  p3_field.field.PrimeCharacteristicRing.AssociatedTypes Goldilocks
  where
  PrimeSubfield := Goldilocks

instance Impl_13 : p3_field.field.PrimeCharacteristicRing Goldilocks := sorry

@[reducible] instance Impl_10.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes Goldilocks
  where

instance Impl_10 : core_models.fmt.Debug Goldilocks where
  dbg_fmt := fun (self : Goldilocks) (f : core_models.fmt.Formatter) => do
    let ⟨tmp0, out⟩ ←
      (core_models.fmt.Debug.dbg_fmt
        u64
        (← (p3_field.field.PrimeField64.as_canonical_u64 Goldilocks self))
        f);
    let f : core_models.fmt.Formatter := tmp0;
    let
      hax_temp_output : (core_models.result.Result
        rust_primitives.hax.Tuple0
        core_models.fmt.Error) :=
      out;
    (pure (rust_primitives.hax.Tuple2.mk f hax_temp_output))

@[reducible] instance Impl_9.AssociatedTypes :
  core_models.fmt.Display.AssociatedTypes Goldilocks
  where

instance Impl_9 : core_models.fmt.Display Goldilocks where
  fmt := fun (self : Goldilocks) (f : core_models.fmt.Formatter) => do
    let ⟨tmp0, out⟩ ←
      (core_models.fmt.Display.fmt
        u64
        (← (p3_field.field.PrimeField64.as_canonical_u64 Goldilocks self))
        f);
    let f : core_models.fmt.Formatter := tmp0;
    let
      hax_temp_output : (core_models.result.Result
        rust_primitives.hax.Tuple0
        core_models.fmt.Error) :=
      out;
    (pure (rust_primitives.hax.Tuple2.mk f hax_temp_output))

@[reducible] instance Impl_3.AssociatedTypes :
  core_models.cmp.PartialEq.AssociatedTypes Goldilocks Goldilocks
  where

instance Impl_3 : core_models.cmp.PartialEq Goldilocks Goldilocks := sorry
@[reducible] instance Impl_4.AssociatedTypes :
  core_models.cmp.Eq.AssociatedTypes Goldilocks
  where

instance Impl_4 : core_models.cmp.Eq Goldilocks where
@[reducible] instance Impl_8.AssociatedTypes :
  core_models.cmp.PartialOrd.AssociatedTypes Goldilocks Goldilocks
  where

instance Impl_8 : core_models.cmp.PartialOrd Goldilocks Goldilocks := sorry

@[reducible] instance Impl_7.AssociatedTypes :
  core_models.cmp.Ord.AssociatedTypes Goldilocks
  where

instance Impl_7 : core_models.cmp.Ord Goldilocks := sorry

@[reducible] instance Impl_6.AssociatedTypes :
  core_models.hash.Hash.AssociatedTypes Goldilocks
  where

instance Impl_6 : core_models.hash.Hash Goldilocks where
  hash :=
    fun
      (H : Type)
      [trait_constr_hash_associated_type_i0 :
        core_models.hash.Hasher.AssociatedTypes
        H]
      [trait_constr_hash_i0 : core_models.hash.Hasher H ]
      (self : Goldilocks)
      (state : H) => do
    let state : H ←
      (core_models.hash.Hasher.write_u64
        H
        state
        (← (p3_field.field.PrimeField64.as_canonical_u64 Goldilocks self)));
    (pure state)

@[reducible] instance Impl_5.AssociatedTypes :
  p3_field.packed.packed_traits.Packable.AssociatedTypes Goldilocks
  where

instance Impl_5 : p3_field.packed.packed_traits.Packable Goldilocks where



@[spec]
def Impl_2.new_array (N : usize) (input : (RustArray u64 N)) :
    RustM (RustArray Goldilocks N) := sorry

def Impl_2.TWO_ADIC_GENERATORS : (RustArray Goldilocks 33) := sorry

def Impl_2.POWERS_OF_TWO : (RustArray Goldilocks 96) := sorry

def Impl_2.NEG_ORDER : u64 := sorry

@[reducible] instance Impl.AssociatedTypes :
  serde_core.ser.Serialize.AssociatedTypes Goldilocks
  where

instance Impl : serde_core.ser.Serialize Goldilocks := sorry

end p3_goldilocks.goldilocks


namespace p3_goldilocks.extension

@[reducible] instance Impl_4.AssociatedTypes :
  p3_field.extension.CubicTrinomialExtendable.AssociatedTypes
  p3_goldilocks.goldilocks.Goldilocks
  where

instance Impl_4 :
  p3_field.extension.CubicTrinomialExtendable
  p3_goldilocks.goldilocks.Goldilocks
  := sorry

@[reducible] instance Impl_5.AssociatedTypes :
  p3_field.extension.HasTwoAdicCubicExtension.AssociatedTypes
  p3_goldilocks.goldilocks.Goldilocks
  where

instance Impl_5 :
  p3_field.extension.HasTwoAdicCubicExtension
  p3_goldilocks.goldilocks.Goldilocks
  := sorry

end p3_goldilocks.extension


namespace p3_goldilocks.poseidon1

--  Create the default width-8 Poseidon1 permutation for Goldilocks.
-- 
--  Returns the platform-optimal implementation: fused ASM on aarch64,
--  generic Karatsuba on all other platforms.
@[spec]
def default_goldilocks_poseidon1_8 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon1.Poseidon1
      p3_goldilocks.goldilocks.Goldilocks
      (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
        p3_goldilocks.goldilocks.Goldilocks
        p3_goldilocks.mds.MdsMatrixGoldilocks
        ((8 : usize)))
      (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
        p3_goldilocks.goldilocks.Goldilocks
        ((8 : usize)))
      ((8 : usize))
      ((7 : u64)))
    := do
  (p3_poseidon1.Impl_1.new
    p3_goldilocks.goldilocks.Goldilocks
    (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
      p3_goldilocks.goldilocks.Goldilocks
      p3_goldilocks.mds.MdsMatrixGoldilocks
      ((8 : usize)))
    (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
      p3_goldilocks.goldilocks.Goldilocks
      ((8 : usize)))
    ((8 : usize))
    ((7 : u64))
    (p3_poseidon1.Poseidon1Constants.mk
      (rounds_f := (← ((2 : usize) *? GOLDILOCKS_POSEIDON_HALF_FULL_ROUNDS)))
      (rounds_p := GOLDILOCKS_POSEIDON_PARTIAL_ROUNDS_8)
      (mds_circ_col := p3_goldilocks.mds.MATRIX_CIRC_MDS_8_COL)
      (round_constants := (← (alloc.slice.Impl.to_vec
        (RustArray p3_goldilocks.goldilocks.Goldilocks 8)
        (← (rust_primitives.unsize GOLDILOCKS_POSEIDON1_RC_8)))))))

--  Create the default width-12 Poseidon1 permutation for Goldilocks.
-- 
--  Returns the platform-optimal implementation: fused ASM on aarch64,
--  generic Karatsuba on all other platforms.
@[spec]
def default_goldilocks_poseidon1_12 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon1.Poseidon1
      p3_goldilocks.goldilocks.Goldilocks
      (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
        p3_goldilocks.goldilocks.Goldilocks
        p3_goldilocks.mds.MdsMatrixGoldilocks
        ((12 : usize)))
      (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
        p3_goldilocks.goldilocks.Goldilocks
        ((12 : usize)))
      ((12 : usize))
      ((7 : u64)))
    := do
  (p3_poseidon1.Impl_1.new
    p3_goldilocks.goldilocks.Goldilocks
    (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
      p3_goldilocks.goldilocks.Goldilocks
      p3_goldilocks.mds.MdsMatrixGoldilocks
      ((12 : usize)))
    (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
      p3_goldilocks.goldilocks.Goldilocks
      ((12 : usize)))
    ((12 : usize))
    ((7 : u64))
    (p3_poseidon1.Poseidon1Constants.mk
      (rounds_f := (← ((2 : usize) *? GOLDILOCKS_POSEIDON_HALF_FULL_ROUNDS)))
      (rounds_p := GOLDILOCKS_POSEIDON_PARTIAL_ROUNDS_12)
      (mds_circ_col := p3_goldilocks.mds.MATRIX_CIRC_MDS_12_COL)
      (round_constants := (← (alloc.slice.Impl.to_vec
        (RustArray p3_goldilocks.goldilocks.Goldilocks 12)
        (← (rust_primitives.unsize GOLDILOCKS_POSEIDON1_RC_12)))))))

end p3_goldilocks.poseidon1


namespace p3_goldilocks.extension

@[reducible] instance Impl_1.AssociatedTypes :
  p3_field.extension.BinomiallyExtendable.AssociatedTypes
  p3_goldilocks.goldilocks.Goldilocks
  ((2 : usize))
  where

instance Impl_1 :
  p3_field.extension.BinomiallyExtendable
  p3_goldilocks.goldilocks.Goldilocks
  ((2 : usize))
  := sorry

@[reducible] instance Impl.AssociatedTypes :
  p3_field.extension.ExtensionAlgebra.AssociatedTypes
  p3_goldilocks.goldilocks.Goldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((2 : usize))
  (p3_field.extension.Binomial p3_goldilocks.goldilocks.Goldilocks)
  where

instance Impl :
  p3_field.extension.ExtensionAlgebra
  p3_goldilocks.goldilocks.Goldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((2 : usize))
  (p3_field.extension.Binomial p3_goldilocks.goldilocks.Goldilocks)
  := sorry

@[reducible] instance Impl_7.AssociatedTypes :
  p3_field.extension.BinomiallyExtendable.AssociatedTypes
  p3_goldilocks.goldilocks.Goldilocks
  ((5 : usize))
  where

instance Impl_7 :
  p3_field.extension.BinomiallyExtendable
  p3_goldilocks.goldilocks.Goldilocks
  ((5 : usize))
  := sorry

@[reducible] instance Impl_6.AssociatedTypes :
  p3_field.extension.ExtensionAlgebra.AssociatedTypes
  p3_goldilocks.goldilocks.Goldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((5 : usize))
  (p3_field.extension.Binomial p3_goldilocks.goldilocks.Goldilocks)
  where

instance Impl_6 :
  p3_field.extension.ExtensionAlgebra
  p3_goldilocks.goldilocks.Goldilocks
  p3_goldilocks.goldilocks.Goldilocks
  ((5 : usize))
  (p3_field.extension.Binomial p3_goldilocks.goldilocks.Goldilocks)
  := sorry

@[reducible] instance Impl_2.AssociatedTypes :
  p3_field.extension.HasTwoAdicBinomialExtension.AssociatedTypes
  p3_goldilocks.goldilocks.Goldilocks
  ((2 : usize))
  where

instance Impl_2 :
  p3_field.extension.HasTwoAdicBinomialExtension
  p3_goldilocks.goldilocks.Goldilocks
  ((2 : usize))
  := sorry

@[reducible] instance Impl_8.AssociatedTypes :
  p3_field.extension.HasTwoAdicBinomialExtension.AssociatedTypes
  p3_goldilocks.goldilocks.Goldilocks
  ((5 : usize))
  where

instance Impl_8 :
  p3_field.extension.HasTwoAdicBinomialExtension
  p3_goldilocks.goldilocks.Goldilocks
  ((5 : usize))
  := sorry

end p3_goldilocks.extension

