# Sync: re-extract & reconcile `p3-monty-31`

Crate-specific runbook, **invoked by the repo-root [`SYNC.md`](../../../../SYNC.md)**
after it has fetched + merged upstream and determined `monty-31` is affected. This
file assumes the merge is already done; it only re-extracts and reconciles this one
crate. (You can also run it standalone after a merge.) `monty-31` is independent of
the other official crates; its field dependencies are **stubbed, not extracted**.

monty-31 has **two** committed patches (see [`TCB.md`](TCB.md), [`README.md`](README.md)):
a pre-extraction **Rust source patch** (`../rust-patch/patches/p3_monty_31.src.patch`,
gates SIMD + `dft` off under `--cfg hax`) and a **Lean patch**
(`patches/p3_monty_31.patch`).

## Step 1 — Re-run the extraction

From anywhere:

```sh
./monty-31/proofs/lean/extraction/build-proofs.sh
```

The script: (0) guards `monty-31/src` is git-clean, installs an EXIT trap to
revert it, and `git apply`s the **source patch**; (1) runs `cargo hax into lean`
in an **isolated `CARGO_TARGET_DIR`** (required — the shared `target/hax` serves
stale cached Lean that ignores the source patch); (2) reverts the source patch;
(3) snapshots the pristine output to `patches/pristine.snapshot.lean`; (4) applies
`patches/p3_monty_31.patch`; (5) runs `lake build` from `proofs/lean/extraction/`.

**`cargo hax into lean` may print errors but still write a usable file.** Do not
abort on hax errors as long as `p3_monty_31.lean` was overwritten. Judge status
from `lake build`, not hax. Confirm `git status --porcelain monty-31/src` is empty
after the run (source patch reverted).

## Step 2 — Reconcile drift, if any

Inside `proofs/lean/extraction/`, only `p3_monty_31.lean` is overwritten by hax;
everything else is hand-maintained:

| Path | Role |
|------|------|
| `p3_monty_31.lean` | Hax output, then `patches/p3_monty_31.patch` is applied |
| `p3_monty_31/p3_field.lean` etc. | Stubs for the dependency crates (`dependencies.lean` wires them) |
| `p3_monty_31/core_shims.lean` | proof-lib gaps (128-bit casts, Sum/Product, Display u32, overflowing_sub) |

If Step 1 ended with **`Build completed successfully`** and only `sorry`
warnings: nothing to reconcile — go to Step 3.

If the source patch failed to apply (upstream changed the SIMD/`dft` `#[cfg]`s):
re-derive it. The transform is mechanical — for each `#[cfg]` that *selects* a
SIMD path add `, not(hax)`; for each that selects the *portable* path
(`not(any(…))` / `not(all(…neon…))`) wrap it `any(hax, …)`; gate `pub mod dft;`
with `#[cfg(not(hax))]`. Apply to `src/{lib,data_traits,monty_31,poseidon1,poseidon2,dft/forward}.rs`,
`git diff -- monty-31/src > ../rust-patch/patches/p3_monty_31.src.patch`, then
`git checkout -- monty-31/src`. (See `../rust-patch/README.md` for the table.)

If `patch` rejected Lean hunks **or** `lake build` failed:

- Read any `.rej` files next to `p3_monty_31.lean`.
- Hand-edit `p3_monty_31.lean` until `lake build` is green. Conventions:
  - For `(by rfl)` → `(by sorry)` swaps, the engine re-emits `(by rfl)`; swap only
    the ones that fail to elaborate.
  - **Sorry trait *default* bodies and *forward-referencing* instance bodies** that
    reference `Trait.item Self` (un-synthesizable self-instance) or call a
    `MontyField31` trait instance declared later in the file. These are the holes
    enumerated in `TCB.md §4`; preserve that set, adding/removing only as the new
    output requires.
  - Keep the injected `import p3_monty_31.dependencies` and the `Debug` field
    rename (`fmt`→`dbg_fmt`).
- If a `p3_monty_31/*.lean` stub breaks because an upstream type/arity shifted, fix
  it minimally (match the new class arity / associated types from the failing call
  site). Don't extract the dependency crates here — that's deferred.
- Re-run `lake build` until green, then regenerate the patch:
  ```sh
  ./monty-31/proofs/lean/extraction/patches/update-patch.sh
  ```

## Step 3 — Refresh `TCB.md`

Update it if any of these moved:
- `p3_monty_31.lean` line / `sorry` counts,
- source patch + Lean patch line counts (`wc -l`),
- per-stub line counts / any stub `opaque`/`sorry` added or removed,
- the Hax `rev` pinned in `lake-manifest.json`,
- the set of sorried default / forward-ref bodies (§4).

## Maintenance: Lean toolchain bumps

The Lean version lives in `proofs/lean/extraction/lean-toolchain`. A toolchain /
Hax-pin bump is independent of an upstream Plonky3 sync and is coordinated across
all official crates by the root [`SYNC.md`](../../../../SYNC.md) "Maintenance"
section.

## What "good" looks like at the end

- `cd monty-31/proofs/lean/extraction && lake build` exits 0 with only `sorry`
  warnings (no errors, no `.rej` files).
- `git status --porcelain monty-31/src` is empty (source patch reverted).
- `TCB.md` figures match `wc -l` of the actual files.
