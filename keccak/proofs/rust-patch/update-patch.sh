#!/usr/bin/env bash
#
# update-patch.sh — regenerate patches/p3_keccak.patch after editing the rewrite.
#
# Unlike koala-bear's Lean patch (which diffs a gitignored pristine snapshot of
# hax OUTPUT), the Rust patch diffs the committed SOURCE against your in-tree
# edits, so the procedure is:
#
#   1. Ensure keccak/src is committed/clean.
#   2. Hand-edit keccak/src/lib.rs into the hax-friendly form (keep `// PATCHED`
#      markers so each change is traceable; see patches/README.md).
#   3. Verify it extracts cleanly:
#        aeneas-obstructions/hax-extract.sh keccak   # but that REVERTS first —
#      so instead, while your edits are in the tree, extract WITHOUT the driver:
#        ( cd keccak && CARGO_TARGET_DIR=/tmp/hax-extract/target-keccak \
#          HAX_ENGINE_BINARY=$HOME/.opam/default/bin/hax-engine \
#          RUSTUP_TOOLCHAIN=nightly-2025-11-08 \
#          RUSTFLAGS=-Zcrate-attr=feature(maybe_uninit_slice) \
#          cargo hax into lean )
#      and confirm 0 `sorry` in ../lean/extraction/p3_keccak.lean.
#   4. Run THIS script to capture the diff, then revert the source.
#
# Result: patches/p3_keccak.patch (git-apply format), source left pristine.

set -eu
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"          # keccak/proofs/rust-patch
REPO="$(cd "$HERE/../../.." && pwd)"
PATCH="$HERE/patches/p3_keccak.patch"

cd "$REPO"
if git diff --quiet -- keccak/src; then
  echo "error: keccak/src has no uncommitted changes — nothing to capture." >&2
  echo "       Make your hax-friendly edits to keccak/src/lib.rs first." >&2
  exit 1
fi

mkdir -p "$(dirname "$PATCH")"
git diff -- keccak/src > "$PATCH"
echo "==> wrote $PATCH ($(wc -l < "$PATCH") lines)"

echo "==> reverting keccak/src to pristine"
git checkout -- keccak/src
echo "==> done. Source is pristine; the rewrite lives only in the patch."
