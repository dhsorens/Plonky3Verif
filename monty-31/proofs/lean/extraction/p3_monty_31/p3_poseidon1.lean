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
