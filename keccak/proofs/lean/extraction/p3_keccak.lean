
-- Experimental lean backend for Hax
-- The Hax prelude library can be found in hax/proof-libs/lean
import Hax
import p3_keccak.dependencies
import Std.Tactic.Do
import Std.Do.Triple
import Std.Tactic.Do.Syntax
open Std.Do
open Std.Tactic

set_option mvcgen.warning false
set_option linter.unusedVariables false


namespace p3_keccak.fallback

def VECTOR_LEN : usize := (1 : usize)

end p3_keccak.fallback


namespace p3_keccak

--  The Keccak-f permutation.
structure KeccakF where
  -- no fields

@[instance] opaque Impl_6.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes KeccakF :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_6 :
  core_models.clone.Clone KeccakF :=
  by constructor <;> exact Inhabited.default

end p3_keccak


namespace p3_keccak.fallback

@[reducible] instance Impl.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  p3_keccak.KeccakF
  (RustArray (RustArray u64 1) 25)
  where

instance Impl :
  p3_symmetric.permutation.Permutation
  p3_keccak.KeccakF
  (RustArray (RustArray u64 1) 25)
  where
  permute_mut :=
    fun (self : p3_keccak.KeccakF) (input : (RustArray (RustArray u64 1) 25)) =>
      do
    (pure sorry)

@[reducible] instance Impl_1.AssociatedTypes :
  p3_symmetric.permutation.CryptographicPermutation.AssociatedTypes
  p3_keccak.KeccakF
  (RustArray (RustArray u64 1) 25)
  where

instance Impl_1 :
  p3_symmetric.permutation.CryptographicPermutation
  p3_keccak.KeccakF
  (RustArray (RustArray u64 1) 25)
  where

end p3_keccak.fallback


namespace p3_keccak

@[instance] opaque Impl_5.AssociatedTypes :
  core_models.marker.Copy.AssociatedTypes KeccakF :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_5 :
  core_models.marker.Copy KeccakF :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_7.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes KeccakF :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_7 :
  core_models.fmt.Debug KeccakF :=
  by constructor <;> exact Inhabited.default

@[reducible] instance Impl.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  KeccakF
  (RustArray u64 25)
  where

instance Impl :
  p3_symmetric.permutation.Permutation KeccakF (RustArray u64 25)
  where
  permute_mut := fun (self : KeccakF) (input : (RustArray u64 25)) => do
    let input : (RustArray u64 25) ← (tiny_keccak.keccakf.keccakf input);
    (pure input)

@[reducible] instance Impl_1.AssociatedTypes :
  p3_symmetric.permutation.CryptographicPermutation.AssociatedTypes
  KeccakF
  (RustArray u64 25)
  where

instance Impl_1 :
  p3_symmetric.permutation.CryptographicPermutation KeccakF (RustArray u64 25)
  where

@[reducible] instance Impl_2.AssociatedTypes :
  p3_symmetric.permutation.Permutation.AssociatedTypes
  KeccakF
  (RustArray u8 200)
  where

instance Impl_2 :
  p3_symmetric.permutation.Permutation KeccakF (RustArray u8 200)
  where
  permute := fun (self : KeccakF) (input_u8s : (RustArray u8 200)) => do
    let state_u64s : (RustArray u64 25) ←
      (core_models.array.from_fn u64 ((25 : usize)) (usize -> RustM u64)
        (fun i =>
          (do
          (core_models.num.Impl_9.from_le_bytes
            (← (core_models.result.Impl.unwrap
              (RustArray u8 8)
              core_models.array.TryFromSliceError
              (← (core_models.convert.TryInto.try_into
                (RustSlice u8)
                (RustArray u8 8)
                (← (← input_u8s[
                    (core_models.ops.range.RangeFrom.mk
                      (start := (← (i *? (8 : usize)))))
                    ]_?)[
                  (core_models.ops.range.RangeTo.mk (_end := (8 : usize)))
                  ]_?)))))) :
          RustM u64)));
    let state_u64s : (RustArray u64 25) ←
      (tiny_keccak.keccakf.keccakf state_u64s);
    (core_models.array.from_fn u8 ((200 : usize)) (usize -> RustM u8)
      (fun i =>
        (do
        let u64_limb : u64 ← state_u64s[(← (i /? (8 : usize)))]_?;
        (← (core_models.num.Impl_9.to_le_bytes u64_limb))[
          (← (i %? (8 : usize)))
          ]_? :
        RustM u8)))

@[reducible] instance Impl_3.AssociatedTypes :
  p3_symmetric.permutation.CryptographicPermutation.AssociatedTypes
  KeccakF
  (RustArray u8 200)
  where

instance Impl_3 :
  p3_symmetric.permutation.CryptographicPermutation KeccakF (RustArray u8 200)
  where

--  The `Keccak` hash functions defined in
--  [Keccak SHA3 submission](https://keccak.team/files/Keccak-submission-3.pdf).
structure Keccak256Hash where
  -- no fields

@[instance] opaque Impl_9.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes Keccak256Hash :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_9 :
  core_models.clone.Clone Keccak256Hash :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_8.AssociatedTypes :
  core_models.marker.Copy.AssociatedTypes Keccak256Hash :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_8 :
  core_models.marker.Copy Keccak256Hash :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_10.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes Keccak256Hash :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_10 :
  core_models.fmt.Debug Keccak256Hash :=
  by constructor <;> exact Inhabited.default

@[reducible] instance Impl_4.AssociatedTypes :
  p3_symmetric.hasher.CryptographicHasher.AssociatedTypes
  Keccak256Hash
  u8
  (RustArray u8 32)
  where

instance Impl_4 :
  p3_symmetric.hasher.CryptographicHasher Keccak256Hash u8 (RustArray u8 32)
  where
  hash_iter :=
    fun
      (I : Type)
      [trait_constr_hash_iter_associated_type_i0 :
        core_models.iter.traits.collect.IntoIterator.AssociatedTypes
        I]
      [trait_constr_hash_iter_i0 : core_models.iter.traits.collect.IntoIterator
        I] (self : Keccak256Hash) (input : I) => do
    (pure sorry)
  hash_iter_slices :=
    fun
      (I : Type)
      [trait_constr_hash_iter_slices_associated_type_i0 :
        core_models.iter.traits.collect.IntoIterator.AssociatedTypes
        I]
      [trait_constr_hash_iter_slices_i0 :
        core_models.iter.traits.collect.IntoIterator
        I] (self : Keccak256Hash) (input : I) =>
      do
    let hasher : tiny_keccak.keccak.Keccak ←
      (tiny_keccak.keccak.Impl.v256 rust_primitives.hax.Tuple0.mk);
    let hasher : tiny_keccak.keccak.Keccak ←
      (core_models.iter.traits.iterator.Iterator.fold
        (← (core_models.iter.traits.collect.IntoIterator.into_iter I input))
        hasher
        (fun hasher chunk =>
          (do
          (tiny_keccak.Hasher.update tiny_keccak.keccak.Keccak hasher chunk) :
          RustM tiny_keccak.keccak.Keccak)));
    let output : (RustArray u8 32) ←
      (rust_primitives.hax.repeat (0 : u8) (32 : usize));
    let output : (RustArray u8 32) ←
      (tiny_keccak.Hasher.finalize tiny_keccak.keccak.Keccak hasher output);
    (pure output)

def Impl_4.hash_iter.BUFLEN : usize := (512 : usize)

end p3_keccak

