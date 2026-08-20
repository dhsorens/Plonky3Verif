# Blake3 extraction — trusted/unverified surface

Scope: **only** the `sorry`s, post-extraction patches, and placeholder stubs
specific to *this* extraction. The general TCB (hax engine, Hax proof library,
Lean kernel, toolchain) is out of scope.

Nothing here is proven. `lake build` type-checks; it does not verify that the
extracted code computes BLAKE3. Everything below must be discharged before any
theorem about `p3-blake3` means something.

---

## A. Patches applied to the generated `p3_blake3.lean`

Mechanical post-processing (`build-lean.sh`) on hax's output — we patch the
*output*, never `blake3/src`.

1. **Inject `import p3_blake3.dependencies`** after `import Hax`. Pure plumbing.
2. **Delete `(associatedTypes := { … with Item := … })` overrides.** The hax
   engine encodes the `IntoIterator<Item = …>` bound by setting an `Item` field
   that does not exist in the pinned Hax proof-lib's `IntoIterator.AssociatedTypes`
   (engine ↔ proof-lib version skew). Dropping it lets the bound infer.
   **Trust cost:** the `Item = u8` / `Item = &[u8]` constraints are no longer
   enforced by the types.

(No `-C target-feature` extraction flag is needed — the `blake3` crate's SIMD is
external and never extracted.)

---

## B. `sorry` in `p3_blake3.lean` (the extracted file)

Both are closure bodies hax can't translate; both sit inside the one
`Blake3 : CryptographicHasher` instance.

| Definition | Why it is `sorry` |
|------------|-------------------|
| `Blake3::hash_iter` | the closure `\|buf\| hasher.update(buf)` passed to `p3_util::apply_to_chunks` — a **mutable capture** of `hasher`. |
| `Blake3::hash_iter_slices` | the `for chunk in input { hasher.update(chunk) }` loop body — `blake3::Hasher::update` returns `&mut Self`, which hax can't thread. |

---

## C. Dependency stubs (trusted placeholders, in `p3_blake3/`)

Typecheck the extraction but do **not** implement the real behaviour.

### `blake3.lean` — the external `blake3` crate is unmodelled
| Item | Stub behaviour | Risk |
|------|----------------|------|
| `Hasher` / `Hash` | empty structures | state/digest not represented |
| `Impl_14.new` | `pure {}` | — |
| `Impl_14.finalize` | `pure {}` (returns an unspecified `Hash`) | digest is **not** computed |
| `Into Hash [u8;32]` (`into`) | returns the all-zero array | digest bytes are **wrong** (constant 0) |

### `p3_util.lean`
| Item | Stub behaviour |
|------|----------------|
| `apply_to_chunks` | **no-op** (`pure ()`); ignores input and `func` |

### `core_shims.lean`
| Item | Stub behaviour |
|------|----------------|
| `iter…Iterator.fold` | `pure init` — folds **zero** elements (item type hard-coded to `RustSlice u8`) |

### `p3_symmetric.lean`
Class **signatures** lifted verbatim from p3_symmetric's own extraction (low risk
— structural). The only placeholder bodies are `Permutation.permute` /
`permute_mut`'s identity defaults, which blake3 never uses (it implements only
`CryptographicHasher`).

> Combined effect: `hash_iter`/`hash_iter_slices` would, if their `sorry`s were
> filled with the current stubs, return a **constant zero digest**. So the whole
> hash path is currently a placeholder — the value here is that the extracted
> structure type-checks and gives a scaffold to fill in.

---

## To shrink this list

- Model `blake3::Hasher` (`new`/`update`/`finalize`) and the `Into` digest
  faithfully → makes the hashers meaningful (and lets the §B closures be filled).
- Add `Iterator.fold` upstream (or a faithful local model) → removes the
  `core_shims` placeholder and lets `hash_iter_slices` compute.
- Model `apply_to_chunks` (or rewrite `hash_iter` to an explicit loop) → removes
  that stub and one §B `sorry`.
