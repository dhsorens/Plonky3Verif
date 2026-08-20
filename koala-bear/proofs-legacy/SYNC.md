# Sync: re-extract & reconcile `p3-koala-bear`

Crate-specific runbook, **invoked by the repo-root [`SYNC.md`](../../../../SYNC.md)**
after it has merged upstream and determined `koala-bear` is affected. Assumes the
merge is done; re-extracts/reconciles this one crate.

**koala-bear depends on the extracted monty-31** (Lake path require — KoalaBear is
`MontyField31<KoalaBearParameters>`), so it is also affected whenever **monty-31**
changes (reverse-dep edge `monty-31 → koala-bear`); **re-extract monty-31 first.**
koala-bear keeps a committed **Lean patch** (`patches/p3_koala_bear.patch`),
koala-specific supplementary stubs (`p3_koala_bear/field_ext.lean`), and hand-written
**proofs** (`p3_koala_bear_proofs/`) checked against CompPoly.

## Step 1 — Re-run the extraction

```sh
./koala-bear/proofs/lean/extraction/build-proofs.sh
```

The script: clean-tree guards `koala-bear/src` **and** `monty-31/src`; applies the
koala-bear source patch **and** monty-31's source patch (so the monty-31 dependency
compiles SIMD-free — `cargo hax` only sets `--cfg hax` on the primary crate; see
`../rust-patch/README.md`); `cargo hax into lean` (isolated target); reverts both
patches; snapshots pristine; applies the Lean patch; `lake exe cache get && lake
build` (CompPoly/mathlib). Confirm `git status --porcelain koala-bear/src
monty-31/src` is empty afterward.

`cargo hax` may print errors but still write a usable file — judge from `lake build`.

## Step 2 — Reconcile drift, if any

Overwritten by hax: only `p3_koala_bear.lean`. Hand-maintained:
`p3_koala_bear/{dependencies,field_ext}.lean`, the lakefile/manifest, `patches/`,
and `p3_koala_bear_proofs/`. If Step 1 ends green (only `sorry` warnings, no `.rej`):
go to Step 3. Otherwise read `.rej`, hand-edit `p3_koala_bear.lean` to green,
preserving the hole set in `TCB.md`:
- `(by rfl)` → `(by sorry)` on transmute constants;
- `sorry` the generic-algebra-bound layer method bodies (Dup/Add/Sub/PCR on a generic
  type param) and the unused `WIDTH`-generic poseidon layer-alias abbrev bodies;
- keep the `KoalaBearParameters` cluster ordered so `MontyParameters.AssociatedTypes`
  precedes the `abbrev KoalaBear`;
- keep `import p3_koala_bear.dependencies`.
Then `./patches/update-patch.sh`. If `p3_koala_bear_proofs/` breaks because the
spec/constant surface shifted, **fix the proof rather than admit it** (don't change
theorem statements unless forced; preserve semantics).

If monty-31's exported interface shifted, the fix may be in **monty-31's shared
stubs** (`monty-31/.../p3_monty_31/*.lean`) — keep them the union of consumer needs
(monty-31 + baby-bear + koala-bear), additive, and re-verify monty-31 builds green.
koala-specific supplements stay in `p3_koala_bear/field_ext.lean`.

## Step 3 — Dependency pin

`lake-manifest.json` must pin **Hax to the same rev monty-31 / the shared
`.lake/packages` use** (currently `c1a93f0f`; this directory's `.lake/packages` is the
shared build the other crates symlink to). Do **not** `lake update` here (floats
Hax/CompPoly to `main`, rebuilds a divergent Hax that breaks the monty-31 dep and
bumps the toolchain). Hax/toolchain bumps are a deliberate cross-crate action — see
the repo-root SYNC.md "Maintenance" section, and bump all crates together.

## Step 4 — Refresh `TCB.md`

Update line/sorry counts, patch sizes, the Hax rev, per-stub line counts, and the
hole set if any moved. Walk its audit checklist.

## Maintenance: Lean toolchain / Hax bumps

Coordinated across all official crates by the root `SYNC.md`. After a bump, re-run
`build-proofs.sh`; if a `p3_koala_bear_proofs/` proof broke due to churn, fix the
proof rather than admit it.

## What "good" looks like
- `cd koala-bear/proofs/lean/extraction && lake build` exits 0 with only `sorry`
  warnings (no errors, no `.rej`); `p3_koala_bear_proofs` builds.
- `git status --porcelain koala-bear/src monty-31/src` empty.
- The `p3_monty_31` path dep resolves; no `p3_monty_31.aarch64_neon` references in
  `p3_koala_bear.lean`.
