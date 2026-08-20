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

> **Two pipelines since 2026-08-19.** Upstream hax renamed its backends
> (PR #2064): the OCaml Lean printer that generated all the original
> workspaces is now `cargo hax into legacy-lean`, and `cargo hax into lean`
> is a **new aeneas-based backend** (charon → `.llbc` → aeneas). The repo
> pins hax `e11615541`. Each original workspace was moved, frozen, to
> `<crate>/proofs-legacy/` (its `lake build` still works; re-extraction there
> would need the old hax). The **active** pipeline is the aeneas-backend
> workspace at `<crate>/proofs/lean/` — currently green for `keccak` and
> `blake3`; the other six are blocked on upstream charon/aeneas bugs, each
> documented in `<crate>/proofs/lean/BLOCKED.md` (cross-referenced with the
> aeneas survey in `aeneas-obstructions/`).

<!-- REGISTRY (machine-readable: one `crate | script | per-crate SYNC | deps` row per official crate) -->

| Crate | Active (aeneas backend) `proofs/lean/` | Frozen legacy `proofs-legacy/` | Depends on (registry) |
|-------|-----------------------------------------|--------------------------------|------------------------|
| `keccak` | ✅ green, 0 sorries — `build-proofs.sh`, `SYNC.md`, `TCB.md` | patched output + stubs + Rust src patch (SIMD gated) | `symmetric` (gates only) |
| `blake3` | ✅ green, 0 sorries — `build-proofs.sh`, `SYNC.md`, `TCB.md` | patched output + stubs | `symmetric` (gates only) |
| `symmetric` | ❌ `BLOCKED.md` (charon stdlib-iterator type errors + aeneas nested-loop returns) | sliced to trait classes | — |
| `monty-31` | ❌ `BLOCKED.md` (aeneas #1264 mixed Div×Field groups) | patched output + src patch (SIMD/dft gated) | — |
| `koala-bear` | ❌ `BLOCKED.md` (same as monty-31) | patched output + src patch + CompPoly proofs; consumes extracted `p3_monty_31` | `monty-31` |
| `baby-bear` | ❌ `BLOCKED.md` (same as monty-31) | patched output + src patch; consumes extracted `p3_monty_31` (never committed) | `monty-31` |
| `mersenne-31` | ❌ `BLOCKED.md` (charon stack overflow, survey Issue #9) | patched output + src patch (SIMD/DFT gated) | — |
| `goldilocks` | ❌ `BLOCKED.md` (charon type errors; src patch needs regenerating) | patched output + src patch (SIMD gated, incl. wasm32) | — |

**Shared pre-extraction source patches** (applied transiently by the active
build scripts, gated on `--cfg hax` which must be set globally via `RUSTFLAGS`
— `cargo hax` does not set it for dependency crates):
`field/proofs/rust-patch/patches/p3_field.src.patch` (removes the
charon-mistranslated `RawDataSerializable` stream methods + `unpack_iter`) and
`symmetric/proofs/rust-patch/patches/p3_symmetric.src.patch` (the
`SerializingHasher` impls that call them), alongside each crate's own patch.

**Dependency order for re-extraction (active pipeline):** `keccak` and
`blake3` are independent of each other; both apply the `field` + `symmetric`
gates. For the frozen legacy pipeline the old order still applies
(`symmetric` → `keccak`, `blake3`; `monty-31` → `baby-bear`, `koala-bear`),
but it is frozen — see the note at the top of each `proofs-legacy/` build
script. When a new crate graduates to "official", add a row here and create
its per-crate `SYNC.md`.

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
  `keccak` and `blake3` (type-checked against the real `p3_symmetric`); if
  `monty-31` is affected, add `baby-bear` **and** `koala-bear` (both type-checked
  against the real `p3_monty_31`).
- **Order topologically:** `symmetric` first, then `keccak`/`blake3`; `monty-31`
  before `baby-bear` and `koala-bear`; `mersenne-31`, `goldilocks` anywhere
  (independent — their deps are stubbed, not extracted).

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
follow <crate>/proofs/lean/SYNC.md        # active (aeneas backend) crates
# frozen legacy workspaces (<crate>/proofs-legacy/) are NOT re-extracted
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

Active (aeneas-backend) workspaces pin `leanprover/lean4:v4.31.0` and
`hax-lean` `v0.3.0` (which pins the Aeneas Lean library); the frozen
`proofs-legacy/` workspaces keep their old pins (`v4.30.0-rc2` era). The
cargo-hax install is pinned to `e11615541` (build from
`~/devel/fv-tools/hax`). A bump is independent of
the upstream Plonky3 sync — keep it on its own commit, and apply it across **all**
registry crates together:

1. Edit each active crate's `proofs/lean/lean-toolchain` to the new tag.
2. In each extraction dir, `lake update` (refreshes `lake-manifest.json`).
3. Re-run each crate's build script (dependency order) and confirm green.

## What "good" looks like at the end

- `git log --oneline HEAD..upstream/main` is empty.
- For every affected active crate: `cd <crate>/proofs/lean && lake build`
  exits 0 with only `sorry` warnings.
- Only registry `proofs/` paths (+ this file) were committed; experimental
  `proofs/` dirs were left untouched.
- The next sync is a one-liner: *"follow SYNC.md"*.
