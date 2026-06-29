# Sync: re-extract & reconcile `p3-goldilocks`

Crate-specific runbook, **invoked by the repo-root [`SYNC.md`](../../../../SYNC.md)**
after it has fetched + merged upstream and determined `goldilocks` is affected.
Assumes the merge is done; re-extracts and reconciles this one crate.
`goldilocks` is independent of the other official crates; its field dependencies
are **stubbed, not extracted** (goldilocks has no DFT module of its own;
it references a `p3-dft` Radix2Bowers stub for one MDS permutation).

Two committed patches (see [`TCB.md`](TCB.md), [`README.md`](README.md)): a
pre-extraction **Rust source patch** (`../rust-patch/patches/p3_goldilocks.src.patch`,
gates SIMD off under `--cfg hax`) and a **Lean patch**
(`patches/p3_goldilocks.patch`).

## Step 1 — Re-run the extraction

```sh
./goldilocks/proofs/lean/extraction/build-proofs.sh
```

The script guards `goldilocks/src` is git-clean, traps-reverts it, applies the
source patch, runs `cargo hax into lean` in an **isolated `CARGO_TARGET_DIR`**
(required — shared `target/hax` serves stale Lean), reverts the source patch,
snapshots pristine, applies the Lean patch, and runs `lake build`.

**`cargo hax` may print errors but still write a usable file** — judge status from
`lake build`, not hax. (The script tolerates a non-zero hax exit via `|| echo
WARNING`.) Confirm `git status --porcelain goldilocks/src` is empty afterward.

## Step 2 — Reconcile drift, if any

Only `p3_goldilocks.lean` is overwritten by hax; the `p3_goldilocks/*.lean`
stubs are hand-maintained. If Step 1 ends **`Build completed successfully`** with
only `sorry` warnings: nothing to reconcile — go to Step 3.

If the source patch failed to apply (upstream changed the SIMD/DFT `#[cfg]`s),
re-derive it: for each SIMD-*selecting* `#[cfg]` add `, not(hax)`; for each portable-selecting one (incl. the wasm32 backend and the
`not(target_arch = "aarch64")` poseidon fallbacks) wrap `any(hax, …)`; (goldilocks has no DFT module to gate). Touch `src/{lib,goldilocks,poseidon1,
poseidon2}.rs`, then `git diff -- goldilocks/src > ../rust-patch/patches/p3_goldilocks.src.patch`
and `git checkout -- goldilocks/src`.

If `patch` rejected Lean hunks **or** `lake build` failed, hand-edit
`p3_goldilocks.lean` until green, preserving the hole set in `TCB.md §4`:
- `(by rfl)`→`(by sorry)` on transmute constants; strip `(associatedTypes := {…with…})`;
  `Debug` `fmt`→`dbg_fmt`.
- whole-instance `:= sorry` for stubbed-dependency-class instances and for the
  mutually-forward-referencing `core_models.ops.arith.*` / `cmp.*` / `convert.*`
  impls on the concrete field types;
- `:= sorry` the forward-referencing `def` bodies (constant tables, field
  helpers — see `TCB.md §4`);
- keep the `PartialEq`/`Eq` `AssociatedTypes`-before-`PartialOrd`/`Ord` reorder.
- If a `p3_goldilocks/*.lean` stub breaks on an upstream arity change, fix it
  minimally (match the failing call site). Don't extract the dep crates.

Re-run `lake build` until green, then `./patches/update-patch.sh`.

## Step 3 — Refresh `TCB.md`

Update line/sorry counts, source + Lean patch sizes, per-stub line counts, the Hax
`rev`, and the hole set (§4) if any moved.

## What "good" looks like

- `cd goldilocks/proofs/lean/extraction && lake build` exits 0 with only `sorry`
  warnings (no errors, no `.rej`).
- `git status --porcelain goldilocks/src` empty (source patch reverted).
- `TCB.md` figures match `wc -l`.
