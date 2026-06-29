import Hax

/-! Stubs for `p3-mds` traits referenced by monty-31's MDS-matrix impls
    (`:= sorry` instances; classes need only correct arity). -/

namespace p3_mds

class MdsPermutation.AssociatedTypes (Self : Type) (T : Type) (N : usize) where
class MdsPermutation (Self : Type) (T : Type) (N : usize)
  [associatedTypes : outParam (MdsPermutation.AssociatedTypes Self T N)] where

end p3_mds

namespace p3_mds.karatsuba_convolution

class Convolve.AssociatedTypes (Self : Type) (T : Type) (U : Type) (V : Type) where
class Convolve (Self : Type) (T : Type) (U : Type) (V : Type)
  [associatedTypes : outParam (Convolve.AssociatedTypes Self T U V)] where

end p3_mds.karatsuba_convolution
