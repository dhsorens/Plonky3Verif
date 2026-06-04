# Known limitations and workarounds

Expected toolchain behavior or upstream won't-fix items. Filed issues:
[`RESOLVED.md`](RESOLVED.md). Repros: [`issue-drafts/`](issue-drafts/).

---

## GAT / RPITIT + `--lift-associated-types='*'` — [charon#1266](https://github.com/AeneasVerif/charon/issues/1266)

**Repro:** [`02-trait-parent-clause-repro/`](issue-drafts/02-trait-parent-clause-repro/)

Charon maintainer (2026-06-04): not a bug — GAT lift is out of scope for
`--lift-associated-types`; Aeneas has no GAT/Lean model anyway. RPITIT may get a
special case in charon later; end-to-end extraction still blocked on Aeneas.

**Plonky3:** `RawDataSerializable` (`into_byte_stream`, …), `unpack_iter_ty`
(`field/src/op_assign_macros.rs`). Default `--preset aeneas` hits this. Charon
writes `TyKind::Error` → Aeneas failures / field-trait lookup cascades at scale.

**Workarounds:**

1. **`--exclude`** flagged traits (start with `p3_field::field::RawDataSerializable`).
2. **Smaller surface** — `-include` / `-start-from`; leaf crates first (`keccak`).
3. **Verification fork** — replace RPITIT with plain assoc type + named iterator type.
4. **Hax Lean workspaces** (`*/proofs/lean/extraction/`) — separate from whole-crate Aeneas.

Scoped GAT-free extraction is still viable; full crypto-core via vanilla preset is not yet.
Related: [aeneas#176](https://github.com/AeneasVerif/aeneas/issues/176) (mutually recursive traits / serde).

```sh
charon cargo --preset aeneas \
  --exclude 'p3_field::field::RawDataSerializable' \
  --dest-file /tmp/out.llbc
```
