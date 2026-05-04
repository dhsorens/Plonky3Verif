#!/usr/bin/env bash
# Regenerate the koala-bear Lean extraction from Rust source.
#
#   1. Run `cargo hax into lean` (overwrites proofs/lean/extraction/p3_koala_bear.lean).
#   2. Snapshot that pristine output (so update-patch.sh can diff against it later).
#   3. Apply proofs/lean/extraction/patches/p3_koala_bear.patch.
#   4. Run `lake build`. Failure here is reported but does not abort, so you can
#      still inspect the file.
#
# When hax output drifts and the patch no longer applies cleanly, hand-edit
# p3_koala_bear.lean until it compiles, then run patches/update-patch.sh to
# regenerate the patch.

set -eu

# This script lives in proofs/lean/extraction/; the Rust crate root is three levels up.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CRATE_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
EXTRACT_DIR="$SCRIPT_DIR"
PATCH_DIR="$EXTRACT_DIR/patches"
TARGET="$EXTRACT_DIR/p3_koala_bear.lean"
PRISTINE="$PATCH_DIR/pristine.snapshot.lean"
PATCH_FILE="$PATCH_DIR/p3_koala_bear.patch"

cd "$CRATE_ROOT"

echo "==> cargo hax into lean"
cargo hax into lean

echo "==> snapshotting pristine output"
cp "$TARGET" "$PRISTINE"

if [ -f "$PATCH_FILE" ]; then
    echo "==> applying $PATCH_FILE"
    patch "$TARGET" < "$PATCH_FILE"
else
    echo "==> no patch file found; skipping (run patches/update-patch.sh after hand-editing)" >&2
fi

echo "==> lake build"
if (cd "$EXTRACT_DIR" && lake build); then
    echo "==> done; build succeeded."
else
    echo "WARNING: lake build failed. The (patched) file is in place; inspect for drift." >&2
fi
