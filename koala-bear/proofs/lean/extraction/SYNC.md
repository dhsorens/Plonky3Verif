# Sync this fork with upstream Plonky3

This repository is a fork of [`Plonky3/Plonky3`](https://github.com/Plonky3/Plonky3)
(the **upstream**) that adds a Lean proof infrastructure under `koala-bear/proofs/`.
All fork-only commits live inside `koala-bear/proofs/`, a directory upstream does
not have, so syncing is *expected* to be conflict-free.

This document is the canonical end-to-end procedure. If you (Claude) are asked to
"sync the fork", "follow SYNC.md", or "pull in upstream changes", run through this
file top to bottom.

---

## Step 1 — Make sure the `upstream` remote exists

```sh
git remote -v
```

If `upstream` is not listed, add it:

```sh
git remote add upstream https://github.com/Plonky3/Plonky3.git
```

Then fetch:

```sh
git fetch upstream
```

## Step 2 — Inspect the gap before merging

```sh
# Commits we are about to bring in
git log --oneline ..upstream/main

# Of those, the ones that touch koala-bear (relevant to extraction)
git log --oneline ..upstream/main -- koala-bear/

# Sanity: our fork-only commits (should all be inside koala-bear/proofs/)
git log --oneline upstream/main..HEAD
```

Look at the second list specifically. If it is empty or only changes
`#[cfg(test)]` blocks, comments, or doc-comments, expect zero hax drift. If it
touches the actual Rust definitions in `koala-bear/src/`, expect re-extraction
to produce a different `p3_koala_bear.lean`.

## Step 3 — Merge upstream/main

```sh
git merge upstream/main -m "merge: sync with upstream Plonky3"
```

**Always merge, do not rebase.** The fork's history is published on
`origin/main`, so rebasing would require a force-push and rewrite shared
history.

If a conflict appears anyway, **stop and surface it to the user** before
resolving. Do not blindly take `--theirs`/`--ours`. (The expected case is no
conflicts at all because all fork-only edits are isolated to a directory
upstream does not have.)

## Step 4 — Re-run the extraction

From the `koala-bear/` crate root (or from any subdirectory using a relative or
absolute path to the script):

```sh
./proofs/lean/extraction/build-proofs.sh
```

The script:

1. runs `cargo hax into lean` (overwrites only `p3_koala_bear.lean`),
2. snapshots the pristine output to `patches/pristine.snapshot.lean`,
3. applies `patches/p3_koala_bear.patch`,
4. runs `lake build` from `proofs/lean/extraction/`.

**`cargo hax into lean` may print errors but still write a usable file.** Do
not abort on hax errors as long as `p3_koala_bear.lean` was overwritten.
Inspect `lake build`'s output, not hax's, for the real status.

## Step 5 — Reconcile drift, if any

Inside `proofs/lean/extraction/`, only one file is overwritten by hax:
`p3_koala_bear.lean`. Everything else is hand-maintained:

| Path | Role |
|------|------|
| `p3_koala_bear.lean` | Hax output, then `patches/p3_koala_bear.patch` is applied |
| `p3_koala_bear/` | Stubs for crates Hax does not extract (`dependencies.lean` wires them) |
| `p3_koala_bear_proofs/` | Proof modules against the imported specs |
| `p3_koala_bear_proofs.lean` | Root module for the proofs library |

If Step 4 ended with **`Build completed successfully`** and only `sorry`
warnings: nothing to reconcile. Skip to Step 6.

If `patch` rejected hunks **or** `lake build` failed:

- Read any `.rej` files left next to `p3_koala_bear.lean`.
- Hand-edit `p3_koala_bear.lean` until `lake build` is green. Conventions:
  - Mark every edit site with `-- PATCHED`.
  - For `(by rfl)` → `(by sorry)` swaps, keep `    -- (by rfl)` on the
    following line so the diff is self-documenting.
  - **Preserve as much of the previous patch's intent as possible.**
    - If a previous `sorry` is no longer needed (the new hax output reduces
      cleanly), drop the swap — that shrinks the TCB.
    - Keep imports the previous patch added.
    - If the previous patch had to modify a function or definition body,
      keep the spirit of that modification.
- If a `p3_koala_bear/*.lean` stub or a `p3_koala_bear_proofs/*.lean` proof
  breaks because upstream types or imports shifted, fix it minimally. **Avoid
  introducing new `sorry`s.** If a proof breaks, fix the proof rather than
  admit it. Do not change theorem statements unless absolutely forced; if
  forced, preserve the original semantics as closely as possible.
- Re-run `lake build` until green.
- Regenerate the patch:
  ```sh
  ./proofs/lean/extraction/patches/update-patch.sh
  ```

## Step 6 — Refresh `TCB.md`

`TCB.md` documents the trusted base. Update it if any of these moved:

- patch line count (`wc -l patches/p3_koala_bear.patch`),
- patch hunk count (`grep -c '^@@' patches/p3_koala_bear.patch`),
- per-stub line counts in §3 (`wc -l p3_koala_bear/*.lean`),
- the Hax `rev` pinned in `lake-manifest.json`,
- the `lean-toolchain` pin,
- any `opaque`/`sorry` added or removed from stubs.

Walk the **Audit checklist** at the bottom of TCB.md and confirm every box
still answers "yes".

## Step 7 — Commit

Stage and commit only the files this sync touched. **Do not** include the
untracked `proofs/` directories under sibling crates (`challenger/proofs/`,
`field/proofs/`, etc.) — those are separate WIP.

```sh
git add koala-bear/proofs/lean/extraction/p3_koala_bear.lean \
        koala-bear/proofs/lean/extraction/patches/p3_koala_bear.patch \
        koala-bear/proofs/lean/extraction/p3_koala_bear/ \
        koala-bear/proofs/lean/extraction/p3_koala_bear_proofs/ \
        koala-bear/proofs/lean/extraction/TCB.md \
        koala-bear/proofs/lean/extraction/SYNC.md
git commit -m "sync: update extraction after merging upstream Plonky3"
```

Do **not** push without explicit approval from the user.

---

## What "good" looks like at the end

- `git log --oneline upstream/main..HEAD -- koala-bear/proofs/` lists every
  fork-only proof commit.
- `git log --oneline HEAD..upstream/main` is empty.
- `cd koala-bear/proofs/lean/extraction && lake build` exits 0 with only
  `sorry` warnings (no errors, no `.rej` files).
- TCB.md figures match `wc -l` of the actual files.
- The next sync can be a one-liner from the user: *"follow SYNC.md"*.
