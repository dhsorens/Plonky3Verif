# Keccak extraction — trusted/unverified surface

Scope: **only** the `sorry`s, post-extraction patches, and placeholder stubs
specific to *this* extraction. The general TCB (the hax engine's faithfulness,
the Hax proof library, the Lean kernel, the toolchain) is out of scope here.

Nothing in this directory is proven. `lake build` type-checks; it does not verify
that the extracted code computes Keccak. Anything below must be discharged before
any theorem about `p3-keccak` means something.

---

## A. Patches applied to the generated `p3_keccak.lean`

These are mechanical post-processing steps (`build-lean.sh`) on hax's output — we
patch the *output*, never `keccak/src`.

1. **Inject `import p3_keccak.dependencies`** after `import Hax`. Pure plumbing
   (pulls in the stub modules); no semantic effect.
2. **Delete `(associatedTypes := { … with Item := … })` overrides.** The hax
   engine emits an `IntoIterator<Item = …>` bound by setting an `Item` field that
   does not exist in the pinned Hax proof-lib's `IntoIterator.AssociatedTypes`
   (engine ↔ proof-lib version skew). Dropping the override lets the bound infer.
   **Trust cost:** the `Item = u8` / `Item = &[u8]` constraints are no longer
   enforced by the types; correctness of the iterator element type is assumed.

**Generation choice (not a patch, but it shapes what is extracted):**
extraction runs with `-C target-feature=-sha3`, so keccak's **scalar** path is
extracted, not the aarch64 NEON/SHA3 SIMD module. The SIMD implementation is
therefore not represented in Lean at all.

---

## B. `sorry` in `p3_keccak.lean` (the extracted file)

| Definition | Why it is `sorry` |
|------------|-------------------|
| `KeccakF : Permutation [[u64;1];25]` — `permute_mut` (fallback packed, width-1) | hax can't translate the body's `unsafe { transmute::<&mut …>() }` reinterpret of `&mut [[u64;1];25]` as `&mut [u64;25]`. |
| `Keccak256Hash : CryptographicHasher … ` — `hash_iter` | hax can't translate `p3_util::apply_to_chunks(input, \|buf\| hasher.update(buf))` — a closure with a **mutable capture** of `hasher`. (The `../../rust-patch/` experiment rewrites this in Rust; it is not applied in this build.) |

Note `hash_iter_slices` is **not** `sorry` here, but its body calls the trusted
stubs in §C, so it is only as trustworthy as those.

---

## C. Dependency stubs (trusted placeholders, in `p3_keccak/`)

These typecheck the extraction but do **not** implement the real behaviour.

### `tiny_keccak.lean` — the external `tiny_keccak` crate is unmodelled
| Item | Stub behaviour | Risk |
|------|----------------|------|
| `keccak.Keccak` | empty structure | sponge state not represented |
| `keccak.Impl.v256` | `pure {}` | — |
| `Hasher.update` | `pure self` (**no-op**, accepts any `data : α`) | absorbed data is **ignored** |
| `Hasher.finalize` | `pure output` (returns the zero-init buffer) | digest is **not** computed |
| `keccakf.keccakf` | `pure input` (**identity**) | the Keccak-f permutation is **not** computed |

These are the most dangerous entries: they are total, type-correct, and **wrong**
(no-op / identity), so code built on them looks complete but computes nothing.

### `core_shims.lean` — `core_models.*` items missing from the pinned proof-lib
| Item | Stub behaviour |
|------|----------------|
| `iter…Iterator.fold` | `pure init` — folds **zero** elements (item type hard-coded to `RustSlice u8`) |
| `num.Impl_9.from_le_bytes` | `sorry` |
| `num.Impl_9.to_le_bytes` | `sorry` |
| `GetElemResult … RangeFrom` / `RangeTo` (range slicing) | `sorry` |

### `p3_symmetric.lean` — trait classes
Class **signatures** are lifted verbatim from p3_symmetric's own extraction (low
risk — structural). The only placeholder bodies are `Permutation.permute` /
`permute_mut`'s identity defaults; keccak's instances override the method they
use, so these defaults are **unused** by the extraction.

---

## To shrink this list

- Model `tiny_keccak::keccakf` (and the sponge) faithfully in Lean → discharges
  most of §C and makes the hashers meaningful.
- Add the missing `core_models` items upstream (or a faithful local model) →
  removes `core_shims` `sorry`s and the §A.2 patch.
- Generalise the `Iterator.fold` shim + apply the `rust-patch/` hash_iter rewrite
  → removes one §B `sorry`.
