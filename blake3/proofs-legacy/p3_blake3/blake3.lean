import Hax

/-
  TRUSTED PLACEHOLDER stubs for the external `blake3` crate (crates.io), which
  hax does not extract — the generated `p3_blake3.lean` only references its items
  by path. These make the extraction typecheck; the actual BLAKE3 hash is NOT
  modelled (bodies are no-ops). Part of the trusted base — see ../README.md.
  Analogous to keccak's `tiny_keccak.lean`.
-/

namespace blake3

/-- `blake3::Hasher` — incremental hasher state. Representation irrelevant. -/
structure Hasher where
  deriving Inhabited

/-- `blake3::Hash` — a finalized 32-byte digest wrapper. -/
structure Hash where
  deriving Inhabited

namespace Impl_14
/-- `Hasher::new()`. -/
def new (_ : rust_primitives.hax.Tuple0) : RustM Hasher := pure {}
/-- `Hasher::finalize(&self) -> Hash`. Stub: returns an unspecified digest. -/
def finalize (_self : Hasher) : RustM Hash := pure {}
end Impl_14

/-- `impl From<Hash> for [u8; 32]` ⇒ `Into<[u8;32]>` for `Hash`. Stub: zero. -/
@[reducible] instance : core_models.convert.Into.AssociatedTypes Hash (RustArray u8 32) where

instance : core_models.convert.Into Hash (RustArray u8 32) where
  into := fun (_self : Hash) => rust_primitives.hax.repeat (0 : u8) (32 : usize)

end blake3
