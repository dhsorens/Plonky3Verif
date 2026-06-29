
-- Experimental lean backend for Hax
-- The Hax prelude library can be found in hax/proof-libs/lean
import Hax
import p3_mersenne_31.dependencies
import Std.Tactic.Do
import Std.Do.Triple
import Std.Tactic.Do.Syntax
open Std.Do
open Std.Tactic

set_option mvcgen.warning false
set_option linter.unusedVariables false


namespace p3_mersenne_31.mds

structure MdsMatrixMersenne31 where
  -- no fields

@[instance] opaque Impl_12.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes MdsMatrixMersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_12 :
  core_models.clone.Clone MdsMatrixMersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_13.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes MdsMatrixMersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_13 :
  core_models.fmt.Debug MdsMatrixMersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_14.AssociatedTypes :
  core_models.default.Default.AssociatedTypes MdsMatrixMersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_14 :
  core_models.default.Default MdsMatrixMersenne31 :=
  by constructor <;> exact Inhabited.default

--  Instantiate convolution for "small" RHS vectors over Mersenne31.
-- 
--  Here "small" means N = len(rhs) <= 16 and sum(r for r in rhs) <
--  2^24 (roughly), though in practice the sum will be less than 2^9.
structure SmallConvolveMersenne31 where
  -- no fields

--  Instantiate convolution for "large" RHS vectors over Mersenne31.
-- 
--  Here "large" means the elements can be as big as the field
--  characteristic, and the size N of the RHS is <= 64.
structure LargeConvolveMersenne31 where
  -- no fields

def Impl_1.parity_dot.LOWMASK : i128 :=
  RustM.of_isOk (do ((← ((1 : i128) <<<? (42 : i32))) -? (1 : i128))) (by sorry)

def Impl_1.parity_dot.HIGHMASK : i128 :=
  RustM.of_isOk (do (~? Impl_1.parity_dot.LOWMASK)) (by sorry)

def Impl_1.reduce.MASK : i64 :=
  RustM.of_isOk (do ((← ((1 : i64) <<<? (31 : i32))) -? (1 : i64))) (by sorry)

def MATRIX_CIRC_MDS_8_SML_ROW : (RustArray i64 8) :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(7 : i64),
                                (1 : i64),
                                (3 : i64),
                                (8 : i64),
                                (8 : i64),
                                (3 : i64),
                                (4 : i64),
                                (9 : i64)])))
    (by sorry)

def Impl_2.permute.MATRIX_CIRC_MDS_8_SML_COL : (RustArray i64 8) :=
  RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((8 : usize)) i64
      MATRIX_CIRC_MDS_8_SML_ROW))
    (by sorry)

def MATRIX_CIRC_MDS_12_SML_ROW : (RustArray i64 12) :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(1 : i64),
                                (1 : i64),
                                (2 : i64),
                                (1 : i64),
                                (8 : i64),
                                (9 : i64),
                                (10 : i64),
                                (7 : i64),
                                (5 : i64),
                                (9 : i64),
                                (4 : i64),
                                (10 : i64)])))
    (by sorry)

def Impl_4.permute.MATRIX_CIRC_MDS_12_SML_COL : (RustArray i64 12) :=
  RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((12 : usize)) i64
      MATRIX_CIRC_MDS_12_SML_ROW))
    (by sorry)

def MATRIX_CIRC_MDS_16_SML_ROW : (RustArray i64 16) :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(1 : i64),
                                (1 : i64),
                                (51 : i64),
                                (1 : i64),
                                (11 : i64),
                                (17 : i64),
                                (2 : i64),
                                (1 : i64),
                                (101 : i64),
                                (63 : i64),
                                (15 : i64),
                                (2 : i64),
                                (67 : i64),
                                (22 : i64),
                                (13 : i64),
                                (3 : i64)])))
    (by sorry)

def Impl_6.permute.MATRIX_CIRC_MDS_16_SML_COL : (RustArray i64 16) :=
  RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((16 : usize)) i64
      MATRIX_CIRC_MDS_16_SML_ROW))
    (by sorry)

def MATRIX_CIRC_MDS_32_MERSENNE31_ROW : (RustArray i64 32) :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(412540024 : i64),
                                (1436360233 : i64),
                                (82564914 : i64),
                                (1072974295 : i64),
                                (766567118 : i64),
                                (645360517 : i64),
                                (1979813463 : i64),
                                (270924307 : i64),
                                (105409451 : i64),
                                (930115258 : i64),
                                (636196459 : i64),
                                (289154277 : i64),
                                (719457988 : i64),
                                (1512525948 : i64),
                                (215190769 : i64),
                                (1981550821 : i64),
                                (434368282 : i64),
                                (53244687 : i64),
                                (903393155 : i64),
                                (1696461115 : i64),
                                (2126764826 : i64),
                                (1779722644 : i64),
                                (1485803845 : i64),
                                (163026005 : i64),
                                (2144994796 : i64),
                                (436105640 : i64),
                                (1770558586 : i64),
                                (1649351985 : i64),
                                (1342944808 : i64),
                                (185870542 : i64),
                                (979558870 : i64),
                                (2003379079 : i64)])))
    (by sorry)

def Impl_8.permute.MATRIX_CIRC_MDS_32_MERSENNE31_COL : (RustArray i64 32) :=
  RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((32 : usize)) i64
      MATRIX_CIRC_MDS_32_MERSENNE31_ROW))
    (by sorry)

def MATRIX_CIRC_MDS_64_MERSENNE31_ROW : (RustArray i64 64) :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(1459759013 : i64),
                                (922916927 : i64),
                                (1266367242 : i64),
                                (1961967075 : i64),
                                (1213404336 : i64),
                                (22536940 : i64),
                                (450029022 : i64),
                                (1913984483 : i64),
                                (1414704547 : i64),
                                (208975553 : i64),
                                (1742378064 : i64),
                                (866419561 : i64),
                                (1004269062 : i64),
                                (2087161182 : i64),
                                (370087635 : i64),
                                (1418234764 : i64),
                                (1718385318 : i64),
                                (289114594 : i64),
                                (708852962 : i64),
                                (419028802 : i64),
                                (711483012 : i64),
                                (1240399333 : i64),
                                (1560561670 : i64),
                                (1443512824 : i64),
                                (1777277904 : i64),
                                (751916934 : i64),
                                (1658877798 : i64),
                                (581054946 : i64),
                                (1023210508 : i64),
                                (1318020056 : i64),
                                (1768258069 : i64),
                                (1181436717 : i64),
                                (1100264658 : i64),
                                (513443306 : i64),
                                (963681319 : i64),
                                (1258490867 : i64),
                                (1700646429 : i64),
                                (622823577 : i64),
                                (1529784441 : i64),
                                (504423471 : i64),
                                (838188551 : i64),
                                (721139705 : i64),
                                (1041302042 : i64),
                                (1570218363 : i64),
                                (1862672573 : i64),
                                (1572848413 : i64),
                                (1992586781 : i64),
                                (563316057 : i64),
                                (863466611 : i64),
                                (1911613740 : i64),
                                (194540193 : i64),
                                (1277432313 : i64),
                                (1415281814 : i64),
                                (539323311 : i64),
                                (2072725822 : i64),
                                (866996828 : i64),
                                (367716892 : i64),
                                (1831672353 : i64),
                                (111680788 : i64),
                                (1068297039 : i64),
                                (319734300 : i64),
                                (1015334133 : i64),
                                (1358784448 : i64),
                                (821942362 : i64)])))
    (by sorry)

def Impl_10.permute.MATRIX_CIRC_MDS_64_MERSENNE31_COL : (RustArray i64 64) :=
  RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((64 : usize)) i64
      MATRIX_CIRC_MDS_64_MERSENNE31_ROW))
    (by sorry)

end p3_mersenne_31.mds


namespace p3_mersenne_31.mersenne_31

--  The Mersenne31 prime
def P : u32 :=
  RustM.of_isOk (do ((← ((1 : u32) <<<? (31 : i32))) -? (1 : u32))) (by sorry)

--  The prime field `F_p` where `p = 2^31 - 1`.
-- 
--  The serde encoding is canonical: every field element has exactly one valid byte representation.
structure Mersenne31 where
  value : u32

end p3_mersenne_31.mersenne_31


namespace p3_mersenne_31.mds

@[reducible] instance Impl_2.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixMersenne31
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 8)
  where

instance Impl_2 :
  p3_symmetric.permutation.Permutation
  MdsMatrixMersenne31
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 8)
  := sorry

@[reducible] instance Impl_3.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((8 : usize))
  where

instance Impl_3 :
  p3_mds.MdsPermutation
  MdsMatrixMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((8 : usize))
  where

@[reducible] instance Impl_4.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixMersenne31
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 12)
  where

instance Impl_4 :
  p3_symmetric.permutation.Permutation
  MdsMatrixMersenne31
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 12)
  := sorry

@[reducible] instance Impl_5.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((12 : usize))
  where

instance Impl_5 :
  p3_mds.MdsPermutation
  MdsMatrixMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((12 : usize))
  where

@[reducible] instance Impl_6.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixMersenne31
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 16)
  where

instance Impl_6 :
  p3_symmetric.permutation.Permutation
  MdsMatrixMersenne31
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 16)
  := sorry

@[reducible] instance Impl_7.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((16 : usize))
  where

instance Impl_7 :
  p3_mds.MdsPermutation
  MdsMatrixMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((16 : usize))
  where

@[reducible] instance Impl_8.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixMersenne31
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 32)
  where

instance Impl_8 :
  p3_symmetric.permutation.Permutation
  MdsMatrixMersenne31
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 32)
  := sorry

@[reducible] instance Impl_9.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((32 : usize))
  where

instance Impl_9 :
  p3_mds.MdsPermutation
  MdsMatrixMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((32 : usize))
  where

@[reducible] instance Impl_10.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  MdsMatrixMersenne31
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 64)
  where

instance Impl_10 :
  p3_symmetric.permutation.Permutation
  MdsMatrixMersenne31
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 64)
  := sorry

@[reducible] instance Impl_11.AssociatedTypes :
  p3_mds.MdsPermutation.AssociatedTypes
  MdsMatrixMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((64 : usize))
  where

instance Impl_11 :
  p3_mds.MdsPermutation
  MdsMatrixMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((64 : usize))
  where

end p3_mersenne_31.mds


namespace p3_mersenne_31.mersenne_31

@[instance] opaque Impl_29.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes Mersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_29 :
  core_models.clone.Clone Mersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_28.AssociatedTypes :
  core_models.marker.Copy.AssociatedTypes Mersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_28 :
  core_models.marker.Copy Mersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_30.AssociatedTypes :
  core_models.default.Default.AssociatedTypes Mersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_30 :
  core_models.default.Default Mersenne31 :=
  by constructor <;> exact Inhabited.default

--  Create a new field element from any `u32`.
-- 
--  Any `u32` value is accepted and automatically reduced modulo P.
@[spec]
def Impl.new (value : u32) : RustM Mersenne31 := do
  (pure (Mersenne31.mk (value := (← (value %? P)))))

--  Create a field element from a value assumed to be < 2^31.
-- 
--  # Safety
--  The element must lie in the range: `[0, 2^31 - 1]`.
@[spec]
def Impl.new_reduced (value : u32) : RustM Mersenne31 := do
  let _ ←
    if true then do
      let _ ← (hax_lib.assert (← ((← (value >>>? (31 : i32))) ==? (0 : u32))));
      (pure rust_primitives.hax.Tuple0.mk)
    else do
      (pure rust_primitives.hax.Tuple0.mk);
  (pure (Mersenne31.mk (value := value)))

--  Convert a u32 element into a Mersenne31 element.
-- 
--  Returns `None` if the element does not lie in the range: `[0, 2^31 - 1]`.
@[spec]
def Impl.new_checked (value : u32) :
    RustM (core_models.option.Option Mersenne31) := do
  if (← ((← (value >>>? (31 : i32))) ==? (0 : u32))) then do
    (pure (core_models.option.Option.Some (Mersenne31.mk (value := value))))
  else do
    (pure core_models.option.Option.None)

@[reducible] instance Impl_7.AssociatedTypes :
  core_models.fmt.Display.AssociatedTypes Mersenne31
  where

instance Impl_7 : core_models.fmt.Display Mersenne31 where
  fmt := fun (self : Mersenne31) (f : core_models.fmt.Formatter) => do
    let ⟨tmp0, out⟩ ←
      (core_models.fmt.Display.fmt u32 (Mersenne31.value self) f);
    let f : core_models.fmt.Formatter := tmp0;
    let
      hax_temp_output : (core_models.result.Result
        rust_primitives.hax.Tuple0
        core_models.fmt.Error) :=
      out;
    (pure (rust_primitives.hax.Tuple2.mk f hax_temp_output))

@[reducible] instance Impl_8.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes Mersenne31
  where

instance Impl_8 : core_models.fmt.Debug Mersenne31 where
  dbg_fmt := fun (self : Mersenne31) (f : core_models.fmt.Formatter) => do
    let ⟨tmp0, out⟩ ← (core_models.fmt.Debug.dbg_fmt u32 (Mersenne31.value self) f);
    let f : core_models.fmt.Formatter := tmp0;
    let
      hax_temp_output : (core_models.result.Result
        rust_primitives.hax.Tuple0
        core_models.fmt.Error) :=
      out;
    (pure (rust_primitives.hax.Tuple2.mk f hax_temp_output))

@[reducible] instance Impl_9.AssociatedTypes :
  rand.distr.distribution.Distribution.AssociatedTypes
  rand.distr.StandardUniform
  Mersenne31
  where

instance Impl_9 :
  rand.distr.distribution.Distribution rand.distr.StandardUniform Mersenne31
  := sorry

@[reducible] instance Impl_11.AssociatedTypes :
  serde_core.de.Deserialize.AssociatedTypes Mersenne31
  where

instance Impl_11 : serde_core.de.Deserialize Mersenne31 := sorry

def Impl_16.try_inverse.NUM_PRIME_BITS : u32 := (31 : u32)

def Impl_18.from_canonical_checked.TWO_EXP_30 : i32 :=
  RustM.of_isOk (do ((1 : i32) <<<? (30 : i32))) (by sorry)

def Impl_18.from_canonical_checked.NEG_TWO_EXP_30_PLUS_1 : i32 :=
  RustM.of_isOk (do ((← ((-1 : i32) <<<? (30 : i32))) +? (1 : i32))) (by sorry)

--  Perform a partial reduction of a u64 value modulo P = 2^31 - 1.
--  The result will be contained in [0, 2^34 - 1].
@[spec]
def partial_reduce (val : u64) : RustM u64 := do
  let lo : u32 ←
    (rust_primitives.hax.cast_op
      (← (val &&&? (← (rust_primitives.hax.cast_op P : RustM u64)))) :
      RustM u32);
  let hi : u64 ← (val >>>? (31 : i32));
  ((← (rust_primitives.hax.cast_op lo : RustM u64)) +? hi)

--  Reduce a u64 value modulo P = 2^31 - 1.
--  Uses the identity: 2^31 ≡ 1 (mod P), so val ≡ (val & P) + (val >> 31) (mod P).
--  Returns a value in [0, P].
@[spec]
def reduce_64 (val : u64) : RustM u32 := do
  let lo : u32 ←
    (rust_primitives.hax.cast_op
      (← (val &&&? (← (rust_primitives.hax.cast_op P : RustM u64)))) :
      RustM u32);
  let hi : u64 ← (val >>>? (31 : i32));
  let sum1 : u64 ← ((← (rust_primitives.hax.cast_op lo : RustM u64)) +? hi);
  let lo2 : u32 ←
    (rust_primitives.hax.cast_op
      (← (sum1 &&&? (← (rust_primitives.hax.cast_op P : RustM u64)))) :
      RustM u32);
  let hi2 : u32 ←
    (rust_primitives.hax.cast_op (← (sum1 >>>? (31 : i32))) : RustM u32);
  let sum2 : u32 ← (lo2 +? hi2);
  (core_models.cmp.Ord.min
    u32 sum2 (← (core_models.num.Impl_8.wrapping_sub sum2 P)))

@[reducible] instance Impl_27.AssociatedTypes :
  p3_challenger.duplex_challenger.UniformSamplingField.AssociatedTypes
  Mersenne31
  where

instance Impl_27 :
  p3_challenger.duplex_challenger.UniformSamplingField Mersenne31
  := sorry

end p3_mersenne_31.mersenne_31


namespace p3_mersenne_31.poseidon1

--  S-box degree for Mersenne31 Poseidon1.
-- 
--  Since `p - 1 = 2 * 3^2 * 7 * 11 * 31 * 151 * 331`, both 3 and 4 share factors
--  with `p - 1`. The smallest valid exponent satisfying `gcd(alpha, p - 1) = 1` is 5.
def MERSENNE31_POSEIDON1_S_BOX_DEGREE : u64 := (5 : u64)

--  Number of full rounds per half for Mersenne31 Poseidon1 (`RF / 2`).
-- 
--  The total number of full rounds is `RF = 8` (4 beginning + 4 ending).
--  Follows the Poseidon1 paper's security analysis (Section 5.4) with a +2 RF margin.
def MERSENNE31_POSEIDON1_HALF_FULL_ROUNDS : usize := (4 : usize)

--  Number of partial rounds for Mersenne31 Poseidon1 (width 16).
-- 
--  Derived from the interpolation bound in the Poseidon1 paper (Eq. 3):
-- 
--    R_interp >= ceil(min{kappa, n} / log_2(alpha)) + ceil(log_alpha(t)) - 5
--             = ceil(31 / log_2(5)) + ceil(log_5(16)) - 5 = 14 + 2 - 5 = 11
-- 
--  With the +7.5% security margin: ceil(1.075 * 11) = 12. After brute-force
--  optimization over all security constraints: R_P = 14.
def MERSENNE31_POSEIDON1_PARTIAL_ROUNDS_16 : usize := (14 : usize)

--  Number of partial rounds for Mersenne31 Poseidon1 (width 32).
-- 
--  With the +7.5% security margin and brute-force optimization: R_P = 30.
def MERSENNE31_POSEIDON1_PARTIAL_ROUNDS_32 : usize := (30 : usize)

--  First column of the width-16 circulant MDS matrix used by Mersenne31 Poseidon1.
-- 
--  Suitable for the `mds_circ_col` field of [`Poseidon1Constants`] when building the
--  width-16 Poseidon1 AIR.
def MERSENNE31_POSEIDON1_MDS_CIRC_COL_16 : (RustArray i64 16) :=
  RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((16 : usize)) i64
      p3_mersenne_31.mds.MATRIX_CIRC_MDS_16_SML_ROW))
    (by sorry)

--  Generic (non-SIMD) Poseidon1 permutation for Mersenne31.
-- 
--  Uses the platform-independent Poseidon1 implementation with Karatsuba
--  MDS convolution via `MdsMatrixMersenne31`.
abbrev Poseidon1Mersenne31Generic (WIDTH : usize) :
  Type :=
  (p3_poseidon1.Poseidon1
    p3_mersenne_31.mersenne_31.Mersenne31
    (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
      p3_mersenne_31.mersenne_31.Mersenne31
      p3_mersenne_31.mds.MdsMatrixMersenne31
      (WIDTH))
    (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
      p3_mersenne_31.mersenne_31.Mersenne31
      (WIDTH))
    (WIDTH)
    ((5 : u64)))

--  Poseidon1 permutation for Mersenne31 (generic fallback).
-- 
--  Used on platforms without NEON or AVX2/AVX512 SIMD support.
abbrev Poseidon1Mersenne31 (WIDTH : usize) :
  Type :=
  (p3_poseidon1.Poseidon1
    p3_mersenne_31.mersenne_31.Mersenne31
    (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
      p3_mersenne_31.mersenne_31.Mersenne31
      p3_mersenne_31.mds.MdsMatrixMersenne31
      (WIDTH))
    (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
      p3_mersenne_31.mersenne_31.Mersenne31
      (WIDTH))
    (WIDTH)
    ((5 : u64)))

end p3_mersenne_31.poseidon1


namespace p3_mersenne_31.poseidon2

--  S-box degree for Mersenne31 Poseidon2.
-- 
--  Since `p - 1 = 2 × 3^2 × 7 × 11 × 31 × 151 × 331`, both 3 and 4 share factors
--  with `p - 1`. The smallest valid exponent satisfying `gcd(α, p - 1) = 1` is 5.
def MERSENNE31_S_BOX_DEGREE : u64 := (5 : u64)

--  Number of full rounds per half for Mersenne31 Poseidon2 (`RF / 2`).
-- 
--  The total number of full rounds is `RF = 8` (4 beginning + 4 ending).
--  Follows the Poseidon2 paper's security analysis with a +2 RF margin.
def MERSENNE31_POSEIDON2_HALF_FULL_ROUNDS : usize := (4 : usize)

--  Number of partial rounds for Mersenne31 Poseidon2 (width 16).
-- 
--  Derived from the Gröbner basis bound in the Poseidon2 paper (Eq. 1, R_GB term 3):
-- 
--    R_GB ≥ t − 7 + log_α(2) · min{κ/(t+1), log_2(p)/2}
--         = 9 + 0.4307 · min{7.53, 15.5} = 12.243
-- 
--  With the +7.5% security margin: ⌈1.075 × 12.243⌉ = 14.
def MERSENNE31_POSEIDON2_PARTIAL_ROUNDS_16 : usize := (14 : usize)

--  Number of partial rounds for Mersenne31 Poseidon2 (width 24).
-- 
--  Same Gröbner basis bound as width 16:
-- 
--    R_GB ≥ 17 + 0.4307 · min{5.12, 15.5} = 19.205
-- 
--  With the +7.5% security margin: ⌈1.075 × 19.205⌉ = 21.
-- 
--  The official round number script yields R_P = 22 for this configuration
--  (matching the Grain LFSR parameters used to generate the round constants).
def MERSENNE31_POSEIDON2_PARTIAL_ROUNDS_24 : usize := (22 : usize)

--  Number of partial rounds for Mersenne31 Poseidon2 (width 32).
-- 
--  The official round number script yields R_P = 30 for this configuration
--  (matching the Grain LFSR parameters used to generate the round constants below).
def MERSENNE31_POSEIDON2_PARTIAL_ROUNDS_32 : usize := (30 : usize)

--  An implementation of the matrix multiplications in the internal and external layers of Poseidon2.
-- 
--  This can act on `[A; WIDTH]` for any ring implementing `Algebra<Mersenne31>`.
--  If you have either `[Mersenne31::Packing; WIDTH]` or `[Mersenne31; WIDTH]` it will be much faster
--  to use `Poseidon2Mersenne31<WIDTH>` instead of building a Poseidon2 permutation using this.
structure GenericPoseidon2LinearLayersMersenne31 where
  -- no fields

def POSEIDON2_INTERNAL_MATRIX_DIAG_16_SHIFTS : (RustArray u8 15) :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(0 : u8),
                                (1 : u8),
                                (2 : u8),
                                (3 : u8),
                                (4 : u8),
                                (5 : u8),
                                (6 : u8),
                                (7 : u8),
                                (8 : u8),
                                (10 : u8),
                                (12 : u8),
                                (13 : u8),
                                (14 : u8),
                                (15 : u8),
                                (16 : u8)])))
    (by sorry)

def POSEIDON2_INTERNAL_MATRIX_DIAG_24_SHIFTS : (RustArray u8 23) :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(0 : u8),
                                (1 : u8),
                                (2 : u8),
                                (3 : u8),
                                (4 : u8),
                                (5 : u8),
                                (6 : u8),
                                (7 : u8),
                                (8 : u8),
                                (9 : u8),
                                (10 : u8),
                                (11 : u8),
                                (12 : u8),
                                (13 : u8),
                                (14 : u8),
                                (15 : u8),
                                (16 : u8),
                                (17 : u8),
                                (18 : u8),
                                (19 : u8),
                                (20 : u8),
                                (21 : u8),
                                (22 : u8)])))
    (by sorry)

def POSEIDON2_INTERNAL_MATRIX_DIAG_32_SHIFTS : (RustArray u8 31) :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(0 : u8),
                                (1 : u8),
                                (2 : u8),
                                (3 : u8),
                                (4 : u8),
                                (5 : u8),
                                (6 : u8),
                                (7 : u8),
                                (8 : u8),
                                (9 : u8),
                                (10 : u8),
                                (11 : u8),
                                (12 : u8),
                                (13 : u8),
                                (14 : u8),
                                (15 : u8),
                                (16 : u8),
                                (17 : u8),
                                (18 : u8),
                                (19 : u8),
                                (20 : u8),
                                (21 : u8),
                                (22 : u8),
                                (23 : u8),
                                (24 : u8),
                                (25 : u8),
                                (26 : u8),
                                (27 : u8),
                                (28 : u8),
                                (29 : u8),
                                (30 : u8)])))
    (by sorry)

@[reducible] instance Impl_4.AssociatedTypes :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers.AssociatedTypes
  GenericPoseidon2LinearLayersMersenne31
  ((16 : usize))
  where

instance Impl_4 :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers
  GenericPoseidon2LinearLayersMersenne31
  ((16 : usize))
  := sorry

@[reducible] instance Impl_5.AssociatedTypes :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers.AssociatedTypes
  GenericPoseidon2LinearLayersMersenne31
  ((24 : usize))
  where

instance Impl_5 :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers
  GenericPoseidon2LinearLayersMersenne31
  ((24 : usize))
  := sorry

@[reducible] instance Impl_6.AssociatedTypes :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers.AssociatedTypes
  GenericPoseidon2LinearLayersMersenne31
  ((32 : usize))
  where

instance Impl_6 :
  p3_poseidon2.generic.GenericPoseidon2LinearLayers
  GenericPoseidon2LinearLayersMersenne31
  ((32 : usize))
  := sorry

end p3_mersenne_31.poseidon2


namespace p3_mersenne_31.qm31

--  The degree-4 extension of Mersenne31: `Mersenne31[i][u]` with `i² = -1`
--  and `u² = 2 + i`.
abbrev QM31 :
  Type :=
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))

abbrev CM31 :
  Type :=
  (p3_field.extension.ExtField
    p3_mersenne_31.mersenne_31.Mersenne31
    ((2 : usize))
    (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
    p3_mersenne_31.mersenne_31.Mersenne31)

abbrev PackedM31 : Type := p3_mersenne_31.mersenne_31.Mersenne31

abbrev PackedCM31 :
  Type :=
  (p3_field.extension.PackedExtField
    p3_mersenne_31.mersenne_31.Mersenne31
    p3_mersenne_31.mersenne_31.Mersenne31
    ((2 : usize))
    (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31))

@[reducible] instance Impl_1.AssociatedTypes :
  core_models.ops.arith.Add.AssociatedTypes
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  where
  Output := (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))

instance Impl_1 :
  core_models.ops.arith.Add
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_2.AssociatedTypes :
  core_models.ops.arith.AddAssign.AssociatedTypes
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl_2 :
  core_models.ops.arith.AddAssign
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_3.AssociatedTypes :
  core_models.ops.arith.Sub.AssociatedTypes
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  where
  Output := (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))

instance Impl_3 :
  core_models.ops.arith.Sub
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_4.AssociatedTypes :
  core_models.ops.arith.SubAssign.AssociatedTypes
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl_4 :
  core_models.ops.arith.SubAssign
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_5.AssociatedTypes :
  core_models.ops.arith.Mul.AssociatedTypes
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  where
  Output := (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))

instance Impl_5 :
  core_models.ops.arith.Mul
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_6.AssociatedTypes :
  core_models.ops.arith.MulAssign.AssociatedTypes
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl_6 :
  core_models.ops.arith.MulAssign
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_8.AssociatedTypes :
  p3_field.field.BasedVectorSpace.AssociatedTypes
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl_8 :
  p3_field.field.BasedVectorSpace
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

structure PackedQM31 where
  _0 :
    (RustArray
    (p3_field.extension.PackedExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31))
    2)

@[instance] opaque Impl_41.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_41 :
  core_models.clone.Clone PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_42.AssociatedTypes :
  core_models.marker.Copy.AssociatedTypes PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_42 :
  core_models.marker.Copy PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_43.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_43 :
  core_models.fmt.Debug PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_44.AssociatedTypes :
  core_models.default.Default.AssociatedTypes PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_44 :
  core_models.default.Default PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_45.AssociatedTypes :
  core_models.marker.StructuralPartialEq.AssociatedTypes PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_45 :
  core_models.marker.StructuralPartialEq PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_46.AssociatedTypes :
  core_models.cmp.PartialEq.AssociatedTypes PackedQM31 PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_46 :
  core_models.cmp.PartialEq PackedQM31 PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_47.AssociatedTypes :
  core_models.cmp.Eq.AssociatedTypes PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_47 :
  core_models.cmp.Eq PackedQM31 :=
  by constructor <;> exact Inhabited.default

@[reducible] instance Impl_11.AssociatedTypes :
  core_models.ops.arith.Neg.AssociatedTypes PackedQM31
  where
  Output := PackedQM31

instance Impl_11 : core_models.ops.arith.Neg PackedQM31 := sorry

@[reducible] instance Impl_16.AssociatedTypes :
  core_models.ops.arith.Mul.AssociatedTypes PackedQM31 PackedQM31
  where
  Output := PackedQM31

instance Impl_16 : core_models.ops.arith.Mul PackedQM31 PackedQM31 := sorry

@[reducible] instance Impl_17.AssociatedTypes :
  core_models.ops.arith.MulAssign.AssociatedTypes PackedQM31 PackedQM31
  where

instance Impl_17 : core_models.ops.arith.MulAssign PackedQM31 PackedQM31 := sorry

@[reducible] instance Impl_22.AssociatedTypes :
  core_models.convert.From.AssociatedTypes
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  where

instance Impl_22 :
  core_models.convert.From
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  := sorry

@[reducible] instance Impl_23.AssociatedTypes :
  core_models.ops.arith.Add.AssociatedTypes
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  where
  Output := PackedQM31

instance Impl_23 :
  core_models.ops.arith.Add
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  := sorry

@[reducible] instance Impl_24.AssociatedTypes :
  core_models.ops.arith.AddAssign.AssociatedTypes
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  where

instance Impl_24 :
  core_models.ops.arith.AddAssign
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  := sorry

@[reducible] instance Impl_25.AssociatedTypes :
  core_models.ops.arith.Sub.AssociatedTypes
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  where
  Output := PackedQM31

instance Impl_25 :
  core_models.ops.arith.Sub
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  := sorry

@[reducible] instance Impl_26.AssociatedTypes :
  core_models.ops.arith.SubAssign.AssociatedTypes
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  where

instance Impl_26 :
  core_models.ops.arith.SubAssign
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  := sorry

@[reducible] instance Impl_27.AssociatedTypes :
  core_models.ops.arith.Mul.AssociatedTypes
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  where
  Output := PackedQM31

instance Impl_27 :
  core_models.ops.arith.Mul
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  := sorry

@[reducible] instance Impl_28.AssociatedTypes :
  core_models.ops.arith.MulAssign.AssociatedTypes
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  where

instance Impl_28 :
  core_models.ops.arith.MulAssign
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  := sorry

@[reducible] instance Impl_38.AssociatedTypes :
  p3_field.field.BasedVectorSpace.AssociatedTypes
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl_38 :
  p3_field.field.BasedVectorSpace
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_39.AssociatedTypes :
  rand.distr.distribution.Distribution.AssociatedTypes
  rand.distr.StandardUniform
  PackedQM31
  where

instance Impl_39 :
  rand.distr.distribution.Distribution rand.distr.StandardUniform PackedQM31
  := sorry

end p3_mersenne_31.qm31


namespace p3_mersenne_31.no_packing.poseidon2

--  The internal layers of the Poseidon2 permutation.
structure Poseidon2InternalLayerMersenne31 where
  internal_constants : (alloc.vec.Vec
      p3_mersenne_31.mersenne_31.Mersenne31
      alloc.alloc.Global)

@[instance] opaque Impl_2.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes Poseidon2InternalLayerMersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_2 :
  core_models.fmt.Debug Poseidon2InternalLayerMersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_3.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes Poseidon2InternalLayerMersenne31 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_3 :
  core_models.clone.Clone Poseidon2InternalLayerMersenne31 :=
  by constructor <;> exact Inhabited.default

end p3_mersenne_31.no_packing.poseidon2


namespace p3_mersenne_31.poseidon2

@[reducible] instance Impl.AssociatedTypes :
  p3_poseidon2.internal.InternalLayer.AssociatedTypes
  p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((16 : usize))
  ((5 : u64))
  where

instance Impl :
  p3_poseidon2.internal.InternalLayer
  p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((16 : usize))
  ((5 : u64))
  := sorry

@[reducible] instance Impl_1.AssociatedTypes :
  p3_poseidon2.internal.InternalLayer.AssociatedTypes
  p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((24 : usize))
  ((5 : u64))
  where

instance Impl_1 :
  p3_poseidon2.internal.InternalLayer
  p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((24 : usize))
  ((5 : u64))
  := sorry

@[reducible] instance Impl_2.AssociatedTypes :
  p3_poseidon2.internal.InternalLayer.AssociatedTypes
  p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((32 : usize))
  ((5 : u64))
  where

instance Impl_2 :
  p3_poseidon2.internal.InternalLayer
  p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((32 : usize))
  ((5 : u64))
  := sorry

end p3_mersenne_31.poseidon2


namespace p3_mersenne_31.no_packing.poseidon2

--  The external layers of the Poseidon2 permutation.
structure Poseidon2ExternalLayerMersenne31 (WIDTH : usize) where
  external_constants : (p3_poseidon2.external.ExternalLayerConstants
      p3_mersenne_31.mersenne_31.Mersenne31
      (WIDTH))

end p3_mersenne_31.no_packing.poseidon2


namespace p3_mersenne_31.poseidon2

--  An implementation of the Poseidon2 hash function specialised to run on the current architecture.
-- 
--  It acts on arrays of the form either `[Mersenne31::Packing; WIDTH]` or `[Mersenne31; WIDTH]`. For speed purposes,
--  wherever possible, input arrays should of the form `[Mersenne31::Packing; WIDTH]`.
abbrev Poseidon2Mersenne31 (WIDTH : usize) :
  Type :=
  (p3_poseidon2.Poseidon2
    p3_mersenne_31.mersenne_31.Mersenne31
    (p3_mersenne_31.no_packing.poseidon2.Poseidon2ExternalLayerMersenne31
      (WIDTH))
    p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
    (WIDTH)
    ((5 : u64)))

end p3_mersenne_31.poseidon2


namespace p3_mersenne_31.no_packing.poseidon2

@[instance] opaque Impl_4.AssociatedTypes (WIDTH : usize) :
  core_models.clone.Clone.AssociatedTypes
  (Poseidon2ExternalLayerMersenne31 (WIDTH)) :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_4 (WIDTH : usize) :
  core_models.clone.Clone (Poseidon2ExternalLayerMersenne31 (WIDTH)) :=
  by constructor <;> exact Inhabited.default

end p3_mersenne_31.no_packing.poseidon2


namespace p3_mersenne_31.poseidon2

@[reducible] instance Impl_3.AssociatedTypes (WIDTH : usize) :
  p3_poseidon2.external.ExternalLayer.AssociatedTypes
  (p3_mersenne_31.no_packing.poseidon2.Poseidon2ExternalLayerMersenne31 (WIDTH))
  p3_mersenne_31.mersenne_31.Mersenne31
  (WIDTH)
  ((5 : u64))
  where

instance Impl_3 (WIDTH : usize) :
  p3_poseidon2.external.ExternalLayer
  (p3_mersenne_31.no_packing.poseidon2.Poseidon2ExternalLayerMersenne31 (WIDTH))
  p3_mersenne_31.mersenne_31.Mersenne31
  (WIDTH)
  ((5 : u64))
  := sorry

end p3_mersenne_31.poseidon2


namespace p3_mersenne_31.no_packing.poseidon2

@[reducible] instance Impl.AssociatedTypes :
  p3_poseidon2.internal.InternalLayerConstructor.AssociatedTypes
  Poseidon2InternalLayerMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl :
  p3_poseidon2.internal.InternalLayerConstructor
  Poseidon2InternalLayerMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_1.AssociatedTypes (WIDTH : usize) :
  p3_poseidon2.external.ExternalLayerConstructor.AssociatedTypes
  (Poseidon2ExternalLayerMersenne31 (WIDTH))
  p3_mersenne_31.mersenne_31.Mersenne31
  (WIDTH)
  where

instance Impl_1 (WIDTH : usize) :
  p3_poseidon2.external.ExternalLayerConstructor
  (Poseidon2ExternalLayerMersenne31 (WIDTH))
  p3_mersenne_31.mersenne_31.Mersenne31
  (WIDTH)
  := sorry

end p3_mersenne_31.no_packing.poseidon2


namespace p3_mersenne_31.mds

@[reducible] instance Impl_1.AssociatedTypes :
  p3_mds.karatsuba_convolution.Convolve.AssociatedTypes
  LargeConvolveMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  i64
  i64
  where

instance Impl_1 :
  p3_mds.karatsuba_convolution.Convolve
  LargeConvolveMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  i64
  i64
  := sorry

end p3_mersenne_31.mds


namespace p3_mersenne_31.poseidon2

--  Multiply state by the matrix (1 + Diag(V))
-- 
--  Here V is the vector [-2] + 1 << shifts. This used delayed reduction to be slightly faster.
@[spec]
def permute_mut (N : usize)
    (state : (RustArray p3_mersenne_31.mersenne_31.Mersenne31 N))
    (shifts : (RustSlice u8)) :
    RustM (RustArray p3_mersenne_31.mersenne_31.Mersenne31 N) := sorry

end p3_mersenne_31.poseidon2


namespace p3_mersenne_31.mds

@[reducible] instance Impl.AssociatedTypes :
  p3_mds.karatsuba_convolution.Convolve.AssociatedTypes
  SmallConvolveMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  i64
  i64
  where

instance Impl :
  p3_mds.karatsuba_convolution.Convolve
  SmallConvolveMersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  i64
  i64
  := sorry

end p3_mersenne_31.mds


namespace p3_mersenne_31.mersenne_31

--  Convert a `[u32; N]` array to an array of field elements.
-- 
--  Const version of `input.map(Mersenne31::new)`.
@[spec]
def Impl.new_array (N : usize) (input : (RustArray u32 N)) :
    RustM (RustArray Mersenne31 N) := sorry

def Impl.EXT_TWO_ADIC_GENERATORS : (RustArray (RustArray Mersenne31 2) 33) := sorry

@[reducible] instance Impl_14.AssociatedTypes :
  p3_field.field.InjectiveMonomial.AssociatedTypes Mersenne31 ((5 : u64))
  where

instance Impl_14 : p3_field.field.InjectiveMonomial Mersenne31 ((5 : u64)) where

end p3_mersenne_31.mersenne_31


namespace p3_mersenne_31.qm31

@[reducible] instance Impl_13.AssociatedTypes :
  core_models.ops.arith.AddAssign.AssociatedTypes PackedQM31 PackedQM31
  where

instance Impl_13 : core_models.ops.arith.AddAssign PackedQM31 PackedQM31 := sorry

@[reducible] instance Impl_15.AssociatedTypes :
  core_models.ops.arith.SubAssign.AssociatedTypes PackedQM31 PackedQM31
  where

instance Impl_15 : core_models.ops.arith.SubAssign PackedQM31 PackedQM31 := sorry

@[reducible] instance Impl_32.AssociatedTypes :
  core_models.ops.arith.AddAssign.AssociatedTypes
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl_32 :
  core_models.ops.arith.AddAssign
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_34.AssociatedTypes :
  core_models.ops.arith.SubAssign.AssociatedTypes
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl_34 :
  core_models.ops.arith.SubAssign
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_36.AssociatedTypes :
  core_models.ops.arith.MulAssign.AssociatedTypes
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl_36 :
  core_models.ops.arith.MulAssign
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

end p3_mersenne_31.qm31


namespace p3_mersenne_31.poseidon1

--  Round constants for width-16 Poseidon1 on Mersenne31.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=5 (exp_flag=0), n=31, t=16, R_F=8, R_P=14
-- 
--  Generated by `poseidon1/generate_constants.py --field mersenne31 --width 16`.
-- 
--  Layout: [initial_full (4 rounds), partial (14 rounds), terminal_full (4 rounds)].
def MERSENNE31_POSEIDON1_RC_16 :
  (RustArray (RustArray p3_mersenne_31.mersenne_31.Mersenne31 16) 22)
  :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1988864850 : u32),
                                                        (1893772157 : u32),
                                                        (1025928330 : u32),
                                                        (1839472709 : u32),
                                                        (1611656994 : u32),
                                                        (1104858731 : u32),
                                                        (1694088660 : u32),
                                                        (1564660990 : u32),
                                                        (1991332205 : u32),
                                                        (1875486487 : u32),
                                                        (1890340790 : u32),
                                                        (1658614 : u32),
                                                        (582370530 : u32),
                                                        (528029397 : u32),
                                                        (1196956642 : u32),
                                                        (655401251 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1652877415 : u32),
                                                        (26032894 : u32),
                                                        (1576640243 : u32),
                                                        (1277052539 : u32),
                                                        (1450142396 : u32),
                                                        (697623591 : u32),
                                                        (1401580866 : u32),
                                                        (1568404175 : u32),
                                                        (2145004971 : u32),
                                                        (265835716 : u32),
                                                        (1183985610 : u32),
                                                        (1031234465 : u32),
                                                        (436012490 : u32),
                                                        (172735299 : u32),
                                                        (352802897 : u32),
                                                        (1032863094 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(757665783 : u32),
                                                        (1082171296 : u32),
                                                        (1507509996 : u32),
                                                        (309929890 : u32),
                                                        (1807683232 : u32),
                                                        (43258895 : u32),
                                                        (611592566 : u32),
                                                        (1854193793 : u32),
                                                        (575164234 : u32),
                                                        (894217817 : u32),
                                                        (72613857 : u32),
                                                        (1061659596 : u32),
                                                        (8921166 : u32),
                                                        (1617355017 : u32),
                                                        (998001536 : u32),
                                                        (1800758877 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1002748055 : u32),
                                                        (1935405944 : u32),
                                                        (1351462722 : u32),
                                                        (411368491 : u32),
                                                        (1913975372 : u32),
                                                        (1956167178 : u32),
                                                        (442558016 : u32),
                                                        (855898408 : u32),
                                                        (699687798 : u32),
                                                        (1553382248 : u32),
                                                        (1708169125 : u32),
                                                        (490049183 : u32),
                                                        (1251643415 : u32),
                                                        (1193594742 : u32),
                                                        (880473871 : u32),
                                                        (511174042 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(2139014335 : u32),
                                                        (69309039 : u32),
                                                        (1368974953 : u32),
                                                        (886780232 : u32),
                                                        (1130937085 : u32),
                                                        (1718115455 : u32),
                                                        (2027103386 : u32),
                                                        (1612216449 : u32),
                                                        (1994053242 : u32),
                                                        (110146615 : u32),
                                                        (514413329 : u32),
                                                        (1088763546 : u32),
                                                        (955319292 : u32),
                                                        (488794657 : u32),
                                                        (1460209171 : u32),
                                                        (530850056 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(398192464 : u32),
                                                        (536338716 : u32),
                                                        (75179210 : u32),
                                                        (1309934197 : u32),
                                                        (1335920373 : u32),
                                                        (127611036 : u32),
                                                        (291093831 : u32),
                                                        (1832379621 : u32),
                                                        (123571662 : u32),
                                                        (303176864 : u32),
                                                        (2137685056 : u32),
                                                        (1759609530 : u32),
                                                        (1418928155 : u32),
                                                        (71608334 : u32),
                                                        (6616262 : u32),
                                                        (1684515814 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1721194338 : u32),
                                                        (720801691 : u32),
                                                        (878392254 : u32),
                                                        (460379263 : u32),
                                                        (87930647 : u32),
                                                        (940673483 : u32),
                                                        (1136203256 : u32),
                                                        (551499412 : u32),
                                                        (256220454 : u32),
                                                        (2007034235 : u32),
                                                        (796124985 : u32),
                                                        (410436345 : u32),
                                                        (1705042586 : u32),
                                                        (1286336446 : u32),
                                                        (1522340456 : u32),
                                                        (1295296352 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(309794713 : u32),
                                                        (1772145068 : u32),
                                                        (956898901 : u32),
                                                        (2137070800 : u32),
                                                        (988829146 : u32),
                                                        (2059451359 : u32),
                                                        (1846491684 : u32),
                                                        (1105442551 : u32),
                                                        (1236497773 : u32),
                                                        (1452000568 : u32),
                                                        (549485016 : u32),
                                                        (385992492 : u32),
                                                        (1987107948 : u32),
                                                        (1514377269 : u32),
                                                        (2090065934 : u32),
                                                        (1444920141 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(293113979 : u32),
                                                        (41120774 : u32),
                                                        (855319793 : u32),
                                                        (1663284746 : u32),
                                                        (1789994008 : u32),
                                                        (1120509162 : u32),
                                                        (358222743 : u32),
                                                        (1406256810 : u32),
                                                        (735183687 : u32),
                                                        (664485235 : u32),
                                                        (1331641456 : u32),
                                                        (38121324 : u32),
                                                        (595810771 : u32),
                                                        (1234594393 : u32),
                                                        (374746316 : u32),
                                                        (683205361 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(333470311 : u32),
                                                        (52569133 : u32),
                                                        (1545061237 : u32),
                                                        (558380440 : u32),
                                                        (1621818734 : u32),
                                                        (917401058 : u32),
                                                        (2067235092 : u32),
                                                        (287699716 : u32),
                                                        (1147048811 : u32),
                                                        (857212322 : u32),
                                                        (1393326356 : u32),
                                                        (59403380 : u32),
                                                        (1953536311 : u32),
                                                        (286210646 : u32),
                                                        (339182306 : u32),
                                                        (1970994821 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(840890734 : u32),
                                                        (251775135 : u32),
                                                        (1095728294 : u32),
                                                        (528364142 : u32),
                                                        (1278120865 : u32),
                                                        (493891384 : u32),
                                                        (1694792391 : u32),
                                                        (973871453 : u32),
                                                        (1984975896 : u32),
                                                        (1721142903 : u32),
                                                        (258664210 : u32),
                                                        (2087302672 : u32),
                                                        (1302288082 : u32),
                                                        (1494146747 : u32),
                                                        (793447426 : u32),
                                                        (761499176 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1751120490 : u32),
                                                        (1640297198 : u32),
                                                        (964462483 : u32),
                                                        (223647345 : u32),
                                                        (422741147 : u32),
                                                        (1144108025 : u32),
                                                        (391562508 : u32),
                                                        (941722791 : u32),
                                                        (1586629518 : u32),
                                                        (197956564 : u32),
                                                        (538428903 : u32),
                                                        (641865127 : u32),
                                                        (1755572882 : u32),
                                                        (1847735350 : u32),
                                                        (285075763 : u32),
                                                        (1204918149 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(346255565 : u32),
                                                        (1260249042 : u32),
                                                        (17595783 : u32),
                                                        (817045041 : u32),
                                                        (40859297 : u32),
                                                        (1692754603 : u32),
                                                        (1561994716 : u32),
                                                        (1819548381 : u32),
                                                        (437357295 : u32),
                                                        (2036105521 : u32),
                                                        (2081490983 : u32),
                                                        (85984143 : u32),
                                                        (1446594830 : u32),
                                                        (1244567970 : u32),
                                                        (1006443630 : u32),
                                                        (343688730 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(917016030 : u32),
                                                        (788669287 : u32),
                                                        (1170922668 : u32),
                                                        (848534226 : u32),
                                                        (1101434239 : u32),
                                                        (399122088 : u32),
                                                        (303694205 : u32),
                                                        (1203257674 : u32),
                                                        (647019654 : u32),
                                                        (1496903548 : u32),
                                                        (1394182228 : u32),
                                                        (212397148 : u32),
                                                        (243811328 : u32),
                                                        (1743191356 : u32),
                                                        (382143294 : u32),
                                                        (1012211611 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1283969163 : u32),
                                                        (990002926 : u32),
                                                        (2007771858 : u32),
                                                        (1974869724 : u32),
                                                        (2061671274 : u32),
                                                        (65000052 : u32),
                                                        (1216115142 : u32),
                                                        (748656623 : u32),
                                                        (33200472 : u32),
                                                        (2054727597 : u32),
                                                        (2018614972 : u32),
                                                        (319157697 : u32),
                                                        (832084944 : u32),
                                                        (838678449 : u32),
                                                        (945306122 : u32),
                                                        (1879962682 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(2023454402 : u32),
                                                        (1955806528 : u32),
                                                        (322243663 : u32),
                                                        (28387690 : u32),
                                                        (1830640156 : u32),
                                                        (106461941 : u32),
                                                        (1432743923 : u32),
                                                        (1535682255 : u32),
                                                        (205719350 : u32),
                                                        (2142342867 : u32),
                                                        (1690914136 : u32),
                                                        (830548222 : u32),
                                                        (959379038 : u32),
                                                        (1907897385 : u32),
                                                        (202063967 : u32),
                                                        (1155229325 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(17178960 : u32),
                                                        (972169837 : u32),
                                                        (1486781932 : u32),
                                                        (703649237 : u32),
                                                        (966071061 : u32),
                                                        (1053462523 : u32),
                                                        (474831952 : u32),
                                                        (689416503 : u32),
                                                        (41034287 : u32),
                                                        (1418544835 : u32),
                                                        (1496115571 : u32),
                                                        (1851571204 : u32),
                                                        (1769305815 : u32),
                                                        (1371133548 : u32),
                                                        (1790997330 : u32),
                                                        (743134624 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(670482084 : u32),
                                                        (211188527 : u32),
                                                        (1146349802 : u32),
                                                        (1452124878 : u32),
                                                        (872181367 : u32),
                                                        (463475412 : u32),
                                                        (25860072 : u32),
                                                        (445390154 : u32),
                                                        (511268715 : u32),
                                                        (1648795599 : u32),
                                                        (934609664 : u32),
                                                        (1521993313 : u32),
                                                        (709269337 : u32),
                                                        (1097343861 : u32),
                                                        (192294895 : u32),
                                                        (176146572 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1545845660 : u32),
                                                        (1571179967 : u32),
                                                        (2049696221 : u32),
                                                        (489923800 : u32),
                                                        (1212825486 : u32),
                                                        (8024170 : u32),
                                                        (1472042855 : u32),
                                                        (1900622879 : u32),
                                                        (644345014 : u32),
                                                        (767104271 : u32),
                                                        (838877505 : u32),
                                                        (1170240143 : u32),
                                                        (1653817667 : u32),
                                                        (851549209 : u32),
                                                        (700266381 : u32),
                                                        (1530744878 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1657504853 : u32),
                                                        (722763601 : u32),
                                                        (1646069035 : u32),
                                                        (297431331 : u32),
                                                        (1505449150 : u32),
                                                        (1631923190 : u32),
                                                        (817545018 : u32),
                                                        (559650807 : u32),
                                                        (124784384 : u32),
                                                        (232392625 : u32),
                                                        (718894869 : u32),
                                                        (746078253 : u32),
                                                        (1620445342 : u32),
                                                        (610658159 : u32),
                                                        (1531514282 : u32),
                                                        (668349597 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1318947977 : u32),
                                                        (2067179133 : u32),
                                                        (1101166452 : u32),
                                                        (1900358186 : u32),
                                                        (1294966157 : u32),
                                                        (1545180440 : u32),
                                                        (1275166252 : u32),
                                                        (877615027 : u32),
                                                        (1890570669 : u32),
                                                        (1363262031 : u32),
                                                        (803235412 : u32),
                                                        (1952290984 : u32),
                                                        (51483180 : u32),
                                                        (861811719 : u32),
                                                        (1543398233 : u32),
                                                        (1962620596 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1101129880 : u32),
                                                        (1595397484 : u32),
                                                        (819053730 : u32),
                                                        (864084411 : u32),
                                                        (1094415504 : u32),
                                                        (1370326502 : u32),
                                                        (446128291 : u32),
                                                        (892553082 : u32),
                                                        (1121564363 : u32),
                                                        (675977724 : u32),
                                                        (82524664 : u32),
                                                        (791360430 : u32),
                                                        (1528948402 : u32),
                                                        (1253654946 : u32),
                                                        (385862305 : u32),
                                                        (1057147875 :
                                                        u32)])))])))
    (by sorry)

--  Round constants for width-32 Poseidon1 on Mersenne31.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=5 (exp_flag=0), n=31, t=32, R_F=8, R_P=30
-- 
--  Generated by `poseidon1/generate_constants.py --field mersenne31 --width 32`.
-- 
--  Layout: [initial_full (4 rounds), partial (30 rounds), terminal_full (4 rounds)].
def MERSENNE31_POSEIDON1_RC_32 :
  (RustArray (RustArray p3_mersenne_31.mersenne_31.Mersenne31 32) 38)
  :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1729160065 : u32),
                                                        (27999661 : u32),
                                                        (1237173535 : u32),
                                                        (1103727717 : u32),
                                                        (596139402 : u32),
                                                        (619347324 : u32),
                                                        (1801845869 : u32),
                                                        (1627808090 : u32),
                                                        (139024371 : u32),
                                                        (360461876 : u32),
                                                        (1303224591 : u32),
                                                        (1826595949 : u32),
                                                        (468846782 : u32),
                                                        (1540501420 : u32),
                                                        (2044366811 : u32),
                                                        (2028718317 : u32),
                                                        (1284230111 : u32),
                                                        (670536848 : u32),
                                                        (1883853842 : u32),
                                                        (708936782 : u32),
                                                        (1371236849 : u32),
                                                        (840293409 : u32),
                                                        (1729185817 : u32),
                                                        (665479689 : u32),
                                                        (1598897325 : u32),
                                                        (1607911204 : u32),
                                                        (457969805 : u32),
                                                        (2126353565 : u32),
                                                        (1469698125 : u32),
                                                        (1452024111 : u32),
                                                        (1745363419 : u32),
                                                        (1644640041 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(580839296 : u32),
                                                        (995071171 : u32),
                                                        (396602452 : u32),
                                                        (1815642745 : u32),
                                                        (1215757909 : u32),
                                                        (829485578 : u32),
                                                        (862993998 : u32),
                                                        (60295857 : u32),
                                                        (19902714 : u32),
                                                        (341764315 : u32),
                                                        (1233214256 : u32),
                                                        (1185777564 : u32),
                                                        (1388073021 : u32),
                                                        (1483026647 : u32),
                                                        (1547106789 : u32),
                                                        (42886403 : u32),
                                                        (137429864 : u32),
                                                        (1968465478 : u32),
                                                        (1931810545 : u32),
                                                        (860372570 : u32),
                                                        (77628460 : u32),
                                                        (439432665 : u32),
                                                        (1400581809 : u32),
                                                        (1538215799 : u32),
                                                        (1266208109 : u32),
                                                        (1525492810 : u32),
                                                        (1724421089 : u32),
                                                        (1012175782 : u32),
                                                        (1187392508 : u32),
                                                        (1447975194 : u32),
                                                        (1390335911 : u32),
                                                        (13697837 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(724621313 : u32),
                                                        (270380023 : u32),
                                                        (788210125 : u32),
                                                        (1245060153 : u32),
                                                        (1240462706 : u32),
                                                        (773049076 : u32),
                                                        (24012697 : u32),
                                                        (459070276 : u32),
                                                        (399125958 : u32),
                                                        (240127712 : u32),
                                                        (21088923 : u32),
                                                        (664478582 : u32),
                                                        (1715979275 : u32),
                                                        (231403068 : u32),
                                                        (384302329 : u32),
                                                        (1508300380 : u32),
                                                        (515322057 : u32),
                                                        (2126447639 : u32),
                                                        (677410888 : u32),
                                                        (1165131676 : u32),
                                                        (1314144251 : u32),
                                                        (65938768 : u32),
                                                        (17618251 : u32),
                                                        (2065305680 : u32),
                                                        (47991670 : u32),
                                                        (725260860 : u32),
                                                        (783004377 : u32),
                                                        (110265683 : u32),
                                                        (757314549 : u32),
                                                        (1839407793 : u32),
                                                        (354937863 : u32),
                                                        (239405946 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1402344978 : u32),
                                                        (552692496 : u32),
                                                        (384830560 : u32),
                                                        (1278858511 : u32),
                                                        (1104518518 : u32),
                                                        (1381234722 : u32),
                                                        (995349377 : u32),
                                                        (461326090 : u32),
                                                        (1581091164 : u32),
                                                        (1382383909 : u32),
                                                        (18976979 : u32),
                                                        (1700150144 : u32),
                                                        (487565895 : u32),
                                                        (896906185 : u32),
                                                        (1275960608 : u32),
                                                        (416280735 : u32),
                                                        (1688722012 : u32),
                                                        (789842725 : u32),
                                                        (329227825 : u32),
                                                        (1726180309 : u32),
                                                        (1682098193 : u32),
                                                        (1485282254 : u32),
                                                        (1607239622 : u32),
                                                        (1745333772 : u32),
                                                        (1091683927 : u32),
                                                        (1664911657 : u32),
                                                        (1955998065 : u32),
                                                        (1069649592 : u32),
                                                        (1164767880 : u32),
                                                        (838256850 : u32),
                                                        (1815753128 : u32),
                                                        (1837293392 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1027811219 : u32),
                                                        (1100325527 : u32),
                                                        (2144294763 : u32),
                                                        (1808702357 : u32),
                                                        (1015163632 : u32),
                                                        (1982457267 : u32),
                                                        (1037946958 : u32),
                                                        (1513948504 : u32),
                                                        (1983802485 : u32),
                                                        (1735335304 : u32),
                                                        (2008556117 : u32),
                                                        (635406929 : u32),
                                                        (1769749264 : u32),
                                                        (63925983 : u32),
                                                        (313872248 : u32),
                                                        (1714672948 : u32),
                                                        (1114619063 : u32),
                                                        (1430676956 : u32),
                                                        (1451867570 : u32),
                                                        (317147102 : u32),
                                                        (1623361349 : u32),
                                                        (298470309 : u32),
                                                        (2088532858 : u32),
                                                        (1057985923 : u32),
                                                        (2050785808 : u32),
                                                        (1455937939 : u32),
                                                        (553027423 : u32),
                                                        (1776654280 : u32),
                                                        (1016141171 : u32),
                                                        (700970754 : u32),
                                                        (2014882003 : u32),
                                                        (442032405 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(688992664 : u32),
                                                        (2003511455 : u32),
                                                        (512896738 : u32),
                                                        (560331760 : u32),
                                                        (684502904 : u32),
                                                        (428025981 : u32),
                                                        (1227563744 : u32),
                                                        (2009876055 : u32),
                                                        (956324903 : u32),
                                                        (1221427337 : u32),
                                                        (645725371 : u32),
                                                        (474073733 : u32),
                                                        (1102287935 : u32),
                                                        (552039034 : u32),
                                                        (1689090291 : u32),
                                                        (333267987 : u32),
                                                        (272819164 : u32),
                                                        (1957554988 : u32),
                                                        (768463815 : u32),
                                                        (100691900 : u32),
                                                        (900073961 : u32),
                                                        (229582652 : u32),
                                                        (978282831 : u32),
                                                        (2056857235 : u32),
                                                        (1509756957 : u32),
                                                        (668078379 : u32),
                                                        (423081631 : u32),
                                                        (780697788 : u32),
                                                        (1086399529 : u32),
                                                        (108619174 : u32),
                                                        (1856090989 : u32),
                                                        (1845577582 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(701329802 : u32),
                                                        (1409730195 : u32),
                                                        (1373515418 : u32),
                                                        (1843148938 : u32),
                                                        (1400255603 : u32),
                                                        (2143120346 : u32),
                                                        (396516543 : u32),
                                                        (522814157 : u32),
                                                        (2063078764 : u32),
                                                        (432691965 : u32),
                                                        (762330259 : u32),
                                                        (203964644 : u32),
                                                        (752517837 : u32),
                                                        (1551847904 : u32),
                                                        (498436102 : u32),
                                                        (1018571729 : u32),
                                                        (725960219 : u32),
                                                        (1644477008 : u32),
                                                        (2077081209 : u32),
                                                        (1750593724 : u32),
                                                        (1257415528 : u32),
                                                        (851527412 : u32),
                                                        (449830291 : u32),
                                                        (767792496 : u32),
                                                        (230550350 : u32),
                                                        (1354692685 : u32),
                                                        (1870897708 : u32),
                                                        (1129068353 : u32),
                                                        (543220064 : u32),
                                                        (1760923403 : u32),
                                                        (623489725 : u32),
                                                        (288114536 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1883282658 : u32),
                                                        (458704398 : u32),
                                                        (568099212 : u32),
                                                        (1600869168 : u32),
                                                        (1145016250 : u32),
                                                        (555389150 : u32),
                                                        (1495091760 : u32),
                                                        (1532640885 : u32),
                                                        (1666986810 : u32),
                                                        (519924336 : u32),
                                                        (1563771999 : u32),
                                                        (1446498082 : u32),
                                                        (1855695025 : u32),
                                                        (280317484 : u32),
                                                        (69803704 : u32),
                                                        (760128835 : u32),
                                                        (1913281633 : u32),
                                                        (442196771 : u32),
                                                        (1759606503 : u32),
                                                        (638883701 : u32),
                                                        (1492323307 : u32),
                                                        (1157890731 : u32),
                                                        (613581397 : u32),
                                                        (851810645 : u32),
                                                        (727413345 : u32),
                                                        (1652127647 : u32),
                                                        (1503357582 : u32),
                                                        (1892763091 : u32),
                                                        (931579089 : u32),
                                                        (288765024 : u32),
                                                        (587145601 : u32),
                                                        (1292303440 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(665363423 : u32),
                                                        (1685977476 : u32),
                                                        (980716739 : u32),
                                                        (1252597410 : u32),
                                                        (569037473 : u32),
                                                        (1355636109 : u32),
                                                        (114753478 : u32),
                                                        (1539641623 : u32),
                                                        (1173899452 : u32),
                                                        (314824177 : u32),
                                                        (1216319589 : u32),
                                                        (370615356 : u32),
                                                        (1552381156 : u32),
                                                        (1992086508 : u32),
                                                        (2016942544 : u32),
                                                        (882674251 : u32),
                                                        (643656246 : u32),
                                                        (972842286 : u32),
                                                        (610808232 : u32),
                                                        (1216370940 : u32),
                                                        (173831638 : u32),
                                                        (1980583661 : u32),
                                                        (2060279135 : u32),
                                                        (757684141 : u32),
                                                        (1636349694 : u32),
                                                        (545572213 : u32),
                                                        (1741029216 : u32),
                                                        (1030588827 : u32),
                                                        (660162122 : u32),
                                                        (507714002 : u32),
                                                        (167704630 : u32),
                                                        (810967268 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(607642520 : u32),
                                                        (1770949549 : u32),
                                                        (1369555082 : u32),
                                                        (1869300458 : u32),
                                                        (1316643372 : u32),
                                                        (861517941 : u32),
                                                        (1875492637 : u32),
                                                        (882822549 : u32),
                                                        (1076559853 : u32),
                                                        (243081034 : u32),
                                                        (1969815445 : u32),
                                                        (1831269979 : u32),
                                                        (1383829493 : u32),
                                                        (333686817 : u32),
                                                        (1995466812 : u32),
                                                        (2087410238 : u32),
                                                        (464042662 : u32),
                                                        (2079376107 : u32),
                                                        (1620965256 : u32),
                                                        (1361757955 : u32),
                                                        (1687486565 : u32),
                                                        (1582532954 : u32),
                                                        (1958059498 : u32),
                                                        (1248211345 : u32),
                                                        (470372939 : u32),
                                                        (817214980 : u32),
                                                        (320432735 : u32),
                                                        (2021392599 : u32),
                                                        (1012325144 : u32),
                                                        (2126625520 : u32),
                                                        (2138443588 : u32),
                                                        (978984422 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(462537722 : u32),
                                                        (1727205391 : u32),
                                                        (1096008537 : u32),
                                                        (235506290 : u32),
                                                        (524991555 : u32),
                                                        (1284467773 : u32),
                                                        (2130653259 : u32),
                                                        (365021405 : u32),
                                                        (180631445 : u32),
                                                        (434667169 : u32),
                                                        (1398533385 : u32),
                                                        (610725616 : u32),
                                                        (751715739 : u32),
                                                        (1715158438 : u32),
                                                        (2070824627 : u32),
                                                        (766129552 : u32),
                                                        (807638192 : u32),
                                                        (233139829 : u32),
                                                        (1872784596 : u32),
                                                        (503780044 : u32),
                                                        (1434459181 : u32),
                                                        (100287793 : u32),
                                                        (812936275 : u32),
                                                        (325319814 : u32),
                                                        (385982312 : u32),
                                                        (289303041 : u32),
                                                        (2110285644 : u32),
                                                        (1899522036 : u32),
                                                        (1188833963 : u32),
                                                        (121010622 : u32),
                                                        (414830292 : u32),
                                                        (1212926622 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(969878499 : u32),
                                                        (1722691449 : u32),
                                                        (282111509 : u32),
                                                        (1878646304 : u32),
                                                        (1685274235 : u32),
                                                        (30918996 : u32),
                                                        (1034268640 : u32),
                                                        (439504827 : u32),
                                                        (2126204727 : u32),
                                                        (1362931375 : u32),
                                                        (1067632333 : u32),
                                                        (1463114519 : u32),
                                                        (624936115 : u32),
                                                        (245902772 : u32),
                                                        (2040368440 : u32),
                                                        (703271477 : u32),
                                                        (291953502 : u32),
                                                        (1191323662 : u32),
                                                        (1275725078 : u32),
                                                        (1900889762 : u32),
                                                        (2036894569 : u32),
                                                        (339685963 : u32),
                                                        (1812608759 : u32),
                                                        (691597832 : u32),
                                                        (1051956004 : u32),
                                                        (526493782 : u32),
                                                        (175036734 : u32),
                                                        (1961637062 : u32),
                                                        (1919337366 : u32),
                                                        (1378779600 : u32),
                                                        (1135162063 : u32),
                                                        (253220281 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(2083645600 : u32),
                                                        (164318108 : u32),
                                                        (1879850590 : u32),
                                                        (614239254 : u32),
                                                        (1011869920 : u32),
                                                        (62410520 : u32),
                                                        (1210448473 : u32),
                                                        (374993581 : u32),
                                                        (51392995 : u32),
                                                        (1953360196 : u32),
                                                        (156235229 : u32),
                                                        (868624894 : u32),
                                                        (92898103 : u32),
                                                        (2082837196 : u32),
                                                        (1372845324 : u32),
                                                        (235166972 : u32),
                                                        (77651417 : u32),
                                                        (1631128342 : u32),
                                                        (2143085018 : u32),
                                                        (210654480 : u32),
                                                        (1615363868 : u32),
                                                        (861874190 : u32),
                                                        (1634032662 : u32),
                                                        (1173628433 : u32),
                                                        (300992124 : u32),
                                                        (2024688449 : u32),
                                                        (387252121 : u32),
                                                        (375355417 : u32),
                                                        (824712307 : u32),
                                                        (954757158 : u32),
                                                        (941162105 : u32),
                                                        (488297037 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(996646508 : u32),
                                                        (1045520494 : u32),
                                                        (1635627288 : u32),
                                                        (1449551308 : u32),
                                                        (727692598 : u32),
                                                        (1318788608 : u32),
                                                        (1738272198 : u32),
                                                        (1600943333 : u32),
                                                        (2005915224 : u32),
                                                        (1081568315 : u32),
                                                        (104625873 : u32),
                                                        (729174761 : u32),
                                                        (630549689 : u32),
                                                        (2062370845 : u32),
                                                        (297642370 : u32),
                                                        (939391991 : u32),
                                                        (1428405809 : u32),
                                                        (1452563921 : u32),
                                                        (2080674565 : u32),
                                                        (1640351084 : u32),
                                                        (2140987518 : u32),
                                                        (198791140 : u32),
                                                        (378126663 : u32),
                                                        (2024950362 : u32),
                                                        (601934452 : u32),
                                                        (1463487074 : u32),
                                                        (2146347220 : u32),
                                                        (343839433 : u32),
                                                        (276107366 : u32),
                                                        (427494909 : u32),
                                                        (756976057 : u32),
                                                        (435679829 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(864938158 : u32),
                                                        (490295541 : u32),
                                                        (485854854 : u32),
                                                        (1520956317 : u32),
                                                        (1332383168 : u32),
                                                        (520160053 : u32),
                                                        (668357423 : u32),
                                                        (71382514 : u32),
                                                        (1602055020 : u32),
                                                        (222515518 : u32),
                                                        (619313639 : u32),
                                                        (762040067 : u32),
                                                        (1084704141 : u32),
                                                        (1489570986 : u32),
                                                        (1292142693 : u32),
                                                        (1219498669 : u32),
                                                        (887058680 : u32),
                                                        (1889070881 : u32),
                                                        (686720023 : u32),
                                                        (245564277 : u32),
                                                        (1478003191 : u32),
                                                        (1001816753 : u32),
                                                        (1992403145 : u32),
                                                        (886387990 : u32),
                                                        (689503779 : u32),
                                                        (278789386 : u32),
                                                        (1294241195 : u32),
                                                        (337637293 : u32),
                                                        (600053374 : u32),
                                                        (709998243 : u32),
                                                        (1884527449 : u32),
                                                        (1633366061 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1524100473 : u32),
                                                        (951217122 : u32),
                                                        (476310402 : u32),
                                                        (2016193267 : u32),
                                                        (1414326671 : u32),
                                                        (134193254 : u32),
                                                        (428130148 : u32),
                                                        (1652595361 : u32),
                                                        (1559664412 : u32),
                                                        (1456458228 : u32),
                                                        (2032602725 : u32),
                                                        (1784334355 : u32),
                                                        (1757107141 : u32),
                                                        (1449960882 : u32),
                                                        (492805340 : u32),
                                                        (1312992406 : u32),
                                                        (1172144780 : u32),
                                                        (34625401 : u32),
                                                        (1636950535 : u32),
                                                        (2047412486 : u32),
                                                        (1334682078 : u32),
                                                        (1092056088 : u32),
                                                        (1164166761 : u32),
                                                        (1888632009 : u32),
                                                        (453264737 : u32),
                                                        (1830710651 : u32),
                                                        (1681296823 : u32),
                                                        (376682325 : u32),
                                                        (896173273 : u32),
                                                        (460776133 : u32),
                                                        (579911791 : u32),
                                                        (316462338 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(69649159 : u32),
                                                        (1355220912 : u32),
                                                        (1752094493 : u32),
                                                        (97214415 : u32),
                                                        (656863133 : u32),
                                                        (1945128949 : u32),
                                                        (1077285232 : u32),
                                                        (122105320 : u32),
                                                        (1059302174 : u32),
                                                        (788968082 : u32),
                                                        (1645114411 : u32),
                                                        (525740928 : u32),
                                                        (1001931420 : u32),
                                                        (1653079209 : u32),
                                                        (2008401175 : u32),
                                                        (2015289370 : u32),
                                                        (1720260260 : u32),
                                                        (413653727 : u32),
                                                        (1137751003 : u32),
                                                        (1405449298 : u32),
                                                        (2135863895 : u32),
                                                        (1228028836 : u32),
                                                        (192758852 : u32),
                                                        (989886877 : u32),
                                                        (646195115 : u32),
                                                        (721926188 : u32),
                                                        (12148983 : u32),
                                                        (1556839982 : u32),
                                                        (2098643909 : u32),
                                                        (233360548 : u32),
                                                        (1226532789 : u32),
                                                        (283166141 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1970761068 : u32),
                                                        (1171894538 : u32),
                                                        (858506965 : u32),
                                                        (195809009 : u32),
                                                        (1183706740 : u32),
                                                        (1746540009 : u32),
                                                        (1056190116 : u32),
                                                        (577300479 : u32),
                                                        (2018887145 : u32),
                                                        (1579898568 : u32),
                                                        (1795585913 : u32),
                                                        (1327467500 : u32),
                                                        (350850095 : u32),
                                                        (1403651644 : u32),
                                                        (1813579051 : u32),
                                                        (326583928 : u32),
                                                        (366216014 : u32),
                                                        (389109329 : u32),
                                                        (337894116 : u32),
                                                        (809861425 : u32),
                                                        (1986479300 : u32),
                                                        (1469429812 : u32),
                                                        (1319672126 : u32),
                                                        (661071585 : u32),
                                                        (1248551636 : u32),
                                                        (130405611 : u32),
                                                        (1306254078 : u32),
                                                        (139557465 : u32),
                                                        (2136314021 : u32),
                                                        (2053103013 : u32),
                                                        (665701660 : u32),
                                                        (1468314287 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(185055486 : u32),
                                                        (1238652970 : u32),
                                                        (335517993 : u32),
                                                        (1093376990 : u32),
                                                        (1925565015 : u32),
                                                        (2109061416 : u32),
                                                        (817186480 : u32),
                                                        (1320522535 : u32),
                                                        (917369142 : u32),
                                                        (402884793 : u32),
                                                        (1695290102 : u32),
                                                        (1952655286 : u32),
                                                        (1219633100 : u32),
                                                        (1789643488 : u32),
                                                        (672985589 : u32),
                                                        (1365490508 : u32),
                                                        (216953603 : u32),
                                                        (1819353550 : u32),
                                                        (1676895983 : u32),
                                                        (1613942421 : u32),
                                                        (1691914404 : u32),
                                                        (831457771 : u32),
                                                        (961173456 : u32),
                                                        (975438178 : u32),
                                                        (1712623442 : u32),
                                                        (381821984 : u32),
                                                        (1727583440 : u32),
                                                        (934727486 : u32),
                                                        (2132437050 : u32),
                                                        (1707075531 : u32),
                                                        (2007926620 : u32),
                                                        (500644889 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1530936637 : u32),
                                                        (717512372 : u32),
                                                        (1091280540 : u32),
                                                        (1975073234 : u32),
                                                        (963165730 : u32),
                                                        (2022662631 : u32),
                                                        (1693740881 : u32),
                                                        (213696603 : u32),
                                                        (1066549603 : u32),
                                                        (1614782563 : u32),
                                                        (1285680656 : u32),
                                                        (1212609076 : u32),
                                                        (37474939 : u32),
                                                        (1371899546 : u32),
                                                        (432579255 : u32),
                                                        (1886095846 : u32),
                                                        (195038691 : u32),
                                                        (831673867 : u32),
                                                        (449476291 : u32),
                                                        (361040653 : u32),
                                                        (2072821687 : u32),
                                                        (1863102187 : u32),
                                                        (640601142 : u32),
                                                        (894990999 : u32),
                                                        (87798996 : u32),
                                                        (693504176 : u32),
                                                        (107742223 : u32),
                                                        (984274041 : u32),
                                                        (2016626149 : u32),
                                                        (384585229 : u32),
                                                        (1910352287 : u32),
                                                        (1588068494 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1406332928 : u32),
                                                        (1886869717 : u32),
                                                        (20070766 : u32),
                                                        (504132948 : u32),
                                                        (1124161369 : u32),
                                                        (845703412 : u32),
                                                        (1472127872 : u32),
                                                        (1047218025 : u32),
                                                        (1110290251 : u32),
                                                        (206772709 : u32),
                                                        (483060370 : u32),
                                                        (2141883360 : u32),
                                                        (808766072 : u32),
                                                        (590445560 : u32),
                                                        (1254772215 : u32),
                                                        (418945922 : u32),
                                                        (909816897 : u32),
                                                        (1347730934 : u32),
                                                        (2146798085 : u32),
                                                        (828038120 : u32),
                                                        (974805555 : u32),
                                                        (985974304 : u32),
                                                        (1749440022 : u32),
                                                        (1510046357 : u32),
                                                        (1764438166 : u32),
                                                        (1797342479 : u32),
                                                        (302636850 : u32),
                                                        (1354521330 : u32),
                                                        (1494110490 : u32),
                                                        (559022503 : u32),
                                                        (1744976859 : u32),
                                                        (2094527722 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(342481026 : u32),
                                                        (1293187653 : u32),
                                                        (1598048353 : u32),
                                                        (716703726 : u32),
                                                        (1784472412 : u32),
                                                        (763084543 : u32),
                                                        (1713147098 : u32),
                                                        (1404450355 : u32),
                                                        (1095722892 : u32),
                                                        (944844204 : u32),
                                                        (1513268795 : u32),
                                                        (1113513153 : u32),
                                                        (706176474 : u32),
                                                        (2000034881 : u32),
                                                        (1253649648 : u32),
                                                        (2003612613 : u32),
                                                        (107837377 : u32),
                                                        (822368971 : u32),
                                                        (1357544249 : u32),
                                                        (1695835000 : u32),
                                                        (1407532951 : u32),
                                                        (1408165516 : u32),
                                                        (1080674304 : u32),
                                                        (1350031553 : u32),
                                                        (1652413894 : u32),
                                                        (1729152423 : u32),
                                                        (361830246 : u32),
                                                        (156969537 : u32),
                                                        (1957123397 : u32),
                                                        (813027638 : u32),
                                                        (70553088 : u32),
                                                        (273754184 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1542558917 : u32),
                                                        (1172866619 : u32),
                                                        (15126821 : u32),
                                                        (208512535 : u32),
                                                        (293987097 : u32),
                                                        (1850176554 : u32),
                                                        (14924492 : u32),
                                                        (989433045 : u32),
                                                        (61294792 : u32),
                                                        (1944601244 : u32),
                                                        (988668816 : u32),
                                                        (731951942 : u32),
                                                        (907583975 : u32),
                                                        (623323157 : u32),
                                                        (1410590944 : u32),
                                                        (1753088773 : u32),
                                                        (183878341 : u32),
                                                        (174544238 : u32),
                                                        (957826066 : u32),
                                                        (556234005 : u32),
                                                        (5545643 : u32),
                                                        (1473983657 : u32),
                                                        (1895960687 : u32),
                                                        (350239428 : u32),
                                                        (839138691 : u32),
                                                        (623542634 : u32),
                                                        (333790906 : u32),
                                                        (1424785754 : u32),
                                                        (597119286 : u32),
                                                        (635148015 : u32),
                                                        (1768269180 : u32),
                                                        (986445623 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(510345508 : u32),
                                                        (41692363 : u32),
                                                        (571099882 : u32),
                                                        (1646690194 : u32),
                                                        (1123831379 : u32),
                                                        (947736947 : u32),
                                                        (1443293986 : u32),
                                                        (17288722 : u32),
                                                        (504429404 : u32),
                                                        (1817246157 : u32),
                                                        (1034134407 : u32),
                                                        (677655450 : u32),
                                                        (989595183 : u32),
                                                        (161019617 : u32),
                                                        (119805585 : u32),
                                                        (570272305 : u32),
                                                        (1963645928 : u32),
                                                        (563560833 : u32),
                                                        (2037312756 : u32),
                                                        (1324515540 : u32),
                                                        (2022270341 : u32),
                                                        (396943199 : u32),
                                                        (1628980751 : u32),
                                                        (2092697240 : u32),
                                                        (967655385 : u32),
                                                        (317332086 : u32),
                                                        (640954511 : u32),
                                                        (1129042817 : u32),
                                                        (712480672 : u32),
                                                        (1669473062 : u32),
                                                        (1175222857 : u32),
                                                        (971264280 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1972086436 : u32),
                                                        (1342800506 : u32),
                                                        (447634502 : u32),
                                                        (1351752329 : u32),
                                                        (354468017 : u32),
                                                        (1572209905 : u32),
                                                        (762959732 : u32),
                                                        (272104360 : u32),
                                                        (1798768322 : u32),
                                                        (110941041 : u32),
                                                        (1237866967 : u32),
                                                        (2049325462 : u32),
                                                        (755294397 : u32),
                                                        (1135510808 : u32),
                                                        (675348499 : u32),
                                                        (640460610 : u32),
                                                        (2013897925 : u32),
                                                        (1767384366 : u32),
                                                        (1616340965 : u32),
                                                        (1431780775 : u32),
                                                        (127863388 : u32),
                                                        (552072311 : u32),
                                                        (1535636724 : u32),
                                                        (885901974 : u32),
                                                        (1512225578 : u32),
                                                        (103123183 : u32),
                                                        (983104879 : u32),
                                                        (1078273419 : u32),
                                                        (107085817 : u32),
                                                        (342285643 : u32),
                                                        (1871101777 : u32),
                                                        (1545352335 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(131852957 : u32),
                                                        (1421760221 : u32),
                                                        (1030306390 : u32),
                                                        (2091023668 : u32),
                                                        (1050076491 : u32),
                                                        (854940671 : u32),
                                                        (376049345 : u32),
                                                        (381459233 : u32),
                                                        (371502265 : u32),
                                                        (2107603652 : u32),
                                                        (1159935983 : u32),
                                                        (57782244 : u32),
                                                        (1723220860 : u32),
                                                        (150804207 : u32),
                                                        (921210410 : u32),
                                                        (1931758678 : u32),
                                                        (833126333 : u32),
                                                        (1686049424 : u32),
                                                        (1363887634 : u32),
                                                        (1496269862 : u32),
                                                        (122399071 : u32),
                                                        (854215593 : u32),
                                                        (1841236173 : u32),
                                                        (1058922586 : u32),
                                                        (1602452690 : u32),
                                                        (1035741857 : u32),
                                                        (826195188 : u32),
                                                        (636420624 : u32),
                                                        (1671716034 : u32),
                                                        (1626116238 : u32),
                                                        (1258803269 : u32),
                                                        (442184590 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1930685162 : u32),
                                                        (707986975 : u32),
                                                        (1556598488 : u32),
                                                        (474294969 : u32),
                                                        (1790431488 : u32),
                                                        (1422026182 : u32),
                                                        (1270836267 : u32),
                                                        (930503875 : u32),
                                                        (2100141619 : u32),
                                                        (246357967 : u32),
                                                        (1770070399 : u32),
                                                        (1533780162 : u32),
                                                        (504199283 : u32),
                                                        (1379284528 : u32),
                                                        (1684316281 : u32),
                                                        (273955330 : u32),
                                                        (1744995791 : u32),
                                                        (1631579784 : u32),
                                                        (1115018488 : u32),
                                                        (1652138850 : u32),
                                                        (216236530 : u32),
                                                        (1436649707 : u32),
                                                        (2114630466 : u32),
                                                        (1996068462 : u32),
                                                        (1015688898 : u32),
                                                        (2049377351 : u32),
                                                        (1490545465 : u32),
                                                        (1729909238 : u32),
                                                        (1586822178 : u32),
                                                        (1546714506 : u32),
                                                        (715295064 : u32),
                                                        (1928642483 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(407612633 : u32),
                                                        (874676540 : u32),
                                                        (1470922810 : u32),
                                                        (2117060426 : u32),
                                                        (2017430784 : u32),
                                                        (1517544886 : u32),
                                                        (714496850 : u32),
                                                        (1199427144 : u32),
                                                        (218869480 : u32),
                                                        (1061431556 : u32),
                                                        (615651362 : u32),
                                                        (596481944 : u32),
                                                        (81984067 : u32),
                                                        (390305852 : u32),
                                                        (673487868 : u32),
                                                        (1195333386 : u32),
                                                        (358446609 : u32),
                                                        (1097196725 : u32),
                                                        (1836490823 : u32),
                                                        (44376108 : u32),
                                                        (1600332671 : u32),
                                                        (1744075670 : u32),
                                                        (500246482 : u32),
                                                        (264589282 : u32),
                                                        (1344597047 : u32),
                                                        (983939542 : u32),
                                                        (987089200 : u32),
                                                        (480832488 : u32),
                                                        (12171153 : u32),
                                                        (1456386585 : u32),
                                                        (1100234257 : u32),
                                                        (590528379 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(7574886 : u32),
                                                        (305044878 : u32),
                                                        (634126942 : u32),
                                                        (2113983788 : u32),
                                                        (1019292561 : u32),
                                                        (1166352574 : u32),
                                                        (1447911358 : u32),
                                                        (1729402523 : u32),
                                                        (474069013 : u32),
                                                        (1232845384 : u32),
                                                        (1496203195 : u32),
                                                        (1607294770 : u32),
                                                        (588373921 : u32),
                                                        (1372983853 : u32),
                                                        (500957777 : u32),
                                                        (241313951 : u32),
                                                        (1470442390 : u32),
                                                        (1140110952 : u32),
                                                        (1390502647 : u32),
                                                        (97216851 : u32),
                                                        (2057181182 : u32),
                                                        (703909546 : u32),
                                                        (965625636 : u32),
                                                        (144640226 : u32),
                                                        (549667217 : u32),
                                                        (252234599 : u32),
                                                        (352443835 : u32),
                                                        (1344756978 : u32),
                                                        (179092906 : u32),
                                                        (1485900984 : u32),
                                                        (389772674 : u32),
                                                        (1626396308 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1842292623 : u32),
                                                        (908763001 : u32),
                                                        (1846983092 : u32),
                                                        (1470275241 : u32),
                                                        (135848524 : u32),
                                                        (581723033 : u32),
                                                        (1960455507 : u32),
                                                        (82603574 : u32),
                                                        (1936907517 : u32),
                                                        (1060569466 : u32),
                                                        (895656659 : u32),
                                                        (1115080353 : u32),
                                                        (1994672788 : u32),
                                                        (404839179 : u32),
                                                        (751046636 : u32),
                                                        (1065725581 : u32),
                                                        (1304870097 : u32),
                                                        (2009265471 : u32),
                                                        (897389208 : u32),
                                                        (848236428 : u32),
                                                        (1351146015 : u32),
                                                        (1318615734 : u32),
                                                        (600736552 : u32),
                                                        (2037464437 : u32),
                                                        (100343291 : u32),
                                                        (707086668 : u32),
                                                        (770585621 : u32),
                                                        (1591481498 : u32),
                                                        (452897337 : u32),
                                                        (994762633 : u32),
                                                        (1805462284 : u32),
                                                        (1999284154 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(131522391 : u32),
                                                        (342005608 : u32),
                                                        (230368097 : u32),
                                                        (773063175 : u32),
                                                        (527436599 : u32),
                                                        (1220046825 : u32),
                                                        (1942461052 : u32),
                                                        (1965434983 : u32),
                                                        (75126351 : u32),
                                                        (1167282014 : u32),
                                                        (977116474 : u32),
                                                        (1259667561 : u32),
                                                        (1925297661 : u32),
                                                        (1854095552 : u32),
                                                        (1030541306 : u32),
                                                        (399181321 : u32),
                                                        (89784670 : u32),
                                                        (1761097955 : u32),
                                                        (1257965896 : u32),
                                                        (1967453401 : u32),
                                                        (1867852120 : u32),
                                                        (677086808 : u32),
                                                        (1460167097 : u32),
                                                        (1421061089 : u32),
                                                        (555615188 : u32),
                                                        (1389636850 : u32),
                                                        (1109176007 : u32),
                                                        (1935077962 : u32),
                                                        (1310784917 : u32),
                                                        (1288910432 : u32),
                                                        (1382260592 : u32),
                                                        (403443262 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1832283511 : u32),
                                                        (1300584547 : u32),
                                                        (1048081917 : u32),
                                                        (294898282 : u32),
                                                        (691884478 : u32),
                                                        (589601517 : u32),
                                                        (1231660915 : u32),
                                                        (1346869533 : u32),
                                                        (2054550853 : u32),
                                                        (1871307164 : u32),
                                                        (2131527115 : u32),
                                                        (503352476 : u32),
                                                        (315585814 : u32),
                                                        (317967372 : u32),
                                                        (1830912894 : u32),
                                                        (1932933715 : u32),
                                                        (1472362836 : u32),
                                                        (1205809005 : u32),
                                                        (1376460994 : u32),
                                                        (1900802694 : u32),
                                                        (1902063629 : u32),
                                                        (2131079697 : u32),
                                                        (1106186001 : u32),
                                                        (1726782722 : u32),
                                                        (1716601369 : u32),
                                                        (441661916 : u32),
                                                        (614735324 : u32),
                                                        (2002801037 : u32),
                                                        (2028080135 : u32),
                                                        (660496380 : u32),
                                                        (1148506638 : u32),
                                                        (126070283 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(651266563 : u32),
                                                        (1860028614 : u32),
                                                        (6845703 : u32),
                                                        (469165362 : u32),
                                                        (643098246 : u32),
                                                        (2187733 : u32),
                                                        (1856271210 : u32),
                                                        (1585225862 : u32),
                                                        (862250091 : u32),
                                                        (1189657071 : u32),
                                                        (1591424122 : u32),
                                                        (2074571952 : u32),
                                                        (851995405 : u32),
                                                        (1961672310 : u32),
                                                        (130264055 : u32),
                                                        (1577210230 : u32),
                                                        (1639120510 : u32),
                                                        (471474175 : u32),
                                                        (1483229952 : u32),
                                                        (147588432 : u32),
                                                        (1047970199 : u32),
                                                        (3833051 : u32),
                                                        (249137557 : u32),
                                                        (2091328691 : u32),
                                                        (1710876542 : u32),
                                                        (1376926474 : u32),
                                                        (520089636 : u32),
                                                        (1631943503 : u32),
                                                        (1076618127 : u32),
                                                        (1457940600 : u32),
                                                        (1751024037 : u32),
                                                        (1353597234 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1369907656 : u32),
                                                        (77580514 : u32),
                                                        (1446339495 : u32),
                                                        (1927161399 : u32),
                                                        (1301454842 : u32),
                                                        (2046854500 : u32),
                                                        (1899855511 : u32),
                                                        (2072469561 : u32),
                                                        (720194514 : u32),
                                                        (1498755138 : u32),
                                                        (1169421452 : u32),
                                                        (600523910 : u32),
                                                        (1298076906 : u32),
                                                        (1236806992 : u32),
                                                        (1425384886 : u32),
                                                        (539896302 : u32),
                                                        (2062300683 : u32),
                                                        (598412809 : u32),
                                                        (1481367827 : u32),
                                                        (1664436828 : u32),
                                                        (376589091 : u32),
                                                        (878524501 : u32),
                                                        (2045014993 : u32),
                                                        (381890081 : u32),
                                                        (149263379 : u32),
                                                        (980361066 : u32),
                                                        (1824592839 : u32),
                                                        (31788474 : u32),
                                                        (1651459490 : u32),
                                                        (1430355180 : u32),
                                                        (2146696660 : u32),
                                                        (1563223083 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(478802057 : u32),
                                                        (1269501175 : u32),
                                                        (1667723129 : u32),
                                                        (1748169677 : u32),
                                                        (874822359 : u32),
                                                        (35086417 : u32),
                                                        (2028599588 : u32),
                                                        (740311719 : u32),
                                                        (777933635 : u32),
                                                        (2132008225 : u32),
                                                        (555363356 : u32),
                                                        (1637908556 : u32),
                                                        (1159677795 : u32),
                                                        (667962555 : u32),
                                                        (986314446 : u32),
                                                        (324354000 : u32),
                                                        (227329278 : u32),
                                                        (1308197804 : u32),
                                                        (1906849552 : u32),
                                                        (1400161209 : u32),
                                                        (1823528371 : u32),
                                                        (332793830 : u32),
                                                        (210328767 : u32),
                                                        (1997662949 : u32),
                                                        (1713014965 : u32),
                                                        (1050093938 : u32),
                                                        (1481017604 : u32),
                                                        (2075382196 : u32),
                                                        (586118195 : u32),
                                                        (1959326602 : u32),
                                                        (1652504494 : u32),
                                                        (1510304153 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(166969271 : u32),
                                                        (57888467 : u32),
                                                        (1403433857 : u32),
                                                        (1222234205 : u32),
                                                        (1811527188 : u32),
                                                        (1251939407 : u32),
                                                        (1271563153 : u32),
                                                        (975114905 : u32),
                                                        (866335263 : u32),
                                                        (484456603 : u32),
                                                        (378599737 : u32),
                                                        (1029802948 : u32),
                                                        (409341762 : u32),
                                                        (551620291 : u32),
                                                        (104448132 : u32),
                                                        (1816174232 : u32),
                                                        (468795317 : u32),
                                                        (991857548 : u32),
                                                        (141404872 : u32),
                                                        (1713672983 : u32),
                                                        (154656770 : u32),
                                                        (1770065508 : u32),
                                                        (457736280 : u32),
                                                        (934438526 : u32),
                                                        (1500819921 : u32),
                                                        (1756957478 : u32),
                                                        (1982236150 : u32),
                                                        (376913043 : u32),
                                                        (929569428 : u32),
                                                        (577685528 : u32),
                                                        (1898479811 : u32),
                                                        (1647878191 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1096869369 : u32),
                                                        (749450503 : u32),
                                                        (1626795248 : u32),
                                                        (551735531 : u32),
                                                        (92394300 : u32),
                                                        (763988352 : u32),
                                                        (1342831100 : u32),
                                                        (1585498272 : u32),
                                                        (862540522 : u32),
                                                        (571049089 : u32),
                                                        (1301994471 : u32),
                                                        (87679860 : u32),
                                                        (1899317471 : u32),
                                                        (524738480 : u32),
                                                        (258436139 : u32),
                                                        (680111499 : u32),
                                                        (884348043 : u32),
                                                        (1373137115 : u32),
                                                        (2061895118 : u32),
                                                        (1339756084 : u32),
                                                        (1874494618 : u32),
                                                        (1276947052 : u32),
                                                        (1982974210 : u32),
                                                        (1164937102 : u32),
                                                        (2116626817 : u32),
                                                        (1576824999 : u32),
                                                        (783000106 : u32),
                                                        (1989737627 : u32),
                                                        (1076048144 : u32),
                                                        (507134941 : u32),
                                                        (366062373 : u32),
                                                        (338594879 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1128193156 : u32),
                                                        (1220981812 : u32),
                                                        (1632843522 : u32),
                                                        (718121752 : u32),
                                                        (1468035159 : u32),
                                                        (479592132 : u32),
                                                        (286298573 : u32),
                                                        (798909332 : u32),
                                                        (1392151676 : u32),
                                                        (412667595 : u32),
                                                        (1606445078 : u32),
                                                        (1278204405 : u32),
                                                        (565691919 : u32),
                                                        (262958867 : u32),
                                                        (1995261738 : u32),
                                                        (358852982 : u32),
                                                        (1594187141 : u32),
                                                        (830884607 : u32),
                                                        (915496142 : u32),
                                                        (2088473205 : u32),
                                                        (422941864 : u32),
                                                        (1962006986 : u32),
                                                        (322198025 : u32),
                                                        (1438948543 : u32),
                                                        (1737968776 : u32),
                                                        (1918518341 : u32),
                                                        (890495304 : u32),
                                                        (1823603926 : u32),
                                                        (1482286717 : u32),
                                                        (2005796868 : u32),
                                                        (1067341765 : u32),
                                                        (1744770897 :
                                                        u32)])))])))
    (by sorry)

end p3_mersenne_31.poseidon1


namespace p3_mersenne_31.poseidon2

--  Round constants for width-16 Poseidon2 on Mersenne31.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=5 (exp_flag=0), n=31, t=16, R_F=8, R_P=14
-- 
--  Generated by `poseidon2/generate_constants.py --field mersenne31 --width 16`.
-- 
--  Layout: external_initial (4 rounds × 16 elements).
def MERSENNE31_POSEIDON2_RC_16_EXTERNAL_INITIAL :
  (RustArray (RustArray p3_mersenne_31.mersenne_31.Mersenne31 16) 4)
  :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1988864850 : u32),
                                                        (1893772157 : u32),
                                                        (1025928330 : u32),
                                                        (1839472709 : u32),
                                                        (1611656994 : u32),
                                                        (1104858731 : u32),
                                                        (1694088660 : u32),
                                                        (1564660990 : u32),
                                                        (1991332205 : u32),
                                                        (1875486487 : u32),
                                                        (1890340790 : u32),
                                                        (1658614 : u32),
                                                        (582370530 : u32),
                                                        (528029397 : u32),
                                                        (1196956642 : u32),
                                                        (655401251 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1652877415 : u32),
                                                        (26032894 : u32),
                                                        (1576640243 : u32),
                                                        (1277052539 : u32),
                                                        (1450142396 : u32),
                                                        (697623591 : u32),
                                                        (1401580866 : u32),
                                                        (1568404175 : u32),
                                                        (2145004971 : u32),
                                                        (265835716 : u32),
                                                        (1183985610 : u32),
                                                        (1031234465 : u32),
                                                        (436012490 : u32),
                                                        (172735299 : u32),
                                                        (352802897 : u32),
                                                        (1032863094 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(757665783 : u32),
                                                        (1082171296 : u32),
                                                        (1507509996 : u32),
                                                        (309929890 : u32),
                                                        (1807683232 : u32),
                                                        (43258895 : u32),
                                                        (611592566 : u32),
                                                        (1854193793 : u32),
                                                        (575164234 : u32),
                                                        (894217817 : u32),
                                                        (72613857 : u32),
                                                        (1061659596 : u32),
                                                        (8921166 : u32),
                                                        (1617355017 : u32),
                                                        (998001536 : u32),
                                                        (1800758877 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1002748055 : u32),
                                                        (1935405944 : u32),
                                                        (1351462722 : u32),
                                                        (411368491 : u32),
                                                        (1913975372 : u32),
                                                        (1956167178 : u32),
                                                        (442558016 : u32),
                                                        (855898408 : u32),
                                                        (699687798 : u32),
                                                        (1553382248 : u32),
                                                        (1708169125 : u32),
                                                        (490049183 : u32),
                                                        (1251643415 : u32),
                                                        (1193594742 : u32),
                                                        (880473871 : u32),
                                                        (511174042 :
                                                        u32)])))])))
    (by sorry)

--  Round constants for width-16 Poseidon2 on Mersenne31.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=5 (exp_flag=0), n=31, t=16, R_F=8, R_P=14
-- 
--  Generated by `poseidon2/generate_constants.py --field mersenne31 --width 16`.
-- 
--  Layout: external_final (4 rounds × 16 elements).
def MERSENNE31_POSEIDON2_RC_16_EXTERNAL_FINAL :
  (RustArray (RustArray p3_mersenne_31.mersenne_31.Mersenne31 16) 4)
  :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1460209171 : u32),
                                                        (530850056 : u32),
                                                        (398192464 : u32),
                                                        (536338716 : u32),
                                                        (75179210 : u32),
                                                        (1309934197 : u32),
                                                        (1335920373 : u32),
                                                        (127611036 : u32),
                                                        (291093831 : u32),
                                                        (1832379621 : u32),
                                                        (123571662 : u32),
                                                        (303176864 : u32),
                                                        (2137685056 : u32),
                                                        (1759609530 : u32),
                                                        (1418928155 : u32),
                                                        (71608334 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(6616262 : u32),
                                                        (1684515814 : u32),
                                                        (1721194338 : u32),
                                                        (720801691 : u32),
                                                        (878392254 : u32),
                                                        (460379263 : u32),
                                                        (87930647 : u32),
                                                        (940673483 : u32),
                                                        (1136203256 : u32),
                                                        (551499412 : u32),
                                                        (256220454 : u32),
                                                        (2007034235 : u32),
                                                        (796124985 : u32),
                                                        (410436345 : u32),
                                                        (1705042586 : u32),
                                                        (1286336446 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(1522340456 : u32),
                                                        (1295296352 : u32),
                                                        (309794713 : u32),
                                                        (1772145068 : u32),
                                                        (956898901 : u32),
                                                        (2137070800 : u32),
                                                        (988829146 : u32),
                                                        (2059451359 : u32),
                                                        (1846491684 : u32),
                                                        (1105442551 : u32),
                                                        (1236497773 : u32),
                                                        (1452000568 : u32),
                                                        (549485016 : u32),
                                                        (385992492 : u32),
                                                        (1987107948 : u32),
                                                        (1514377269 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((16 : usize))
                                  (RustArray.ofVec #v[(2090065934 : u32),
                                                        (1444920141 : u32),
                                                        (293113979 : u32),
                                                        (41120774 : u32),
                                                        (855319793 : u32),
                                                        (1663284746 : u32),
                                                        (1789994008 : u32),
                                                        (1120509162 : u32),
                                                        (358222743 : u32),
                                                        (1406256810 : u32),
                                                        (735183687 : u32),
                                                        (664485235 : u32),
                                                        (1331641456 : u32),
                                                        (38121324 : u32),
                                                        (595810771 : u32),
                                                        (1234594393 :
                                                        u32)])))])))
    (by sorry)

--  Round constants for width-16 Poseidon2 on Mersenne31.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=5 (exp_flag=0), n=31, t=16, R_F=8, R_P=14
-- 
--  Generated by `poseidon2/generate_constants.py --field mersenne31 --width 16`.
-- 
--  Layout: internal (14 scalar constants).
def MERSENNE31_POSEIDON2_RC_16_INTERNAL :
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 14)
  :=
  RustM.of_isOk
    (do
    (p3_mersenne_31.mersenne_31.Impl.new_array ((14 : usize))
      (RustArray.ofVec #v[(2139014335 : u32),
                            (69309039 : u32),
                            (1368974953 : u32),
                            (886780232 : u32),
                            (1130937085 : u32),
                            (1718115455 : u32),
                            (2027103386 : u32),
                            (1612216449 : u32),
                            (1994053242 : u32),
                            (110146615 : u32),
                            (514413329 : u32),
                            (1088763546 : u32),
                            (955319292 : u32),
                            (488794657 : u32)])))
    (by sorry)

--  Round constants for width-24 Poseidon2 on Mersenne31.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=5 (exp_flag=0), n=31, t=24, R_F=8, R_P=22
-- 
--  Generated by `poseidon2/generate_constants.py --field mersenne31 --width 24`.
-- 
--  Layout: external_initial (4 rounds × 24 elements).
def MERSENNE31_POSEIDON2_RC_24_EXTERNAL_INITIAL :
  (RustArray (RustArray p3_mersenne_31.mersenne_31.Mersenne31 24) 4)
  :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((24 : usize))
                                  (RustArray.ofVec #v[(535476833 : u32),
                                                        (1394754644 : u32),
                                                        (1808710114 : u32),
                                                        (1343879604 : u32),
                                                        (1215456658 : u32),
                                                        (723701928 : u32),
                                                        (1632746489 : u32),
                                                        (793201441 : u32),
                                                        (783676215 : u32),
                                                        (996433287 : u32),
                                                        (155373296 : u32),
                                                        (1696762962 : u32),
                                                        (2030023439 : u32),
                                                        (1294481352 : u32),
                                                        (236432463 : u32),
                                                        (89417350 : u32),
                                                        (74188492 : u32),
                                                        (189907894 : u32),
                                                        (1452128099 : u32),
                                                        (951268580 : u32),
                                                        (1475718384 : u32),
                                                        (433268241 : u32),
                                                        (2010132299 : u32),
                                                        (1820518840 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((24 : usize))
                                  (RustArray.ofVec #v[(1900593590 : u32),
                                                        (134642805 : u32),
                                                        (1188161737 : u32),
                                                        (815217415 : u32),
                                                        (543248187 : u32),
                                                        (1547696209 : u32),
                                                        (810562345 : u32),
                                                        (1232267212 : u32),
                                                        (47306940 : u32),
                                                        (165003174 : u32),
                                                        (158401728 : u32),
                                                        (2074384948 : u32),
                                                        (1242022652 : u32),
                                                        (616689257 : u32),
                                                        (682011457 : u32),
                                                        (1569786016 : u32),
                                                        (980963783 : u32),
                                                        (500471289 : u32),
                                                        (313827316 : u32),
                                                        (2074957664 : u32),
                                                        (1609393346 : u32),
                                                        (1727383916 : u32),
                                                        (2125446402 : u32),
                                                        (968055099 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((24 : usize))
                                  (RustArray.ofVec #v[(1248148297 : u32),
                                                        (1963531713 : u32),
                                                        (1457817824 : u32),
                                                        (386179925 : u32),
                                                        (1952337907 : u32),
                                                        (959377774 : u32),
                                                        (836976607 : u32),
                                                        (46304358 : u32),
                                                        (918751290 : u32),
                                                        (822399482 : u32),
                                                        (1526975907 : u32),
                                                        (1715593647 : u32),
                                                        (930433878 : u32),
                                                        (963599097 : u32),
                                                        (437929498 : u32),
                                                        (1754146546 : u32),
                                                        (1870829444 : u32),
                                                        (465116521 : u32),
                                                        (1534623766 : u32),
                                                        (1883940293 : u32),
                                                        (25265820 : u32),
                                                        (1092689494 : u32),
                                                        (216531872 : u32),
                                                        (599782304 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((24 : usize))
                                  (RustArray.ofVec #v[(402354276 : u32),
                                                        (1194422816 : u32),
                                                        (1989233491 : u32),
                                                        (563878149 : u32),
                                                        (375739688 : u32),
                                                        (1307792708 : u32),
                                                        (1619035237 : u32),
                                                        (860944435 : u32),
                                                        (62705095 : u32),
                                                        (176625674 : u32),
                                                        (24812021 : u32),
                                                        (1855215398 : u32),
                                                        (356799748 : u32),
                                                        (2013606833 : u32),
                                                        (999407416 : u32),
                                                        (1070038705 : u32),
                                                        (1263375886 : u32),
                                                        (1020869934 : u32),
                                                        (245688694 : u32),
                                                        (491980492 : u32),
                                                        (981123716 : u32),
                                                        (247605556 : u32),
                                                        (1301780243 : u32),
                                                        (1369709669 :
                                                        u32)])))])))
    (by sorry)

--  Round constants for width-24 Poseidon2 on Mersenne31.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=5 (exp_flag=0), n=31, t=24, R_F=8, R_P=22
-- 
--  Generated by `poseidon2/generate_constants.py --field mersenne31 --width 24`.
-- 
--  Layout: external_final (4 rounds × 24 elements).
def MERSENNE31_POSEIDON2_RC_24_EXTERNAL_FINAL :
  (RustArray (RustArray p3_mersenne_31.mersenne_31.Mersenne31 24) 4)
  :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((24 : usize))
                                  (RustArray.ofVec #v[(476455577 : u32),
                                                        (92050778 : u32),
                                                        (2058797298 : u32),
                                                        (631680266 : u32),
                                                        (1971653464 : u32),
                                                        (1224554387 : u32),
                                                        (188966577 : u32),
                                                        (266145097 : u32),
                                                        (2108955129 : u32),
                                                        (1236913167 : u32),
                                                        (1217697558 : u32),
                                                        (700668048 : u32),
                                                        (1984189573 : u32),
                                                        (472371980 : u32),
                                                        (279607867 : u32),
                                                        (821252022 : u32),
                                                        (1876976693 : u32),
                                                        (34823885 : u32),
                                                        (1823128214 : u32),
                                                        (1051889872 : u32),
                                                        (587042107 : u32),
                                                        (1988826405 : u32),
                                                        (1542019092 : u32),
                                                        (1379762153 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((24 : usize))
                                  (RustArray.ofVec #v[(1441352940 : u32),
                                                        (1204039199 : u32),
                                                        (447036254 : u32),
                                                        (802291326 : u32),
                                                        (1495469713 : u32),
                                                        (1953684070 : u32),
                                                        (1682174687 : u32),
                                                        (765321629 : u32),
                                                        (1870621316 : u32),
                                                        (2004878384 : u32),
                                                        (251743176 : u32),
                                                        (2079576213 : u32),
                                                        (649057048 : u32),
                                                        (1478844919 : u32),
                                                        (1591941516 : u32),
                                                        (1791754240 : u32),
                                                        (791764518 : u32),
                                                        (667598912 : u32),
                                                        (630523934 : u32),
                                                        (1499707354 : u32),
                                                        (2114401637 : u32),
                                                        (1827927537 : u32),
                                                        (167289764 : u32),
                                                        (229166334 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((24 : usize))
                                  (RustArray.ofVec #v[(1623073637 : u32),
                                                        (2128036597 : u32),
                                                        (1720418353 : u32),
                                                        (1269838996 : u32),
                                                        (1493275443 : u32),
                                                        (1879976056 : u32),
                                                        (482629718 : u32),
                                                        (487987191 : u32),
                                                        (2073595302 : u32),
                                                        (1320457068 : u32),
                                                        (2026502270 : u32),
                                                        (1674460820 : u32),
                                                        (1903703067 : u32),
                                                        (1169960838 : u32),
                                                        (95909308 : u32),
                                                        (1883963972 : u32),
                                                        (703517304 : u32),
                                                        (1207185458 : u32),
                                                        (556249829 : u32),
                                                        (429363263 : u32),
                                                        (615763459 : u32),
                                                        (204614028 : u32),
                                                        (2099998522 : u32),
                                                        (402434689 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((24 : usize))
                                  (RustArray.ofVec #v[(1928560623 : u32),
                                                        (807987113 : u32),
                                                        (1591561622 : u32),
                                                        (529946683 : u32),
                                                        (1289130378 : u32),
                                                        (344461070 : u32),
                                                        (1763115865 : u32),
                                                        (389856563 : u32),
                                                        (157935604 : u32),
                                                        (1853825963 : u32),
                                                        (1635969671 : u32),
                                                        (1305157468 : u32),
                                                        (1482662163 : u32),
                                                        (1922872246 : u32),
                                                        (28549754 : u32),
                                                        (463565799 : u32),
                                                        (1261681898 : u32),
                                                        (1675180987 : u32),
                                                        (1799339929 : u32),
                                                        (1863838161 : u32),
                                                        (205379770 : u32),
                                                        (197261736 : u32),
                                                        (1691612016 : u32),
                                                        (1180330520 :
                                                        u32)])))])))
    (by sorry)

--  Round constants for width-24 Poseidon2 on Mersenne31.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=5 (exp_flag=0), n=31, t=24, R_F=8, R_P=22
-- 
--  Generated by `poseidon2/generate_constants.py --field mersenne31 --width 24`.
-- 
--  Layout: internal (22 scalar constants).
def MERSENNE31_POSEIDON2_RC_24_INTERNAL :
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 22)
  :=
  RustM.of_isOk
    (do
    (p3_mersenne_31.mersenne_31.Impl.new_array ((22 : usize))
      (RustArray.ofVec #v[(578251281 : u32),
                            (1604534888 : u32),
                            (336941709 : u32),
                            (1447017748 : u32),
                            (888427076 : u32),
                            (302948790 : u32),
                            (638806181 : u32),
                            (661020353 : u32),
                            (918431749 : u32),
                            (878462852 : u32),
                            (401595585 : u32),
                            (960390448 : u32),
                            (1839248568 : u32),
                            (837148371 : u32),
                            (1734027180 : u32),
                            (183012400 : u32),
                            (1467498956 : u32),
                            (1608543724 : u32),
                            (1454401818 : u32),
                            (1916984863 : u32),
                            (1010267433 : u32),
                            (865826083 : u32)])))
    (by sorry)

--  Round constants for width-32 Poseidon2 on Mersenne31.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=5 (exp_flag=0), n=31, t=32, R_F=8, R_P=30
-- 
--  Generated by `poseidon2/generate_constants.py --field mersenne31 --width 32`.
-- 
--  Layout: external_initial (4 rounds × 32 elements).
def MERSENNE31_POSEIDON2_RC_32_EXTERNAL_INITIAL :
  (RustArray (RustArray p3_mersenne_31.mersenne_31.Mersenne31 32) 4)
  :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1729160065 : u32),
                                                        (27999661 : u32),
                                                        (1237173535 : u32),
                                                        (1103727717 : u32),
                                                        (596139402 : u32),
                                                        (619347324 : u32),
                                                        (1801845869 : u32),
                                                        (1627808090 : u32),
                                                        (139024371 : u32),
                                                        (360461876 : u32),
                                                        (1303224591 : u32),
                                                        (1826595949 : u32),
                                                        (468846782 : u32),
                                                        (1540501420 : u32),
                                                        (2044366811 : u32),
                                                        (2028718317 : u32),
                                                        (1284230111 : u32),
                                                        (670536848 : u32),
                                                        (1883853842 : u32),
                                                        (708936782 : u32),
                                                        (1371236849 : u32),
                                                        (840293409 : u32),
                                                        (1729185817 : u32),
                                                        (665479689 : u32),
                                                        (1598897325 : u32),
                                                        (1607911204 : u32),
                                                        (457969805 : u32),
                                                        (2126353565 : u32),
                                                        (1469698125 : u32),
                                                        (1452024111 : u32),
                                                        (1745363419 : u32),
                                                        (1644640041 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(580839296 : u32),
                                                        (995071171 : u32),
                                                        (396602452 : u32),
                                                        (1815642745 : u32),
                                                        (1215757909 : u32),
                                                        (829485578 : u32),
                                                        (862993998 : u32),
                                                        (60295857 : u32),
                                                        (19902714 : u32),
                                                        (341764315 : u32),
                                                        (1233214256 : u32),
                                                        (1185777564 : u32),
                                                        (1388073021 : u32),
                                                        (1483026647 : u32),
                                                        (1547106789 : u32),
                                                        (42886403 : u32),
                                                        (137429864 : u32),
                                                        (1968465478 : u32),
                                                        (1931810545 : u32),
                                                        (860372570 : u32),
                                                        (77628460 : u32),
                                                        (439432665 : u32),
                                                        (1400581809 : u32),
                                                        (1538215799 : u32),
                                                        (1266208109 : u32),
                                                        (1525492810 : u32),
                                                        (1724421089 : u32),
                                                        (1012175782 : u32),
                                                        (1187392508 : u32),
                                                        (1447975194 : u32),
                                                        (1390335911 : u32),
                                                        (13697837 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(724621313 : u32),
                                                        (270380023 : u32),
                                                        (788210125 : u32),
                                                        (1245060153 : u32),
                                                        (1240462706 : u32),
                                                        (773049076 : u32),
                                                        (24012697 : u32),
                                                        (459070276 : u32),
                                                        (399125958 : u32),
                                                        (240127712 : u32),
                                                        (21088923 : u32),
                                                        (664478582 : u32),
                                                        (1715979275 : u32),
                                                        (231403068 : u32),
                                                        (384302329 : u32),
                                                        (1508300380 : u32),
                                                        (515322057 : u32),
                                                        (2126447639 : u32),
                                                        (677410888 : u32),
                                                        (1165131676 : u32),
                                                        (1314144251 : u32),
                                                        (65938768 : u32),
                                                        (17618251 : u32),
                                                        (2065305680 : u32),
                                                        (47991670 : u32),
                                                        (725260860 : u32),
                                                        (783004377 : u32),
                                                        (110265683 : u32),
                                                        (757314549 : u32),
                                                        (1839407793 : u32),
                                                        (354937863 : u32),
                                                        (239405946 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1402344978 : u32),
                                                        (552692496 : u32),
                                                        (384830560 : u32),
                                                        (1278858511 : u32),
                                                        (1104518518 : u32),
                                                        (1381234722 : u32),
                                                        (995349377 : u32),
                                                        (461326090 : u32),
                                                        (1581091164 : u32),
                                                        (1382383909 : u32),
                                                        (18976979 : u32),
                                                        (1700150144 : u32),
                                                        (487565895 : u32),
                                                        (896906185 : u32),
                                                        (1275960608 : u32),
                                                        (416280735 : u32),
                                                        (1688722012 : u32),
                                                        (789842725 : u32),
                                                        (329227825 : u32),
                                                        (1726180309 : u32),
                                                        (1682098193 : u32),
                                                        (1485282254 : u32),
                                                        (1607239622 : u32),
                                                        (1745333772 : u32),
                                                        (1091683927 : u32),
                                                        (1664911657 : u32),
                                                        (1955998065 : u32),
                                                        (1069649592 : u32),
                                                        (1164767880 : u32),
                                                        (838256850 : u32),
                                                        (1815753128 : u32),
                                                        (1837293392 :
                                                        u32)])))])))
    (by sorry)

--  Round constants for width-32 Poseidon2 on Mersenne31.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=5 (exp_flag=0), n=31, t=32, R_F=8, R_P=30
-- 
--  Generated by `poseidon2/generate_constants.py --field mersenne31 --width 32`.
-- 
--  Layout: external_final (4 rounds × 32 elements).
def MERSENNE31_POSEIDON2_RC_32_EXTERNAL_FINAL :
  (RustArray (RustArray p3_mersenne_31.mersenne_31.Mersenne31 32) 4)
  :=
  RustM.of_isOk
    (do
    (pure (RustArray.ofVec #v[(← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(2014882003 : u32),
                                                        (442032405 : u32),
                                                        (688992664 : u32),
                                                        (2003511455 : u32),
                                                        (512896738 : u32),
                                                        (560331760 : u32),
                                                        (684502904 : u32),
                                                        (428025981 : u32),
                                                        (1227563744 : u32),
                                                        (2009876055 : u32),
                                                        (956324903 : u32),
                                                        (1221427337 : u32),
                                                        (645725371 : u32),
                                                        (474073733 : u32),
                                                        (1102287935 : u32),
                                                        (552039034 : u32),
                                                        (1689090291 : u32),
                                                        (333267987 : u32),
                                                        (272819164 : u32),
                                                        (1957554988 : u32),
                                                        (768463815 : u32),
                                                        (100691900 : u32),
                                                        (900073961 : u32),
                                                        (229582652 : u32),
                                                        (978282831 : u32),
                                                        (2056857235 : u32),
                                                        (1509756957 : u32),
                                                        (668078379 : u32),
                                                        (423081631 : u32),
                                                        (780697788 : u32),
                                                        (1086399529 : u32),
                                                        (108619174 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(1856090989 : u32),
                                                        (1845577582 : u32),
                                                        (701329802 : u32),
                                                        (1409730195 : u32),
                                                        (1373515418 : u32),
                                                        (1843148938 : u32),
                                                        (1400255603 : u32),
                                                        (2143120346 : u32),
                                                        (396516543 : u32),
                                                        (522814157 : u32),
                                                        (2063078764 : u32),
                                                        (432691965 : u32),
                                                        (762330259 : u32),
                                                        (203964644 : u32),
                                                        (752517837 : u32),
                                                        (1551847904 : u32),
                                                        (498436102 : u32),
                                                        (1018571729 : u32),
                                                        (725960219 : u32),
                                                        (1644477008 : u32),
                                                        (2077081209 : u32),
                                                        (1750593724 : u32),
                                                        (1257415528 : u32),
                                                        (851527412 : u32),
                                                        (449830291 : u32),
                                                        (767792496 : u32),
                                                        (230550350 : u32),
                                                        (1354692685 : u32),
                                                        (1870897708 : u32),
                                                        (1129068353 : u32),
                                                        (543220064 : u32),
                                                        (1760923403 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(623489725 : u32),
                                                        (288114536 : u32),
                                                        (1883282658 : u32),
                                                        (458704398 : u32),
                                                        (568099212 : u32),
                                                        (1600869168 : u32),
                                                        (1145016250 : u32),
                                                        (555389150 : u32),
                                                        (1495091760 : u32),
                                                        (1532640885 : u32),
                                                        (1666986810 : u32),
                                                        (519924336 : u32),
                                                        (1563771999 : u32),
                                                        (1446498082 : u32),
                                                        (1855695025 : u32),
                                                        (280317484 : u32),
                                                        (69803704 : u32),
                                                        (760128835 : u32),
                                                        (1913281633 : u32),
                                                        (442196771 : u32),
                                                        (1759606503 : u32),
                                                        (638883701 : u32),
                                                        (1492323307 : u32),
                                                        (1157890731 : u32),
                                                        (613581397 : u32),
                                                        (851810645 : u32),
                                                        (727413345 : u32),
                                                        (1652127647 : u32),
                                                        (1503357582 : u32),
                                                        (1892763091 : u32),
                                                        (931579089 : u32),
                                                        (288765024 : u32)]))),
                                (← (p3_mersenne_31.mersenne_31.Impl.new_array
                                  ((32 : usize))
                                  (RustArray.ofVec #v[(587145601 : u32),
                                                        (1292303440 : u32),
                                                        (665363423 : u32),
                                                        (1685977476 : u32),
                                                        (980716739 : u32),
                                                        (1252597410 : u32),
                                                        (569037473 : u32),
                                                        (1355636109 : u32),
                                                        (114753478 : u32),
                                                        (1539641623 : u32),
                                                        (1173899452 : u32),
                                                        (314824177 : u32),
                                                        (1216319589 : u32),
                                                        (370615356 : u32),
                                                        (1552381156 : u32),
                                                        (1992086508 : u32),
                                                        (2016942544 : u32),
                                                        (882674251 : u32),
                                                        (643656246 : u32),
                                                        (972842286 : u32),
                                                        (610808232 : u32),
                                                        (1216370940 : u32),
                                                        (173831638 : u32),
                                                        (1980583661 : u32),
                                                        (2060279135 : u32),
                                                        (757684141 : u32),
                                                        (1636349694 : u32),
                                                        (545572213 : u32),
                                                        (1741029216 : u32),
                                                        (1030588827 : u32),
                                                        (660162122 : u32),
                                                        (507714002 :
                                                        u32)])))])))
    (by sorry)

--  Round constants for width-32 Poseidon2 on Mersenne31.
-- 
--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=5 (exp_flag=0), n=31, t=32, R_F=8, R_P=30
-- 
--  Generated by `poseidon2/generate_constants.py --field mersenne31 --width 32`.
-- 
--  Layout: internal (30 scalar constants).
def MERSENNE31_POSEIDON2_RC_32_INTERNAL :
  (RustArray p3_mersenne_31.mersenne_31.Mersenne31 30)
  :=
  RustM.of_isOk
    (do
    (p3_mersenne_31.mersenne_31.Impl.new_array ((30 : usize))
      (RustArray.ofVec #v[(1027811219 : u32),
                            (1100325527 : u32),
                            (2144294763 : u32),
                            (1808702357 : u32),
                            (1015163632 : u32),
                            (1982457267 : u32),
                            (1037946958 : u32),
                            (1513948504 : u32),
                            (1983802485 : u32),
                            (1735335304 : u32),
                            (2008556117 : u32),
                            (635406929 : u32),
                            (1769749264 : u32),
                            (63925983 : u32),
                            (313872248 : u32),
                            (1714672948 : u32),
                            (1114619063 : u32),
                            (1430676956 : u32),
                            (1451867570 : u32),
                            (317147102 : u32),
                            (1623361349 : u32),
                            (298470309 : u32),
                            (2088532858 : u32),
                            (1057985923 : u32),
                            (2050785808 : u32),
                            (1455937939 : u32),
                            (553027423 : u32),
                            (1776654280 : u32),
                            (1016141171 : u32),
                            (700970754 : u32)])))
    (by sorry)

end p3_mersenne_31.poseidon2


namespace p3_mersenne_31.mersenne_31

@[reducible] instance Impl_15.AssociatedTypes :
  p3_field.field.PermutationMonomial.AssociatedTypes Mersenne31 ((5 : u64))
  where

instance Impl_15 :
  p3_field.field.PermutationMonomial Mersenne31 ((5 : u64))
  := sorry

end p3_mersenne_31.mersenne_31


namespace p3_mersenne_31.poseidon2

--  Create a default width-16 Poseidon2 permutation for Mersenne31.
@[spec]
def default_mersenne31_poseidon2_16 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon2.Poseidon2
      p3_mersenne_31.mersenne_31.Mersenne31
      (p3_mersenne_31.no_packing.poseidon2.Poseidon2ExternalLayerMersenne31
        ((16 : usize)))
      p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
      ((16 : usize))
      ((5 : u64)))
    := do
  (p3_poseidon2.Impl.new
    p3_mersenne_31.mersenne_31.Mersenne31
    (p3_mersenne_31.no_packing.poseidon2.Poseidon2ExternalLayerMersenne31
      ((16 : usize)))
    p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
    ((16 : usize))
    ((5 : u64))
    (← (p3_poseidon2.external.Impl_4.new
      p3_mersenne_31.mersenne_31.Mersenne31
      ((16 : usize))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_mersenne_31.mersenne_31.Mersenne31 16)
        (← (rust_primitives.unsize
          MERSENNE31_POSEIDON2_RC_16_EXTERNAL_INITIAL))))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_mersenne_31.mersenne_31.Mersenne31 16)
        (← (rust_primitives.unsize
          MERSENNE31_POSEIDON2_RC_16_EXTERNAL_FINAL))))))
    (← (alloc.slice.Impl.to_vec p3_mersenne_31.mersenne_31.Mersenne31
      (← (rust_primitives.unsize MERSENNE31_POSEIDON2_RC_16_INTERNAL)))))

--  Create a default width-24 Poseidon2 permutation for Mersenne31.
@[spec]
def default_mersenne31_poseidon2_24 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon2.Poseidon2
      p3_mersenne_31.mersenne_31.Mersenne31
      (p3_mersenne_31.no_packing.poseidon2.Poseidon2ExternalLayerMersenne31
        ((24 : usize)))
      p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
      ((24 : usize))
      ((5 : u64)))
    := do
  (p3_poseidon2.Impl.new
    p3_mersenne_31.mersenne_31.Mersenne31
    (p3_mersenne_31.no_packing.poseidon2.Poseidon2ExternalLayerMersenne31
      ((24 : usize)))
    p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
    ((24 : usize))
    ((5 : u64))
    (← (p3_poseidon2.external.Impl_4.new
      p3_mersenne_31.mersenne_31.Mersenne31
      ((24 : usize))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_mersenne_31.mersenne_31.Mersenne31 24)
        (← (rust_primitives.unsize
          MERSENNE31_POSEIDON2_RC_24_EXTERNAL_INITIAL))))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_mersenne_31.mersenne_31.Mersenne31 24)
        (← (rust_primitives.unsize
          MERSENNE31_POSEIDON2_RC_24_EXTERNAL_FINAL))))))
    (← (alloc.slice.Impl.to_vec p3_mersenne_31.mersenne_31.Mersenne31
      (← (rust_primitives.unsize MERSENNE31_POSEIDON2_RC_24_INTERNAL)))))

--  Create a default width-32 Poseidon2 permutation for Mersenne31.
@[spec]
def default_mersenne31_poseidon2_32 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon2.Poseidon2
      p3_mersenne_31.mersenne_31.Mersenne31
      (p3_mersenne_31.no_packing.poseidon2.Poseidon2ExternalLayerMersenne31
        ((32 : usize)))
      p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
      ((32 : usize))
      ((5 : u64)))
    := do
  (p3_poseidon2.Impl.new
    p3_mersenne_31.mersenne_31.Mersenne31
    (p3_mersenne_31.no_packing.poseidon2.Poseidon2ExternalLayerMersenne31
      ((32 : usize)))
    p3_mersenne_31.no_packing.poseidon2.Poseidon2InternalLayerMersenne31
    ((32 : usize))
    ((5 : u64))
    (← (p3_poseidon2.external.Impl_4.new
      p3_mersenne_31.mersenne_31.Mersenne31
      ((32 : usize))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_mersenne_31.mersenne_31.Mersenne31 32)
        (← (rust_primitives.unsize
          MERSENNE31_POSEIDON2_RC_32_EXTERNAL_INITIAL))))
      (← (alloc.slice.Impl.to_vec
        (RustArray p3_mersenne_31.mersenne_31.Mersenne31 32)
        (← (rust_primitives.unsize
          MERSENNE31_POSEIDON2_RC_32_EXTERNAL_FINAL))))))
    (← (alloc.slice.Impl.to_vec p3_mersenne_31.mersenne_31.Mersenne31
      (← (rust_primitives.unsize MERSENNE31_POSEIDON2_RC_32_INTERNAL)))))

end p3_mersenne_31.poseidon2


namespace p3_mersenne_31.qm31

@[reducible] instance Impl_29.AssociatedTypes :
  p3_field.field.Algebra.AssociatedTypes
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  where

instance Impl_29 :
  p3_field.field.Algebra
  PackedQM31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  where

@[reducible] instance Impl_19.AssociatedTypes :
  core_models.ops.arith.DivAssign.AssociatedTypes PackedQM31 PackedQM31
  where

instance Impl_19 : core_models.ops.arith.DivAssign PackedQM31 PackedQM31 := sorry

end p3_mersenne_31.qm31


namespace p3_mersenne_31.mersenne_31

@[spec]
def from_u62 (input : u64) : RustM Mersenne31 := sorry

@[reducible] instance Impl_44.AssociatedTypes :
  core_models.ops.arith.DivAssign.AssociatedTypes Mersenne31 Mersenne31
  where

instance Impl_44 : core_models.ops.arith.DivAssign Mersenne31 Mersenne31 := sorry

@[reducible] instance Impl_43.AssociatedTypes :
  core_models.ops.arith.Div.AssociatedTypes Mersenne31 Mersenne31
  where
  Output := Mersenne31

instance Impl_43 : core_models.ops.arith.Div Mersenne31 Mersenne31 := sorry

@[reducible] instance Impl_42.AssociatedTypes :
  core_models.iter.traits.accum.Product.AssociatedTypes Mersenne31 Mersenne31
  where

instance Impl_42 :
  core_models.iter.traits.accum.Product Mersenne31 Mersenne31
  := sorry

@[reducible] instance Impl_41.AssociatedTypes
  (T : Type)
  [trait_constr_Impl_41_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Mersenne31]
  [trait_constr_Impl_41_i0 : core_models.convert.Into T Mersenne31 ] :
  core_models.ops.arith.MulAssign.AssociatedTypes Mersenne31 T
  where

instance Impl_41
  (T : Type)
  [trait_constr_Impl_41_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Mersenne31]
  [trait_constr_Impl_41_i0 : core_models.convert.Into T Mersenne31 ] :
  core_models.ops.arith.MulAssign Mersenne31 T
  := sorry

@[reducible] instance Impl_40.AssociatedTypes
  (T : Type)
  [trait_constr_Impl_40_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Mersenne31]
  [trait_constr_Impl_40_i0 : core_models.convert.Into T Mersenne31 ] :
  core_models.ops.arith.SubAssign.AssociatedTypes Mersenne31 T
  where

instance Impl_40
  (T : Type)
  [trait_constr_Impl_40_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Mersenne31]
  [trait_constr_Impl_40_i0 : core_models.convert.Into T Mersenne31 ] :
  core_models.ops.arith.SubAssign Mersenne31 T
  := sorry

@[reducible] instance Impl_39.AssociatedTypes
  (T : Type)
  [trait_constr_Impl_39_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Mersenne31]
  [trait_constr_Impl_39_i0 : core_models.convert.Into T Mersenne31 ] :
  core_models.ops.arith.AddAssign.AssociatedTypes Mersenne31 T
  where

instance Impl_39
  (T : Type)
  [trait_constr_Impl_39_associated_type_i0 :
    core_models.convert.Into.AssociatedTypes
    T
    Mersenne31]
  [trait_constr_Impl_39_i0 : core_models.convert.Into T Mersenne31 ] :
  core_models.ops.arith.AddAssign Mersenne31 T
  := sorry

@[reducible] instance Impl_38.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Mersenne31 i128
  where

instance Impl_38 : p3_field.integers.QuotientMap Mersenne31 i128 := sorry

@[reducible] instance Impl_37.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Mersenne31 i64
  where

instance Impl_37 : p3_field.integers.QuotientMap Mersenne31 i64 := sorry

@[reducible] instance Impl_36.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Mersenne31 u128
  where

instance Impl_36 : p3_field.integers.QuotientMap Mersenne31 u128 := sorry

@[reducible] instance Impl_35.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Mersenne31 u64
  where

instance Impl_35 : p3_field.integers.QuotientMap Mersenne31 u64 := sorry

@[reducible] instance Impl_34.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Mersenne31 i16
  where

instance Impl_34 : p3_field.integers.QuotientMap Mersenne31 i16 := sorry

@[reducible] instance Impl_33.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Mersenne31 i8
  where

instance Impl_33 : p3_field.integers.QuotientMap Mersenne31 i8 := sorry

@[reducible] instance Impl_32.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Mersenne31 u16
  where

instance Impl_32 : p3_field.integers.QuotientMap Mersenne31 u16 := sorry

@[reducible] instance Impl_31.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Mersenne31 u8
  where

instance Impl_31 : p3_field.integers.QuotientMap Mersenne31 u8 := sorry

@[reducible] instance Impl_26.AssociatedTypes :
  core_models.iter.traits.accum.Sum.AssociatedTypes Mersenne31 Mersenne31
  where

instance Impl_26 : core_models.iter.traits.accum.Sum Mersenne31 Mersenne31 := sorry

@[reducible] instance Impl_25.AssociatedTypes :
  core_models.ops.arith.Mul.AssociatedTypes Mersenne31 Mersenne31
  where
  Output := Mersenne31

instance Impl_25 : core_models.ops.arith.Mul Mersenne31 Mersenne31 := sorry

@[reducible] instance Impl_24.AssociatedTypes :
  core_models.ops.arith.Neg.AssociatedTypes Mersenne31
  where
  Output := Mersenne31

instance Impl_24 : core_models.ops.arith.Neg Mersenne31 := sorry

@[reducible] instance Impl_23.AssociatedTypes :
  core_models.ops.arith.Sub.AssociatedTypes Mersenne31 Mersenne31
  where
  Output := Mersenne31

instance Impl_23 : core_models.ops.arith.Sub Mersenne31 Mersenne31 := sorry

@[reducible] instance Impl_22.AssociatedTypes :
  core_models.ops.arith.Add.AssociatedTypes Mersenne31 Mersenne31
  where
  Output := Mersenne31

instance Impl_22 : core_models.ops.arith.Add Mersenne31 Mersenne31 := sorry

@[reducible] instance Impl_21.AssociatedTypes :
  p3_field.field.PrimeField64.AssociatedTypes Mersenne31
  where

instance Impl_21 : p3_field.field.PrimeField64 Mersenne31 := sorry

@[reducible] instance Impl_20.AssociatedTypes :
  p3_field.field.PrimeField32.AssociatedTypes Mersenne31
  where

instance Impl_20 : p3_field.field.PrimeField32 Mersenne31 := sorry

@[reducible] instance Impl_19.AssociatedTypes :
  p3_field.field.PrimeField.AssociatedTypes Mersenne31
  where

instance Impl_19 : p3_field.field.PrimeField Mersenne31 := sorry

@[reducible] instance Impl_18.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Mersenne31 i32
  where

instance Impl_18 : p3_field.integers.QuotientMap Mersenne31 i32 := sorry

@[reducible] instance Impl_17.AssociatedTypes :
  p3_field.integers.QuotientMap.AssociatedTypes Mersenne31 u32
  where

instance Impl_17 : p3_field.integers.QuotientMap Mersenne31 u32 := sorry

@[reducible] instance Impl_16.AssociatedTypes :
  p3_field.field.Field.AssociatedTypes Mersenne31
  where
  Packing := Mersenne31

instance Impl_16 : p3_field.field.Field Mersenne31 := sorry

@[reducible] instance Impl_13.AssociatedTypes :
  p3_field.field.PrimeCharacteristicRing.AssociatedTypes Mersenne31
  where
  PrimeSubfield := Mersenne31

instance Impl_13 : p3_field.field.PrimeCharacteristicRing Mersenne31 := sorry

@[reducible] instance Impl_12.AssociatedTypes :
  p3_field.field.RawDataSerializable.AssociatedTypes Mersenne31
  where

instance Impl_12 : p3_field.field.RawDataSerializable Mersenne31 := sorry

@[reducible] instance Impl_10.AssociatedTypes :
  serde_core.ser.Serialize.AssociatedTypes Mersenne31
  where

instance Impl_10 : serde_core.ser.Serialize Mersenne31 := sorry

@[reducible] instance Impl_1.AssociatedTypes :
  core_models.cmp.PartialEq.AssociatedTypes Mersenne31 Mersenne31
  where

instance Impl_1 : core_models.cmp.PartialEq Mersenne31 Mersenne31 := sorry

@[reducible] instance Impl_2.AssociatedTypes :
  core_models.cmp.Eq.AssociatedTypes Mersenne31
  where

instance Impl_2 : core_models.cmp.Eq Mersenne31 where

@[reducible] instance Impl_6.AssociatedTypes :
  core_models.cmp.PartialOrd.AssociatedTypes Mersenne31 Mersenne31
  where

instance Impl_6 : core_models.cmp.PartialOrd Mersenne31 Mersenne31 := sorry

@[reducible] instance Impl_5.AssociatedTypes :
  core_models.cmp.Ord.AssociatedTypes Mersenne31
  where

instance Impl_5 : core_models.cmp.Ord Mersenne31 := sorry

@[reducible] instance Impl_4.AssociatedTypes :
  core_models.hash.Hash.AssociatedTypes Mersenne31
  where

instance Impl_4 : core_models.hash.Hash Mersenne31 where
  hash :=
    fun
      (H : Type)
      [trait_constr_hash_associated_type_i0 :
        core_models.hash.Hasher.AssociatedTypes
        H]
      [trait_constr_hash_i0 : core_models.hash.Hasher H ]
      (self : Mersenne31)
      (state : H) => do
    let state : H ←
      (core_models.hash.Hasher.write_u32
        H
        state
        (← (p3_field.field.PrimeField32.to_unique_u32 Mersenne31 self)));
    (pure state)

@[reducible] instance Impl_3.AssociatedTypes :
  p3_field.packed.packed_traits.Packable.AssociatedTypes Mersenne31
  where

instance Impl_3 : p3_field.packed.packed_traits.Packable Mersenne31 where

end p3_mersenne_31.mersenne_31


namespace p3_mersenne_31.poseidon1

--  Create the default width-16 Poseidon1 permutation for Mersenne31.
@[spec]
def default_mersenne31_poseidon1_16 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon1.Poseidon1
      p3_mersenne_31.mersenne_31.Mersenne31
      (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
        p3_mersenne_31.mersenne_31.Mersenne31
        p3_mersenne_31.mds.MdsMatrixMersenne31
        ((16 : usize)))
      (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
        p3_mersenne_31.mersenne_31.Mersenne31
        ((16 : usize)))
      ((16 : usize))
      ((5 : u64)))
    := do
  (p3_poseidon1.Impl_1.new
    p3_mersenne_31.mersenne_31.Mersenne31
    (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
      p3_mersenne_31.mersenne_31.Mersenne31
      p3_mersenne_31.mds.MdsMatrixMersenne31
      ((16 : usize)))
    (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
      p3_mersenne_31.mersenne_31.Mersenne31
      ((16 : usize)))
    ((16 : usize))
    ((5 : u64))
    (p3_poseidon1.Poseidon1Constants.mk
      (rounds_f := (← ((2 : usize) *? MERSENNE31_POSEIDON1_HALF_FULL_ROUNDS)))
      (rounds_p := MERSENNE31_POSEIDON1_PARTIAL_ROUNDS_16)
      (mds_circ_col := (← (p3_mds.util.first_row_to_first_col ((16 : usize)) i64
        p3_mersenne_31.mds.MATRIX_CIRC_MDS_16_SML_ROW)))
      (round_constants := (← (alloc.slice.Impl.to_vec
        (RustArray p3_mersenne_31.mersenne_31.Mersenne31 16)
        (← (rust_primitives.unsize MERSENNE31_POSEIDON1_RC_16)))))))

--  Create the default width-32 Poseidon1 permutation for Mersenne31.
@[spec]
def default_mersenne31_poseidon1_32 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon1.Poseidon1
      p3_mersenne_31.mersenne_31.Mersenne31
      (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
        p3_mersenne_31.mersenne_31.Mersenne31
        p3_mersenne_31.mds.MdsMatrixMersenne31
        ((32 : usize)))
      (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
        p3_mersenne_31.mersenne_31.Mersenne31
        ((32 : usize)))
      ((32 : usize))
      ((5 : u64)))
    := do
  (p3_poseidon1.Impl_1.new
    p3_mersenne_31.mersenne_31.Mersenne31
    (p3_poseidon1.generic.Poseidon1ExternalLayerGeneric
      p3_mersenne_31.mersenne_31.Mersenne31
      p3_mersenne_31.mds.MdsMatrixMersenne31
      ((32 : usize)))
    (p3_poseidon1.generic.Poseidon1InternalLayerGeneric
      p3_mersenne_31.mersenne_31.Mersenne31
      ((32 : usize)))
    ((32 : usize))
    ((5 : u64))
    (p3_poseidon1.Poseidon1Constants.mk
      (rounds_f := (← ((2 : usize) *? MERSENNE31_POSEIDON1_HALF_FULL_ROUNDS)))
      (rounds_p := MERSENNE31_POSEIDON1_PARTIAL_ROUNDS_32)
      (mds_circ_col := (← (p3_mds.util.first_row_to_first_col ((32 : usize)) i64
        p3_mersenne_31.mds.MATRIX_CIRC_MDS_32_MERSENNE31_ROW)))
      (round_constants := (← (alloc.slice.Impl.to_vec
        (RustArray p3_mersenne_31.mersenne_31.Mersenne31 32)
        (← (rust_primitives.unsize MERSENNE31_POSEIDON1_RC_32)))))))

end p3_mersenne_31.poseidon1


namespace p3_mersenne_31.complex

@[reducible] instance Impl.AssociatedTypes :
  p3_field.extension.complex.ComplexExtendable.AssociatedTypes
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl :
  p3_field.extension.complex.ComplexExtendable
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

end p3_mersenne_31.complex


namespace p3_mersenne_31.extension

@[reducible] instance Impl_1.AssociatedTypes :
  p3_field.extension.BinomiallyExtendable.AssociatedTypes
  p3_mersenne_31.mersenne_31.Mersenne31
  ((3 : usize))
  where

instance Impl_1 :
  p3_field.extension.BinomiallyExtendable
  p3_mersenne_31.mersenne_31.Mersenne31
  ((3 : usize))
  := sorry

@[reducible] instance Impl.AssociatedTypes :
  p3_field.extension.ExtensionAlgebra.AssociatedTypes
  p3_mersenne_31.mersenne_31.Mersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((3 : usize))
  (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
  where

instance Impl :
  p3_field.extension.ExtensionAlgebra
  p3_mersenne_31.mersenne_31.Mersenne31
  p3_mersenne_31.mersenne_31.Mersenne31
  ((3 : usize))
  (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
  := sorry

@[reducible] instance Impl_2.AssociatedTypes :
  p3_field.extension.complex.HasComplexBinomialExtension.AssociatedTypes
  p3_mersenne_31.mersenne_31.Mersenne31
  ((2 : usize))
  where

instance Impl_2 :
  p3_field.extension.complex.HasComplexBinomialExtension
  p3_mersenne_31.mersenne_31.Mersenne31
  ((2 : usize))
  := sorry

@[reducible] instance Impl_4.AssociatedTypes :
  p3_field.extension.complex.HasComplexBinomialExtension.AssociatedTypes
  p3_mersenne_31.mersenne_31.Mersenne31
  ((3 : usize))
  where

instance Impl_4 :
  p3_field.extension.complex.HasComplexBinomialExtension
  p3_mersenne_31.mersenne_31.Mersenne31
  ((3 : usize))
  := sorry

end p3_mersenne_31.extension


namespace p3_mersenne_31.qm31

--  The two `CM31` coefficients of a `QM31` element.
@[spec]
def coeffs
    (x :
    (p3_field.extension.ExtField
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31)
      ((2 : usize))
      (p3_field.extension.Binomial
        (p3_field.extension.ExtField
          p3_mersenne_31.mersenne_31.Mersenne31
          ((2 : usize))
          (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
          p3_mersenne_31.mersenne_31.Mersenne31))
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))) :
    RustM
    (RustArray
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    2)
 := sorry

@[spec]
def packed_mul_by_w
    (c :
    (p3_field.extension.PackedExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31))) :
    RustM
    (p3_field.extension.PackedExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31))
 := sorry

@[reducible] instance Impl.AssociatedTypes :
  core_models.convert.From.AssociatedTypes
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl :
  core_models.convert.From
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_7.AssociatedTypes :
  p3_field.field.Algebra.AssociatedTypes
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl_7 :
  p3_field.field.Algebra
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  where

@[reducible] instance Impl_12.AssociatedTypes :
  core_models.ops.arith.Add.AssociatedTypes PackedQM31 PackedQM31
  where
  Output := PackedQM31

instance Impl_12 : core_models.ops.arith.Add PackedQM31 PackedQM31 := sorry

@[reducible] instance Impl_14.AssociatedTypes :
  core_models.ops.arith.Sub.AssociatedTypes PackedQM31 PackedQM31
  where
  Output := PackedQM31

instance Impl_14 : core_models.ops.arith.Sub PackedQM31 PackedQM31 := sorry

@[reducible] instance Impl_30.AssociatedTypes :
  core_models.convert.From.AssociatedTypes
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl_30 :
  core_models.convert.From PackedQM31 p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_31.AssociatedTypes :
  core_models.ops.arith.Add.AssociatedTypes
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  where
  Output := PackedQM31

instance Impl_31 :
  core_models.ops.arith.Add PackedQM31 p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_33.AssociatedTypes :
  core_models.ops.arith.Sub.AssociatedTypes
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  where
  Output := PackedQM31

instance Impl_33 :
  core_models.ops.arith.Sub PackedQM31 p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_35.AssociatedTypes :
  core_models.ops.arith.Mul.AssociatedTypes
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  where
  Output := PackedQM31

instance Impl_35 :
  core_models.ops.arith.Mul PackedQM31 p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

end p3_mersenne_31.qm31


namespace p3_mersenne_31.complex

@[reducible] instance Impl_1.AssociatedTypes :
  p3_field.extension.HasTwoAdicBinomialExtension.AssociatedTypes
  p3_mersenne_31.mersenne_31.Mersenne31
  ((2 : usize))
  where

instance Impl_1 :
  p3_field.extension.HasTwoAdicBinomialExtension
  p3_mersenne_31.mersenne_31.Mersenne31
  ((2 : usize))
  := sorry

end p3_mersenne_31.complex


namespace p3_mersenne_31.qm31

@[reducible] instance Impl_21.AssociatedTypes :
  core_models.iter.traits.accum.Product.AssociatedTypes PackedQM31 PackedQM31
  where

instance Impl_21 :
  core_models.iter.traits.accum.Product PackedQM31 PackedQM31
  := sorry

@[reducible] instance Impl_20.AssociatedTypes :
  core_models.iter.traits.accum.Sum.AssociatedTypes PackedQM31 PackedQM31
  where

instance Impl_20 : core_models.iter.traits.accum.Sum PackedQM31 PackedQM31 := sorry

@[reducible] instance Impl_10.AssociatedTypes :
  p3_field.field.PrimeCharacteristicRing.AssociatedTypes PackedQM31
  where
  PrimeSubfield := p3_mersenne_31.mersenne_31.Mersenne31

instance Impl_10 : p3_field.field.PrimeCharacteristicRing PackedQM31 := sorry

end p3_mersenne_31.qm31


namespace p3_mersenne_31.extension

@[reducible] instance Impl_3.AssociatedTypes :
  p3_field.extension.complex.HasTwoAdicComplexBinomialExtension.AssociatedTypes
  p3_mersenne_31.mersenne_31.Mersenne31
  ((2 : usize))
  where

instance Impl_3 :
  p3_field.extension.complex.HasTwoAdicComplexBinomialExtension
  p3_mersenne_31.mersenne_31.Mersenne31
  ((2 : usize))
  := sorry

@[reducible] instance Impl_5.AssociatedTypes :
  p3_field.extension.complex.HasTwoAdicComplexBinomialExtension.AssociatedTypes
  p3_mersenne_31.mersenne_31.Mersenne31
  ((3 : usize))
  where

instance Impl_5 :
  p3_field.extension.complex.HasTwoAdicComplexBinomialExtension
  p3_mersenne_31.mersenne_31.Mersenne31
  ((3 : usize))
  := sorry

end p3_mersenne_31.extension


namespace p3_mersenne_31.qm31

@[reducible] instance Impl_37.AssociatedTypes :
  p3_field.field.Algebra.AssociatedTypes
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  where

instance Impl_37 :
  p3_field.field.Algebra PackedQM31 p3_mersenne_31.mersenne_31.Mersenne31
  where

@[reducible] instance Impl_40.AssociatedTypes :
  p3_field.packed.packed_traits.PackedFieldExtension.AssociatedTypes
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  where

instance Impl_40 :
  p3_field.packed.packed_traits.PackedFieldExtension
  PackedQM31
  p3_mersenne_31.mersenne_31.Mersenne31
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  := sorry

@[reducible] instance Impl_9.AssociatedTypes :
  p3_field.field.ExtensionField.AssociatedTypes
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  where
  ExtensionPacking := PackedQM31

instance Impl_9 :
  p3_field.field.ExtensionField
  (p3_field.extension.ExtField
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31)
    ((2 : usize))
    (p3_field.extension.Binomial
      (p3_field.extension.ExtField
        p3_mersenne_31.mersenne_31.Mersenne31
        ((2 : usize))
        (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
        p3_mersenne_31.mersenne_31.Mersenne31))
    (p3_field.extension.ExtField
      p3_mersenne_31.mersenne_31.Mersenne31
      ((2 : usize))
      (p3_field.extension.Binomial p3_mersenne_31.mersenne_31.Mersenne31)
      p3_mersenne_31.mersenne_31.Mersenne31))
  p3_mersenne_31.mersenne_31.Mersenne31
  := sorry

@[reducible] instance Impl_18.AssociatedTypes :
  core_models.ops.arith.Div.AssociatedTypes PackedQM31 PackedQM31
  where
  Output := PackedQM31

instance Impl_18 : core_models.ops.arith.Div PackedQM31 PackedQM31 := sorry

end p3_mersenne_31.qm31

