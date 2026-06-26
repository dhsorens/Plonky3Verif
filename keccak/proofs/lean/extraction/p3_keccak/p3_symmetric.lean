import Hax

/-
  Trait-class stubs for `p3_symmetric`, the only items the extracted
  `p3_keccak.lean` needs from that crate. The class *signatures* are lifted
  verbatim from p3_symmetric's own hax extraction (same hax version → identical
  encoding); the default method *bodies* are dropped or replaced because they
  reference iterator-model combinators (`Iterator.flatten`/`cloned`,
  `sources.once.once`) and mutually-recursive projections that this Hax proof
  library / Lean version does not support standalone. keccak's instances
  override every method they actually use, so the stripped defaults are never
  exercised by the extraction. Part of the trusted base — see ../README.md.
-/

namespace p3_symmetric.hasher

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
      I] (self : Self) (input : I) : RustM Out

attribute [instance_reducible, instance]
  CryptographicHasher.trait_constr_CryptographicHasher_i0

attribute [instance_reducible, instance]
  CryptographicHasher.trait_constr_CryptographicHasher_i1

end p3_symmetric.hasher

namespace p3_symmetric.permutation

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
  -- Rust's `Permutation` defines `permute`/`permute_mut` circularly (implement
  -- either, get the other). The real defaults don't elaborate standalone here,
  -- so these are placeholder identity defaults — UNUSED, because every keccak
  -- instance overrides the one method it implements and never calls the other.
  permute (Self) (T) (self : Self) (input : T) : RustM T := pure input
  permute_mut (Self) (T) (self : Self) (input : T) : RustM T := pure input

attribute [instance_reducible, instance] Permutation.trait_constr_Permutation_i0

attribute [instance_reducible, instance] Permutation.trait_constr_Permutation_i1

attribute [instance_reducible, instance] Permutation.trait_constr_Permutation_i2

end p3_symmetric.permutation

namespace p3_symmetric.permutation

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
