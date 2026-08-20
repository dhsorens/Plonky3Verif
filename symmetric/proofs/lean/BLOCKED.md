# symmetric — aeneas-backend extraction: BLOCKED

`cargo hax into lean` (hax e11615541, charon nightly-2026.07.24, aeneas
nightly-2026.08.18-ae2f343) cannot yet extract this crate. Tested 2026-08-19
with the pre-extraction source patches applied and `--cfg hax` set globally
(RUSTFLAGS), i.e. the same conditions as the working keccak/blake3 pipelines.

**Blocker:** 3 residual charon `Type error after transformations` (stdlib iterator items: `ChunksExactMut`/`Zip`/`IterMut` — charon bug, not patchable from this repo) and aeneas `[Error] Returns inside of nested loops are not supported yet` in the sponge/padding loops. (The p3-field hax gates already removed 46 of the original 49 type errors.)

The frozen legacy-printer workspace lives in `../../proofs-legacy/`. Cross-
reference: the aeneas survey (`aeneas-obstructions/`) tracks these upstream
obstructions; re-test after the referenced issue moves.
