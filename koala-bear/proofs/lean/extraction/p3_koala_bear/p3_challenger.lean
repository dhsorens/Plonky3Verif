import Hax

namespace p3_challenger.duplex_challenger

--  Trait for fields that support uniform bit sampling optimizations
class UniformSamplingField.AssociatedTypes (Self : Type) where

class UniformSamplingField (Self : Type)
  [associatedTypes : outParam (UniformSamplingField.AssociatedTypes (Self :
      Type))]
  where
  MAX_SINGLE_SAMPLE_BITS (Self) : usize
  SAMPLING_BITS_M (Self) : (RustArray u64 64)

end p3_challenger.duplex_challenger
