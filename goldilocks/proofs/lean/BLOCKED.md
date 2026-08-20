# goldilocks — aeneas-backend extraction: BLOCKED

`cargo hax into lean` (hax e11615541, charon nightly-2026.07.24, aeneas
nightly-2026.08.18-ae2f343) cannot yet extract this crate. Tested 2026-08-19
with the pre-extraction source patches applied and `--cfg hax` set globally
(RUSTFLAGS), i.e. the same conditions as the working keccak/blake3 pipelines.

**Blocker:** 9 charon `Type error after transformations` (its `impl_raw_serializable_primefield64`/u64-stream surface plus stdlib iterator items), and its committed src patch `p3_goldilocks.src.patch` no longer applies after the 2026-07-27 upstream sync (pre-existing breakage — regenerate it first).

The frozen legacy-printer workspace lives in `../../proofs-legacy/`. Cross-
reference: the aeneas survey (`aeneas-obstructions/`) tracks these upstream
obstructions; re-test after the referenced issue moves.
