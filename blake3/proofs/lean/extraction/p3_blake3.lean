
-- Experimental lean backend for Hax
-- The Hax prelude library can be found in hax/proof-libs/lean
import Hax
import p3_blake3.dependencies
import Std.Tactic.Do
import Std.Do.Triple
import Std.Tactic.Do.Syntax
open Std.Do
open Std.Tactic

set_option mvcgen.warning false
set_option linter.unusedVariables false


namespace p3_blake3

--  The blake3 hash function.
structure Blake3 where
  -- no fields

@[instance] opaque Impl_2.AssociatedTypes :
  core_models.clone.Clone.AssociatedTypes Blake3 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_2 :
  core_models.clone.Clone Blake3 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_1.AssociatedTypes :
  core_models.marker.Copy.AssociatedTypes Blake3 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_1 :
  core_models.marker.Copy Blake3 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_3.AssociatedTypes :
  core_models.fmt.Debug.AssociatedTypes Blake3 :=
  by constructor <;> exact Inhabited.default

@[instance] opaque Impl_3 :
  core_models.fmt.Debug Blake3 :=
  by constructor <;> exact Inhabited.default

@[reducible] instance Impl.AssociatedTypes :
  p3_symmetric.hasher.CryptographicHasher.AssociatedTypes
  Blake3
  u8
  (RustArray u8 32)
  where

instance Impl :
  p3_symmetric.hasher.CryptographicHasher Blake3 u8 (RustArray u8 32)
  where
  hash_iter :=
    fun
      (I : Type)
      [trait_constr_hash_iter_associated_type_i0 :
        core_models.iter.traits.collect.IntoIterator.AssociatedTypes
        I]
      [trait_constr_hash_iter_i0 : core_models.iter.traits.collect.IntoIterator
        I] (self : Blake3) (input : I) => do
    let hasher : blake3.Hasher ←
      (blake3.Impl_14.new rust_primitives.hax.Tuple0.mk);
    let _ ←
      (p3_util.apply_to_chunks
        ((512 : usize))
        I
        ((RustSlice u8) -> RustM rust_primitives.hax.Tuple0)
        input
        (fun buf => (do (pure sorry) : RustM rust_primitives.hax.Tuple0)));
    (core_models.convert.Into.into
      blake3.Hash
      (RustArray u8 32) (← (blake3.Impl_14.finalize hasher)))
  hash_iter_slices :=
    fun
      (I : Type)
      [trait_constr_hash_iter_slices_associated_type_i0 :
        core_models.iter.traits.collect.IntoIterator.AssociatedTypes
        I]
      [trait_constr_hash_iter_slices_i0 :
        core_models.iter.traits.collect.IntoIterator
        I] (self : Blake3) (input : I) => do
    let hasher : blake3.Hasher ←
      (blake3.Impl_14.new rust_primitives.hax.Tuple0.mk);
    let _ ←
      (core_models.iter.traits.iterator.Iterator.fold
        (← (core_models.iter.traits.collect.IntoIterator.into_iter I input))
        rust_primitives.hax.Tuple0.mk
        (fun _ chunk => (do (pure sorry) : RustM rust_primitives.hax.Tuple0)));
    (core_models.convert.Into.into
      blake3.Hash
      (RustArray u8 32) (← (blake3.Impl_14.finalize hasher)))

def Impl.hash_iter.BUFLEN : usize := (512 : usize)

end p3_blake3

