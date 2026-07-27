import Hax

/-! koala-bear-specific supplementary stubs not carried by monty-31's shared
    field-agnostic stubs: the per-field exponentiation helper and the blanket
    array→slice `AsRef` for monty-31's `BinomialExtensionData.ArrayLike` bound. -/

@[reducible] instance {T : Type} {N : usize} :
  core_models.convert.AsRef.AssociatedTypes (RustArray T N) (RustSlice T) where
instance {T : Type} {N : usize} :
  core_models.convert.AsRef (RustArray T N) (RustSlice T) where
  as_ref := sorry

namespace p3_field.exponentiation

opaque exp_1420470955 (R : Type) (val : R) : RustM R

end p3_field.exponentiation
