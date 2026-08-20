import Hax

/-
  Shims for `core_models.*` items that the extracted `p3_blake3.lean` references
  but that THIS Hax proof-library version does not provide (the hax engine emits
  them; the pinned proof-lib predates them). Defined here — in a dependency file
  — with placeholder bodies so `p3_blake3.lean` compiles UNCHANGED, as clean hax
  output. Trusted placeholder; a faithful model is future work.

  (This is the trimmed counterpart of keccak's core_shims.lean: blake3 only uses
  `Iterator.fold`, so the `from/to_le_bytes` and range-indexing stubs are omitted.)
-/

namespace core_models.iter.traits.iterator

/-- `Iterator::fold`. The proof-lib lacks it. Item type is fixed to `RustSlice u8`
    because the only call site (`Blake3::hash_iter_slices`) folds over `&[u8]`
    chunks; a polymorphic version would need the `IntoIterator` Item associated
    type the proof-lib doesn't track. Placeholder body. -/
def Iterator.fold {S B : Type} (_self : S) (init : B)
    (_f : B → RustSlice u8 → RustM B) : RustM B :=
  pure init

end core_models.iter.traits.iterator
