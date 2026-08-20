# Sync: re-extract & reconcile `p3-symmetric`

Crate-specific runbook, **invoked by the repo-root [`SYNC.md`](../../../../SYNC.md)**
after it has fetched + merged upstream and determined `symmetric` is affected.
This file assumes the merge is already done; it only re-extracts and reconciles
this one crate. (You can also run it standalone to re-sync just `symmetric` after
a merge.)

`symmetric` is the **dependency root**: `keccak` and `blake3` consume the real
extracted `p3_symmetric` via a Lake path `require`, so re-extract `symmetric`
*before* them, and re-run their SYNC.md afterward.

## What this extraction is

`build-lean.sh` extracts the full crate but **slices** the generated
`p3_symmetric.lean` down to the trait-class interface
(`p3_symmetric.hasher.CryptographicHasher`,
`p3_symmetric.permutation.{Permutation, CryptographicPermutation}`) — that is all
the dependents consume. The sponge/hash/serializing/compression impl modules are
dropped (they pull in a surface the pinned Hax proof-lib can't type-check). See
[`TCB.md`](TCB.md) / [`README.md`](README.md).

## Step 1 — Re-extract

```sh
cd symmetric/proofs/lean/extraction && ./build-lean.sh
```

`build-lean.sh` re-runs `cargo hax into lean`, then post-processes the output:
injects the dependency import, **slices to the `hasher`/`permutation` `class`
namespaces**, strips the bogus `(associatedTypes := { … with Item := … })`
overrides, `sorry`s the trait default-method bodies, and runs `lake build`.

`cargo hax into lean` may print errors but still write a usable file — judge
status from `lake build`, not hax.

## Step 2 — Reconcile drift, if `lake build` failed

Fix in this order (keep everything `sorry`/stub-only — there are no proofs here):

1. **Post-processing rule drift** — the most likely cause. If hax's output shape
   changed, one of the `perl`/`awk` steps in `build-lean.sh` may no longer match.
   The drift-prone ones:
   - the **slice** `awk` (keeps `namespace p3_symmetric.hasher` /
     `…permutation` blocks containing a `class`) — check the namespace names /
     `end` markers still match;
   - the `with Item` override strip and the trait default-body `sorry` regex.
   Adjust the rule, re-run.
2. **Trait-signature drift** — if upstream changed the `CryptographicHasher` /
   `Permutation` traits (new/renamed methods, changed bounds), the sliced classes
   change shape. Usually they still compile (signatures + sorried defaults); if a
   default body's new plumbing breaks, extend the default-body `sorry` rule.
   `p3_symmetric/dependencies.lean` needs nothing beyond `Hax` for the slice.
3. Re-run `./build-lean.sh` until green (only `sorry` warnings).

## Step 3 — Refresh `TCB.md`

Update sorry counts and the Hax `rev` if they moved. Note in particular whether
the set of kept trait classes (or their default-`sorry` count) changed.

## Step 4 — Hand back to the root

Tell the root SYNC.md you're done so it re-runs `keccak` and `blake3` against the
new `p3_symmetric`, then commits. (If running standalone, just rebuild those two.)
