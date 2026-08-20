import Hax

/-! `serde` stubs: monty-31's Serialize/Deserialize impls are `:= sorry`
    instances, so the classes need only correct arity. -/
namespace serde_core.ser

class Serialize.AssociatedTypes (Self : Type) where
class Serialize (Self : Type)
  [associatedTypes : outParam (Serialize.AssociatedTypes Self)] where

end serde_core.ser

namespace serde_core.de

class Deserialize.AssociatedTypes (Self : Type) where
class Deserialize (Self : Type)
  [associatedTypes : outParam (Deserialize.AssociatedTypes Self)] where

end serde_core.de
