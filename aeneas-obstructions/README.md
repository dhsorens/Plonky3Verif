# Aeneas obstruction reports

Dated snapshots of how well the [Aeneas](https://github.com/AeneasVerif/aeneas)
/ [Charon](https://github.com/AeneasVerif/charon) toolchain can extract the
Plonky3 crates in this repo, and what blocks it. Each report records the exact
aeneas + charon commits surveyed, so this directory doubles as a log of which
upstream commits fixed (or regressed) which blockers over time.

**To generate a new report:** prompt Claude to *"run AENEAS.md"*. The procedure
lives in [`../AENEAS.md`](../AENEAS.md); the per-crate extractor it drives is
[`run-extract.sh`](run-extract.sh).

Live obstructions (with minimal repros) are drafted in
[`issue-drafts/`](issue-drafts/); obstructions fixed upstream are logged in
[`RESOLVED.md`](RESOLVED.md). Known limitations and extraction workarounds:
[`WORKAROUNDS.md`](WORKAROUNDS.md).

Only these reports and the runner script are committed — never extracted Lean
code (it stays in `/tmp/aeneas-extract/`). The hax-based workspaces under
`*/proofs/` are a separate, unrelated workflow.

## Reports (newest first)

| Date | aeneas | charon | Headline |
| --- | --- | --- | --- |
| [2026-08-06](2026-08-06.md) | `daa85d7e` | `340b1af4` (v0.1.232) | **Quiet toolchain, one real discovery.** aeneas moved 2 mechanical commits, charon 25 — no obstruction moved, and `air` (the one crate with zero source changes) reproduced #9 bit-for-bit, which pins that down. New **#16**: charon reports `error: Type error after transformations` on RPITIT assoc-type arity yet **exits 0**, handing aeneas ill-typed LLBC — 68 hits in 4 crates, missed by prior surveys because they keyed on exit code. Rebuilding the old charon proved it pre-existing, not a regression; `run-extract.sh` now counts charon errors. Its **7-line repro also reproduces #11** (aeneas #1164). #3 and #10 gained upstream tickets (aeneas #1112, #1239); the `trait_decl_id` cascade is now covered by #1241. ⚠️ Per-crate counts are confounded: the Plonky3 source synced with upstream, touching 12 of 13 sample crates. |
| [2026-07-27](2026-07-27.md) | `3a8586fa` | `527ea8e3` (v0.1.225) | **First crate ever extracts cleanly.** Biggest delta since 06-04 (aeneas +57, charon +103): `maybe-rayon` **0 errors / exit 0**, `keccak` down to 1 unique error, errors fell in every crate, and charon #1326 cut the GAT cascade (`field` 668→17). Both hard blockers survive: #9 stack overflow (now on `packed_ext_powers_capped_ty`; `air`/`commit` abort on their own crate) and #11 `CFailure`. New #12 HRTB errors from aeneas #1158 (Represented by #1227); #6 mixed trait×closure groups identified as the real cascade root; #13/#14 filed-ready with one-line repros. |
| [2026-06-25](2026-06-25.md) | `21e39de9` | `6f058254` (v0.1.216) | **Quiet run — no obstruction moved.** 12 aeneas commits, all Lean-backend/tooling (iterator models, `translation.json`, tactics); charon pin unchanged. Every error count + GAT cascade identical; #9 stack overflow reproduces byte-for-byte. The #11 `CFailure` (last run's top filing) **now Represented** by aeneas #1164. New build dep: `ppx_deriving_yojson`. |
| [2026-06-16](2026-06-16.md) | `8dd8bfb3` | `6f058254` (v0.1.216) | **Refactor churn, net mixed.** Trait-method rework killed the #2 trait-lookup cascade (now 0) and cut errors 50–90 %, but a new uncaught `CFailure` (#11) regressed `util`/`symmetric`/`merkle-tree` to **zero Lean**. #9 charon stack overflow unchanged; #10 superseded; closures now tracked by aeneas #1119. |
| [2026-06-08](2026-06-08.md) | `39c6a720` | `9dd7f23c` (v0.1.212) | **Toolchain moved, no obstruction moved.** aeneas bumped `charon-pin` past #1263 → last run's charon override **retired** (by-the-book build). Verdicts identical; charon #1266 closed NOT_PLANNED (Issue #2 → known limitation). |
| [2026-06-04](2026-06-04.md) | `5c70d9b0` | `985e04c6` (v0.1.210) | **#1 blocker moved.** charon #1263 fixes the `GenericsMismatch` panic → 7→10 crates produce a `.llbc`; but a new charon stack overflow (#9) + new aeneas `Not_found` (#10) appear. |
| [2026-06-03](2026-06-03.md) | `ac74e1ba` | `a535e914` (v0.1.210) | Toolchain advanced ~90 commits; **no blocker moved**. charon still panics on `p3-field`; adjacent charon #1159 closed. |
| [2026-05-28](2026-05-28.md) | `42776dac` | `103daa06` (v0.1.198) | Not usable yet. Top blocker: charon `GenericsMismatch` panic on `p3-field`. |
