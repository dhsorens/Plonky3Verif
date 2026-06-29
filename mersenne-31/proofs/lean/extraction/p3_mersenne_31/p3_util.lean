import Hax

/-! Stubs for the `p3-util` free functions mersenne-31 references (extension-field
    flattening + the prime-field GCD inversion). Stubbed, not extracted. -/

namespace p3_util

-- Extension <-> base-slice conversions. Best-effort opaque signatures; the exact
-- value/return shapes are refined against the call sites (see TCB.md).
opaque as_base_slice (Base : Type) (Ext : Type) (x : Ext) :
  RustM (RustSlice Base)

opaque flatten_to_base (Base : Type) (Ext : Type)
  (v : (alloc.vec.Vec Ext alloc.alloc.Global)) :
  RustM (alloc.vec.Vec Base alloc.alloc.Global)

opaque reconstitute_from_base (Base : Type) (Ext : Type)
  (v : (alloc.vec.Vec Base alloc.alloc.Global)) :
  RustM (alloc.vec.Vec Ext alloc.alloc.Global)

-- GCD-based inversion in a 32-bit prime field: gcd_inversion_prime_field_32 bits x p.
opaque gcd_inversion_prime_field_32 (bits : u32) (x : u32) (p : u32) : RustM i64

end p3_util
