import Hax

/-! `rand` stubs: monty-31's `Distribution<StandardUniform>` impl is a `:= sorry`
    instance, so we need only the marker type + the class with correct arity. -/
namespace rand.distr

opaque StandardUniform : Type

end rand.distr

namespace rand.distr.distribution

class Distribution.AssociatedTypes (Self : Type) (T : Type) where
class Distribution (Self : Type) (T : Type)
  [associatedTypes : outParam (Distribution.AssociatedTypes Self T)] where

end rand.distr.distribution
