import Hax

/-
  Stub for `p3_util::apply_to_chunks`, referenced by `Blake3::hash_iter`. hax does
  not bring the real (unsafe, MaybeUninit-based) implementation into a buildable
  form here, and the closure passed to it is already `sorry` in the extraction, so
  this no-op suffices to typecheck. Trusted placeholder — see ../README.md.
-/

namespace p3_util

/-- `apply_to_chunks::<BUFLEN, I, H>(input, func)` — buffers `input` into chunks
    and calls `func` on each. Stub: does nothing. -/
def apply_to_chunks (_BUFLEN : usize) (I : Type) (H : Type) (_input : I) (_func : H) :
    RustM rust_primitives.hax.Tuple0 :=
  pure rust_primitives.hax.Tuple0.mk

end p3_util
