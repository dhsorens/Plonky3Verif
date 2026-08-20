# baby-bear — aeneas-backend extraction: BLOCKED

`cargo hax into lean` (hax e11615541, charon nightly-2026.07.24, aeneas
nightly-2026.08.18-ae2f343) cannot yet extract this crate. Tested 2026-08-19
with the pre-extraction source patches applied and `--cfg hax` set globally
(RUSTFLAGS), i.e. the same conditions as the working keccak/blake3 pipelines.

**Blocker:** same as monty-31/koala-bear: the `Div` × `Field` mixed mutually-recursive group (aeneas #1264).

The frozen legacy-printer workspace lives in `../../proofs-legacy/`. Cross-
reference: the aeneas survey (`aeneas-obstructions/`) tracks these upstream
obstructions; re-test after the referenced issue moves.
