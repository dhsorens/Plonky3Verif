# Filed obstructions

Obstructions from the survey reports that we have **filed upstream**, with the
issue we opened and (once fixed) the PR that closed it. Obstructions not yet
filed are drafted in `issue-drafts/`. Known limitations and workarounds:
[`WORKAROUNDS.md`](WORKAROUNDS.md).

## Open (pending fix)

| Obstruction | Issue opened | Status |
| --- | --- | --- |
| aeneas uncaught `Not_found` in `trait_impl_is_builtin` (`Translate.ml:1017`) when a trait impl references a declaration dropped from `trans_trait_decls` (common with serde's mutually recursive `Serialize`/`Serializer` cluster). Repro: `issue-drafts/03-not-found-trait-impl-repro/`. | [aeneas#1102](https://github.com/AeneasVerif/aeneas/issues/1102) — *"Uncaught Not_found in trait_impl_is_builtin (Translate.ml:1017)"* | open (filed 2026-06-04) |

## Known limitations (work around locally)

Upstream treats these as out of scope or blocked on missing Aeneas/Lean support.
**Workarounds:** [`WORKAROUNDS.md`](WORKAROUNDS.md).

| Obstruction | Issue / link | Notes |
| --- | --- | --- |
| GAT / RPITIT under `--lift-associated-types='*'`. Plonky3: `RawDataSerializable`, `unpack_iter_ty`. | [charon#1266](https://github.com/AeneasVerif/charon/issues/1266) | Known limitation (2026-06-04). [`WORKAROUNDS.md`](WORKAROUNDS.md). Repro: `issue-drafts/02-trait-parent-clause-repro/`. |

## Fixed upstream

| Obstruction | Issue opened | Closed by | Verified |
| --- | --- | --- | --- |
| charon `GenericsMismatch` panic in `expand_associated_types` (`types_utils.rs:1254`) when lifting associated types on the `p3-field` trait hierarchy — was the top blocker (every crate depending on `p3-field`). | [charon#1260](https://github.com/AeneasVerif/charon/issues/1260) | [charon#1263](https://github.com/AeneasVerif/charon/pull/1263) — `lift-assoc-tys: add constraints in scope when adding extra assoc tys` | 2026-06-04, against `origin/main` `985e04c6` (toolchain nightly-2026-06-01): minimal repro exits 0, no panic. Confirmed in the [2026-06-04 survey](2026-06-04.md) — 5 previously-panicking crates now extract (`monty-31`/`challenger`/`mds`/`symmetric`/`merkle-tree`). Note: `p3-field` itself now hits a *successor* charon stack overflow in the same pass (Issue #9, [2026-06-04.md](2026-06-04.md), unfiled). Installed `a535e914` still panics. |
