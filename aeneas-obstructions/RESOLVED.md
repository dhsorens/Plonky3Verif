# Filed obstructions

Obstructions from the survey reports that we have **filed upstream**, with the
issue we opened and (once fixed) the PR that closed it. Obstructions not yet
filed are drafted in `issue-drafts/`.

## Open (pending fix)

| Obstruction | Issue opened | Status |
| --- | --- | --- |
| charon cannot lift a GAT produced by a return-position-`impl Trait`-in-trait (RPITIT) method under `--lift-associated-types='*'`; it writes an `Error` placeholder into the LLBC. Root cause of the aeneas `trait_parent_clause_id`/`trait_const_id`/`trait_type_id` lookup-failure cascade on the `p3-field` trait cluster (480+ on `p3-koala-bear`). Repro: `issue-drafts/02-trait-parent-clause-repro/`. | [charon#1266](https://github.com/AeneasVerif/charon/issues/1266) — *"Could not compute GAT from RPITIT in trait under `--lift-associated-types='*'`"* | open (filed 2026-06-04) |

## Fixed upstream

| Obstruction | Issue opened | Closed by | Verified |
| --- | --- | --- | --- |
| charon `GenericsMismatch` panic in `expand_associated_types` (`types_utils.rs:1254`) when lifting associated types on the `p3-field` trait hierarchy — was the top blocker (every crate depending on `p3-field`). | [charon#1260](https://github.com/AeneasVerif/charon/issues/1260) | [charon#1263](https://github.com/AeneasVerif/charon/pull/1263) — `lift-assoc-tys: add constraints in scope when adding extra assoc tys` | 2026-06-04, against `origin/main` `985e04c6` (toolchain nightly-2026-06-01): minimal repro exits 0, no panic. Installed `a535e914` still panics. |
