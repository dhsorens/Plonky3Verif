# Sync this fork with upstream Plonky3 (orchestrator)

This repository is a fork of [`Plonky3/Plonky3`](https://github.com/Plonky3/Plonky3)
(the **upstream**) that adds Lean proof/extraction infrastructure under various
crates' `proofs/` directories. This file is the **entry point** for syncing: when
asked to "sync the fork", "follow SYNC.md", or "pull in upstream changes", run
through this file top to bottom. It does the one-time upstream merge, figures out
which extracted crates the merge actually touched, and then hands each affected
crate off to its own per-crate `SYNC.md`.

All fork-only commits live inside `*/proofs/` directories upstream does not have,
so syncing is *expected* to be conflict-free.

---

## The registry of "official" extracted crates

**Only the crates in this registry are official.** Every other `*/proofs/`
directory in the repo (e.g. `field/proofs/`, `mds/proofs/`, …) is **experimental
WIP** from the extraction survey — never re-extract, reconcile, or commit those.

<!-- REGISTRY (machine-readable: one `crate | script | per-crate SYNC | deps` row per official crate) -->

| Crate | Extraction dir | Build script | Per-crate SYNC | Kind | Depends on (registry) |
|-------|----------------|--------------|----------------|------|------------------------|
| `koala-bear` | `koala-bear/proofs/lean/extraction/` | `build-proofs.sh` | `koala-bear/proofs/lean/extraction/SYNC.md` | patched Lean output + hand-written proofs | — |
| `symmetric` | `symmetric/proofs/lean/extraction/` | `build-lean.sh` | `symmetric/proofs/lean/extraction/SYNC.md` | post-processed extraction (sliced to trait classes) | — |
| `keccak` | `keccak/proofs/lean/extraction/` | `build-lean.sh` | `keccak/proofs/lean/extraction/SYNC.md` | post-processed extraction + stubs | `symmetric` |
| `blake3` | `blake3/proofs/lean/extraction/` | `build-lean.sh` | `blake3/proofs/lean/extraction/SYNC.md` | post-processed extraction + stubs | `symmetric` |
| `monty-31` | `monty-31/proofs/lean/extraction/` | `build-proofs.sh` | `monty-31/proofs/lean/extraction/SYNC.md` | patched Lean output + Rust source patch (SIMD/dft gated under `--cfg hax`); field deps stubbed | — |
| `mersenne-31` | `mersenne-31/proofs/lean/extraction/` | `build-proofs.sh` | `mersenne-31/proofs/lean/extraction/SYNC.md` | patched Lean output + Rust source patch (SIMD/DFT gated under `--cfg hax`); field deps stubbed | — |

**Dependency order for re-extraction:** `symmetric` → `keccak`, `blake3`
(`keccak`/`blake3` consume the real extracted `p3_symmetric` via a Lake path
`require`). `koala-bear` is independent. When a new crate graduates to "official",
add a row here and create its per-crate `SYNC.md`.

---

## Step 1 — Make sure the `upstream` remote exists, then fetch

```sh
git remote -v                      # expect an `upstream` entry
# if missing: git remote add upstream https://github.com/Plonky3/Plonky3.git
git fetch upstream
```

## Step 2 — Record the pre-merge HEAD and inspect the gap

```sh
BEFORE=$(git rev-parse HEAD)
git log --oneline ..upstream/main                       # commits about to come in
git log --oneline upstream/main..HEAD -- '*/proofs/'    # our fork-only proof commits
```

If the fork-only list touches anything **outside** `*/proofs/`, stop and surface
it — fork edits should be confined to `proofs/` dirs.

## Step 3 — Merge upstream/main

```sh
git merge upstream/main -m "merge: sync with upstream Plonky3"
```

**Always merge, never rebase** (the fork history is published on `origin/main`).
If a conflict appears, **stop and surface it to the user** — do not blindly take
`--ours`/`--theirs`. The expected case is no conflicts (fork edits live in dirs
upstream lacks).

## Step 4 — Detect which official crates are affected

```sh
git diff --name-only "$BEFORE"..HEAD
```

A registry crate is **affected** if the merge changed any file under its
`<crate>/src/` or `<crate>/Cargo.toml` (also treat workspace `Cargo.toml` /
`Cargo.lock` changes as affecting all registry crates). Then:

- **Close under the reverse-dependency edge:** if `symmetric` is affected, add
  `keccak` and `blake3` (their extractions are type-checked against the real
  `p3_symmetric`).
- **Order topologically:** `symmetric` first, then `keccak`/`blake3`; `koala-bear`,
  `monty-31` and `mersenne-31` anywhere (all independent — no reverse-dep edges;
  the field crates' deps are stubbed, not extracted).

If **no** registry crate's `src/`/`Cargo.toml` changed, there is no hax drift —
skip to Step 6 (the merge itself is the only change to commit).

> Detection is conservative: a comment/test-only change to a crate's `src/` will
> flag it, but re-extraction is idempotent, so re-running is harmless. Judge real
> drift from `lake build`, not from hax's noisy output.

## Step 5 — Re-extract + reconcile each affected crate

For each affected crate **in dependency order**, follow that crate's per-crate
runbook (it assumes the merge is already done and only re-extracts/reconciles that
one crate):

```
follow <crate>/proofs/lean/extraction/SYNC.md
```

Each per-crate SYNC.md ends green when its `lake build` exits 0 with only `sorry`
warnings (no errors, no `.rej` files) and its `TCB.md` is refreshed.

## Step 6 — Commit

Stage and commit **only** the affected registry crates' `proofs/` paths plus this
file. **Never** stage experimental `*/proofs/` dirs (the non-registry ones).

```sh
# example, if symmetric+keccak+blake3 were affected:
git add SYNC.md \
        symmetric/proofs/ keccak/proofs/ blake3/proofs/
git commit -m "sync: re-extract affected crates after merging upstream Plonky3"
```

Do **not** push without explicit approval.

---

## Maintenance: Lean toolchain / Hax pin bumps

All official crates currently pin the same Lean toolchain
(`leanprover/lean4:v4.30.0-rc2`) and the same Hax `rev`. A bump is independent of
the upstream Plonky3 sync — keep it on its own commit, and apply it across **all**
registry crates together:

1. Edit each crate's `proofs/lean/extraction/lean-toolchain` to the new tag.
2. In each extraction dir, `lake update` (refreshes `lake-manifest.json`).
3. Re-run each crate's build script (dependency order) and confirm green.

## What "good" looks like at the end

- `git log --oneline HEAD..upstream/main` is empty.
- For every affected crate: `cd <crate>/proofs/lean/extraction && lake build`
  exits 0 with only `sorry` warnings.
- Only registry `proofs/` paths (+ this file) were committed; experimental
  `proofs/` dirs were left untouched.
- The next sync is a one-liner: *"follow SYNC.md"*.
