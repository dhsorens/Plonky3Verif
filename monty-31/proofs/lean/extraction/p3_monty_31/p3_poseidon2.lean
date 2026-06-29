import Hax

/-! Stubs for `p3-poseidon2` traits/types referenced by monty-31's Poseidon2 layer
    impls (those impls are `:= sorry` instances; classes need only correct arity). -/

namespace p3_poseidon2.external

class ExternalLayer.AssociatedTypes (Self : Type) (F : Type) (WIDTH : usize) (D : u64) where
class ExternalLayer (Self : Type) (F : Type) (WIDTH : usize) (D : u64)
  [associatedTypes : outParam (ExternalLayer.AssociatedTypes Self F WIDTH D)] where

class ExternalLayerConstructor.AssociatedTypes (Self : Type) (F : Type) (WIDTH : usize) where
class ExternalLayerConstructor (Self : Type) (F : Type) (WIDTH : usize)
  [associatedTypes : outParam (ExternalLayerConstructor.AssociatedTypes Self F WIDTH)] where

structure ExternalLayerConstants (F : Type) (WIDTH : usize) where

end p3_poseidon2.external

namespace p3_poseidon2.internal

class InternalLayer.AssociatedTypes (Self : Type) (F : Type) (WIDTH : usize) (D : u64) where
class InternalLayer (Self : Type) (F : Type) (WIDTH : usize) (D : u64)
  [associatedTypes : outParam (InternalLayer.AssociatedTypes Self F WIDTH D)] where

class InternalLayerConstructor.AssociatedTypes (Self : Type) (F : Type) where
class InternalLayerConstructor (Self : Type) (F : Type)
  [associatedTypes : outParam (InternalLayerConstructor.AssociatedTypes Self F)] where

end p3_poseidon2.internal

namespace p3_poseidon2.generic

class GenericPoseidon2LinearLayers.AssociatedTypes (Self : Type) (WIDTH : usize) where
class GenericPoseidon2LinearLayers (Self : Type) (WIDTH : usize)
  [associatedTypes : outParam (GenericPoseidon2LinearLayers.AssociatedTypes Self WIDTH)] where

end p3_poseidon2.generic
