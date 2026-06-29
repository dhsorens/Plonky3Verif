# Sync: re-extract & reconcile `p3-koala-bear`

Crate-specific runbook, **invoked by the repo-root [`SYNC.md`](../../../../SYNC.md)**
after it has fetched + merged upstream and determined `koala-bear` is affected.
This file assumes the merge is already done; it only re-extracts and reconciles
this one crate. (You can also run it standalone to re-sync just `koala-bear` after
a merge.) `koala-bear` is independent of the other official crates.

Unlike the post-processed crates (`keccak`/`blake3`/`symmetric`), `koala-bear`
keeps a committed **Lean patch** (`patches/p3_koala_bear.patch`) and hand-written
**proofs** (`p3_koala_bear_proofs/`), so reconciliation here can mean fixing
patch hunks and proofs — detailed below.

## Step 1 — Re-run the extraction

From the `koala-bear/` crate root:

```sh
./proofs/lean/extraction/build-proofs.sh
```

The script: (1) runs `cargo hax into lean` (overwrites only `p3_koala_bear.lean`),
(2) snapshots the pristine output to `patches/pristine.snapshot.lean`, (3) applies
`patches/p3_koala_bear.patch`, (4) runs `lake build` from
`proofs/lean/extraction/`.

**`cargo hax into lean` may print errors but still write a usable file.** Do not
abort on hax errors as long as `p3_koala_bear.lean` was overwritten. Judge status
from `lake build`, not hax.

## Step 2 — Reconcile drift, if any

Inside `proofs/lean/extraction/`, only `p3_koala_bear.lean` is overwritten by hax.
Everything else is hand-maintained:

| Path | Role |
|------|------|
| `p3_koala_bear.lean` | Hax output, then `patches/p3_koala_bear.patch` is applied |
| `p3_koala_bear/` | Stubs for crates Hax does not extract (`dependencies.lean` wires them) |
| `p3_koala_bear_proofs/` | Proof modules against the imported specs |
| `p3_koala_bear_proofs.lean` | Root module for the proofs library |

If Step 1 ended with **`Build completed successfully`** and only `sorry`
warnings: nothing to reconcile — go to Step 3.

If `patch` rejected hunks **or** `lake build` failed:

- Read any `.rej` files left next to `p3_koala_bear.lean`.
- Hand-edit `p3_koala_bear.lean` until `lake build` is green. Conventions:
  - Mark every edit site with `-- PATCHED`.
  - For `(by rfl)` → `(by sorry)` swaps, keep `    -- (by rfl)` on the following
    line so the diff is self-documenting.
  - **Preserve as much of the previous patch's intent as possible.** Drop a `sorry`
    swap if the new hax output no longer needs it (shrinks the TCB); keep imports
    the previous patch added; keep the spirit of any body modifications.
- If a `p3_koala_bear/*.lean` stub or a `p3_koala_bear_proofs/*.lean` proof breaks
  because upstream types/imports shifted, fix it minimally. **Avoid new `sorry`s** —
  fix the proof rather than admit it; don't change theorem statements unless
  forced, and then preserve semantics as closely as possible.
- Re-run `lake build` until green, then regenerate the patch:
  ```sh
  ./proofs/lean/extraction/patches/update-patch.sh
  ```

## Step 3 — Refresh `TCB.md`

Update it if any of these moved:
- patch line count (`wc -l patches/p3_koala_bear.patch`),
- patch hunk count (`grep -c '^@@' patches/p3_koala_bear.patch`),
- per-stub line counts in §3 (`wc -l p3_koala_bear/*.lean`),
- the Hax `rev` pinned in `lake-manifest.json`,
- any `opaque`/`sorry` added or removed from stubs.

Walk the **Audit checklist** at the bottom of `TCB.md` and confirm every box still
answers "yes". When done, hand back to the root SYNC.md (it commits).

---

## Maintenance: Lean toolchain bumps

The Lean version lives in `proofs/lean/extraction/lean-toolchain`. A toolchain /
Hax-pin bump is independent of an upstream Plonky3 sync and is coordinated across
all official crates by the root [`SYNC.md`](../../../../SYNC.md) "Maintenance"
section. For `koala-bear` specifically, after a bump re-run
`./proofs/lean/extraction/build-proofs.sh` and, if a proof in
`p3_koala_bear_proofs/` broke due to Lean churn, **fix the proof rather than admit
it** (don't change theorem statements unless forced; preserve semantics).

## What "good" looks like at the end

- `cd koala-bear/proofs/lean/extraction && lake build` exits 0 with only `sorry`
  warnings (no errors, no `.rej` files).
- `TCB.md` figures match `wc -l` of the actual files.
- `git log --oneline upstream/main..HEAD -- koala-bear/proofs/` lists the
  fork-only proof commits.
