import Hax

/-! Stubs for the `p3-util` free functions goldilocks references. Stubbed, not
    extracted (deferred). Signatures are best-effort, refined vs the call sites. -/

namespace p3_util

opaque branch_hint (x : rust_primitives.hax.Tuple0) : RustM rust_primitives.hax.Tuple0

-- Extended-GCD inner loop: returns (a, b, 2x2 transform matrix of coefficients).
opaque gcd_inner (n : usize) (a : u64) (b : u64) :
  RustM (u64 × u64 × (i128 × i128 × i128 × i128))

opaque flatten_to_base (Base : Type) (Ext : Type)
  (v : (alloc.vec.Vec Ext alloc.alloc.Global)) :
  RustM (alloc.vec.Vec Base alloc.alloc.Global)

end p3_util
