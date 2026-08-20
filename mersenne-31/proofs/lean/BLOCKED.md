# mersenne-31 — aeneas-backend extraction: BLOCKED

`cargo hax into lean` (hax e11615541, charon nightly-2026.07.24, aeneas
nightly-2026.08.18-ae2f343) cannot yet extract this crate. Tested 2026-08-19
with the pre-extraction source patches applied and `--cfg hax` set globally
(RUSTFLAGS), i.e. the same conditions as the working keccak/blake3 pipelines.

**Blocker:** charon stack overflow (SIGABRT) lifting associated types on p3-mersenne-31 itself — aeneas-survey Issue #9 — reproduced even with SIMD/DFT source-gated. Needs the upstream charon fix (no ticket yet; see aeneas-obstructions issue drafts).

The frozen legacy-printer workspace lives in `../../proofs-legacy/`. Cross-
reference: the aeneas survey (`aeneas-obstructions/`) tracks these upstream
obstructions; re-test after the referenced issue moves.
