# Sync: re-extract & reconcile `p3-blake3`

Crate-specific runbook, **invoked by the repo-root [`SYNC.md`](../../../../SYNC.md)**
after it has fetched + merged upstream and determined `blake3` is affected. Assumes
the merge is done; only re-extracts/reconciles this crate. (Runnable standalone
after a merge.)

**Dependency:** `blake3` consumes the real extracted `p3_symmetric` via a Lake
path `require`. If `symmetric` was also affected, re-extract it (its
[`SYNC.md`](../../../../symmetric/proofs/lean/extraction/SYNC.md)) **first**.

## What this extraction is

`build-lean.sh` runs `cargo hax into lean` (no `-C target-feature` flag — the
`blake3` crate is external, so its SIMD never enters the extraction), post-processes
the output (inject dependency import, strip bogus `IntoIterator … with Item`
overrides), and runs `lake build`. Stubs live in `p3_blake3/`:
- `blake3.lean` — the external `blake3` crate (trusted no-op: `Hasher`, `Hash`, `Into`),
- `p3_util.lean` — `apply_to_chunks` (no-op),
- `core_shims.lean` — `Iterator.fold`,
- `dependencies.lean` — imports the stubs **and `import p3_symmetric`** (the real
  package; not a local stub).
Two `sorry`s remain (the two hasher closures). See [`TCB.md`](TCB.md) / [`README.md`](README.md).

## Step 1 — Re-extract

```sh
cd blake3/proofs/lean/extraction && ./build-lean.sh
```

`cargo hax into lean` may print errors but still write a usable file — judge from
`lake build`.

If `lake build` complains the `p3_symmetric` dependency is missing from the
manifest:

```sh
lake update p3_symmetric    # re-adds the local path dep; preserves the Hax pin
```

## Step 2 — Reconcile drift, if `lake build` failed

Fix in order (keep everything `sorry`/stub-only):

1. **Post-processing rule drift** — if hax output shape changed, fix the `perl`
   steps in `build-lean.sh` (import injection, `with Item` strip).
2. **`p3_symmetric` trait drift** — if `symmetric`'s re-extracted trait classes
   changed shape, reconcile `p3_blake3.lean`'s `CryptographicHasher` instance /
   stubs against the new interface.
3. **Stub drift** — if upstream changed how the wrapper calls the `blake3` crate
   or `p3_util::apply_to_chunks`, update `p3_blake3/blake3.lean` / `p3_util.lean`.
   New `core_models` gaps → `p3_blake3/core_shims.lean`.
4. Re-run `./build-lean.sh` until green (expect the 2 hasher `sorry`s).

## Step 3 — Refresh `TCB.md`

Update the `sorry` count / stub list / Hax `rev` if they moved.
