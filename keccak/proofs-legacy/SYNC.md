# Sync: re-extract & reconcile `p3-keccak`

Crate-specific runbook, **invoked by the repo-root [`SYNC.md`](../../../../SYNC.md)**
after it has fetched + merged upstream and determined `keccak` is affected. Assumes
the merge is done; only re-extracts/reconciles this crate. (Runnable standalone
after a merge.)

**Dependency:** `keccak` consumes the real extracted `p3_symmetric` via a Lake
path `require`. If `symmetric` was also affected, re-extract it (its
[`SYNC.md`](../../../../symmetric/proofs/lean/extraction/SYNC.md)) **first**.

## What this extraction is

`build-lean.sh` runs `cargo hax into lean` with `-C target-feature=-sha3` (drops
keccak's aarch64 NEON path so the scalar path extracts), post-processes the output
(inject dependency import, strip bogus `IntoIterator … with Item` overrides), and
runs `lake build`. Stubs live in `p3_keccak/`:
- `tiny_keccak.lean` — the external `tiny_keccak` crate (trusted no-op),
- `core_shims.lean` — `core_models` items the pinned proof-lib lacks (`Iterator.fold`),
- `dependencies.lean` — imports the stubs **and `import p3_symmetric`** (the real
  package; not a local stub).
Two `sorry`s remain (the two hasher closures). See [`TCB.md`](TCB.md) / [`README.md`](README.md).

## Step 1 — Re-extract

```sh
cd keccak/proofs/lean/extraction && ./build-lean.sh
```

`cargo hax into lean` may print errors but still write a usable file — judge from
`lake build`.

If `lake build` complains the `p3_symmetric` dependency is missing from the
manifest (e.g. after a `lake-manifest.json` reset):

```sh
lake update p3_symmetric    # re-adds the local path dep; preserves the Hax pin
```

## Step 2 — Reconcile drift, if `lake build` failed

Fix in order (keep everything `sorry`/stub-only):

1. **Post-processing rule drift** — if hax output shape changed, fix the `perl`
   steps in `build-lean.sh` (import injection, `with Item` strip). If keccak's
   `src` no longer takes the NEON path under `-sha3`, revisit that flag.
2. **`p3_symmetric` trait drift** — if `symmetric`'s re-extracted trait classes
   changed shape (new/renamed methods), `p3_keccak.lean`'s
   `CryptographicHasher`/`Permutation` instances may need the stubs adjusted, or
   the extraction reconciled against the new interface.
3. **Stub drift** — if upstream changed `tiny_keccak` usage, update
   `p3_keccak/tiny_keccak.lean`. New `core_models` gaps → `p3_keccak/core_shims.lean`.
4. Re-run `./build-lean.sh` until green (expect the 2 hasher `sorry`s).

## Step 3 — Refresh `TCB.md`

Update the `sorry` count / stub list / Hax `rev` if they moved.
