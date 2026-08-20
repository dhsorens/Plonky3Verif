# monty-31 — aeneas-backend extraction: BLOCKED

`cargo hax into lean` (hax e11615541, charon nightly-2026.07.24, aeneas
nightly-2026.08.18-ae2f343) cannot yet extract this crate. Tested 2026-08-19
with the pre-extraction source patches applied and `--cfg hax` set globally
(RUSTFLAGS), i.e. the same conditions as the working keccak/blake3 pipelines.

**Blocker:** aeneas `Detected groups of mixed mutually recursive definitions`: the `Div`/`DivAssign` impls (from p3-field's `impl_div_methods` macro) are mutually recursive with the `Field`/`PrimeCharacteristicRing` trait impls — aeneas issue #1264 territory; fatal at declaration-reordering, no output. (All 9 charon type errors are already fixed by the p3-field hax gates.) Blocks koala-bear and baby-bear identically.

The frozen legacy-printer workspace lives in `../../proofs-legacy/`. Cross-
reference: the aeneas survey (`aeneas-obstructions/`) tracks these upstream
obstructions; re-test after the referenced issue moves.
