# blake3 — Lean extraction via hax's aeneas backend

Extraction of `p3-blake3` through **`cargo hax into lean`** on hax
`e11615541`+ — the aeneas-based backend (charon → `.llbc` → aeneas), which
replaced the OCaml Lean printer as hax's `lean` backend in July 2026. The
previous (legacy-printer) workspace lives on in
[`../../proofs-legacy/`](../legacy) — see the repo-root `SYNC.md`.

- **Regenerate:** `./build-proofs.sh` (applies the pre-extraction Rust source
  patches, extracts with `--cfg hax` set globally via `RUSTFLAGS` — `cargo
  hax` does *not* set it for dependency crates — then runs
  `patches/reconcile.py` and `lake build`).
- **Layout:** `P3Blake3/Extraction/{Types,Funs}.lean` are generated;
  `TypesExternal.lean` / `FunsExternal.lean` are **hand-maintained** (filled
  from the `*_Template.lean` files, plus hand-modeled dependency traits and
  external axioms); `lakefile.toml` pins `hax-lean` v0.3.0 (Lean v4.31.0),
  which pulls the matching Aeneas Lean library.
- **Status:** `lake build` green, **0 sorries**. Trust surface in
  [`TCB.md`](TCB.md).
- **Sync:** [`SYNC.md`](SYNC.md).
