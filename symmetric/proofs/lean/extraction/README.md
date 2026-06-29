# p3-symmetric — Lean extraction (compiles)

Hax-extracted Lean for `p3-symmetric`, built with Lake. This is the **shared
dependency** that `keccak` and `blake3` now depend on (via a Lake path
`require`) instead of each carrying their own copy of the trait classes.

## Build

```bash
cd symmetric/proofs/lean/extraction
lake build              # compiles p3_symmetric.lean
# or regenerate from Rust first:
./build-lean.sh
```

**Syncing with upstream:** re-extraction after an upstream merge is governed by
the repo-root [`SYNC.md`](../../../../SYNC.md); this crate's re-extract/reconcile
steps are in [`SYNC.md`](SYNC.md).

`lake build` **succeeds** (with `sorry` warnings — see [`TCB.md`](TCB.md)).

## Scope — essential interface only

`keccak`/`blake3`/`koala-bear` only consume `p3-symmetric`'s **trait classes**:
`p3_symmetric.hasher.CryptographicHasher` and
`p3_symmetric.permutation.{Permutation, CryptographicPermutation}`.

The crate's `sponge` / `hash` / `serializing_hasher` / `compression` *impl*
modules pull in a large surface the pinned Hax proof-lib can't type-check
(`num-bigint::BigUint`, `serde`, `itertools`, the `p3_field`
`Field`/`PrimeField`/`PrimeField32` hierarchy, several missing iterator
combinators). Rather than stub all of that, `build-lean.sh` **slices** the
generated file down to the trait-class namespaces, which depend only on
`core_models`/Hax. The trait methods' default bodies (generic iterator plumbing)
are replaced with `sorry`; instances override what they actually use.

So this is the real extracted `p3_symmetric` trait interface — just not its
unused-here implementation modules.

## Layout

| Path | Role |
|------|------|
| `p3_symmetric.lean` | hax output, sliced to the `hasher` + `permutation` trait-class namespaces (post-processed by `build-lean.sh`). |
| `p3_symmetric/dependencies.lean` | import target for the generated file; the sliced classes need only Hax, so it's essentially empty. |
| `lakefile.toml`, `lean-toolchain`, `lake-manifest.json` | Lake package (lib `p3_symmetric`; requires **Hax**). |
| `build-lean.sh` | extract → inject import → slice → strip `with Item` → sorry default bodies → `lake build`. |

## Consumed by

`keccak/proofs/lean/extraction/` and `blake3/proofs/lean/extraction/` each
`require` this package by path and `import p3_symmetric` (replacing their former
hand-written `p3_symmetric.lean` stubs). Build those after this one.

`.lake/` is gitignored; `.lake/packages` symlinks to koala-bear's built packages
to reuse Hax. On a fresh checkout, `lake build` resolves Hax per the manifest.
