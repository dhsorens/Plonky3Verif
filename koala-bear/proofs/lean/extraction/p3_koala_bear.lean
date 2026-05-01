
-- Experimental lean backend for Hax
-- The Hax prelude library can be found in hax/proof-libs/lean
import Hax
import p3_koala_bear.dependencies -- ALTERED
import Std.Tactic.Do
import Std.Do.Triple
import Std.Tactic.Do.Syntax
open Std.Do
open Std.Tactic

set_option mvcgen.warning false
set_option linter.unusedVariables false


namespace p3_koala_bear.koala_bear

structure KoalaBearParameters where
  -- no fields

--  The prime field `2^31 - 2^24 + 1`, a.k.a. the Koala Bear field.
abbrev KoalaBear
  [ p3_monty_31.data_traits.MontyParameters.AssociatedTypes KoalaBearParameters ]
  [ p3_monty_31.data_traits.MontyParameters KoalaBearParameters ] :
  Type :=
  (p3_monty_31.monty_31.MontyField31 KoalaBearParameters)

@[instance] opaque Impl_11.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_11 :
  core_models.clone.Clone KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_10.AssociatedTypes :
  core_models.marker.Copy.AssociatedTypes KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_10 :
  core_models.marker.Copy KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_12.AssociatedTypes :
  core_models.default.Default.AssociatedTypes KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_12 :
  core_models.default.Default KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_13.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_13 :
  core_models.fmt.Debug KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_15.AssociatedTypes :
  core_models.hash.Hash.AssociatedTypes KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_15 :
  core_models.hash.Hash KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_16.AssociatedTypes :
  core_models.marker.StructuralPartialEq.AssociatedTypes KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_16 :
  core_models.marker.StructuralPartialEq KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_17.AssociatedTypes :
  core_models.cmp.PartialEq.AssociatedTypes
  KoalaBearParameters
  KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_17 :
  core_models.cmp.PartialEq KoalaBearParameters KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_14.AssociatedTypes :
  core_models.cmp.Eq.AssociatedTypes KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_14 :
  core_models.cmp.Eq KoalaBearParameters :=
  by constructor <;> exact Inhabited.default

@[reducible] instance Impl.AssociatedTypes :
  p3_monty_31.data_traits.MontyParameters.AssociatedTypes KoalaBearParameters
  where

instance Impl :
  p3_monty_31.data_traits.MontyParameters KoalaBearParameters
  where
  PRIME := (2130706433 : u32)
  MONTY_BITS := (32 : u32)
  MONTY_MU := (2164260865 : u32)

@[reducible] instance Impl_1.AssociatedTypes :
  p3_challenger.duplex_challenger.UniformSamplingField.AssociatedTypes
  KoalaBearParameters
  where

instance Impl_1 :
  p3_challenger.duplex_challenger.UniformSamplingField KoalaBearParameters
  where
  MAX_SINGLE_SAMPLE_BITS := (24 : usize)
  SAMPLING_BITS_M := RustM.of_isOk
    (do
    let prime : u64 ←
      (rust_primitives.hax.cast_op
        (p3_monty_31.data_traits.MontyParameters.PRIME KoalaBearParameters) :
        RustM u64);
    let a : (RustArray u64 64) ←
      (rust_primitives.hax.repeat (0 : u64) (64 : usize));
    let k : usize := (0 : usize);
    let ⟨a, k⟩ ←
      (rust_primitives.hax.while_loop
        (fun ⟨a, k⟩ => (do (pure true) : RustM Bool))
        (fun ⟨a, k⟩ => (do (k <? (64 : usize)) : RustM Bool))
        (fun ⟨a, k⟩ =>
          (do
          (rust_primitives.hax.int.from_machine (0 : u32)) :
          RustM hax_lib.int.Int))
        (rust_primitives.hax.Tuple2.mk a k)
        (fun ⟨a, k⟩ =>
          (do
          let a : (RustArray u64 64) ←
            if (← (k ==? (0 : usize))) then do
              let a : (RustArray u64 64) ←
                (rust_primitives.hax.monomorphized_update_at.update_at_usize
                  a
                  k
                  prime);
              (pure a)
            else do
              let mask : u64 ← (~? (← ((← ((1 : u64) <<<? k)) -? (1 : u64))));
              let a : (RustArray u64 64) ←
                (rust_primitives.hax.monomorphized_update_at.update_at_usize
                  a
                  k
                  (← (prime &&&? mask)));
              (pure a);
          let k : usize ← (k +? (1 : usize));
          (pure (rust_primitives.hax.Tuple2.mk a k)) :
          RustM (rust_primitives.hax.Tuple2 (RustArray u64 64) usize))));
    (pure a))
    (by sorry) -- ALTERED
    -- (by rfl)

@[reducible] instance Impl_3.AssociatedTypes :
  p3_monty_31.data_traits.BarrettParameters.AssociatedTypes KoalaBearParameters
  where

instance Impl_3 :
  p3_monty_31.data_traits.BarrettParameters KoalaBearParameters
  where

@[reducible] instance Impl_5.AssociatedTypes :
  p3_monty_31.data_traits.RelativelyPrimePower.AssociatedTypes
  KoalaBearParameters
  ((3 : u64))
  where

instance Impl_5 :
  p3_monty_31.data_traits.RelativelyPrimePower KoalaBearParameters ((3 : u64))
  where
  exp_root_d :=
    fun
      (R : Type)
      [trait_constr_exp_root_d_associated_type_i0 :
        p3_field.field.PrimeCharacteristicRing.AssociatedTypes
        R]
      [trait_constr_exp_root_d_i0 : p3_field.field.PrimeCharacteristicRing R ]
      (val : R) => do
    (p3_field.exponentiation.exp_1420470955 R val)

@[reducible] instance Impl_6.AssociatedTypes :
  p3_monty_31.data_traits.TwoAdicData.AssociatedTypes KoalaBearParameters
  where
  ArrayLike := (RustSlice
  (p3_monty_31.monty_31.MontyField31 KoalaBearParameters))

instance Impl_6 : p3_monty_31.data_traits.TwoAdicData KoalaBearParameters where
  TWO_ADICITY := (24 : usize)
  TWO_ADIC_GENERATORS := RustM.of_isOk
    (do
    (rust_primitives.unsize
      (← (p3_monty_31.monty_31.Impl.new_array KoalaBearParameters ((25 : usize))
        (RustArray.ofVec #v[(1 : u32),
                              (2130706432 : u32),
                              (2113994754 : u32),
                              (1748172362 : u32),
                              (148625052 : u32),
                              (170455089 : u32),
                              (1548376985 : u32),
                              (699882112 : u32),
                              (392596362 : u32),
                              (665670555 : u32),
                              (860702919 : u32),
                              (2000983452 : u32),
                              (1989134074 : u32),
                              (809067698 : u32),
                              (1047035213 : u32),
                              (1168510561 : u32),
                              (1848593786 : u32),
                              (373019801 : u32),
                              (1816824389 : u32),
                              (339671193 : u32),
                              (1364057261 : u32),
                              (1213133211 : u32),
                              (542991299 : u32),
                              (1760025929 : u32),
                              (1791270792 : u32)])))))
    (by sorry) -- ALTERED
    -- (by rfl)
  ROOTS_8 := RustM.of_isOk
    (do
    (rust_primitives.unsize
      (← (p3_monty_31.monty_31.Impl.new_array KoalaBearParameters ((4 : usize))
        (RustArray.ofVec #v[(1 : u32),
                              (1748172362 : u32),
                              (2113994754 : u32),
                              (391001680 : u32)])))))
    (by sorry) -- ALTERED
    -- (by rfl)
  INV_ROOTS_8 := RustM.of_isOk
    (do
    (rust_primitives.unsize
      (← (p3_monty_31.monty_31.Impl.new_array KoalaBearParameters ((4 : usize))
        (RustArray.ofVec #v[(1 : u32),
                              (1739704753 : u32),
                              (16711679 : u32),
                              (382534071 : u32)])))))
    (by sorry) -- ALTERED
    -- (by rfl)
  ROOTS_16 := RustM.of_isOk
    (do
    (rust_primitives.unsize
      (← (p3_monty_31.monty_31.Impl.new_array KoalaBearParameters ((8 : usize))
        (RustArray.ofVec #v[(1 : u32),
                              (148625052 : u32),
                              (1748172362 : u32),
                              (665723362 : u32),
                              (2113994754 : u32),
                              (982097957 : u32),
                              (391001680 : u32),
                              (668978722 : u32)])))))
    (by sorry) -- ALTERED
    -- (by rfl)
  INV_ROOTS_16 := RustM.of_isOk
    (do
    (rust_primitives.unsize
      (← (p3_monty_31.monty_31.Impl.new_array KoalaBearParameters ((8 : usize))
        (RustArray.ofVec #v[(1 : u32),
                              (1461727711 : u32),
                              (1739704753 : u32),
                              (1148608476 : u32),
                              (16711679 : u32),
                              (1464983071 : u32),
                              (382534071 : u32),
                              (1982081381 : u32)])))))
    (by sorry) -- ALTERED
    -- (by rfl)

@[reducible] instance Impl_7.AssociatedTypes :
  p3_monty_31.data_traits.BinomialExtensionData.AssociatedTypes
  KoalaBearParameters
  ((4 : usize))
  where
  ArrayLike := (RustArray
  (RustArray (p3_monty_31.monty_31.MontyField31 KoalaBearParameters) 4)
  2)

instance Impl_7 :
  p3_monty_31.data_traits.BinomialExtensionData
  KoalaBearParameters
  ((4 : usize))
  where
  W := RustM.of_isOk
    (do (p3_monty_31.monty_31.Impl.new KoalaBearParameters (3 : u32)))
    (by sorry) -- ALTERED
    -- (by rfl)
  mul_w :=
    fun
      (A : Type)
      [trait_constr_mul_w_associated_type_i0 :
        p3_field.field.Algebra.AssociatedTypes
        A
        (p3_monty_31.monty_31.MontyField31 KoalaBearParameters)]
      [trait_constr_mul_w_i0 : p3_field.field.Algebra
        A
        (p3_monty_31.monty_31.MontyField31 KoalaBearParameters)
        ] (a : A) => sorry -- ALTERED
    -- (do
    -- (core_models.ops.arith.Add.add
    --   A
    --   A (← (p3_field.field.PrimeCharacteristicRing.double A a)) a))
  DTH_ROOT := RustM.of_isOk
    (do (p3_monty_31.monty_31.Impl.new KoalaBearParameters (2113994754 : u32)))
    (by sorry) -- ALTERED
    -- (by rfl)
  EXT_GENERATOR := RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_array KoalaBearParameters ((4 : usize))
      (RustArray.ofVec #v[(2 : u32), (1 : u32), (0 : u32), (0 : u32)])))
    (by sorry) -- ALTERED
    -- (by rfl)
  EXT_TWO_ADICITY := (26 : usize)
  TWO_ADIC_EXTENSION_GENERATORS := RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_2d_array
      KoalaBearParameters
      ((4 : usize))
      ((2 : usize))
      (RustArray.ofVec #v[(RustArray.ofVec #v[(0 : u32),
                                                (0 : u32),
                                                (1759267465 : u32),
                                                (0 : u32)]),
                            (RustArray.ofVec #v[(0 : u32),
                                                  (0 : u32),
                                                  (0 : u32),
                                                  (777715144 : u32)])])))
    (by sorry) -- ALTERED
    -- (by rfl)

@[reducible] instance Impl_8.AssociatedTypes :
  p3_monty_31.data_traits.BinomialExtensionData.AssociatedTypes
  KoalaBearParameters
  ((8 : usize))
  where
  ArrayLike := (RustArray
  (RustArray (p3_monty_31.monty_31.MontyField31 KoalaBearParameters) 8)
  3)

instance Impl_8 :
  p3_monty_31.data_traits.BinomialExtensionData
  KoalaBearParameters
  ((8 : usize))
  where
  W := RustM.of_isOk
    (do (p3_monty_31.monty_31.Impl.new KoalaBearParameters (3 : u32)))
    (by sorry) -- ALTERED
    -- (by rfl)
  DTH_ROOT := RustM.of_isOk
    (do (p3_monty_31.monty_31.Impl.new KoalaBearParameters (1748172362 : u32)))
    (by sorry) -- ALTERED
    -- (by rfl)
  EXT_GENERATOR := RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_array KoalaBearParameters ((8 : usize))
      (RustArray.ofVec #v[(10 : u32),
                            (1 : u32),
                            (0 : u32),
                            (0 : u32),
                            (0 : u32),
                            (0 : u32),
                            (0 : u32),
                            (0 : u32)])))
    (by sorry) -- ALTERED
    -- (by rfl)
  EXT_TWO_ADICITY := (27 : usize)
  TWO_ADIC_EXTENSION_GENERATORS := RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_2d_array
      KoalaBearParameters
      ((8 : usize))
      ((3 : usize))
      (RustArray.ofVec #v[(RustArray.ofVec #v[(0 : u32),
                                                (0 : u32),
                                                (0 : u32),
                                                (0 : u32),
                                                (1759267465 : u32),
                                                (0 : u32),
                                                (0 : u32),
                                                (0 : u32)]),
                            (RustArray.ofVec #v[(0 : u32),
                                                  (0 : u32),
                                                  (0 : u32),
                                                  (0 : u32),
                                                  (0 : u32),
                                                  (0 : u32),
                                                  (777715144 : u32),
                                                  (0 : u32)]),
                            (RustArray.ofVec #v[(0 : u32),
                                                  (0 : u32),
                                                  (0 : u32),
                                                  (0 : u32),
                                                  (0 : u32),
                                                  (0 : u32),
                                                  (0 : u32),
                                                  (14348907 : u32)])])))
    (by sorry) -- ALTERED
    -- (by rfl)
  mul_w :=
    fun
      (A : Type)
      [trait_constr_mul_w_associated_type_i0 :
        p3_field.field.Algebra.AssociatedTypes
        A
        (p3_monty_31.monty_31.MontyField31 KoalaBearParameters)]
      [trait_constr_mul_w_i0 : p3_field.field.Algebra
        A
        (p3_monty_31.monty_31.MontyField31 KoalaBearParameters)
        ] (a : A) => sorry -- ALTERED
    -- (do
    -- (core_models.ops.arith.Add.add
    --   A
    --   A (← (p3_field.field.PrimeCharacteristicRing.double A a)) a))

@[reducible] instance Impl_9.AssociatedTypes :
  p3_monty_31.data_traits.TrinomialQuinticData.AssociatedTypes
  KoalaBearParameters
  where
  ArrayLike := (RustArray
  (RustArray (p3_monty_31.monty_31.MontyField31 KoalaBearParameters) 5)
  0)

instance Impl_9 :
  p3_monty_31.data_traits.TrinomialQuinticData KoalaBearParameters
  where
  EXT_GENERATOR := RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_array KoalaBearParameters ((5 : usize))
      (RustArray.ofVec #v[(2 : u32),
                            (1 : u32),
                            (0 : u32),
                            (0 : u32),
                            (0 : u32)])))
    (by sorry) -- ALTERED
    -- (by rfl)
  EXT_TWO_ADICITY := (24 : usize)
  FROBENIUS_COEFFS := RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_2d_array
      KoalaBearParameters
      ((5 : usize))
      ((4 : usize))
      (RustArray.ofVec #v[(RustArray.ofVec #v[(1576402667 : u32),
                                                (1173144480 : u32),
                                                (1567662457 : u32),
                                                (1206866823 : u32),
                                                (2428146 : u32)]),
                            (RustArray.ofVec #v[(1680345488 : u32),
                                                  (1381986 : u32),
                                                  (615237464 : u32),
                                                  (1380104858 : u32),
                                                  (295431824 : u32)]),
                            (RustArray.ofVec #v[(441230756 : u32),
                                                  (323126830 : u32),
                                                  (704986542 : u32),
                                                  (1445620072 : u32),
                                                  (503505220 : u32)]),
                            (RustArray.ofVec #v[(1364444097 : u32),
                                                  (1144738982 : u32),
                                                  (2008416047 : u32),
                                                  (143367062 : u32),
                                                  (1027410849 : u32)])])))
    (by sorry) -- ALTERED
    -- (by rfl)
  TWO_ADIC_EXTENSION_GENERATORS := RustM.of_isOk
    (do (pure (RustArray.ofVec #v[])))
    (by rfl)

end p3_koala_bear.koala_bear


namespace p3_koala_bear.mds

structure MDSKoalaBearData where
  -- no fields

@[instance] opaque Impl_1.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes MDSKoalaBearData :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_1 :
  core_models.clone.Clone MDSKoalaBearData :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_2.AssociatedTypes :
  core_models.default.Default.AssociatedTypes MDSKoalaBearData :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_2 :
  core_models.default.Default MDSKoalaBearData :=
  by constructor <;> exact Inhabited.default

@[reducible] instance Impl.AssociatedTypes :
  p3_monty_31.mds.MDSUtils.AssociatedTypes MDSKoalaBearData
  where

instance Impl : p3_monty_31.mds.MDSUtils MDSKoalaBearData where
  MATRIX_CIRC_MDS_8_COL := RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((8 : usize)) i64
      (RustArray.ofVec #v[(7 : i64),
                            (1 : i64),
                            (3 : i64),
                            (8 : i64),
                            (8 : i64),
                            (3 : i64),
                            (4 : i64),
                            (9 : i64)])))
    (by sorry) -- ALTERED
    -- (by rfl)
  MATRIX_CIRC_MDS_12_COL := RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((12 : usize)) i64
      (RustArray.ofVec #v[(1 : i64),
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
    (by sorry) -- ALTERED
    -- (by rfl)
  MATRIX_CIRC_MDS_16_COL := RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((16 : usize)) i64
      (RustArray.ofVec #v[(1 : i64),
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
    (by sorry) -- ALTERED
    -- (by rfl)
  MATRIX_CIRC_MDS_24_COL := RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((24 : usize)) i64
      (RustArray.ofVec #v[(755673771 : i64),
                            (1686439191 : i64),
                            (401954077 : i64),
                            (82624181 : i64),
                            (1838262485 : i64),
                            (1617965094 : i64),
                            (416740298 : i64),
                            (1922433447 : i64),
                            (2009967074 : i64),
                            (1007636536 : i64),
                            (651504225 : i64),
                            (56639581 : i64),
                            (1761374664 : i64),
                            (613787421 : i64),
                            (1566027714 : i64),
                            (378133912 : i64),
                            (1009532350 : i64),
                            (203676737 : i64),
                            (86296562 : i64),
                            (1810161513 : i64),
                            (175003436 : i64),
                            (1551339770 : i64),
                            (400627958 : i64),
                            (142123135 : i64)])))
    (by sorry) -- ALTERED
    -- (by rfl)
  MATRIX_CIRC_MDS_32_COL := RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((32 : usize)) i64
      (RustArray.ofVec #v[(197132288 : i64),
                            (736989057 : i64),
                            (863897170 : i64),
                            (1279604177 : i64),
                            (1257430066 : i64),
                            (766772495 : i64),
                            (1735032035 : i64),
                            (973518478 : i64),
                            (1586872753 : i64),
                            (744445088 : i64),
                            (590541117 : i64),
                            (1491556337 : i64),
                            (984014030 : i64),
                            (1618929200 : i64),
                            (1322614768 : i64),
                            (1846039899 : i64),
                            (1276466518 : i64),
                            (1484771534 : i64),
                            (1177490769 : i64),
                            (53101516 : i64),
                            (1580090346 : i64),
                            (1902156546 : i64),
                            (249134661 : i64),
                            (1445767145 : i64),
                            (750193437 : i64),
                            (1318329891 : i64),
                            (390750657 : i64),
                            (293245990 : i64),
                            (1935024439 : i64),
                            (1415143558 : i64),
                            (1216108043 : i64),
                            (1755622571 : i64)])))
    (by sorry) -- ALTERED
    -- (by rfl)
  MATRIX_CIRC_MDS_64_COL := RustM.of_isOk
    (do
    (p3_mds.util.first_row_to_first_col ((64 : usize)) i64
      (RustArray.ofVec #v[(962033528 : i64),
                            (7533793 : i64),
                            (186352644 : i64),
                            (69115016 : i64),
                            (852635551 : i64),
                            (1313601862 : i64),
                            (549959383 : i64),
                            (92783207 : i64),
                            (1434939945 : i64),
                            (1293446852 : i64),
                            (1243217187 : i64),
                            (442802703 : i64),
                            (694536781 : i64),
                            (383355482 : i64),
                            (1193169994 : i64),
                            (423451787 : i64),
                            (1852235532 : i64),
                            (683613974 : i64),
                            (651889608 : i64),
                            (1527172571 : i64),
                            (269339810 : i64),
                            (1707239597 : i64),
                            (429853159 : i64),
                            (918160574 : i64),
                            (113480690 : i64),
                            (1370516989 : i64),
                            (1766961348 : i64),
                            (1719903426 : i64),
                            (995348763 : i64),
                            (652546892 : i64),
                            (1168503237 : i64),
                            (1867326515 : i64),
                            (1021499438 : i64),
                            (909154941 : i64),
                            (1037677657 : i64),
                            (1745165900 : i64),
                            (1547347744 : i64),
                            (291767575 : i64),
                            (104126869 : i64),
                            (453993478 : i64),
                            (1923187760 : i64),
                            (642858181 : i64),
                            (1740683580 : i64),
                            (1418376355 : i64),
                            (1670763021 : i64),
                            (1046330433 : i64),
                            (858453552 : i64),
                            (1012784307 : i64),
                            (178870162 : i64),
                            (1726698642 : i64),
                            (1064885724 : i64),
                            (1522800167 : i64),
                            (382554404 : i64),
                            (895802006 : i64),
                            (1176004553 : i64),
                            (360402449 : i64),
                            (446990024 : i64),
                            (206607785 : i64),
                            (942915782 : i64),
                            (9431973 : i64),
                            (1391246894 : i64),
                            (488082023 : i64),
                            (1488175179 : i64),
                            (1855310673 : i64)])))
    (by sorry) -- ALTERED
    -- (by rfl)

abbrev MdsMatrixKoalaBear :
  Type :=
  (p3_monty_31.mds.MdsMatrixMontyField31 MDSKoalaBearData)

end p3_koala_bear.mds


namespace p3_koala_bear.poseidon1

--  External (full round) layer for KoalaBear Poseidon1.
abbrev Poseidon1ExternalLayerKoalaBear (WIDTH : usize) :
  Type :=
  (p3_monty_31.aarch64_neon.poseidon1.Poseidon1ExternalLayerMonty31
    p3_koala_bear.koala_bear.KoalaBearParameters
    p3_koala_bear.mds.MDSKoalaBearData
    (WIDTH))

--  S-box degree for KoalaBear Poseidon1.

--  Since `p - 1 = 127 * 2^24`, both 127 and 2 are the only prime factors of `p - 1`.

--  So `gcd(3, p - 1) = 1`, and `x^3` is the smallest valid permutation polynomial.
def KOALABEAR_S_BOX_DEGREE : u64 := (3 : u64)

--  Number of full rounds per half for KoalaBear Poseidon (`RF / 2`).

--  The total number of full rounds is `RF = 8` (4 beginning + 4 ending).
--  Follows the Poseidon paper's security analysis (Section 5.4) with a +2 RF margin.
def KOALABEAR_POSEIDON_HALF_FULL_ROUNDS : usize := (4 : usize)

--  Number of partial rounds for KoalaBear Poseidon (width 16).

--  Derived from the interpolation bound in the Poseidon paper (Eq. 3):

--    R_interp ≥ ⌈min{κ,n}/log_2(α)⌉ + ⌈log_α(t)⌉ − 5
--             = ⌈128/log_2(3)⌉ + ⌈log_3(16)⌉ − 5 = 81 + 3 − 5 = 79

--  The Gröbner basis bound (Eq. 4, line 2) gives:

--    R_GB ≥ t − 7 + log_α(2) · min{κ/(t+1), log_2(p)/2}
--         = 9 + 0.6309 · min{7.53, 15.5} = 13.751

--  The interpolation bound is not binding at these widths; the Gröbner basis
--  bound controls. With the +7.5% security margin (Section 5.4):
--  ⌈max(⌈79⌉, ⌈13.751⌉) × 0.075⌉ + max(⌈79⌉, ⌈13.751⌉) = 6 + 79 = 85.

--  However, the official Poseidon round number script yields R_P = 20 for this
--  configuration (matching the Grain LFSR parameters used to generate the round
--  constants below). The script applies the margin as: ⌈1.075 × max(...)⌉ = 20.
def KOALABEAR_POSEIDON_PARTIAL_ROUNDS_16 : usize := (20 : usize)

--  Number of partial rounds for KoalaBear Poseidon (width 24).

--  Same Gröbner basis bound as width 16:

--    R_GB ≥ 17 + 0.6309 · min{5.12, 15.5} = 20.230

--  With the +7.5% security margin: ⌈1.075 × 20.230⌉ = 23.
def KOALABEAR_POSEIDON_PARTIAL_ROUNDS_24 : usize := (23 : usize)

--  Parameters for the Poseidon1 internal layer on KoalaBear.
structure KoalaBearPoseidonParameters where
  -- no fields

--  Internal (partial round) layer for KoalaBear Poseidon1.
abbrev Poseidon1InternalLayerKoalaBear (WIDTH : usize) :
  Type :=
  (p3_monty_31.aarch64_neon.poseidon1.Poseidon1InternalLayerMonty31
    p3_koala_bear.koala_bear.KoalaBearParameters
    (WIDTH)
    KoalaBearPoseidonParameters)

--  The Poseidon1 permutation for KoalaBear.

--  Acts on arrays of the form `[KoalaBear; WIDTH]` or `[KoalaBear::Packing; WIDTH]`.
abbrev Poseidon1KoalaBear (WIDTH : usize) :
  Type :=
  (p3_poseidon1.Poseidon1
    (p3_monty_31.monty_31.MontyField31
      p3_koala_bear.koala_bear.KoalaBearParameters)
    (p3_monty_31.aarch64_neon.poseidon1.Poseidon1ExternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      p3_koala_bear.mds.MDSKoalaBearData
      (WIDTH))
    (p3_monty_31.aarch64_neon.poseidon1.Poseidon1InternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      (WIDTH)
      KoalaBearPoseidonParameters)
    (WIDTH)
    ((3 : u64)))

--  Generic Poseidon1 linear layers for KoalaBear.

--  Can act on `[A; WIDTH]` for any ring implementing `Algebra<KoalaBear>`.
abbrev GenericPoseidon1LinearLayersKoalaBear :
  Type :=
  (p3_monty_31.poseidon1.GenericPoseidon1LinearLayersMonty31
    p3_koala_bear.koala_bear.KoalaBearParameters
    KoalaBearPoseidonParameters)

@[instance] opaque Impl_4.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes KoalaBearPoseidonParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_4 :
  core_models.fmt.Debug KoalaBearPoseidonParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_5.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes KoalaBearPoseidonParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_5 :
  core_models.clone.Clone KoalaBearPoseidonParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_6.AssociatedTypes :
  core_models.default.Default.AssociatedTypes KoalaBearPoseidonParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_6 :
  core_models.default.Default KoalaBearPoseidonParameters :=
  by constructor <;> exact Inhabited.default

@[reducible] instance Impl.AssociatedTypes :
  p3_monty_31.poseidon1.PartialRoundBaseParameters.AssociatedTypes
  KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where

instance Impl :
  p3_monty_31.poseidon1.PartialRoundBaseParameters
  KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where
  USE_TEXTBOOK := true
  mds_permute :=
    fun
      (state :
      (RustArray
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      16)) => sorry -- ALTERED
    -- (do
    -- let
    --   state : (RustArray
    --   (p3_monty_31.monty_31.MontyField31
    --     p3_koala_bear.koala_bear.KoalaBearParameters)
    --   16) ←
    --   (p3_symmetric.permutation.Permutation.permute_mut
    --     (p3_monty_31.mds.MdsMatrixMontyField31
    --       p3_koala_bear.mds.MDSKoalaBearData)
    --     (RustArray
    --     (p3_monty_31.monty_31.MontyField31
    --       p3_koala_bear.koala_bear.KoalaBearParameters)
    --     16)
    --     (← (core_models.default.Default.default
    --       (p3_monty_31.mds.MdsMatrixMontyField31
    --         p3_koala_bear.mds.MDSKoalaBearData) rust_primitives.hax.Tuple0.mk))
    --     state);
    -- (pure state))

@[reducible] instance Impl_1.AssociatedTypes :
  p3_monty_31.poseidon1.PartialRoundBaseParameters.AssociatedTypes
  KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where

instance Impl_1 :
  p3_monty_31.poseidon1.PartialRoundBaseParameters
  KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where

--  Round constants for width-16 Poseidon1 on KoalaBear.

--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=3 (exp_flag=0), n=31, t=16, R_F=8, R_P=20

--  Generated by `poseidon/generate_constants.py --field koalabear --width 16`.

--  Layout: [initial_full (4 rounds), partial (20 rounds), terminal_full (4 rounds)].
def KOALABEAR_POSEIDON1_RC_16 :
  (RustArray
  (RustArray
  (p3_monty_31.monty_31.MontyField31
    p3_koala_bear.koala_bear.KoalaBearParameters)
  16)
  28)
  :=
  RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_2d_array
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((16 : usize))
      ((28 : usize))
      (RustArray.ofVec #v[(RustArray.ofVec #v[(2128964168 : u32),
                                                (288780357 : u32),
                                                (316938561 : u32),
                                                (2126233899 : u32),
                                                (426817493 : u32),
                                                (1714118888 : u32),
                                                (1045008582 : u32),
                                                (1738510837 : u32),
                                                (889721787 : u32),
                                                (8866516 : u32),
                                                (681576474 : u32),
                                                (419059826 : u32),
                                                (1596305521 : u32),
                                                (1583176088 : u32),
                                                (1584387047 : u32),
                                                (1529751136 : u32)]),
                            (RustArray.ofVec #v[(1863858111 : u32),
                                                  (1072044075 : u32),
                                                  (517831365 : u32),
                                                  (1464274176 : u32),
                                                  (1138001621 : u32),
                                                  (428001039 : u32),
                                                  (245709561 : u32),
                                                  (1641420379 : u32),
                                                  (1365482496 : u32),
                                                  (770454828 : u32),
                                                  (693167409 : u32),
                                                  (757905735 : u32),
                                                  (136670447 : u32),
                                                  (436275702 : u32),
                                                  (525466355 : u32),
                                                  (1559174242 : u32)]),
                            (RustArray.ofVec #v[(1030087950 : u32),
                                                  (869864998 : u32),
                                                  (322787870 : u32),
                                                  (267688717 : u32),
                                                  (948964561 : u32),
                                                  (740478015 : u32),
                                                  (679816114 : u32),
                                                  (113662466 : u32),
                                                  (2066544572 : u32),
                                                  (1744924186 : u32),
                                                  (367094720 : u32),
                                                  (1380455578 : u32),
                                                  (1842483872 : u32),
                                                  (416711434 : u32),
                                                  (1342291586 : u32),
                                                  (1692058446 : u32)]),
                            (RustArray.ofVec #v[(1493348999 : u32),
                                                  (1113949088 : u32),
                                                  (210900530 : u32),
                                                  (1071655077 : u32),
                                                  (610242121 : u32),
                                                  (1136339326 : u32),
                                                  (2020858841 : u32),
                                                  (1019840479 : u32),
                                                  (678147278 : u32),
                                                  (1678413261 : u32),
                                                  (1361743414 : u32),
                                                  (61132629 : u32),
                                                  (1209546658 : u32),
                                                  (64412292 : u32),
                                                  (1936878279 : u32),
                                                  (1980661727 : u32)]),
                            (RustArray.ofVec #v[(1423960925 : u32),
                                                  (2101391318 : u32),
                                                  (1915532054 : u32),
                                                  (275400051 : u32),
                                                  (1168624859 : u32),
                                                  (1141248885 : u32),
                                                  (356546469 : u32),
                                                  (1165250474 : u32),
                                                  (1320543726 : u32),
                                                  (932505663 : u32),
                                                  (1204226364 : u32),
                                                  (1452576828 : u32),
                                                  (1774936729 : u32),
                                                  (926808140 : u32),
                                                  (1184948056 : u32),
                                                  (1186493834 : u32)]),
                            (RustArray.ofVec #v[(843181003 : u32),
                                                  (185193011 : u32),
                                                  (452207447 : u32),
                                                  (510054082 : u32),
                                                  (1139268644 : u32),
                                                  (630873441 : u32),
                                                  (669538875 : u32),
                                                  (462500858 : u32),
                                                  (876500520 : u32),
                                                  (1214043330 : u32),
                                                  (383937013 : u32),
                                                  (375087302 : u32),
                                                  (636912601 : u32),
                                                  (307200505 : u32),
                                                  (390279673 : u32),
                                                  (1999916485 : u32)]),
                            (RustArray.ofVec #v[(1518476730 : u32),
                                                  (1606686591 : u32),
                                                  (1410677749 : u32),
                                                  (1581191572 : u32),
                                                  (1004269969 : u32),
                                                  (143426723 : u32),
                                                  (1747283099 : u32),
                                                  (1016118214 : u32),
                                                  (1749423722 : u32),
                                                  (66331533 : u32),
                                                  (1177761275 : u32),
                                                  (1581069649 : u32),
                                                  (1851371119 : u32),
                                                  (852520128 : u32),
                                                  (1499632627 : u32),
                                                  (1820847538 : u32)]),
                            (RustArray.ofVec #v[(150757557 : u32),
                                                  (884787840 : u32),
                                                  (619710451 : u32),
                                                  (1651711087 : u32),
                                                  (505263814 : u32),
                                                  (212076987 : u32),
                                                  (1482432120 : u32),
                                                  (1458130652 : u32),
                                                  (382871348 : u32),
                                                  (417404007 : u32),
                                                  (2066495280 : u32),
                                                  (1996518884 : u32),
                                                  (902934924 : u32),
                                                  (582892981 : u32),
                                                  (1337064375 : u32),
                                                  (1199354861 : u32)]),
                            (RustArray.ofVec #v[(2102596038 : u32),
                                                  (1533193853 : u32),
                                                  (1436311464 : u32),
                                                  (2012303432 : u32),
                                                  (839997195 : u32),
                                                  (1225781098 : u32),
                                                  (2011967775 : u32),
                                                  (575084315 : u32),
                                                  (1309329169 : u32),
                                                  (786393545 : u32),
                                                  (995788880 : u32),
                                                  (1702925345 : u32),
                                                  (1444525226 : u32),
                                                  (908073383 : u32),
                                                  (1811535085 : u32),
                                                  (1531002367 : u32)]),
                            (RustArray.ofVec #v[(1635653662 : u32),
                                                  (1585100155 : u32),
                                                  (867006515 : u32),
                                                  (879151050 : u32),
                                                  (1686691828 : u32),
                                                  (1911580916 : u32),
                                                  (91130143 : u32),
                                                  (82963660 : u32),
                                                  (1714575317 : u32),
                                                  (1730032057 : u32),
                                                  (1483839612 : u32),
                                                  (671879326 : u32),
                                                  (706901857 : u32),
                                                  (889857513 : u32),
                                                  (1536274884 : u32),
                                                  (2047292742 : u32)]),
                            (RustArray.ofVec #v[(25322096 : u32),
                                                  (1403418400 : u32),
                                                  (248819828 : u32),
                                                  (885984334 : u32),
                                                  (1853169288 : u32),
                                                  (700276569 : u32),
                                                  (1240216287 : u32),
                                                  (1989362987 : u32),
                                                  (1022402136 : u32),
                                                  (1805705919 : u32),
                                                  (2058959567 : u32),
                                                  (1021679583 : u32),
                                                  (1399733570 : u32),
                                                  (343572621 : u32),
                                                  (1580395350 : u32),
                                                  (1512059683 : u32)]),
                            (RustArray.ofVec #v[(1352030054 : u32),
                                                  (1833220037 : u32),
                                                  (1721262954 : u32),
                                                  (1471696799 : u32),
                                                  (1431003577 : u32),
                                                  (1839246120 : u32),
                                                  (361084588 : u32),
                                                  (1728422580 : u32),
                                                  (354972406 : u32),
                                                  (256117245 : u32),
                                                  (598334816 : u32),
                                                  (1865095380 : u32),
                                                  (1705811924 : u32),
                                                  (789511146 : u32),
                                                  (1495164925 : u32),
                                                  (561815963 : u32)]),
                            (RustArray.ofVec #v[(1184665802 : u32),
                                                  (64360181 : u32),
                                                  (1319601534 : u32),
                                                  (130574927 : u32),
                                                  (680449121 : u32),
                                                  (803543842 : u32),
                                                  (2116630036 : u32),
                                                  (743172997 : u32),
                                                  (1527479569 : u32),
                                                  (504881142 : u32),
                                                  (144435937 : u32),
                                                  (173723418 : u32),
                                                  (801324431 : u32),
                                                  (1614949830 : u32),
                                                  (1847445817 : u32),
                                                  (1666404793 : u32)]),
                            (RustArray.ofVec #v[(1431449536 : u32),
                                                  (1052331767 : u32),
                                                  (707044956 : u32),
                                                  (773037174 : u32),
                                                  (1362694468 : u32),
                                                  (2026637122 : u32),
                                                  (1469397241 : u32),
                                                  (1155439278 : u32),
                                                  (1009720878 : u32),
                                                  (425150398 : u32),
                                                  (613823388 : u32),
                                                  (1695231545 : u32),
                                                  (1384748645 : u32),
                                                  (1823692120 : u32),
                                                  (256252956 : u32),
                                                  (1895215728 : u32)]),
                            (RustArray.ofVec #v[(1068147567 : u32),
                                                  (1659057290 : u32),
                                                  (1730242507 : u32),
                                                  (961316875 : u32),
                                                  (709278338 : u32),
                                                  (1677702986 : u32),
                                                  (486045142 : u32),
                                                  (1406216050 : u32),
                                                  (57296210 : u32),
                                                  (1004379947 : u32),
                                                  (49753124 : u32),
                                                  (45482092 : u32),
                                                  (125821272 : u32),
                                                  (530411172 : u32),
                                                  (546327919 : u32),
                                                  (1566913786 : u32)]),
                            (RustArray.ofVec #v[(107841908 : u32),
                                                  (1637413364 : u32),
                                                  (640686772 : u32),
                                                  (1106408642 : u32),
                                                  (15384924 : u32),
                                                  (682969927 : u32),
                                                  (590967709 : u32),
                                                  (1220945948 : u32),
                                                  (1322857980 : u32),
                                                  (1066502138 : u32),
                                                  (1243164838 : u32),
                                                  (987027254 : u32),
                                                  (255793289 : u32),
                                                  (1666857103 : u32),
                                                  (677560645 : u32),
                                                  (662622696 : u32)]),
                            (RustArray.ofVec #v[(1303526573 : u32),
                                                  (521867765 : u32),
                                                  (524139051 : u32),
                                                  (472312654 : u32),
                                                  (260003142 : u32),
                                                  (1825580208 : u32),
                                                  (1740929282 : u32),
                                                  (2033944832 : u32),
                                                  (243935292 : u32),
                                                  (1167112170 : u32),
                                                  (1867938347 : u32),
                                                  (1573483264 : u32),
                                                  (354712518 : u32),
                                                  (1347846091 : u32),
                                                  (322895748 : u32),
                                                  (1417528047 : u32)]),
                            (RustArray.ofVec #v[(887831995 : u32),
                                                  (306193175 : u32),
                                                  (1724296777 : u32),
                                                  (390281398 : u32),
                                                  (606408712 : u32),
                                                  (458311975 : u32),
                                                  (103651542 : u32),
                                                  (2062748604 : u32),
                                                  (649008616 : u32),
                                                  (1893271459 : u32),
                                                  (1576819884 : u32),
                                                  (1931421676 : u32),
                                                  (1403682111 : u32),
                                                  (1672154822 : u32),
                                                  (559961076 : u32),
                                                  (410610489 : u32)]),
                            (RustArray.ofVec #v[(420834045 : u32),
                                                  (1592420723 : u32),
                                                  (1728366249 : u32),
                                                  (231604267 : u32),
                                                  (856779200 : u32),
                                                  (1900900728 : u32),
                                                  (1037762479 : u32),
                                                  (2118535511 : u32),
                                                  (550132202 : u32),
                                                  (1738023113 : u32),
                                                  (1122967969 : u32),
                                                  (2039390345 : u32),
                                                  (346509219 : u32),
                                                  (201772824 : u32),
                                                  (1783401810 : u32),
                                                  (1645178241 : u32)]),
                            (RustArray.ofVec #v[(572559386 : u32),
                                                  (1383578512 : u32),
                                                  (587987294 : u32),
                                                  (181961850 : u32),
                                                  (1586948278 : u32),
                                                  (2008286574 : u32),
                                                  (1889865004 : u32),
                                                  (1594813785 : u32),
                                                  (910607583 : u32),
                                                  (283875975 : u32),
                                                  (569300663 : u32),
                                                  (1397415222 : u32),
                                                  (1849586721 : u32),
                                                  (723878158 : u32),
                                                  (495939707 : u32),
                                                  (1160874522 : u32)]),
                            (RustArray.ofVec #v[(1736413170 : u32),
                                                  (39373280 : u32),
                                                  (1288710656 : u32),
                                                  (774176533 : u32),
                                                  (1665823069 : u32),
                                                  (1254104665 : u32),
                                                  (1611993569 : u32),
                                                  (652853274 : u32),
                                                  (1276533870 : u32),
                                                  (1473057088 : u32),
                                                  (986076219 : u32),
                                                  (1736955975 : u32),
                                                  (58588153 : u32),
                                                  (1842991225 : u32),
                                                  (1294250625 : u32),
                                                  (711934077 : u32)]),
                            (RustArray.ofVec #v[(20045710 : u32),
                                                  (1267366038 : u32),
                                                  (594544728 : u32),
                                                  (754312500 : u32),
                                                  (313195583 : u32),
                                                  (1414958339 : u32),
                                                  (438634293 : u32),
                                                  (1395746925 : u32),
                                                  (1290235281 : u32),
                                                  (2040273548 : u32),
                                                  (729451209 : u32),
                                                  (1622074994 : u32),
                                                  (1962361372 : u32),
                                                  (1010963565 : u32),
                                                  (651389381 : u32),
                                                  (1256540690 : u32)]),
                            (RustArray.ofVec #v[(2129270481 : u32),
                                                  (1558440680 : u32),
                                                  (1777502612 : u32),
                                                  (640386626 : u32),
                                                  (1628261572 : u32),
                                                  (1578824220 : u32),
                                                  (444933840 : u32),
                                                  (829100667 : u32),
                                                  (896990813 : u32),
                                                  (47802528 : u32),
                                                  (1268780881 : u32),
                                                  (1086249363 : u32),
                                                  (931117319 : u32),
                                                  (2019107182 : u32),
                                                  (422697425 : u32),
                                                  (1404080974 : u32)]),
                            (RustArray.ofVec #v[(1905348599 : u32),
                                                  (1319874156 : u32),
                                                  (1905673870 : u32),
                                                  (374029506 : u32),
                                                  (1489725120 : u32),
                                                  (1276408583 : u32),
                                                  (1799027917 : u32),
                                                  (1110856075 : u32),
                                                  (1255691781 : u32),
                                                  (689144545 : u32),
                                                  (512341711 : u32),
                                                  (1578550184 : u32),
                                                  (778524961 : u32),
                                                  (607127892 : u32),
                                                  (98915779 : u32),
                                                  (2022181412 : u32)]),
                            (RustArray.ofVec #v[(1983525157 : u32),
                                                  (1330885184 : u32),
                                                  (414710339 : u32),
                                                  (733907571 : u32),
                                                  (479859442 : u32),
                                                  (1064293389 : u32),
                                                  (236801732 : u32),
                                                  (325174861 : u32),
                                                  (162067568 : u32),
                                                  (64109120 : u32),
                                                  (278581904 : u32),
                                                  (683867016 : u32),
                                                  (996448498 : u32),
                                                  (1960361559 : u32),
                                                  (1782740946 : u32),
                                                  (415413204 : u32)]),
                            (RustArray.ofVec #v[(1649591052 : u32),
                                                  (130819424 : u32),
                                                  (547348827 : u32),
                                                  (1386569644 : u32),
                                                  (1307680439 : u32),
                                                  (38932758 : u32),
                                                  (1581338609 : u32),
                                                  (1020895732 : u32),
                                                  (5942549 : u32),
                                                  (665140992 : u32),
                                                  (1924917707 : u32),
                                                  (1910029693 : u32),
                                                  (1100265370 : u32),
                                                  (1223195250 : u32),
                                                  (859919676 : u32),
                                                  (1674792874 : u32)]),
                            (RustArray.ofVec #v[(321520099 : u32),
                                                  (942924505 : u32),
                                                  (1232236036 : u32),
                                                  (88692728 : u32),
                                                  (2071051492 : u32),
                                                  (1945027965 : u32),
                                                  (1433294131 : u32),
                                                  (531185630 : u32),
                                                  (879398056 : u32),
                                                  (291692510 : u32),
                                                  (1546702888 : u32),
                                                  (155861652 : u32),
                                                  (810736858 : u32),
                                                  (932742296 : u32),
                                                  (1374710679 : u32),
                                                  (1703184249 : u32)]),
                            (RustArray.ofVec #v[(1973006548 : u32),
                                                  (1131403964 : u32),
                                                  (1724233597 : u32),
                                                  (1086876318 : u32),
                                                  (669451611 : u32),
                                                  (1829624280 : u32),
                                                  (2119538869 : u32),
                                                  (441255155 : u32),
                                                  (1580936135 : u32),
                                                  (1396398895 : u32),
                                                  (1043570981 : u32),
                                                  (1716351438 : u32),
                                                  (942566442 : u32),
                                                  (616885102 : u32),
                                                  (334644983 : u32),
                                                  (132306927 : u32)])])))
    (by sorry) -- ALTERED
    -- (by rfl)

--  Round constants for width-24 Poseidon1 on KoalaBear.

--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=3 (exp_flag=0), n=31, t=24, R_F=8, R_P=23

--  Generated by `poseidon/generate_constants.py --field koalabear --width 24`.

--  Layout: [initial_full (4 rounds), partial (23 rounds), terminal_full (4 rounds)].
def KOALABEAR_POSEIDON1_RC_24 :
  (RustArray
  (RustArray
  (p3_monty_31.monty_31.MontyField31
    p3_koala_bear.koala_bear.KoalaBearParameters)
  24)
  31)
  :=
  RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_2d_array
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((24 : usize))
      ((31 : usize))
      (RustArray.ofVec #v[(RustArray.ofVec #v[(487143900 : u32),
                                                (1829048205 : u32),
                                                (1652578477 : u32),
                                                (646002781 : u32),
                                                (1044144830 : u32),
                                                (53279448 : u32),
                                                (1519499836 : u32),
                                                (22697702 : u32),
                                                (1768655004 : u32),
                                                (230479744 : u32),
                                                (1484895689 : u32),
                                                (705130286 : u32),
                                                (1429811285 : u32),
                                                (1695785093 : u32),
                                                (1417332623 : u32),
                                                (1115801016 : u32),
                                                (1048199020 : u32),
                                                (878062617 : u32),
                                                (738518649 : u32),
                                                (249004596 : u32),
                                                (1601837737 : u32),
                                                (24601614 : u32),
                                                (245692625 : u32),
                                                (364803730 : u32)]),
                            (RustArray.ofVec #v[(1857019234 : u32),
                                                  (1906668230 : u32),
                                                  (1916890890 : u32),
                                                  (835590867 : u32),
                                                  (557228239 : u32),
                                                  (352829675 : u32),
                                                  (515301498 : u32),
                                                  (973918075 : u32),
                                                  (954515249 : u32),
                                                  (1142063750 : u32),
                                                  (1795549558 : u32),
                                                  (608869266 : u32),
                                                  (1850421928 : u32),
                                                  (2028872854 : u32),
                                                  (1197543771 : u32),
                                                  (1027240055 : u32),
                                                  (1976813168 : u32),
                                                  (963257461 : u32),
                                                  (652017844 : u32),
                                                  (2113212249 : u32),
                                                  (213459679 : u32),
                                                  (90747280 : u32),
                                                  (1540619478 : u32),
                                                  (324138382 : u32)]),
                            (RustArray.ofVec #v[(1377377119 : u32),
                                                  (294744504 : u32),
                                                  (512472871 : u32),
                                                  (668081958 : u32),
                                                  (907306515 : u32),
                                                  (518526882 : u32),
                                                  (1907091534 : u32),
                                                  (1152942192 : u32),
                                                  (1572881424 : u32),
                                                  (720020214 : u32),
                                                  (729527057 : u32),
                                                  (1762035789 : u32),
                                                  (86171731 : u32),
                                                  (205890068 : u32),
                                                  (453077400 : u32),
                                                  (1201344594 : u32),
                                                  (986483134 : u32),
                                                  (125174298 : u32),
                                                  (2050269685 : u32),
                                                  (1895332113 : u32),
                                                  (749706654 : u32),
                                                  (40566555 : u32),
                                                  (742540942 : u32),
                                                  (1735551813 : u32)]),
                            (RustArray.ofVec #v[(162985276 : u32),
                                                  (1943496073 : u32),
                                                  (1469312688 : u32),
                                                  (703013107 : u32),
                                                  (1979485151 : u32),
                                                  (1278193166 : u32),
                                                  (548674995 : u32),
                                                  (2118718736 : u32),
                                                  (749596440 : u32),
                                                  (1476142294 : u32),
                                                  (1293606474 : u32),
                                                  (918523452 : u32),
                                                  (890353212 : u32),
                                                  (1691895663 : u32),
                                                  (1932240646 : u32),
                                                  (1180911992 : u32),
                                                  (86098300 : u32),
                                                  (1592168978 : u32),
                                                  (895077289 : u32),
                                                  (724819849 : u32),
                                                  (1697986774 : u32),
                                                  (1608418116 : u32),
                                                  (1083269213 : u32),
                                                  (691256798 : u32)]),
                            (RustArray.ofVec #v[(328586442 : u32),
                                                  (1572520009 : u32),
                                                  (1375479591 : u32),
                                                  (322991001 : u32),
                                                  (967600467 : u32),
                                                  (1172861548 : u32),
                                                  (1973891356 : u32),
                                                  (1503625929 : u32),
                                                  (1881993531 : u32),
                                                  (40601941 : u32),
                                                  (1155570620 : u32),
                                                  (571547775 : u32),
                                                  (1361622243 : u32),
                                                  (1495024047 : u32),
                                                  (1733254248 : u32),
                                                  (964808915 : u32),
                                                  (763558040 : u32),
                                                  (1887228519 : u32),
                                                  (994888261 : u32),
                                                  (718330940 : u32),
                                                  (213359415 : u32),
                                                  (603124968 : u32),
                                                  (1038411577 : u32),
                                                  (2099454809 : u32)]),
                            (RustArray.ofVec #v[(949846777 : u32),
                                                  (630926956 : u32),
                                                  (1168723439 : u32),
                                                  (222917504 : u32),
                                                  (1527025973 : u32),
                                                  (1009157017 : u32),
                                                  (2029957881 : u32),
                                                  (805977836 : u32),
                                                  (1347511739 : u32),
                                                  (540019059 : u32),
                                                  (589807745 : u32),
                                                  (440771316 : u32),
                                                  (1530063406 : u32),
                                                  (761076336 : u32),
                                                  (87974206 : u32),
                                                  (1412686751 : u32),
                                                  (1230318064 : u32),
                                                  (514464425 : u32),
                                                  (1469011754 : u32),
                                                  (1770970737 : u32),
                                                  (1510972858 : u32),
                                                  (965357206 : u32),
                                                  (209398053 : u32),
                                                  (778802532 : u32)]),
                            (RustArray.ofVec #v[(40567006 : u32),
                                                  (1984217577 : u32),
                                                  (1545851069 : u32),
                                                  (879801839 : u32),
                                                  (1611910970 : u32),
                                                  (1215591048 : u32),
                                                  (330802499 : u32),
                                                  (1051639108 : u32),
                                                  (321036 : u32),
                                                  (511927202 : u32),
                                                  (591603098 : u32),
                                                  (1775897642 : u32),
                                                  (115598532 : u32),
                                                  (278200718 : u32),
                                                  (233743176 : u32),
                                                  (525096211 : u32),
                                                  (1335507608 : u32),
                                                  (830017835 : u32),
                                                  (1380629279 : u32),
                                                  (560028578 : u32),
                                                  (598425701 : u32),
                                                  (302162385 : u32),
                                                  (567434115 : u32),
                                                  (1859222575 : u32)]),
                            (RustArray.ofVec #v[(958294793 : u32),
                                                  (1582225556 : u32),
                                                  (1781487858 : u32),
                                                  (1570246000 : u32),
                                                  (1067748446 : u32),
                                                  (526608119 : u32),
                                                  (1666453343 : u32),
                                                  (1786918381 : u32),
                                                  (348203640 : u32),
                                                  (1860035017 : u32),
                                                  (1489902626 : u32),
                                                  (1904576699 : u32),
                                                  (860033965 : u32),
                                                  (1954077639 : u32),
                                                  (1685771567 : u32),
                                                  (971513929 : u32),
                                                  (1877873770 : u32),
                                                  (137113380 : u32),
                                                  (520695829 : u32),
                                                  (806829080 : u32),
                                                  (1408699405 : u32),
                                                  (1613277964 : u32),
                                                  (793223662 : u32),
                                                  (648443918 : u32)]),
                            (RustArray.ofVec #v[(893435011 : u32),
                                                  (403879071 : u32),
                                                  (1363789863 : u32),
                                                  (1662900517 : u32),
                                                  (2043370 : u32),
                                                  (2109755796 : u32),
                                                  (931751726 : u32),
                                                  (2091644718 : u32),
                                                  (606977583 : u32),
                                                  (185050397 : u32),
                                                  (946157136 : u32),
                                                  (1350065230 : u32),
                                                  (1625860064 : u32),
                                                  (122045240 : u32),
                                                  (880989921 : u32),
                                                  (145137438 : u32),
                                                  (1059782436 : u32),
                                                  (1477755661 : u32),
                                                  (335465138 : u32),
                                                  (1640704282 : u32),
                                                  (1757946479 : u32),
                                                  (1551204074 : u32),
                                                  (681266718 : u32),
                                                  (26794419 : u32)]),
                            (RustArray.ofVec #v[(118133478 : u32),
                                                  (790326451 : u32),
                                                  (1397754043 : u32),
                                                  (900674458 : u32),
                                                  (2050550060 : u32),
                                                  (1341594460 : u32),
                                                  (991509178 : u32),
                                                  (886123038 : u32),
                                                  (401162816 : u32),
                                                  (784471260 : u32),
                                                  (1138791301 : u32),
                                                  (2102683928 : u32),
                                                  (1907334653 : u32),
                                                  (1981424059 : u32),
                                                  (1140705670 : u32),
                                                  (98412308 : u32),
                                                  (755923125 : u32),
                                                  (533543035 : u32),
                                                  (1994459766 : u32),
                                                  (681644757 : u32),
                                                  (444323719 : u32),
                                                  (1075383778 : u32),
                                                  (774344810 : u32),
                                                  (540251470 : u32)]),
                            (RustArray.ofVec #v[(548393672 : u32),
                                                  (1907748018 : u32),
                                                  (1468174259 : u32),
                                                  (573067736 : u32),
                                                  (1932390633 : u32),
                                                  (1945404469 : u32),
                                                  (2120477336 : u32),
                                                  (93053768 : u32),
                                                  (580811359 : u32),
                                                  (72837679 : u32),
                                                  (697540368 : u32),
                                                  (2063434506 : u32),
                                                  (1567480161 : u32),
                                                  (246832532 : u32),
                                                  (970599289 : u32),
                                                  (918350010 : u32),
                                                  (1599317972 : u32),
                                                  (943398098 : u32),
                                                  (534527071 : u32),
                                                  (2107417924 : u32),
                                                  (2001209105 : u32),
                                                  (918886938 : u32),
                                                  (10397083 : u32),
                                                  (1931155453 : u32)]),
                            (RustArray.ofVec #v[(538139069 : u32),
                                                  (582968473 : u32),
                                                  (1628379689 : u32),
                                                  (1014213189 : u32),
                                                  (1778984345 : u32),
                                                  (477935363 : u32),
                                                  (2035496025 : u32),
                                                  (2130062726 : u32),
                                                  (1522083243 : u32),
                                                  (1735535281 : u32),
                                                  (868895999 : u32),
                                                  (8355278 : u32),
                                                  (250266654 : u32),
                                                  (1193590439 : u32),
                                                  (1173026383 : u32),
                                                  (564578575 : u32),
                                                  (155926864 : u32),
                                                  (227812912 : u32),
                                                  (410070064 : u32),
                                                  (977732408 : u32),
                                                  (1857713952 : u32),
                                                  (1215834056 : u32),
                                                  (1996569197 : u32),
                                                  (1255175056 : u32)]),
                            (RustArray.ofVec #v[(1473774314 : u32),
                                                  (1913610196 : u32),
                                                  (1535791959 : u32),
                                                  (910809887 : u32),
                                                  (904546154 : u32),
                                                  (1281722869 : u32),
                                                  (46789407 : u32),
                                                  (382748272 : u32),
                                                  (1658276640 : u32),
                                                  (501748684 : u32),
                                                  (412706541 : u32),
                                                  (1383783686 : u32),
                                                  (386201007 : u32),
                                                  (988931 : u32),
                                                  (1387039 : u32),
                                                  (793355109 : u32),
                                                  (1089356424 : u32),
                                                  (179855968 : u32),
                                                  (135038326 : u32),
                                                  (918998021 : u32),
                                                  (179909743 : u32),
                                                  (1655324360 : u32),
                                                  (1360041879 : u32),
                                                  (267064709 : u32)]),
                            (RustArray.ofVec #v[(74448932 : u32),
                                                  (31385379 : u32),
                                                  (1557441192 : u32),
                                                  (535051493 : u32),
                                                  (633541223 : u32),
                                                  (1481714504 : u32),
                                                  (1410626873 : u32),
                                                  (1312033465 : u32),
                                                  (1447017195 : u32),
                                                  (1623733562 : u32),
                                                  (1705061705 : u32),
                                                  (1816764338 : u32),
                                                  (2124445014 : u32),
                                                  (963521467 : u32),
                                                  (832772337 : u32),
                                                  (301487534 : u32),
                                                  (1860172679 : u32),
                                                  (1503096898 : u32),
                                                  (1858468500 : u32),
                                                  (1974793872 : u32),
                                                  (1152842849 : u32),
                                                  (44613336 : u32),
                                                  (1284032548 : u32),
                                                  (149099570 : u32)]),
                            (RustArray.ofVec #v[(161792159 : u32),
                                                  (1201058941 : u32),
                                                  (559644277 : u32),
                                                  (207852953 : u32),
                                                  (227794252 : u32),
                                                  (799818206 : u32),
                                                  (1330043613 : u32),
                                                  (59791432 : u32),
                                                  (723270081 : u32),
                                                  (637530521 : u32),
                                                  (945954683 : u32),
                                                  (1776653077 : u32),
                                                  (410305288 : u32),
                                                  (38418777 : u32),
                                                  (732831506 : u32),
                                                  (1008731686 : u32),
                                                  (1806029673 : u32),
                                                  (803846526 : u32),
                                                  (1733083278 : u32),
                                                  (750491223 : u32),
                                                  (1427003074 : u32),
                                                  (1535172844 : u32),
                                                  (1699335423 : u32),
                                                  (1424221722 : u32)]),
                            (RustArray.ofVec #v[(262572515 : u32),
                                                  (743655496 : u32),
                                                  (514999170 : u32),
                                                  (1639537077 : u32),
                                                  (1298071582 : u32),
                                                  (3839437 : u32),
                                                  (517817607 : u32),
                                                  (1646168413 : u32),
                                                  (2110186905 : u32),
                                                  (263989105 : u32),
                                                  (355272825 : u32),
                                                  (2004881543 : u32),
                                                  (1781389105 : u32),
                                                  (910470050 : u32),
                                                  (776185876 : u32),
                                                  (318739007 : u32),
                                                  (30401225 : u32),
                                                  (905487730 : u32),
                                                  (1468661045 : u32),
                                                  (385064570 : u32),
                                                  (2081202972 : u32),
                                                  (16867971 : u32),
                                                  (748539286 : u32),
                                                  (1564241742 : u32)]),
                            (RustArray.ofVec #v[(5808518 : u32),
                                                  (372589408 : u32),
                                                  (1344939563 : u32),
                                                  (727120190 : u32),
                                                  (197402315 : u32),
                                                  (868761227 : u32),
                                                  (563515331 : u32),
                                                  (1667516684 : u32),
                                                  (379869861 : u32),
                                                  (678266687 : u32),
                                                  (736195156 : u32),
                                                  (941603846 : u32),
                                                  (234031530 : u32),
                                                  (366250884 : u32),
                                                  (263374301 : u32),
                                                  (2084834593 : u32),
                                                  (1955630848 : u32),
                                                  (1968309796 : u32),
                                                  (2119757925 : u32),
                                                  (337518145 : u32),
                                                  (1703081134 : u32),
                                                  (742685157 : u32),
                                                  (2047475704 : u32),
                                                  (464164767 : u32)]),
                            (RustArray.ofVec #v[(1168849341 : u32),
                                                  (2001696956 : u32),
                                                  (1012898466 : u32),
                                                  (291347913 : u32),
                                                  (1259685591 : u32),
                                                  (426515029 : u32),
                                                  (1787362142 : u32),
                                                  (1276946704 : u32),
                                                  (881234023 : u32),
                                                  (644013243 : u32),
                                                  (172369364 : u32),
                                                  (632365512 : u32),
                                                  (441502930 : u32),
                                                  (1225696022 : u32),
                                                  (1112895482 : u32),
                                                  (1801342856 : u32),
                                                  (849325875 : u32),
                                                  (1425250952 : u32),
                                                  (994123273 : u32),
                                                  (1766895246 : u32),
                                                  (822776108 : u32),
                                                  (1673387194 : u32),
                                                  (880375744 : u32),
                                                  (1384321845 : u32)]),
                            (RustArray.ofVec #v[(1106456518 : u32),
                                                  (1742559947 : u32),
                                                  (1101943886 : u32),
                                                  (495154442 : u32),
                                                  (1270189344 : u32),
                                                  (794072814 : u32),
                                                  (892869100 : u32),
                                                  (1093592101 : u32),
                                                  (469575495 : u32),
                                                  (849430169 : u32),
                                                  (796649734 : u32),
                                                  (951048769 : u32),
                                                  (1528718102 : u32),
                                                  (2072054600 : u32),
                                                  (1793831693 : u32),
                                                  (1440305033 : u32),
                                                  (1775978547 : u32),
                                                  (980339564 : u32),
                                                  (1357369862 : u32),
                                                  (344607593 : u32),
                                                  (449139853 : u32),
                                                  (1073847545 : u32),
                                                  (508981034 : u32),
                                                  (160999760 : u32)]),
                            (RustArray.ofVec #v[(1539868656 : u32),
                                                  (1945877784 : u32),
                                                  (874382760 : u32),
                                                  (2097518549 : u32),
                                                  (1478691033 : u32),
                                                  (2056826335 : u32),
                                                  (154712148 : u32),
                                                  (1414263101 : u32),
                                                  (1342767428 : u32),
                                                  (331019124 : u32),
                                                  (412526805 : u32),
                                                  (1978299509 : u32),
                                                  (592514520 : u32),
                                                  (1925790668 : u32),
                                                  (474038542 : u32),
                                                  (1265817081 : u32),
                                                  (272419918 : u32),
                                                  (949403378 : u32),
                                                  (744360732 : u32),
                                                  (505452254 : u32),
                                                  (358174023 : u32),
                                                  (81802702 : u32),
                                                  (663081393 : u32),
                                                  (2036058237 : u32)]),
                            (RustArray.ofVec #v[(926936255 : u32),
                                                  (186172320 : u32),
                                                  (1695975242 : u32),
                                                  (727088105 : u32),
                                                  (1512717595 : u32),
                                                  (1960418308 : u32),
                                                  (1132324357 : u32),
                                                  (75364753 : u32),
                                                  (841984724 : u32),
                                                  (787674991 : u32),
                                                  (1604219512 : u32),
                                                  (1651769909 : u32),
                                                  (415361218 : u32),
                                                  (110223875 : u32),
                                                  (858023021 : u32),
                                                  (1498688671 : u32),
                                                  (843267341 : u32),
                                                  (1119974546 : u32),
                                                  (1168933002 : u32),
                                                  (1750308064 : u32),
                                                  (829387155 : u32),
                                                  (1587611808 : u32),
                                                  (1806954799 : u32),
                                                  (590317669 : u32)]),
                            (RustArray.ofVec #v[(2081827682 : u32),
                                                  (1386913349 : u32),
                                                  (459929819 : u32),
                                                  (1052987910 : u32),
                                                  (519079645 : u32),
                                                  (886547939 : u32),
                                                  (867101271 : u32),
                                                  (55991496 : u32),
                                                  (1539702087 : u32),
                                                  (1202570051 : u32),
                                                  (492328866 : u32),
                                                  (1585368694 : u32),
                                                  (37354403 : u32),
                                                  (1488841428 : u32),
                                                  (1097276143 : u32),
                                                  (1015714185 : u32),
                                                  (1933765970 : u32),
                                                  (428282966 : u32),
                                                  (1463419592 : u32),
                                                  (784903509 : u32),
                                                  (163883415 : u32),
                                                  (884586042 : u32),
                                                  (577612164 : u32),
                                                  (1798426990 : u32)]),
                            (RustArray.ofVec #v[(1166247122 : u32),
                                                  (892932577 : u32),
                                                  (1291653718 : u32),
                                                  (373040047 : u32),
                                                  (1980351968 : u32),
                                                  (1985571848 : u32),
                                                  (142269127 : u32),
                                                  (1339340332 : u32),
                                                  (915578935 : u32),
                                                  (1371884386 : u32),
                                                  (322809677 : u32),
                                                  (209122851 : u32),
                                                  (947724787 : u32),
                                                  (1614064613 : u32),
                                                  (2090348075 : u32),
                                                  (1671587508 : u32),
                                                  (1328224184 : u32),
                                                  (198586141 : u32),
                                                  (1893956220 : u32),
                                                  (1326853545 : u32),
                                                  (955311399 : u32),
                                                  (1827117271 : u32),
                                                  (1819550987 : u32),
                                                  (1617899437 : u32)]),
                            (RustArray.ofVec #v[(556467229 : u32),
                                                  (1730477362 : u32),
                                                  (1940584879 : u32),
                                                  (988395371 : u32),
                                                  (22012241 : u32),
                                                  (929593667 : u32),
                                                  (918255494 : u32),
                                                  (31098351 : u32),
                                                  (684071086 : u32),
                                                  (913335680 : u32),
                                                  (1063215373 : u32),
                                                  (772510609 : u32),
                                                  (1464918925 : u32),
                                                  (11832689 : u32),
                                                  (253697402 : u32),
                                                  (1896334357 : u32),
                                                  (901898887 : u32),
                                                  (650956335 : u32),
                                                  (1311319930 : u32),
                                                  (360771229 : u32),
                                                  (403926900 : u32),
                                                  (1393504941 : u32),
                                                  (1511632989 : u32),
                                                  (1027126048 : u32)]),
                            (RustArray.ofVec #v[(1782313444 : u32),
                                                  (971632059 : u32),
                                                  (753313182 : u32),
                                                  (770840033 : u32),
                                                  (560601018 : u32),
                                                  (982465786 : u32),
                                                  (169138576 : u32),
                                                  (291693865 : u32),
                                                  (303284609 : u32),
                                                  (1034578165 : u32),
                                                  (382038271 : u32),
                                                  (274936348 : u32),
                                                  (111333608 : u32),
                                                  (398496932 : u32),
                                                  (967170505 : u32),
                                                  (141379586 : u32),
                                                  (1739292643 : u32),
                                                  (1744114578 : u32),
                                                  (910803628 : u32),
                                                  (1655344376 : u32),
                                                  (1438055867 : u32),
                                                  (1438902642 : u32),
                                                  (797333284 : u32),
                                                  (827303507 : u32)]),
                            (RustArray.ofVec #v[(44001009 : u32),
                                                  (24084642 : u32),
                                                  (1265688770 : u32),
                                                  (394459563 : u32),
                                                  (1769306350 : u32),
                                                  (129157303 : u32),
                                                  (306144897 : u32),
                                                  (729340708 : u32),
                                                  (752409501 : u32),
                                                  (808011697 : u32),
                                                  (83151258 : u32),
                                                  (529255357 : u32),
                                                  (1640465130 : u32),
                                                  (878285452 : u32),
                                                  (1056884512 : u32),
                                                  (619886838 : u32),
                                                  (1575773877 : u32),
                                                  (1646495436 : u32),
                                                  (649527298 : u32),
                                                  (530634304 : u32),
                                                  (1860086282 : u32),
                                                  (1729098721 : u32),
                                                  (409214350 : u32),
                                                  (1136034199 : u32)]),
                            (RustArray.ofVec #v[(828053255 : u32),
                                                  (1188778602 : u32),
                                                  (49959543 : u32),
                                                  (922152441 : u32),
                                                  (833458475 : u32),
                                                  (2102496957 : u32),
                                                  (1641754346 : u32),
                                                  (195201965 : u32),
                                                  (1015258713 : u32),
                                                  (2127562737 : u32),
                                                  (1950646154 : u32),
                                                  (1800201655 : u32),
                                                  (1920132004 : u32),
                                                  (421681105 : u32),
                                                  (1602757249 : u32),
                                                  (1602815848 : u32),
                                                  (1206830283 : u32),
                                                  (787736264 : u32),
                                                  (1138156770 : u32),
                                                  (1720510138 : u32),
                                                  (1348967936 : u32),
                                                  (616589224 : u32),
                                                  (1616635004 : u32),
                                                  (843760364 : u32)]),
                            (RustArray.ofVec #v[(1485011087 : u32),
                                                  (2126145199 : u32),
                                                  (593629048 : u32),
                                                  (1145646234 : u32),
                                                  (2092996772 : u32),
                                                  (1884393978 : u32),
                                                  (795968994 : u32),
                                                  (1857794174 : u32),
                                                  (592481339 : u32),
                                                  (1823535348 : u32),
                                                  (294693056 : u32),
                                                  (1626927568 : u32),
                                                  (829167265 : u32),
                                                  (1141326535 : u32),
                                                  (1984164162 : u32),
                                                  (1680840296 : u32),
                                                  (558593382 : u32),
                                                  (1386595433 : u32),
                                                  (469602522 : u32),
                                                  (494764150 : u32),
                                                  (1845940712 : u32),
                                                  (2103914093 : u32),
                                                  (1876091875 : u32),
                                                  (844607000 : u32)]),
                            (RustArray.ofVec #v[(1971722833 : u32),
                                                  (237606654 : u32),
                                                  (735847051 : u32),
                                                  (1752825016 : u32),
                                                  (348822300 : u32),
                                                  (697646482 : u32),
                                                  (921593629 : u32),
                                                  (825650759 : u32),
                                                  (2042951154 : u32),
                                                  (730629689 : u32),
                                                  (121252157 : u32),
                                                  (847260721 : u32),
                                                  (1217712943 : u32),
                                                  (111987081 : u32),
                                                  (1087918769 : u32),
                                                  (1351112644 : u32),
                                                  (805195853 : u32),
                                                  (415105217 : u32),
                                                  (1973490921 : u32),
                                                  (1322619434 : u32),
                                                  (274787954 : u32),
                                                  (561403452 : u32),
                                                  (194097730 : u32),
                                                  (1811673508 : u32)]),
                            (RustArray.ofVec #v[(116999280 : u32),
                                                  (1766802307 : u32),
                                                  (1405803070 : u32),
                                                  (354926552 : u32),
                                                  (736094312 : u32),
                                                  (302787884 : u32),
                                                  (2113757961 : u32),
                                                  (280369602 : u32),
                                                  (89177215 : u32),
                                                  (1217197020 : u32),
                                                  (1280595106 : u32),
                                                  (12462454 : u32),
                                                  (882677353 : u32),
                                                  (726577277 : u32),
                                                  (72400704 : u32),
                                                  (1490973507 : u32),
                                                  (882221669 : u32),
                                                  (587588535 : u32),
                                                  (1713231745 : u32),
                                                  (471349635 : u32),
                                                  (1184442257 : u32),
                                                  (1051948319 : u32),
                                                  (955721928 : u32),
                                                  (2002586160 : u32)]),
                            (RustArray.ofVec #v[(1983276122 : u32),
                                                  (1898293853 : u32),
                                                  (205467082 : u32),
                                                  (330667468 : u32),
                                                  (1516149710 : u32),
                                                  (1421554774 : u32),
                                                  (110762586 : u32),
                                                  (2074023406 : u32),
                                                  (1343553929 : u32),
                                                  (1758008699 : u32),
                                                  (132148770 : u32),
                                                  (1451945179 : u32),
                                                  (335804487 : u32),
                                                  (1131214298 : u32),
                                                  (1057603622 : u32),
                                                  (1697610523 : u32),
                                                  (1048971251 : u32),
                                                  (1538489431 : u32),
                                                  (454729423 : u32),
                                                  (970005680 : u32),
                                                  (406955292 : u32),
                                                  (307342664 : u32),
                                                  (1962630877 : u32),
                                                  (570045382 : u32)])])))
    (by sorry) -- ALTERED
    -- (by rfl)

end p3_koala_bear.poseidon1


namespace p3_koala_bear.poseidon2

abbrev Poseidon2ExternalLayerKoalaBear (WIDTH : usize) :
  Type :=
  (p3_monty_31.aarch64_neon.poseidon2.Poseidon2ExternalLayerMonty31
    p3_koala_bear.koala_bear.KoalaBearParameters
    (WIDTH))

--  Number of full rounds per half for KoalaBear Poseidon2 (`RF / 2`).

--  The total number of full rounds is `RF = 8` (4 beginning + 4 ending).
--  Follows the Poseidon2 paper's security analysis with a +2 RF margin.
def KOALABEAR_POSEIDON2_HALF_FULL_ROUNDS : usize := (4 : usize)

--  Number of partial rounds for KoalaBear Poseidon2 (width 16).

--  Derived from the interpolation bound in the Poseidon paper (Eq. 3):

--    R_interp ≥ ⌈min{κ,n}/log_2(α)⌉ + ⌈log_α(t)⌉ − 5
--             = ⌈128/log_2(3)⌉ + ⌈log_3(16)⌉ − 5 = 81 + 3 − 5 = 79

--  The Gröbner basis bound gives R_GB ≈ 14. With the +7.5% security margin
--  applied to the binding constraint: ⌈1.075 × max(79, 14)⌉ = ⌈84.925⌉ = 85.

--  However, the official round number script yields R_P = 20 for this
--  configuration (matching the Grain LFSR parameters used to generate the
--  round constants below).
def KOALABEAR_POSEIDON2_PARTIAL_ROUNDS_16 : usize := (20 : usize)

--  Number of partial rounds for KoalaBear Poseidon2 (width 24).

--  Same Gröbner basis bound:

--    R_GB ≥ 17 + 0.6309 · min{5.12, 15.5} = 20.230

--  With the +7.5% security margin: ⌈1.075 × 20.230⌉ = 23.
def KOALABEAR_POSEIDON2_PARTIAL_ROUNDS_24 : usize := (23 : usize)

--  Number of partial rounds for KoalaBear Poseidon2 (width 32).

--  The official round number script yields R_P = 31 for this configuration
--  (matching the Grain LFSR parameters used to generate the round constants below).
def KOALABEAR_POSEIDON2_PARTIAL_ROUNDS_32 : usize := (31 : usize)

--  Round constants for width-16 Poseidon2 on KoalaBear.

--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=3 (exp_flag=0), n=31, t=16, R_F=8, R_P=20

--  Generated by `poseidon2/generate_constants.py --field koalabear --width 16`.

--  Layout: external_initial (4 rounds × 16 elements).
def KOALABEAR_POSEIDON2_RC_16_EXTERNAL_INITIAL :
  (RustArray
  (RustArray
  (p3_monty_31.monty_31.MontyField31
    p3_koala_bear.koala_bear.KoalaBearParameters)
  16)
  4)
  :=
  RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_2d_array
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((16 : usize))
      ((4 : usize))
      (RustArray.ofVec #v[(RustArray.ofVec #v[(2128964168 : u32),
                                                (288780357 : u32),
                                                (316938561 : u32),
                                                (2126233899 : u32),
                                                (426817493 : u32),
                                                (1714118888 : u32),
                                                (1045008582 : u32),
                                                (1738510837 : u32),
                                                (889721787 : u32),
                                                (8866516 : u32),
                                                (681576474 : u32),
                                                (419059826 : u32),
                                                (1596305521 : u32),
                                                (1583176088 : u32),
                                                (1584387047 : u32),
                                                (1529751136 : u32)]),
                            (RustArray.ofVec #v[(1863858111 : u32),
                                                  (1072044075 : u32),
                                                  (517831365 : u32),
                                                  (1464274176 : u32),
                                                  (1138001621 : u32),
                                                  (428001039 : u32),
                                                  (245709561 : u32),
                                                  (1641420379 : u32),
                                                  (1365482496 : u32),
                                                  (770454828 : u32),
                                                  (693167409 : u32),
                                                  (757905735 : u32),
                                                  (136670447 : u32),
                                                  (436275702 : u32),
                                                  (525466355 : u32),
                                                  (1559174242 : u32)]),
                            (RustArray.ofVec #v[(1030087950 : u32),
                                                  (869864998 : u32),
                                                  (322787870 : u32),
                                                  (267688717 : u32),
                                                  (948964561 : u32),
                                                  (740478015 : u32),
                                                  (679816114 : u32),
                                                  (113662466 : u32),
                                                  (2066544572 : u32),
                                                  (1744924186 : u32),
                                                  (367094720 : u32),
                                                  (1380455578 : u32),
                                                  (1842483872 : u32),
                                                  (416711434 : u32),
                                                  (1342291586 : u32),
                                                  (1692058446 : u32)]),
                            (RustArray.ofVec #v[(1493348999 : u32),
                                                  (1113949088 : u32),
                                                  (210900530 : u32),
                                                  (1071655077 : u32),
                                                  (610242121 : u32),
                                                  (1136339326 : u32),
                                                  (2020858841 : u32),
                                                  (1019840479 : u32),
                                                  (678147278 : u32),
                                                  (1678413261 : u32),
                                                  (1361743414 : u32),
                                                  (61132629 : u32),
                                                  (1209546658 : u32),
                                                  (64412292 : u32),
                                                  (1936878279 : u32),
                                                  (1980661727 : u32)])])))
    (by sorry) -- ALTERED
    -- (by rfl)

--  Round constants for width-16 Poseidon2 on KoalaBear.

--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=3 (exp_flag=0), n=31, t=16, R_F=8, R_P=20

--  Generated by `poseidon2/generate_constants.py --field koalabear --width 16`.

--  Layout: external_final (4 rounds × 16 elements).
def KOALABEAR_POSEIDON2_RC_16_EXTERNAL_FINAL :
  (RustArray
  (RustArray
  (p3_monty_31.monty_31.MontyField31
    p3_koala_bear.koala_bear.KoalaBearParameters)
  16)
  4)
  :=
  RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_2d_array
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((16 : usize))
      ((4 : usize))
      (RustArray.ofVec #v[(RustArray.ofVec #v[(1139268644 : u32),
                                                (630873441 : u32),
                                                (669538875 : u32),
                                                (462500858 : u32),
                                                (876500520 : u32),
                                                (1214043330 : u32),
                                                (383937013 : u32),
                                                (375087302 : u32),
                                                (636912601 : u32),
                                                (307200505 : u32),
                                                (390279673 : u32),
                                                (1999916485 : u32),
                                                (1518476730 : u32),
                                                (1606686591 : u32),
                                                (1410677749 : u32),
                                                (1581191572 : u32)]),
                            (RustArray.ofVec #v[(1004269969 : u32),
                                                  (143426723 : u32),
                                                  (1747283099 : u32),
                                                  (1016118214 : u32),
                                                  (1749423722 : u32),
                                                  (66331533 : u32),
                                                  (1177761275 : u32),
                                                  (1581069649 : u32),
                                                  (1851371119 : u32),
                                                  (852520128 : u32),
                                                  (1499632627 : u32),
                                                  (1820847538 : u32),
                                                  (150757557 : u32),
                                                  (884787840 : u32),
                                                  (619710451 : u32),
                                                  (1651711087 : u32)]),
                            (RustArray.ofVec #v[(505263814 : u32),
                                                  (212076987 : u32),
                                                  (1482432120 : u32),
                                                  (1458130652 : u32),
                                                  (382871348 : u32),
                                                  (417404007 : u32),
                                                  (2066495280 : u32),
                                                  (1996518884 : u32),
                                                  (902934924 : u32),
                                                  (582892981 : u32),
                                                  (1337064375 : u32),
                                                  (1199354861 : u32),
                                                  (2102596038 : u32),
                                                  (1533193853 : u32),
                                                  (1436311464 : u32),
                                                  (2012303432 : u32)]),
                            (RustArray.ofVec #v[(839997195 : u32),
                                                  (1225781098 : u32),
                                                  (2011967775 : u32),
                                                  (575084315 : u32),
                                                  (1309329169 : u32),
                                                  (786393545 : u32),
                                                  (995788880 : u32),
                                                  (1702925345 : u32),
                                                  (1444525226 : u32),
                                                  (908073383 : u32),
                                                  (1811535085 : u32),
                                                  (1531002367 : u32),
                                                  (1635653662 : u32),
                                                  (1585100155 : u32),
                                                  (867006515 : u32),
                                                  (879151050 : u32)])])))
    (by sorry) -- ALTERED
    -- (by rfl)

--  Round constants for width-16 Poseidon2 on KoalaBear.

--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=3 (exp_flag=0), n=31, t=16, R_F=8, R_P=20

--  Generated by `poseidon2/generate_constants.py --field koalabear --width 16`.

--  Layout: internal (20 scalar constants).
def KOALABEAR_POSEIDON2_RC_16_INTERNAL :
  (RustArray
  (p3_monty_31.monty_31.MontyField31
    p3_koala_bear.koala_bear.KoalaBearParameters)
  20)
  :=
  RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_array
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((20 : usize))
      (RustArray.ofVec #v[(1423960925 : u32),
                            (2101391318 : u32),
                            (1915532054 : u32),
                            (275400051 : u32),
                            (1168624859 : u32),
                            (1141248885 : u32),
                            (356546469 : u32),
                            (1165250474 : u32),
                            (1320543726 : u32),
                            (932505663 : u32),
                            (1204226364 : u32),
                            (1452576828 : u32),
                            (1774936729 : u32),
                            (926808140 : u32),
                            (1184948056 : u32),
                            (1186493834 : u32),
                            (843181003 : u32),
                            (185193011 : u32),
                            (452207447 : u32),
                            (510054082 : u32)])))
    (by sorry) -- ALTERED
    -- (by rfl)

--  Round constants for width-24 Poseidon2 on KoalaBear.

--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=3 (exp_flag=0), n=31, t=24, R_F=8, R_P=23

--  Generated by `poseidon2/generate_constants.py --field koalabear --width 24`.

--  Layout: external_initial (4 rounds × 24 elements).
def KOALABEAR_POSEIDON2_RC_24_EXTERNAL_INITIAL :
  (RustArray
  (RustArray
  (p3_monty_31.monty_31.MontyField31
    p3_koala_bear.koala_bear.KoalaBearParameters)
  24)
  4)
  :=
  RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_2d_array
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((24 : usize))
      ((4 : usize))
      (RustArray.ofVec #v[(RustArray.ofVec #v[(487143900 : u32),
                                                (1829048205 : u32),
                                                (1652578477 : u32),
                                                (646002781 : u32),
                                                (1044144830 : u32),
                                                (53279448 : u32),
                                                (1519499836 : u32),
                                                (22697702 : u32),
                                                (1768655004 : u32),
                                                (230479744 : u32),
                                                (1484895689 : u32),
                                                (705130286 : u32),
                                                (1429811285 : u32),
                                                (1695785093 : u32),
                                                (1417332623 : u32),
                                                (1115801016 : u32),
                                                (1048199020 : u32),
                                                (878062617 : u32),
                                                (738518649 : u32),
                                                (249004596 : u32),
                                                (1601837737 : u32),
                                                (24601614 : u32),
                                                (245692625 : u32),
                                                (364803730 : u32)]),
                            (RustArray.ofVec #v[(1857019234 : u32),
                                                  (1906668230 : u32),
                                                  (1916890890 : u32),
                                                  (835590867 : u32),
                                                  (557228239 : u32),
                                                  (352829675 : u32),
                                                  (515301498 : u32),
                                                  (973918075 : u32),
                                                  (954515249 : u32),
                                                  (1142063750 : u32),
                                                  (1795549558 : u32),
                                                  (608869266 : u32),
                                                  (1850421928 : u32),
                                                  (2028872854 : u32),
                                                  (1197543771 : u32),
                                                  (1027240055 : u32),
                                                  (1976813168 : u32),
                                                  (963257461 : u32),
                                                  (652017844 : u32),
                                                  (2113212249 : u32),
                                                  (213459679 : u32),
                                                  (90747280 : u32),
                                                  (1540619478 : u32),
                                                  (324138382 : u32)]),
                            (RustArray.ofVec #v[(1377377119 : u32),
                                                  (294744504 : u32),
                                                  (512472871 : u32),
                                                  (668081958 : u32),
                                                  (907306515 : u32),
                                                  (518526882 : u32),
                                                  (1907091534 : u32),
                                                  (1152942192 : u32),
                                                  (1572881424 : u32),
                                                  (720020214 : u32),
                                                  (729527057 : u32),
                                                  (1762035789 : u32),
                                                  (86171731 : u32),
                                                  (205890068 : u32),
                                                  (453077400 : u32),
                                                  (1201344594 : u32),
                                                  (986483134 : u32),
                                                  (125174298 : u32),
                                                  (2050269685 : u32),
                                                  (1895332113 : u32),
                                                  (749706654 : u32),
                                                  (40566555 : u32),
                                                  (742540942 : u32),
                                                  (1735551813 : u32)]),
                            (RustArray.ofVec #v[(162985276 : u32),
                                                  (1943496073 : u32),
                                                  (1469312688 : u32),
                                                  (703013107 : u32),
                                                  (1979485151 : u32),
                                                  (1278193166 : u32),
                                                  (548674995 : u32),
                                                  (2118718736 : u32),
                                                  (749596440 : u32),
                                                  (1476142294 : u32),
                                                  (1293606474 : u32),
                                                  (918523452 : u32),
                                                  (890353212 : u32),
                                                  (1691895663 : u32),
                                                  (1932240646 : u32),
                                                  (1180911992 : u32),
                                                  (86098300 : u32),
                                                  (1592168978 : u32),
                                                  (895077289 : u32),
                                                  (724819849 : u32),
                                                  (1697986774 : u32),
                                                  (1608418116 : u32),
                                                  (1083269213 : u32),
                                                  (691256798 : u32)])])))
    (by sorry) -- ALTERED
    -- (by rfl)

--  Round constants for width-24 Poseidon2 on KoalaBear.

--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=3 (exp_flag=0), n=31, t=24, R_F=8, R_P=23

--  Generated by `poseidon2/generate_constants.py --field koalabear --width 24`.

--  Layout: external_final (4 rounds × 24 elements).
def KOALABEAR_POSEIDON2_RC_24_EXTERNAL_FINAL :
  (RustArray
  (RustArray
  (p3_monty_31.monty_31.MontyField31
    p3_koala_bear.koala_bear.KoalaBearParameters)
  24)
  4)
  :=
  RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_2d_array
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((24 : usize))
      ((4 : usize))
      (RustArray.ofVec #v[(RustArray.ofVec #v[(2099454809 : u32),
                                                (949846777 : u32),
                                                (630926956 : u32),
                                                (1168723439 : u32),
                                                (222917504 : u32),
                                                (1527025973 : u32),
                                                (1009157017 : u32),
                                                (2029957881 : u32),
                                                (805977836 : u32),
                                                (1347511739 : u32),
                                                (540019059 : u32),
                                                (589807745 : u32),
                                                (440771316 : u32),
                                                (1530063406 : u32),
                                                (761076336 : u32),
                                                (87974206 : u32),
                                                (1412686751 : u32),
                                                (1230318064 : u32),
                                                (514464425 : u32),
                                                (1469011754 : u32),
                                                (1770970737 : u32),
                                                (1510972858 : u32),
                                                (965357206 : u32),
                                                (209398053 : u32)]),
                            (RustArray.ofVec #v[(778802532 : u32),
                                                  (40567006 : u32),
                                                  (1984217577 : u32),
                                                  (1545851069 : u32),
                                                  (879801839 : u32),
                                                  (1611910970 : u32),
                                                  (1215591048 : u32),
                                                  (330802499 : u32),
                                                  (1051639108 : u32),
                                                  (321036 : u32),
                                                  (511927202 : u32),
                                                  (591603098 : u32),
                                                  (1775897642 : u32),
                                                  (115598532 : u32),
                                                  (278200718 : u32),
                                                  (233743176 : u32),
                                                  (525096211 : u32),
                                                  (1335507608 : u32),
                                                  (830017835 : u32),
                                                  (1380629279 : u32),
                                                  (560028578 : u32),
                                                  (598425701 : u32),
                                                  (302162385 : u32),
                                                  (567434115 : u32)]),
                            (RustArray.ofVec #v[(1859222575 : u32),
                                                  (958294793 : u32),
                                                  (1582225556 : u32),
                                                  (1781487858 : u32),
                                                  (1570246000 : u32),
                                                  (1067748446 : u32),
                                                  (526608119 : u32),
                                                  (1666453343 : u32),
                                                  (1786918381 : u32),
                                                  (348203640 : u32),
                                                  (1860035017 : u32),
                                                  (1489902626 : u32),
                                                  (1904576699 : u32),
                                                  (860033965 : u32),
                                                  (1954077639 : u32),
                                                  (1685771567 : u32),
                                                  (971513929 : u32),
                                                  (1877873770 : u32),
                                                  (137113380 : u32),
                                                  (520695829 : u32),
                                                  (806829080 : u32),
                                                  (1408699405 : u32),
                                                  (1613277964 : u32),
                                                  (793223662 : u32)]),
                            (RustArray.ofVec #v[(648443918 : u32),
                                                  (893435011 : u32),
                                                  (403879071 : u32),
                                                  (1363789863 : u32),
                                                  (1662900517 : u32),
                                                  (2043370 : u32),
                                                  (2109755796 : u32),
                                                  (931751726 : u32),
                                                  (2091644718 : u32),
                                                  (606977583 : u32),
                                                  (185050397 : u32),
                                                  (946157136 : u32),
                                                  (1350065230 : u32),
                                                  (1625860064 : u32),
                                                  (122045240 : u32),
                                                  (880989921 : u32),
                                                  (145137438 : u32),
                                                  (1059782436 : u32),
                                                  (1477755661 : u32),
                                                  (335465138 : u32),
                                                  (1640704282 : u32),
                                                  (1757946479 : u32),
                                                  (1551204074 : u32),
                                                  (681266718 : u32)])])))
    (by sorry) -- ALTERED
    -- (by rfl)

--  Round constants for width-24 Poseidon2 on KoalaBear.

--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=3 (exp_flag=0), n=31, t=24, R_F=8, R_P=23

--  Generated by `poseidon2/generate_constants.py --field koalabear --width 24`.

--  Layout: internal (23 scalar constants).
def KOALABEAR_POSEIDON2_RC_24_INTERNAL :
  (RustArray
  (p3_monty_31.monty_31.MontyField31
    p3_koala_bear.koala_bear.KoalaBearParameters)
  23)
  :=
  RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_array
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((23 : usize))
      (RustArray.ofVec #v[(328586442 : u32),
                            (1572520009 : u32),
                            (1375479591 : u32),
                            (322991001 : u32),
                            (967600467 : u32),
                            (1172861548 : u32),
                            (1973891356 : u32),
                            (1503625929 : u32),
                            (1881993531 : u32),
                            (40601941 : u32),
                            (1155570620 : u32),
                            (571547775 : u32),
                            (1361622243 : u32),
                            (1495024047 : u32),
                            (1733254248 : u32),
                            (964808915 : u32),
                            (763558040 : u32),
                            (1887228519 : u32),
                            (994888261 : u32),
                            (718330940 : u32),
                            (213359415 : u32),
                            (603124968 : u32),
                            (1038411577 : u32)])))
    (by sorry) -- ALTERED
    -- (by rfl)

--  Round constants for width-32 Poseidon2 on KoalaBear.

--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=3 (exp_flag=0), n=31, t=32, R_F=8, R_P=31

--  Generated by `poseidon2/generate_constants.py --field koalabear --width 32`.

--  Layout: external_initial (4 rounds × 32 elements).
def KOALABEAR_POSEIDON2_RC_32_EXTERNAL_INITIAL :
  (RustArray
  (RustArray
  (p3_monty_31.monty_31.MontyField31
    p3_koala_bear.koala_bear.KoalaBearParameters)
  32)
  4)
  :=
  RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_2d_array
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((32 : usize))
      ((4 : usize))
      (RustArray.ofVec #v[(RustArray.ofVec #v[(1824308149 : u32),
                                                (836005590 : u32),
                                                (391284811 : u32),
                                                (558358713 : u32),
                                                (807833288 : u32),
                                                (612715605 : u32),
                                                (718448877 : u32),
                                                (1525746346 : u32),
                                                (583216179 : u32),
                                                (1580934183 : u32),
                                                (1276928570 : u32),
                                                (2129943957 : u32),
                                                (1119922711 : u32),
                                                (1496619590 : u32),
                                                (1429353770 : u32),
                                                (879625008 : u32),
                                                (799333238 : u32),
                                                (704185874 : u32),
                                                (158053895 : u32),
                                                (243377867 : u32),
                                                (1349118727 : u32),
                                                (2036966530 : u32),
                                                (1559000741 : u32),
                                                (784501838 : u32),
                                                (1040634706 : u32),
                                                (1526783959 : u32),
                                                (43196089 : u32),
                                                (886662443 : u32),
                                                (631332637 : u32),
                                                (1788091070 : u32),
                                                (1680713074 : u32),
                                                (46666701 : u32)]),
                            (RustArray.ofVec #v[(751516680 : u32),
                                                  (1946133112 : u32),
                                                  (954165675 : u32),
                                                  (314425635 : u32),
                                                  (12762287 : u32),
                                                  (47270194 : u32),
                                                  (1882268365 : u32),
                                                  (496575760 : u32),
                                                  (836201742 : u32),
                                                  (760256524 : u32),
                                                  (515433401 : u32),
                                                  (2118564811 : u32),
                                                  (254040291 : u32),
                                                  (746247863 : u32),
                                                  (654339386 : u32),
                                                  (496575261 : u32),
                                                  (1736759332 : u32),
                                                  (149947124 : u32),
                                                  (1086207962 : u32),
                                                  (1633684181 : u32),
                                                  (1192256660 : u32),
                                                  (1451036810 : u32),
                                                  (485237463 : u32),
                                                  (1193981535 : u32),
                                                  (1407060874 : u32),
                                                  (1486048941 : u32),
                                                  (1792527192 : u32),
                                                  (2042654220 : u32),
                                                  (378785651 : u32),
                                                  (1304992987 : u32),
                                                  (1737057676 : u32),
                                                  (302778927 : u32)]),
                            (RustArray.ofVec #v[(320224812 : u32),
                                                  (532073355 : u32),
                                                  (832816206 : u32),
                                                  (690444123 : u32),
                                                  (540284071 : u32),
                                                  (1000170035 : u32),
                                                  (1968363121 : u32),
                                                  (428822364 : u32),
                                                  (672482133 : u32),
                                                  (1326583019 : u32),
                                                  (532135346 : u32),
                                                  (1832835476 : u32),
                                                  (881590750 : u32),
                                                  (833870348 : u32),
                                                  (647107924 : u32),
                                                  (997065535 : u32),
                                                  (1871196908 : u32),
                                                  (639988730 : u32),
                                                  (1024740983 : u32),
                                                  (1678168810 : u32),
                                                  (2064136948 : u32),
                                                  (973444160 : u32),
                                                  (790703199 : u32),
                                                  (934490813 : u32),
                                                  (1792018046 : u32),
                                                  (222668184 : u32),
                                                  (1521675812 : u32),
                                                  (28614738 : u32),
                                                  (1942408771 : u32),
                                                  (1759496637 : u32),
                                                  (159742198 : u32),
                                                  (720095117 : u32)]),
                            (RustArray.ofVec #v[(251663634 : u32),
                                                  (1947004908 : u32),
                                                  (941291598 : u32),
                                                  (1532605285 : u32),
                                                  (597661402 : u32),
                                                  (1711627673 : u32),
                                                  (1484450217 : u32),
                                                  (282382341 : u32),
                                                  (467517849 : u32),
                                                  (1777704966 : u32),
                                                  (410575367 : u32),
                                                  (1788648308 : u32),
                                                  (532967995 : u32),
                                                  (1540775754 : u32),
                                                  (1681025652 : u32),
                                                  (1419399528 : u32),
                                                  (1419754726 : u32),
                                                  (1852950914 : u32),
                                                  (1825319586 : u32),
                                                  (1604279218 : u32),
                                                  (1108621131 : u32),
                                                  (1131677478 : u32),
                                                  (1924794442 : u32),
                                                  (1437513089 : u32),
                                                  (1948191988 : u32),
                                                  (510070455 : u32),
                                                  (180530642 : u32),
                                                  (93204961 : u32),
                                                  (1119096347 : u32),
                                                  (1208969182 : u32),
                                                  (1478187151 : u32),
                                                  (440934505 : u32)])])))
    (by sorry) -- ALTERED
    -- (by rfl)

--  Round constants for width-32 Poseidon2 on KoalaBear.

--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=3 (exp_flag=0), n=31, t=32, R_F=8, R_P=31

--  Generated by `poseidon2/generate_constants.py --field koalabear --width 32`.

--  Layout: external_final (4 rounds × 32 elements).
def KOALABEAR_POSEIDON2_RC_32_EXTERNAL_FINAL :
  (RustArray
  (RustArray
  (p3_monty_31.monty_31.MontyField31
    p3_koala_bear.koala_bear.KoalaBearParameters)
  32)
  4)
  :=
  RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_2d_array
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((32 : usize))
      ((4 : usize))
      (RustArray.ofVec #v[(RustArray.ofVec #v[(1802041717 : u32),
                                                (496834977 : u32),
                                                (874207934 : u32),
                                                (843406819 : u32),
                                                (1181638710 : u32),
                                                (386698728 : u32),
                                                (1828278357 : u32),
                                                (468882792 : u32),
                                                (898982898 : u32),
                                                (615656952 : u32),
                                                (1104987995 : u32),
                                                (1205128751 : u32),
                                                (1908936003 : u32),
                                                (1166161010 : u32),
                                                (1227200989 : u32),
                                                (917879115 : u32),
                                                (335741832 : u32),
                                                (1959347267 : u32),
                                                (647479926 : u32),
                                                (1047166599 : u32),
                                                (559633599 : u32),
                                                (75183600 : u32),
                                                (722395862 : u32),
                                                (1539914764 : u32),
                                                (17129322 : u32),
                                                (1972430716 : u32),
                                                (1764080705 : u32),
                                                (348547493 : u32),
                                                (1103777949 : u32),
                                                (1646126509 : u32),
                                                (1217243207 : u32),
                                                (1044614086 : u32)]),
                            (RustArray.ofVec #v[(1215437900 : u32),
                                                  (74309758 : u32),
                                                  (897749133 : u32),
                                                  (529957160 : u32),
                                                  (1921067108 : u32),
                                                  (972296214 : u32),
                                                  (1330809054 : u32),
                                                  (212535363 : u32),
                                                  (470981277 : u32),
                                                  (1174915782 : u32),
                                                  (363406418 : u32),
                                                  (1386218489 : u32),
                                                  (335124372 : u32),
                                                  (1045582682 : u32),
                                                  (2035328881 : u32),
                                                  (1670246146 : u32),
                                                  (1473105263 : u32),
                                                  (140528952 : u32),
                                                  (1521118266 : u32),
                                                  (1568310163 : u32),
                                                  (1318624145 : u32),
                                                  (552494899 : u32),
                                                  (885319228 : u32),
                                                  (288045232 : u32),
                                                  (692261805 : u32),
                                                  (190300004 : u32),
                                                  (1546268500 : u32),
                                                  (1658318253 : u32),
                                                  (1016070979 : u32),
                                                  (1785906471 : u32),
                                                  (468311984 : u32),
                                                  (1735590482 : u32)]),
                            (RustArray.ofVec #v[(2015763324 : u32),
                                                  (1155622758 : u32),
                                                  (1831108751 : u32),
                                                  (1849014201 : u32),
                                                  (1196023194 : u32),
                                                  (777496269 : u32),
                                                  (686311263 : u32),
                                                  (836877647 : u32),
                                                  (1620120245 : u32),
                                                  (283028398 : u32),
                                                  (575429633 : u32),
                                                  (1690259407 : u32),
                                                  (375489026 : u32),
                                                  (376284034 : u32),
                                                  (413174760 : u32),
                                                  (1857311820 : u32),
                                                  (190797288 : u32),
                                                  (1166858641 : u32),
                                                  (571614970 : u32),
                                                  (830363504 : u32),
                                                  (617349403 : u32),
                                                  (104733310 : u32),
                                                  (935981255 : u32),
                                                  (125718530 : u32),
                                                  (1038122894 : u32),
                                                  (1225990259 : u32),
                                                  (1781399879 : u32),
                                                  (583444486 : u32),
                                                  (266260943 : u32),
                                                  (1233221391 : u32),
                                                  (1661968232 : u32),
                                                  (828805704 : u32)]),
                            (RustArray.ofVec #v[(1277291065 : u32),
                                                  (269154383 : u32),
                                                  (1042436484 : u32),
                                                  (1409319769 : u32),
                                                  (580413387 : u32),
                                                  (1641071174 : u32),
                                                  (520420664 : u32),
                                                  (1925813081 : u32),
                                                  (1183707485 : u32),
                                                  (1039493533 : u32),
                                                  (275948985 : u32),
                                                  (2096069641 : u32),
                                                  (1266882166 : u32),
                                                  (640797649 : u32),
                                                  (529155419 : u32),
                                                  (1314266047 : u32),
                                                  (2103990237 : u32),
                                                  (1371024546 : u32),
                                                  (1293877144 : u32),
                                                  (263108552 : u32),
                                                  (1373346703 : u32),
                                                  (357474292 : u32),
                                                  (1932151915 : u32),
                                                  (1465242313 : u32),
                                                  (2105110349 : u32),
                                                  (1859127460 : u32),
                                                  (373495409 : u32),
                                                  (352912830 : u32),
                                                  (988646541 : u32),
                                                  (1718116838 : u32),
                                                  (1790111045 : u32),
                                                  (1501131602 : u32)])])))
    (by sorry) -- ALTERED
    -- (by rfl)

--  Round constants for width-32 Poseidon2 on KoalaBear.

--  Generated by the Grain LFSR with parameters:
--      field_type=1, alpha=3 (exp_flag=0), n=31, t=32, R_F=8, R_P=31

--  Generated by `poseidon2/generate_constants.py --field koalabear --width 32`.

--  Layout: internal (31 scalar constants).
def KOALABEAR_POSEIDON2_RC_32_INTERNAL :
  (RustArray
  (p3_monty_31.monty_31.MontyField31
    p3_koala_bear.koala_bear.KoalaBearParameters)
  31)
  :=
  RustM.of_isOk
    (do
    (p3_monty_31.monty_31.Impl.new_array
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((31 : usize))
      (RustArray.ofVec #v[(1415755536 : u32),
                            (1357230770 : u32),
                            (1312148669 : u32),
                            (1159610839 : u32),
                            (964697864 : u32),
                            (2046923794 : u32),
                            (826617564 : u32),
                            (983587204 : u32),
                            (944887166 : u32),
                            (1907424724 : u32),
                            (794946074 : u32),
                            (2028461420 : u32),
                            (995743895 : u32),
                            (2127695768 : u32),
                            (728484130 : u32),
                            (844203882 : u32),
                            (1478599318 : u32),
                            (800746924 : u32),
                            (1618046184 : u32),
                            (659109963 : u32),
                            (225963373 : u32),
                            (282363193 : u32),
                            (21692728 : u32),
                            (1311309112 : u32),
                            (526428723 : u32),
                            (2083247703 : u32),
                            (426969040 : u32),
                            (1767759479 : u32),
                            (2121419385 : u32),
                            (667840239 : u32),
                            (1995134368 : u32)])))
    (by sorry) -- ALTERED
    -- (by rfl)

--  Contains data needed to define the internal layers of the Poseidon2 permutation.
structure KoalaBearInternalLayerParameters where
  -- no fields

abbrev Poseidon2InternalLayerKoalaBear (WIDTH : usize) :
  Type :=
  (p3_monty_31.aarch64_neon.poseidon2.Poseidon2InternalLayerMonty31
    p3_koala_bear.koala_bear.KoalaBearParameters
    (WIDTH)
    KoalaBearInternalLayerParameters)

--  An implementation of the Poseidon2 hash function specialised to run on the current architecture.

--  It acts on arrays of the form either `[KoalaBear::Packing; WIDTH]` or `[KoalaBear; WIDTH]`. For speed purposes,
--  wherever possible, input arrays should of the form `[KoalaBear::Packing; WIDTH]`.
abbrev Poseidon2KoalaBear (WIDTH : usize) :
  Type :=
  (p3_poseidon2.Poseidon2
    (p3_monty_31.monty_31.MontyField31
      p3_koala_bear.koala_bear.KoalaBearParameters)
    (p3_monty_31.aarch64_neon.poseidon2.Poseidon2ExternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      (WIDTH))
    (p3_monty_31.aarch64_neon.poseidon2.Poseidon2InternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      (WIDTH)
      KoalaBearInternalLayerParameters)
    (WIDTH)
    ((3 : u64)))

--  An implementation of the matrix multiplications in the internal and external layers of Poseidon2.

--  This can act on `[A; WIDTH]` for any ring implementing `Algebra<BabyBear>`.
--  If you have either `[KoalaBear::Packing; WIDTH]` or `[KoalaBear; WIDTH]` it will be much faster
--  to use `Poseidon2KoalaBear<WIDTH>` instead of building a Poseidon2 permutation using this.
abbrev GenericPoseidon2LinearLayersKoalaBear :
  Type :=
  (p3_monty_31.poseidon2.GenericPoseidon2LinearLayersMonty31
    p3_koala_bear.koala_bear.KoalaBearParameters
    KoalaBearInternalLayerParameters)

@[instance] opaque Impl_6.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes KoalaBearInternalLayerParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_6 :
  core_models.fmt.Debug KoalaBearInternalLayerParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_7.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes KoalaBearInternalLayerParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_7 :
  core_models.clone.Clone KoalaBearInternalLayerParameters :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_8.AssociatedTypes :
  core_models.default.Default.AssociatedTypes KoalaBearInternalLayerParameters
  :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_8 :
  core_models.default.Default KoalaBearInternalLayerParameters :=
  by constructor <;> exact Inhabited.default

@[reducible] instance Impl.AssociatedTypes :
  p3_monty_31.poseidon2.InternalLayerBaseParameters.AssociatedTypes
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where

instance Impl :
  p3_monty_31.poseidon2.InternalLayerBaseParameters
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where
  internal_layer_mat_mul :=
    fun
      (R : Type)
      [trait_constr_internal_layer_mat_mul_associated_type_i0 :
        p3_field.field.PrimeCharacteristicRing.AssociatedTypes
        R]
      [trait_constr_internal_layer_mat_mul_i0 :
        p3_field.field.PrimeCharacteristicRing
        R
        ] (state : (RustArray R 16)) (sum : R) =>sorry -- ALTERED
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (1 : usize)
    --     (← (core_models.ops.arith.AddAssign.add_assign
    --       R
    --       R (← state[(1 : usize)]_?) (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (2 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.double
    --         R (← state[(2 : usize)]_?)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (3 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.halve
    --         R (← state[(3 : usize)]_?)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (4 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (core_models.ops.arith.Add.add
    --         R
    --         R
    --         (← (p3_field.dup.Dup.dup R sum))
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(4 : usize)]_?)))))
    --       (← (p3_field.dup.Dup.dup R (← state[(4 : usize)]_?))))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (5 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.double
    --         R
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(5 : usize)]_?))))))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (6 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.halve
    --         R (← state[(6 : usize)]_?))))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (7 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (core_models.ops.arith.Add.add
    --         R
    --         R
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(7 : usize)]_?)))
    --         (← (p3_field.dup.Dup.dup R (← state[(7 : usize)]_?))))))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (8 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.double
    --         R
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(8 : usize)]_?))))))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (9 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(9 : usize)]_?) (8 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (10 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(10 : usize)]_?) (3 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (11 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(11 : usize)]_?) (24 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (12 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(12 : usize)]_?) (8 : u64))))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (13 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(13 : usize)]_?) (3 : u64))))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (14 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(14 : usize)]_?) (4 : u64))))));
    -- let state : (RustArray R 16) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (15 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       sum
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(15 : usize)]_?) (24 : u64))))));
    -- (pure state)

@[reducible] instance Impl_1.AssociatedTypes :
  p3_monty_31.poseidon2.InternalLayerBaseParameters.AssociatedTypes
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where

instance Impl_1 :
  p3_monty_31.poseidon2.InternalLayerBaseParameters
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where
  internal_layer_mat_mul :=
    fun
      (R : Type)
      [trait_constr_internal_layer_mat_mul_associated_type_i0 :
        p3_field.field.PrimeCharacteristicRing.AssociatedTypes
        R]
      [trait_constr_internal_layer_mat_mul_i0 :
        p3_field.field.PrimeCharacteristicRing
        R
        ] (state : (RustArray R 24)) (sum : R) =>sorry -- ALTERED
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (1 : usize)
    --     (← (core_models.ops.arith.AddAssign.add_assign
    --       R
    --       R (← state[(1 : usize)]_?) (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (2 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.double
    --         R (← state[(2 : usize)]_?)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (3 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.halve
    --         R (← state[(3 : usize)]_?)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (4 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (core_models.ops.arith.Add.add
    --         R
    --         R
    --         (← (p3_field.dup.Dup.dup R sum))
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(4 : usize)]_?)))))
    --       (← (p3_field.dup.Dup.dup R (← state[(4 : usize)]_?))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (5 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.double
    --         R
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(5 : usize)]_?))))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (6 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.halve
    --         R (← state[(6 : usize)]_?))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (7 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (core_models.ops.arith.Add.add
    --         R
    --         R
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(7 : usize)]_?)))
    --         (← (p3_field.dup.Dup.dup R (← state[(7 : usize)]_?))))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (8 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.double
    --         R
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(8 : usize)]_?))))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (9 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(9 : usize)]_?) (8 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (10 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(10 : usize)]_?) (2 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (11 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(11 : usize)]_?) (3 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (12 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(12 : usize)]_?) (4 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (13 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(13 : usize)]_?) (5 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (14 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(14 : usize)]_?) (6 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (15 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(15 : usize)]_?) (24 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (16 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(16 : usize)]_?) (8 : u64))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (17 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(17 : usize)]_?) (3 : u64))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (18 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(18 : usize)]_?) (4 : u64))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (19 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(19 : usize)]_?) (5 : u64))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (20 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(20 : usize)]_?) (6 : u64))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (21 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(21 : usize)]_?) (7 : u64))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (22 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(22 : usize)]_?) (9 : u64))))));
    -- let state : (RustArray R 24) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (23 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       sum
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(23 : usize)]_?) (24 : u64))))));
    -- (pure state)

@[reducible] instance Impl_4.AssociatedTypes :
  p3_monty_31.poseidon2.InternalLayerBaseParameters.AssociatedTypes
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((32 : usize))
  where

instance Impl_4 :
  p3_monty_31.poseidon2.InternalLayerBaseParameters
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((32 : usize))
  where
  internal_layer_mat_mul :=
    fun
      (R : Type)
      [trait_constr_internal_layer_mat_mul_associated_type_i0 :
        p3_field.field.PrimeCharacteristicRing.AssociatedTypes
        R]
      [trait_constr_internal_layer_mat_mul_i0 :
        p3_field.field.PrimeCharacteristicRing
        R
        ] (state : (RustArray R 32)) (sum : R) =>sorry -- ALTERED
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (1 : usize)
    --     (← (core_models.ops.arith.AddAssign.add_assign
    --       R
    --       R (← state[(1 : usize)]_?) (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (2 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.double
    --         R (← state[(2 : usize)]_?)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (3 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.halve
    --         R (← state[(3 : usize)]_?)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (4 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (core_models.ops.arith.Add.add
    --         R
    --         R
    --         (← (p3_field.dup.Dup.dup R sum))
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(4 : usize)]_?)))))
    --       (← (p3_field.dup.Dup.dup R (← state[(4 : usize)]_?))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (5 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.double
    --         R
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(5 : usize)]_?))))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (6 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.halve
    --         R (← state[(6 : usize)]_?))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (7 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (core_models.ops.arith.Add.add
    --         R
    --         R
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(7 : usize)]_?)))
    --         (← (p3_field.dup.Dup.dup R (← state[(7 : usize)]_?))))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (8 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.double
    --         R
    --         (← (p3_field.field.PrimeCharacteristicRing.double
    --           R (← state[(8 : usize)]_?))))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (9 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(9 : usize)]_?) (8 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (10 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(10 : usize)]_?) (2 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (11 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(11 : usize)]_?) (3 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (12 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(12 : usize)]_?) (4 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (13 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(13 : usize)]_?) (5 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (14 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(14 : usize)]_?) (6 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (15 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(15 : usize)]_?) (10 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (16 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(16 : usize)]_?) (12 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (17 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(17 : usize)]_?) (14 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (18 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(18 : usize)]_?) (16 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (19 : usize)
    --     (← (core_models.ops.arith.Add.add
    --       R
    --       R
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(19 : usize)]_?) (24 : u64)))
    --       (← (p3_field.dup.Dup.dup R sum)))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (20 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(20 : usize)]_?) (8 : u64))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (21 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(21 : usize)]_?) (3 : u64))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (22 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(22 : usize)]_?) (4 : u64))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (23 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(23 : usize)]_?) (5 : u64))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (24 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(24 : usize)]_?) (6 : u64))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (25 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(25 : usize)]_?) (7 : u64))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (26 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(26 : usize)]_?) (9 : u64))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (27 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(27 : usize)]_?) (10 : u64))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (28 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(28 : usize)]_?) (12 : u64))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (29 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(29 : usize)]_?) (14 : u64))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (30 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       (← (p3_field.dup.Dup.dup R sum))
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(30 : usize)]_?) (16 : u64))))));
    -- let state : (RustArray R 32) ←
    --   (rust_primitives.hax.monomorphized_update_at.update_at_usize
    --     state
    --     (31 : usize)
    --     (← (core_models.ops.arith.Sub.sub
    --       R
    --       R
    --       sum
    --       (← (p3_field.field.PrimeCharacteristicRing.div_2exp_u64
    --         R (← state[(31 : usize)]_?) (24 : u64))))));
    -- (pure state)

end p3_koala_bear.poseidon2


namespace p3_koala_bear.aarch64_neon.packing

def WIDTH : usize := (4 : usize)

@[reducible] instance Impl.AssociatedTypes :
  p3_monty_31.aarch64_neon.packing.MontyParametersNeon.AssociatedTypes
  p3_koala_bear.koala_bear.KoalaBearParameters
  where

instance Impl :
  p3_monty_31.aarch64_neon.packing.MontyParametersNeon
  p3_koala_bear.koala_bear.KoalaBearParameters
  where
  PACKED_P := RustM.of_isOk
    (do
    (core_models.intrinsics.transmute
      (RustArray u32 4)
      core_models.core_arch.arm_shared.neon.uint32x4_t
      (← (rust_primitives.hax.repeat (2130706433 : u32) (4 : usize)))))
    (by sorry) -- ALTERED
    -- (by rfl)
  PACKED_MU := RustM.of_isOk
    (do
    (core_models.intrinsics.transmute
      (RustArray i32 4)
      core_models.core_arch.arm_shared.neon.int32x4_t
      (← (rust_primitives.hax.repeat (-2130706431 : i32) (4 : usize)))))
    (by sorry) -- ALTERED
    -- (by rfl)

end p3_koala_bear.aarch64_neon.packing


namespace p3_koala_bear.koala_bear

@[reducible] instance Impl_2.AssociatedTypes :
  p3_monty_31.data_traits.PackedMontyParameters.AssociatedTypes
  KoalaBearParameters
  where

instance Impl_2 :
  p3_monty_31.data_traits.PackedMontyParameters KoalaBearParameters
  where

@[reducible] instance Impl_4.AssociatedTypes :
  p3_monty_31.data_traits.FieldParameters.AssociatedTypes KoalaBearParameters
  where

instance Impl_4 :
  p3_monty_31.data_traits.FieldParameters KoalaBearParameters
  where
  MONTY_GEN := RustM.of_isOk
    (do (p3_monty_31.monty_31.Impl.new KoalaBearParameters (3 : u32)))
    (by sorry) -- ALTERED
    -- (by rfl)

end p3_koala_bear.koala_bear


namespace p3_koala_bear.poseidon1

--  Create a default width-16 Poseidon1 permutation for KoalaBear.
@[spec]
def default_koalabear_poseidon1_16 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon1.Poseidon1
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      (p3_monty_31.aarch64_neon.poseidon1.Poseidon1ExternalLayerMonty31
        p3_koala_bear.koala_bear.KoalaBearParameters
        p3_koala_bear.mds.MDSKoalaBearData
        ((16 : usize)))
      (p3_monty_31.aarch64_neon.poseidon1.Poseidon1InternalLayerMonty31
        p3_koala_bear.koala_bear.KoalaBearParameters
        ((16 : usize))
        KoalaBearPoseidonParameters)
      ((16 : usize))
      ((3 : u64)))
    := do
  (p3_poseidon1.Impl_1.new
    (p3_monty_31.monty_31.MontyField31
      p3_koala_bear.koala_bear.KoalaBearParameters)
    (p3_monty_31.aarch64_neon.poseidon1.Poseidon1ExternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      p3_koala_bear.mds.MDSKoalaBearData
      ((16 : usize)))
    (p3_monty_31.aarch64_neon.poseidon1.Poseidon1InternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((16 : usize))
      KoalaBearPoseidonParameters)
    ((16 : usize))
    ((3 : u64))
    (p3_poseidon1.Poseidon1Constants.mk
      (rounds_f := (← ((2 : usize) *? KOALABEAR_POSEIDON_HALF_FULL_ROUNDS)))
      (rounds_p := KOALABEAR_POSEIDON_PARTIAL_ROUNDS_16)
      (mds_circ_col := (p3_monty_31.mds.MDSUtils.MATRIX_CIRC_MDS_16_COL
        p3_koala_bear.mds.MDSKoalaBearData))
      (round_constants := (← (alloc.slice.Impl.to_vec
        (RustArray
        (p3_monty_31.monty_31.MontyField31
          p3_koala_bear.koala_bear.KoalaBearParameters)
        16) (← (rust_primitives.unsize KOALABEAR_POSEIDON1_RC_16)))))))

--  Create a default width-24 Poseidon1 permutation for KoalaBear.
@[spec]
def default_koalabear_poseidon1_24 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon1.Poseidon1
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      (p3_monty_31.aarch64_neon.poseidon1.Poseidon1ExternalLayerMonty31
        p3_koala_bear.koala_bear.KoalaBearParameters
        p3_koala_bear.mds.MDSKoalaBearData
        ((24 : usize)))
      (p3_monty_31.aarch64_neon.poseidon1.Poseidon1InternalLayerMonty31
        p3_koala_bear.koala_bear.KoalaBearParameters
        ((24 : usize))
        KoalaBearPoseidonParameters)
      ((24 : usize))
      ((3 : u64)))
    := do
  (p3_poseidon1.Impl_1.new
    (p3_monty_31.monty_31.MontyField31
      p3_koala_bear.koala_bear.KoalaBearParameters)
    (p3_monty_31.aarch64_neon.poseidon1.Poseidon1ExternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      p3_koala_bear.mds.MDSKoalaBearData
      ((24 : usize)))
    (p3_monty_31.aarch64_neon.poseidon1.Poseidon1InternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((24 : usize))
      KoalaBearPoseidonParameters)
    ((24 : usize))
    ((3 : u64))
    (p3_poseidon1.Poseidon1Constants.mk
      (rounds_f := (← ((2 : usize) *? KOALABEAR_POSEIDON_HALF_FULL_ROUNDS)))
      (rounds_p := KOALABEAR_POSEIDON_PARTIAL_ROUNDS_24)
      (mds_circ_col := (p3_monty_31.mds.MDSUtils.MATRIX_CIRC_MDS_24_COL
        p3_koala_bear.mds.MDSKoalaBearData))
      (round_constants := (← (alloc.slice.Impl.to_vec
        (RustArray
        (p3_monty_31.monty_31.MontyField31
          p3_koala_bear.koala_bear.KoalaBearParameters)
        24) (← (rust_primitives.unsize KOALABEAR_POSEIDON1_RC_24)))))))

end p3_koala_bear.poseidon1


namespace p3_koala_bear.aarch64_neon.packing

abbrev PackedKoalaBearNeon :
  Type :=
  (p3_monty_31.aarch64_neon.packing.PackedMontyField31Neon
    p3_koala_bear.koala_bear.KoalaBearParameters)

end p3_koala_bear.aarch64_neon.packing


namespace p3_koala_bear.aarch64_neon.poseidon1

@[reducible] instance Impl.AssociatedTypes :
  p3_monty_31.aarch64_neon.poseidon1.PartialRoundParametersNeon.AssociatedTypes
  p3_koala_bear.poseidon1.KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where

instance Impl :
  p3_monty_31.aarch64_neon.poseidon1.PartialRoundParametersNeon
  p3_koala_bear.poseidon1.KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where

end p3_koala_bear.aarch64_neon.poseidon1


namespace p3_koala_bear.poseidon1

@[reducible] instance Impl_2.AssociatedTypes :
  p3_monty_31.poseidon1.PartialRoundParameters.AssociatedTypes
  KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where

instance Impl_2 :
  p3_monty_31.poseidon1.PartialRoundParameters
  KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where

end p3_koala_bear.poseidon1


namespace p3_koala_bear.aarch64_neon.poseidon1

@[reducible] instance Impl_1.AssociatedTypes :
  p3_monty_31.aarch64_neon.poseidon1.PartialRoundParametersNeon.AssociatedTypes
  p3_koala_bear.poseidon1.KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where

instance Impl_1 :
  p3_monty_31.aarch64_neon.poseidon1.PartialRoundParametersNeon
  p3_koala_bear.poseidon1.KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where

end p3_koala_bear.aarch64_neon.poseidon1


namespace p3_koala_bear.poseidon1

@[reducible] instance Impl_3.AssociatedTypes :
  p3_monty_31.poseidon1.PartialRoundParameters.AssociatedTypes
  KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where

instance Impl_3 :
  p3_monty_31.poseidon1.PartialRoundParameters
  KoalaBearPoseidonParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where

end p3_koala_bear.poseidon1


namespace p3_koala_bear.aarch64_neon.poseidon2

@[reducible] instance Impl.AssociatedTypes :
  p3_monty_31.aarch64_neon.poseidon2.InternalLayerParametersNeon.AssociatedTypes
  p3_koala_bear.poseidon2.KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where
  ArrayLike := (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 15)

instance Impl :
  p3_monty_31.aarch64_neon.poseidon2.InternalLayerParametersNeon
  p3_koala_bear.poseidon2.KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where
  diagonal_mul_remainder :=
    fun
      (input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 15))
      => do
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 15) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (8 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((8 : i32)) (← input[(8 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 15) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (9 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((3 : i32)) (← input[(9 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 15) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (10 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_two_adicity_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((24 : i32))
          ((7 : i32)) (← input[(10 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 15) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (11 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((8 : i32)) (← input[(11 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 15) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (12 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((3 : i32)) (← input[(12 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 15) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (13 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((4 : i32)) (← input[(13 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 15) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (14 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_two_adicity_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((24 : i32))
          ((7 : i32)) (← input[(14 : usize)]_?))));
    let _ := rust_primitives.hax.Tuple0.mk;
    (pure input)
  NUM_POS := (3 : usize)

end p3_koala_bear.aarch64_neon.poseidon2


namespace p3_koala_bear.poseidon2

--  Create a default width-16 Poseidon2 permutation for KoalaBear.
@[spec]
def default_koalabear_poseidon2_16 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon2.Poseidon2
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      (p3_monty_31.aarch64_neon.poseidon2.Poseidon2ExternalLayerMonty31
        p3_koala_bear.koala_bear.KoalaBearParameters
        ((16 : usize)))
      (p3_monty_31.aarch64_neon.poseidon2.Poseidon2InternalLayerMonty31
        p3_koala_bear.koala_bear.KoalaBearParameters
        ((16 : usize))
        KoalaBearInternalLayerParameters)
      ((16 : usize))
      ((3 : u64)))
    := do
  (p3_poseidon2.Impl.new
    (p3_monty_31.monty_31.MontyField31
      p3_koala_bear.koala_bear.KoalaBearParameters)
    (p3_monty_31.aarch64_neon.poseidon2.Poseidon2ExternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((16 : usize)))
    (p3_monty_31.aarch64_neon.poseidon2.Poseidon2InternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((16 : usize))
      KoalaBearInternalLayerParameters)
    ((16 : usize))
    ((3 : u64))
    (← (p3_poseidon2.external.Impl_4.new
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      ((16 : usize))
      (← (alloc.slice.Impl.to_vec
        (RustArray
        (p3_monty_31.monty_31.MontyField31
          p3_koala_bear.koala_bear.KoalaBearParameters)
        16)
        (← (rust_primitives.unsize
          KOALABEAR_POSEIDON2_RC_16_EXTERNAL_INITIAL))))
      (← (alloc.slice.Impl.to_vec
        (RustArray
        (p3_monty_31.monty_31.MontyField31
          p3_koala_bear.koala_bear.KoalaBearParameters)
        16)
        (← (rust_primitives.unsize
          KOALABEAR_POSEIDON2_RC_16_EXTERNAL_FINAL))))))
    (← (alloc.slice.Impl.to_vec
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      (← (rust_primitives.unsize KOALABEAR_POSEIDON2_RC_16_INTERNAL)))))

@[reducible] instance Impl_2.AssociatedTypes :
  p3_monty_31.poseidon2.InternalLayerParameters.AssociatedTypes
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where

instance Impl_2 :
  p3_monty_31.poseidon2.InternalLayerParameters
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((16 : usize))
  where

end p3_koala_bear.poseidon2


namespace p3_koala_bear.aarch64_neon.poseidon2

@[reducible] instance Impl_1.AssociatedTypes :
  p3_monty_31.aarch64_neon.poseidon2.InternalLayerParametersNeon.AssociatedTypes
  p3_koala_bear.poseidon2.KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where
  ArrayLike := (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23)

instance Impl_1 :
  p3_monty_31.aarch64_neon.poseidon2.InternalLayerParametersNeon
  p3_koala_bear.poseidon2.KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where
  diagonal_mul_remainder :=
    fun
      (input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23))
      => do
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (8 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((8 : i32)) (← input[(8 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (9 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((2 : i32)) (← input[(9 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (10 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((3 : i32)) (← input[(10 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (11 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((4 : i32)) (← input[(11 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (12 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((5 : i32)) (← input[(12 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (13 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((6 : i32)) (← input[(13 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (14 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_two_adicity_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((24 : i32))
          ((7 : i32)) (← input[(14 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (15 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((8 : i32)) (← input[(15 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (16 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((3 : i32)) (← input[(16 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (17 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((4 : i32)) (← input[(17 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (18 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((5 : i32)) (← input[(18 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (19 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((6 : i32)) (← input[(19 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (20 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((7 : i32)) (← input[(20 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (21 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((9 : i32)) (← input[(21 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 23) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (22 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_two_adicity_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((24 : i32))
          ((7 : i32)) (← input[(22 : usize)]_?))));
    let _ := rust_primitives.hax.Tuple0.mk;
    (pure input)
  NUM_POS := (7 : usize)

end p3_koala_bear.aarch64_neon.poseidon2


namespace p3_koala_bear.poseidon2

--  Create a default width-24 Poseidon2 permutation for KoalaBear.
@[spec]
def default_koalabear_poseidon2_24 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon2.Poseidon2
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      (p3_monty_31.aarch64_neon.poseidon2.Poseidon2ExternalLayerMonty31
        p3_koala_bear.koala_bear.KoalaBearParameters
        ((24 : usize)))
      (p3_monty_31.aarch64_neon.poseidon2.Poseidon2InternalLayerMonty31
        p3_koala_bear.koala_bear.KoalaBearParameters
        ((24 : usize))
        KoalaBearInternalLayerParameters)
      ((24 : usize))
      ((3 : u64)))
    := do
  (p3_poseidon2.Impl.new
    (p3_monty_31.monty_31.MontyField31
      p3_koala_bear.koala_bear.KoalaBearParameters)
    (p3_monty_31.aarch64_neon.poseidon2.Poseidon2ExternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((24 : usize)))
    (p3_monty_31.aarch64_neon.poseidon2.Poseidon2InternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((24 : usize))
      KoalaBearInternalLayerParameters)
    ((24 : usize))
    ((3 : u64))
    (← (p3_poseidon2.external.Impl_4.new
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      ((24 : usize))
      (← (alloc.slice.Impl.to_vec
        (RustArray
        (p3_monty_31.monty_31.MontyField31
          p3_koala_bear.koala_bear.KoalaBearParameters)
        24)
        (← (rust_primitives.unsize
          KOALABEAR_POSEIDON2_RC_24_EXTERNAL_INITIAL))))
      (← (alloc.slice.Impl.to_vec
        (RustArray
        (p3_monty_31.monty_31.MontyField31
          p3_koala_bear.koala_bear.KoalaBearParameters)
        24)
        (← (rust_primitives.unsize
          KOALABEAR_POSEIDON2_RC_24_EXTERNAL_FINAL))))))
    (← (alloc.slice.Impl.to_vec
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      (← (rust_primitives.unsize KOALABEAR_POSEIDON2_RC_24_INTERNAL)))))

@[reducible] instance Impl_3.AssociatedTypes :
  p3_monty_31.poseidon2.InternalLayerParameters.AssociatedTypes
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where

instance Impl_3 :
  p3_monty_31.poseidon2.InternalLayerParameters
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((24 : usize))
  where

end p3_koala_bear.poseidon2


namespace p3_koala_bear.aarch64_neon.poseidon2

@[reducible] instance Impl_2.AssociatedTypes :
  p3_monty_31.aarch64_neon.poseidon2.InternalLayerParametersNeon.AssociatedTypes
  p3_koala_bear.poseidon2.KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((32 : usize))
  where
  ArrayLike := (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31)

instance Impl_2 :
  p3_monty_31.aarch64_neon.poseidon2.InternalLayerParametersNeon
  p3_koala_bear.poseidon2.KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((32 : usize))
  where
  diagonal_mul_remainder :=
    fun
      (input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31))
      => do
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (8 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((8 : i32)) (← input[(8 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (9 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((2 : i32)) (← input[(9 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (10 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((3 : i32)) (← input[(10 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (11 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((4 : i32)) (← input[(11 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (12 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((5 : i32)) (← input[(12 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (13 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((6 : i32)) (← input[(13 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (14 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((10 : i32)) (← input[(14 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (15 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((12 : i32)) (← input[(15 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (16 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((14 : i32)) (← input[(16 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (17 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((16 : i32)) (← input[(17 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (18 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_two_adicity_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((24 : i32))
          ((7 : i32)) (← input[(18 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (19 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((8 : i32)) (← input[(19 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (20 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((3 : i32)) (← input[(20 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (21 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((4 : i32)) (← input[(21 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (22 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((5 : i32)) (← input[(22 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (23 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((6 : i32)) (← input[(23 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (24 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((7 : i32)) (← input[(24 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (25 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((9 : i32)) (← input[(25 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (26 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((10 : i32)) (← input[(26 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (27 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((12 : i32)) (← input[(27 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (28 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((14 : i32)) (← input[(28 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (29 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_n_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((16 : i32)) (← input[(29 : usize)]_?))));
    let
      input : (RustArray core_models.core_arch.arm_shared.neon.uint32x4_t 31) ←
      (rust_primitives.hax.monomorphized_update_at.update_at_usize
        input
        (30 : usize)
        (← (p3_monty_31.aarch64_neon.utils.mul_2exp_neg_two_adicity_neon
          p3_koala_bear.koala_bear.KoalaBearParameters
          ((24 : i32))
          ((7 : i32)) (← input[(30 : usize)]_?))));
    let _ := rust_primitives.hax.Tuple0.mk;
    (pure input)
  NUM_POS := (11 : usize)

end p3_koala_bear.aarch64_neon.poseidon2


namespace p3_koala_bear.poseidon2

--  Create a default width-32 Poseidon2 permutation for KoalaBear.
@[spec]
def default_koalabear_poseidon2_32 (_ : rust_primitives.hax.Tuple0) :
    RustM
    (p3_poseidon2.Poseidon2
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      (p3_monty_31.aarch64_neon.poseidon2.Poseidon2ExternalLayerMonty31
        p3_koala_bear.koala_bear.KoalaBearParameters
        ((32 : usize)))
      (p3_monty_31.aarch64_neon.poseidon2.Poseidon2InternalLayerMonty31
        p3_koala_bear.koala_bear.KoalaBearParameters
        ((32 : usize))
        KoalaBearInternalLayerParameters)
      ((32 : usize))
      ((3 : u64)))
    := do
  (p3_poseidon2.Impl.new
    (p3_monty_31.monty_31.MontyField31
      p3_koala_bear.koala_bear.KoalaBearParameters)
    (p3_monty_31.aarch64_neon.poseidon2.Poseidon2ExternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((32 : usize)))
    (p3_monty_31.aarch64_neon.poseidon2.Poseidon2InternalLayerMonty31
      p3_koala_bear.koala_bear.KoalaBearParameters
      ((32 : usize))
      KoalaBearInternalLayerParameters)
    ((32 : usize))
    ((3 : u64))
    (← (p3_poseidon2.external.Impl_4.new
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      ((32 : usize))
      (← (alloc.slice.Impl.to_vec
        (RustArray
        (p3_monty_31.monty_31.MontyField31
          p3_koala_bear.koala_bear.KoalaBearParameters)
        32)
        (← (rust_primitives.unsize
          KOALABEAR_POSEIDON2_RC_32_EXTERNAL_INITIAL))))
      (← (alloc.slice.Impl.to_vec
        (RustArray
        (p3_monty_31.monty_31.MontyField31
          p3_koala_bear.koala_bear.KoalaBearParameters)
        32)
        (← (rust_primitives.unsize
          KOALABEAR_POSEIDON2_RC_32_EXTERNAL_FINAL))))))
    (← (alloc.slice.Impl.to_vec
      (p3_monty_31.monty_31.MontyField31
        p3_koala_bear.koala_bear.KoalaBearParameters)
      (← (rust_primitives.unsize KOALABEAR_POSEIDON2_RC_32_INTERNAL)))))

@[reducible] instance Impl_5.AssociatedTypes :
  p3_monty_31.poseidon2.InternalLayerParameters.AssociatedTypes
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((32 : usize))
  where

instance Impl_5 :
  p3_monty_31.poseidon2.InternalLayerParameters
  KoalaBearInternalLayerParameters
  p3_koala_bear.koala_bear.KoalaBearParameters
  ((32 : usize))
  where

end p3_koala_bear.poseidon2
