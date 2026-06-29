import Hax

/-
  Shims for `core_models.*` / `rust_primitives.*` items that the extracted
  `p3_keccak.lean` references but that THIS Hax proof-library version does not
  provide (the hax engine at ad110bfa emits them; the pinned proof-lib predates
  them). They are defined here — in a dependency file — with placeholder bodies
  so that `p3_keccak.lean` compiles UNCHANGED, as clean hax output. All of these
  are trusted placeholders / `sorry`; faithful models are future work. None of
  the keccak *spec* relies on them being correct yet.
-/

namespace core_models.iter.traits.iterator

/-- `Iterator::fold`. The proof-lib lacks it. Item type is fixed to `RustSlice u8`
    because the only call site (`Keccak256Hash::hash_iter_slices`) folds over
    `&[u8]` chunks; a polymorphic version would need the `IntoIterator` Item
    associated type the proof-lib doesn't track. Placeholder body. -/
def Iterator.fold {S B : Type} (_self : S) (init : B)
    (_f : B → RustSlice u8 → RustM B) : RustM B :=
  pure init

end core_models.iter.traits.iterator

namespace core_models.num

/-- `u64::from_le_bytes`. Placeholder. -/
def Impl_9.from_le_bytes (_bytes : (RustArray u8 8)) : RustM u64 := sorry

/-- `u64::to_le_bytes`. Placeholder. -/
def Impl_9.to_le_bytes (_x : u64) : RustM (RustArray u8 8) := sorry

end core_models.num

/-
  Range-slicing index instances `xs[a..]_?` and `xs[..b]_?`. The proof-lib only
  ships `usize`/`Nat` element indexing on `RustArray`/`Seq`; these add the range
  forms used by `KeccakF::permute` on `[u8; 200]`. Placeholder bodies.
-/

instance instGetElemResultArrayRangeFrom {α n} :
    GetElemResult (RustArray α n) (core_models.ops.range.RangeFrom usize) (RustSlice α) where
  getElemResult _xs _r := sorry

instance instGetElemResultSliceRangeTo {α} :
    GetElemResult (RustSlice α) (core_models.ops.range.RangeTo usize) (RustSlice α) where
  getElemResult _xs _r := sorry
