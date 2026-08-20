import Hax

/-
  TRUSTED PLACEHOLDER stubs for the external `tiny_keccak` crate.

  `tiny_keccak` is a third-party dependency that hax does not extract, so the
  generated `p3_keccak.lean` references its items by path. These definitions
  exist only to make the extraction *typecheck*; the actual Keccak sponge is
  NOT modelled here (the bodies are no-ops). They are part of the trusted base
  (TCB) — see ../README.md. A future step can replace them with a faithful Lean
  model of Keccak-f and verify equivalence.
-/

namespace tiny_keccak.keccak

/-- Opaque-ish sponge state. Representation is irrelevant to the stub. -/
structure Keccak where
  -- no fields; the real sponge state is not modelled
  deriving Inhabited

namespace Impl
/-- `Keccak::v256()` — fresh SHA3-256 sponge. -/
def v256 (_ : rust_primitives.hax.Tuple0) : RustM Keccak := pure {}
end Impl

end tiny_keccak.keccak

namespace tiny_keccak

/-- `Hasher::update(&mut self, data)` — absorb `data`. Stub: leaves state unchanged.
    `data` is left polymorphic (`{α}`) on purpose: the extracted `hash_iter` /
    `hash_iter_slices` pass an element whose type comes from the iterator's
    associated `Item`, which the current Hax `IntoIterator` model does not pin to
    `[u8]` (engine/proof-lib skew). Accepting any `α` lets the generated bodies
    typecheck without that constraint. -/
def Hasher.update (Self : Type) (self : Self) {α : Type} (_data : α) : RustM Self :=
  pure self

/-- `Hasher::finalize(self, output)` — squeeze into `output`. Stub: returns `output` as-is. -/
def Hasher.finalize
    (Self : Type) (_self : Self) (output : (RustArray u8 32)) :
    RustM (RustArray u8 32) :=
  pure output

end tiny_keccak

namespace tiny_keccak.keccakf

/-- `keccakf(state)` — the Keccak-f[1600] permutation. Stub: identity. -/
def keccakf (input : (RustArray u64 25)) : RustM (RustArray u64 25) :=
  pure input

end tiny_keccak.keccakf
