# Sync: re-extract & reconcile `p3-mersenne-31`

Crate-specific runbook, **invoked by the repo-root [`SYNC.md`](../../../../SYNC.md)**
after it has fetched + merged upstream and determined `mersenne-31` is affected.
Assumes the merge is done; re-extracts and reconciles this one crate.
`mersenne-31` is independent of the other official crates; its field dependencies
are **stubbed, not extracted**, and its DFT is excluded.

Two committed patches (see [`TCB.md`](TCB.md), [`README.md`](README.md)): a
pre-extraction **Rust source patch** (`../rust-patch/patches/p3_mersenne_31.src.patch`,
gates SIMD + DFT off under `--cfg hax`) and a **Lean patch**
(`patches/p3_mersenne_31.patch`).

## Step 1 — Re-run the extraction

```sh
./mersenne-31/proofs/lean/extraction/build-proofs.sh
```

The script guards `mersenne-31/src` is git-clean, traps-reverts it, applies the
source patch, runs `cargo hax into lean` in an **isolated `CARGO_TARGET_DIR`**
(required — shared `target/hax` serves stale Lean), reverts the source patch,
snapshots pristine, applies the Lean patch, and runs `lake build`.

**`cargo hax` exits non-zero here** (HAX0001 / #1923 on `qm31.rs`'s
`from_basis_coefficients_*`) but still writes a usable file — the script tolerates
this (`|| echo WARNING`). Judge status from `lake build`. Confirm
`git status --porcelain mersenne-31/src` is empty afterward.

## Step 2 — Reconcile drift, if any

Only `p3_mersenne_31.lean` is overwritten by hax; the `p3_mersenne_31/*.lean`
stubs are hand-maintained. If Step 1 ends **`Build completed successfully`** with
only `sorry` warnings: nothing to reconcile — go to Step 3.

If the source patch failed to apply (upstream changed the SIMD/DFT `#[cfg]`s),
re-derive it: for each SIMD-*selecting* `#[cfg]` add `, not(hax)`; for each
portable-selecting one wrap `any(hax, …)`; gate the `dft`/`radix_2_dit` `mod` +
`pub use` lines with `#[cfg(not(hax))]`. Touch `src/{lib,mersenne_31,poseidon1,
poseidon2}.rs`, then `git diff -- mersenne-31/src > ../rust-patch/patches/p3_mersenne_31.src.patch`
and `git checkout -- mersenne-31/src`.

If `patch` rejected Lean hunks **or** `lake build` failed, hand-edit
`p3_mersenne_31.lean` until green, preserving the hole set in `TCB.md §4`:
- `(by rfl)`→`(by sorry)` on transmute constants; strip `(associatedTypes := {…with…})`;
  `Debug` `fmt`→`dbg_fmt`.
- whole-instance `:= sorry` for stubbed-dependency-class instances and for the
  mutually-forward-referencing `core_models.ops.arith.*` / `cmp.*` / `convert.*`
  impls on the concrete field types;
- `:= sorry` the forward-referencing `def` bodies;
- keep the `PartialEq`/`Eq` `AssociatedTypes`-before-`PartialOrd`/`Ord` reorder.
- If a `p3_mersenne_31/*.lean` stub breaks on an upstream arity change, fix it
  minimally (match the failing call site). Don't extract the dep crates.

Re-run `lake build` until green, then `./patches/update-patch.sh`.

## Step 3 — Refresh `TCB.md`

Update line/sorry counts, source + Lean patch sizes, per-stub line counts, the Hax
`rev`, and the hole set (§4) if any moved.

## What "good" looks like

- `cd mersenne-31/proofs/lean/extraction && lake build` exits 0 with only `sorry`
  warnings (no errors, no `.rej`).
- `git status --porcelain mersenne-31/src` empty (source patch reverted).
- `TCB.md` figures match `wc -l`.
