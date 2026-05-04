# Trusted patch for `p3_koala_bear.lean`

`cargo hax into lean` extracts the `p3-koala-bear` Rust crate to
`proofs/lean/extraction/p3_koala_bear.lean`. That extraction is not
self-sufficient — for the file to compile against our hand-curated dependency
stubs in `p3_koala_bear/`, a small number of edits are needed.

`p3_koala_bear.patch` is a unified diff capturing every such edit. It is the
trusted computing base for the Lean side of this extraction: every deviation
from hax output is documented in that one file.

## Files

- `p3_koala_bear.patch` — the source of truth. Apply with `patch p3_koala_bear.lean < p3_koala_bear.patch`.
- `pristine.snapshot.lean` — the most-recent fresh hax output, kept for diffing.
  Recreated every time `build-proofs.sh` runs. Not checked in.
- `update-patch.sh` — regenerates `p3_koala_bear.patch` from the current
  `p3_koala_bear.lean` vs `pristine.snapshot.lean`.

## Daily workflow

From `koala-bear/proofs` (or run `./proofs/build-proofs.sh` from the crate root):

```sh
./build-proofs.sh
```

That runs `cargo hax into lean`, snapshots the pristine output, applies
`p3_koala_bear.patch`, and runs `lake build`. Build failure is reported but the
script does not abort, so the file is left in place for inspection.

## When hax output drifts

If `build-proofs.sh` reports `patch` rejecting hunks or `lake build` fails after
patching, the hax output has changed in a way the existing patch can't handle.
Workflow:

1. Inspect `p3_koala_bear.lean` (the target) and any `.rej` files `patch`
   produced.
2. Hand-edit `p3_koala_bear.lean` until `lake build` succeeds.
3. Run `patches/update-patch.sh`. It diffs the current verified file against
   `pristine.snapshot.lean` (saved by step 2 of `build-proofs.sh`) and
   overwrites `p3_koala_bear.patch`.
4. Commit the new patch.

A shrinking patch is a sign that hax has improved: each removed hunk is one
less thing in the trusted base.

## First-time bootstrap

If this directory is fresh (no `pristine.snapshot.lean`, no `p3_koala_bear.patch`):

1. From `koala-bear/proofs`, `./build-proofs.sh` (or `./proofs/build-proofs.sh` from the crate root). The patch is missing,
   so the script will skip the apply step but still produce the snapshot.
2. Hand-edit `proofs/lean/extraction/p3_koala_bear.lean` until `lake build`
   succeeds.
3. Run `patches/update-patch.sh` to write the initial `p3_koala_bear.patch`.

## Patch conventions

- Mark every edit in the verified file with `-- PATCHED`. When a `(by rfl)`
  proof tactic is swapped for `(by sorry)`, preserve the original by including
  `    -- (by rfl)` on the following line — the patch then reads as
  self-documenting context.
- Don't reformat for cosmetic reasons; minimize patch surface area so each
  hunk reflects a real trusted alteration.
