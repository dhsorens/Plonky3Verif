# p3-symmetric extraction — trusted/unverified surface

Scope: only the `sorry`s + patches specific to *this* extraction. The general
TCB (hax engine, Hax proof library, Lean kernel, toolchain) is out of scope.

Nothing here is proven. `lake build` type-checks; it does not verify anything.

## A. Scoping patch (the big one)

`build-lean.sh` **slices** the generated `p3_symmetric.lean` down to the two
trait-class namespaces and **drops the rest of the crate**:

- **Kept:** `p3_symmetric.hasher` (`CryptographicHasher`) and
  `p3_symmetric.permutation` (`Permutation`, `CryptographicPermutation`, …) —
  the interface keccak/blake3/koala-bear consume.
- **Dropped (not present in the compiled file at all):** `sponge`, `hash`
  (`Hash`/`MerkleCap`), `serializing_hasher`, and the `compression`
  implementation namespaces. These were the entire `MerkleCap`/sponge/hashing
  machinery; they did not type-check against the pinned Hax proof-lib (missing
  `num-bigint`, `serde`, `itertools`, `p3_field` hierarchy, iterator
  combinators) and are unused by the current dependents. **Trust cost:** any
  future use of those modules is simply absent — there is nothing to trust yet,
  but also nothing extracted.

## B. Other post-extraction patches to `p3_symmetric.lean`

1. **Inject `import p3_symmetric.dependencies`** — plumbing.
2. **Delete `(associatedTypes := { … with Item := … })` overrides** — the engine
   encodes `IntoIterator<Item=…>` via an `Item` field the proof-lib's
   `IntoIterator.AssociatedTypes` lacks (engine ↔ proof-lib skew). Stripping it
   lets the bound infer; the `Item = …` constraint is no longer type-enforced.

## C. `sorry` in the kept trait classes

The trait methods' **default** bodies are replaced with `sorry` (5 declarations
flagged). In Rust these defaults are mutually-recursive iterator plumbing
(`CryptographicHasher::{hash_iter_slices, hash_slice, hash_item}`,
`Permutation::{permute, permute_mut}`) that builds `Cloned`/`Flatten`/`Once`
adapters; that can't be expressed against the pinned proof-lib. Every concrete
instance overrides the method it actually implements, so these defaults are
never the ones used — but they are unproven placeholders.

The trait-class **signatures themselves** (fields, super-trait bounds, associated
types) are the genuine hax-extracted definitions and are *not* sorried — that is
exactly the interface keccak/blake3 type-check against.

## To shrink this list

- Bring the dropped impl modules back by stubbing/​modelling `num-bigint`,
  `serde`, `itertools`, the `p3_field` hierarchy, and the missing iterator
  combinators (the "full crate" path).
- Model the trait default bodies (or upstream the missing iterator adapters) to
  remove the §C `sorry`s.
