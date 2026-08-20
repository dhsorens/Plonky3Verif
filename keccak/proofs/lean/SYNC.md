# keccak (aeneas backend) — per-crate sync runbook

Assumes the upstream merge is already done (root `SYNC.md` dispatches here
when the merge touched `keccak/src`, `keccak/Cargo.toml`, or the gated parts
of `field/`/`symmetric`).

1. `./build-proofs.sh`. Expected: cargo hax exits non-zero with 2 aeneas
   errors (`Unreachable` on the two `derive(Debug)` impls — axiomatized), the
   reconcile prints `changed`, and `lake build` ends green.
2. If `reconcile.py` prints `no-op` or the build fails, the generator output
   drifted: diff `patches/Funs.pristine.lean` against the last committed
   pristine, adjust `reconcile.py`'s literal patterns (they are exact-string
   matches on generated text) and, if new externals appeared, extend
   `P3Keccak/Extraction/{Types,Funs}External.lean`. Update `TCB.md` for any
   new axiom.
3. Commit `keccak/proofs/lean/` only (generated + hand files; `llbc/`,
   `aeneas-error.log`, `.lake/`, and `patches/Funs.pristine.lean` are
   gitignored).
