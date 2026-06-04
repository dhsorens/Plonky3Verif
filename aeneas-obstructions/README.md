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
| [2026-06-04](2026-06-04.md) | `5c70d9b0` | `985e04c6` (v0.1.210) | **#1 blocker moved.** charon #1263 fixes the `GenericsMismatch` panic → 7→10 crates produce a `.llbc`; but a new charon stack overflow (#9) + new aeneas `Not_found` (#10) appear. |
| [2026-06-03](2026-06-03.md) | `ac74e1ba` | `a535e914` (v0.1.210) | Toolchain advanced ~90 commits; **no blocker moved**. charon still panics on `p3-field`; adjacent charon #1159 closed. |
| [2026-05-28](2026-05-28.md) | `42776dac` | `103daa06` (v0.1.198) | Not usable yet. Top blocker: charon `GenericsMismatch` panic on `p3-field`. |
