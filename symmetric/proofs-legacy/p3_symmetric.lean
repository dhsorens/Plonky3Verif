
-- Experimental lean backend for Hax
-- The Hax prelude library can be found in hax/proof-libs/lean
import Hax
import p3_symmetric.dependencies
import Std.Tactic.Do
import Std.Do.Triple
import Std.Tactic.Do.Syntax
open Std.Do
open Std.Tactic

set_option mvcgen.warning false
set_option linter.unusedVariables false


namespace p3_symmetric.hasher

--  A generic trait for cryptographic hashers that consume an arbitrary sequence of input items
--  and produce a fixed-size output.
-- 
--  This trait abstracts over hash functions in a flexible way, supporting both field elements,
--  scalars, or any other data type that implements `Clone`.
class CryptographicHasher.AssociatedTypes
  (Self : Type)
  (Item : Type)
  (Out : Type)
  where
  [trait_constr_CryptographicHasher_i0 :
  core_models.clone.Clone.AssociatedTypes
  Self]
  [trait_constr_CryptographicHasher_i1 :
  core_models.clone.Clone.AssociatedTypes
  Item]

attribute [instance_reducible, instance]
  CryptographicHasher.AssociatedTypes.trait_constr_CryptographicHasher_i0

attribute [instance_reducible, instance]
  CryptographicHasher.AssociatedTypes.trait_constr_CryptographicHasher_i1

class CryptographicHasher (Self : Type) (Item : Type) (Out : Type)
  [associatedTypes : outParam (CryptographicHasher.AssociatedTypes (Self : Type)
      (Item : Type) (Out : Type))]
  where
  [trait_constr_CryptographicHasher_i0 : core_models.clone.Clone Self]
  [trait_constr_CryptographicHasher_i1 : core_models.clone.Clone Item]
  hash_iter (Self) (Item) (Out)
    (I : Type)
    [trait_constr_hash_iter_associated_type_i1 :
      core_models.iter.traits.collect.IntoIterator.AssociatedTypes
      I]
    [trait_constr_hash_iter_i1 : core_models.iter.traits.collect.IntoIterator
      I] :
    (Self -> I -> RustM Out)
  hash_iter_slices (Self) (Item) (Out)
    (I : Type)
    [trait_constr_hash_iter_slices_associated_type_i1 :
      core_models.iter.traits.collect.IntoIterator.AssociatedTypes
      I]
    [trait_constr_hash_iter_slices_i1 :
      core_models.iter.traits.collect.IntoIterator
      I] (self : Self) (input : I) :RustM Out := sorry
  hash_slice (Self) (Item) (Out) (self : Self) (input : (RustSlice Item)) :RustM
    Out := sorry
  hash_item (Self) (Item) (Out) (self : Self) (input : Item) :RustM Out := sorry

attribute [instance_reducible, instance]
  CryptographicHasher.trait_constr_CryptographicHasher_i0

attribute [instance_reducible, instance]
  CryptographicHasher.trait_constr_CryptographicHasher_i1

end p3_symmetric.hasher
namespace p3_symmetric.permutation

--  A permutation in the mathematical sense.
class Permutation.AssociatedTypes (Self : Type) (T : Type) where
  [trait_constr_Permutation_i0 : core_models.clone.Clone.AssociatedTypes Self]
  [trait_constr_Permutation_i1 : core_models.marker.Sync.AssociatedTypes Self]
  [trait_constr_Permutation_i2 : core_models.clone.Clone.AssociatedTypes T]

attribute [instance_reducible, instance]
  Permutation.AssociatedTypes.trait_constr_Permutation_i0

attribute [instance_reducible, instance]
  Permutation.AssociatedTypes.trait_constr_Permutation_i1

attribute [instance_reducible, instance]
  Permutation.AssociatedTypes.trait_constr_Permutation_i2

class Permutation (Self : Type) (T : Type)
  [associatedTypes : outParam (Permutation.AssociatedTypes (Self : Type) (T :
      Type))]
  where
  [trait_constr_Permutation_i0 : core_models.clone.Clone Self]
  [trait_constr_Permutation_i1 : core_models.marker.Sync Self]
  [trait_constr_Permutation_i2 : core_models.clone.Clone T]
  permute (Self) (T) (self : Self) (input : T) :RustM T := sorry
  permute_mut (Self) (T) (self : Self) (input : T) :RustM T := sorry

attribute [instance_reducible, instance] Permutation.trait_constr_Permutation_i0

attribute [instance_reducible, instance] Permutation.trait_constr_Permutation_i1

attribute [instance_reducible, instance] Permutation.trait_constr_Permutation_i2

end p3_symmetric.permutation
namespace p3_symmetric.permutation

--  A permutation thought to be cryptographically secure, in the sense that it is thought to be
--  difficult to distinguish (in a nontrivial way) from a random permutation.
class CryptographicPermutation.AssociatedTypes (Self : Type) (T : Type) where
  [trait_constr_CryptographicPermutation_i0 :
  Permutation.AssociatedTypes
  Self
  T]
  [trait_constr_CryptographicPermutation_i1 :
  core_models.clone.Clone.AssociatedTypes
  T]

attribute [instance_reducible, instance]
  CryptographicPermutation.AssociatedTypes.trait_constr_CryptographicPermutation_i0

attribute [instance_reducible, instance]
  CryptographicPermutation.AssociatedTypes.trait_constr_CryptographicPermutation_i1

class CryptographicPermutation (Self : Type) (T : Type)
  [associatedTypes : outParam (CryptographicPermutation.AssociatedTypes (Self :
      Type) (T : Type))]
  where
  [trait_constr_CryptographicPermutation_i0 : Permutation Self T]
  [trait_constr_CryptographicPermutation_i1 : core_models.clone.Clone T]

attribute [instance_reducible, instance]
  CryptographicPermutation.trait_constr_CryptographicPermutation_i0

attribute [instance_reducible, instance]
  CryptographicPermutation.trait_constr_CryptographicPermutation_i1

end p3_symmetric.permutation
namespace p3_symmetric.permutation

--  A derangement: a permutation with no fixed points (d(x) != x for all x).
-- 
--  The standard choice is d(x) = x + 1 (via `Increment`).
class Derangement.AssociatedTypes (Self : Type) (T : Type) where
  [trait_constr_Derangement_i0 : Permutation.AssociatedTypes Self T]
  [trait_constr_Derangement_i1 : core_models.clone.Clone.AssociatedTypes T]

attribute [instance_reducible, instance]
  Derangement.AssociatedTypes.trait_constr_Derangement_i0

attribute [instance_reducible, instance]
  Derangement.AssociatedTypes.trait_constr_Derangement_i1

class Derangement (Self : Type) (T : Type)
  [associatedTypes : outParam (Derangement.AssociatedTypes (Self : Type) (T :
      Type))]
  where
  [trait_constr_Derangement_i0 : Permutation Self T]
  [trait_constr_Derangement_i1 : core_models.clone.Clone T]

attribute [instance_reducible, instance] Derangement.trait_constr_Derangement_i0

attribute [instance_reducible, instance] Derangement.trait_constr_Derangement_i1

end p3_symmetric.permutation
