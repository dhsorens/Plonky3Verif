import Hax

/-! Stubs for `p3-poseidon` traits/types that monty-31's Poseidon1 layer impls
    reference. monty-31's `impl` blocks for these are `:= sorry` instances, so the
    classes only need correct arity; the constant structs need to exist as types. -/

namespace p3_poseidon1.external

class FullRoundLayer.AssociatedTypes (Self : Type) (F : Type) (WIDTH : usize) (D : u64) where
class FullRoundLayer (Self : Type) (F : Type) (WIDTH : usize) (D : u64)
  [associatedTypes : outParam (FullRoundLayer.AssociatedTypes Self F WIDTH D)] where

class FullRoundLayerConstructor.AssociatedTypes (Self : Type) (F : Type) (WIDTH : usize) where
class FullRoundLayerConstructor (Self : Type) (F : Type) (WIDTH : usize)
  [associatedTypes : outParam (FullRoundLayerConstructor.AssociatedTypes Self F WIDTH)] where

structure FullRoundConstants (F : Type) (WIDTH : usize) where

end p3_poseidon1.external

namespace p3_poseidon1.internal

class PartialRoundLayer.AssociatedTypes (Self : Type) (F : Type) (WIDTH : usize) (D : u64) where
class PartialRoundLayer (Self : Type) (F : Type) (WIDTH : usize) (D : u64)
  [associatedTypes : outParam (PartialRoundLayer.AssociatedTypes Self F WIDTH D)] where

class PartialRoundLayerConstructor.AssociatedTypes (Self : Type) (F : Type) (WIDTH : usize) where
class PartialRoundLayerConstructor (Self : Type) (F : Type) (WIDTH : usize)
  [associatedTypes : outParam (PartialRoundLayerConstructor.AssociatedTypes Self F WIDTH)] where

structure PartialRoundConstants (F : Type) (WIDTH : usize) where

end p3_poseidon1.internal

namespace p3_poseidon1.generic

class GenericPoseidon1LinearLayers.AssociatedTypes (Self : Type) (F : Type) (WIDTH : usize) where
class GenericPoseidon1LinearLayers (Self : Type) (F : Type) (WIDTH : usize)
  [associatedTypes : outParam (GenericPoseidon1LinearLayers.AssociatedTypes Self F WIDTH)] where

end p3_poseidon1.generic

namespace p3_poseidon1

structure Poseidon1
  (F : Type) (FullRoundPerm : Type) (PartialRoundPerm : Type)
  (WIDTH : usize) (D : u64)
  where
  full_round_layer : FullRoundPerm
  partial_round_layer : PartialRoundPerm
  _phantom : (core_models.marker.PhantomData F)

structure Poseidon1Constants (F : Type) (WIDTH : usize) where
  rounds_f : usize
  rounds_p : usize
  mds_circ_col : (RustArray i64 WIDTH)
  round_constants : (alloc.vec.Vec (RustArray F WIDTH) alloc.alloc.Global)

opaque Impl_1.new
    (F : Type) (FullRoundPerm : Type) (PartialRoundPerm : Type)
    (WIDTH : usize) (D : u64)
    (raw : (Poseidon1Constants F (WIDTH))) :
    RustM (Poseidon1 F FullRoundPerm PartialRoundPerm (WIDTH) (D))

end p3_poseidon1

namespace p3_poseidon1.generic

-- Generic Poseidon1 layer perm types (used as the FullRound/PartialRound perm params).
opaque Poseidon1ExternalLayerGeneric (F : Type) (Mds : Type) (WIDTH : usize) : Type
opaque Poseidon1InternalLayerGeneric (F : Type) (WIDTH : usize) : Type

end p3_poseidon1.generic
