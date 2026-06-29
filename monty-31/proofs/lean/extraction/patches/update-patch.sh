#!/usr/bin/env bash
# Regenerate p3_monty_31.patch from the current p3_monty_31.lean.
#
# Use after hand-editing p3_monty_31.lean to make it compile (e.g. after a hax
# upgrade changed the pristine output and the existing patch no longer applies).
# Captures the diff between fresh hax output (pristine.snapshot.lean, written by
# build-proofs.sh) and the now-verified state.

set -eu

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTRACT_DIR="$(dirname "$HERE")"
TARGET="$EXTRACT_DIR/p3_monty_31.lean"
PRISTINE="$HERE/pristine.snapshot.lean"
PATCH_FILE="$HERE/p3_monty_31.patch"

if [ ! -f "$PRISTINE" ]; then
    echo "ERROR: $PRISTINE not found. Run build-proofs.sh first to populate it." >&2
    exit 1
fi
if [ ! -f "$TARGET" ]; then
    echo "ERROR: $TARGET not found." >&2
    exit 1
fi

(cd "$HERE" && diff -u "pristine.snapshot.lean" "../p3_monty_31.lean") > "$PATCH_FILE" || true

if [ ! -s "$PATCH_FILE" ]; then
    echo "==> no differences; removing empty patch file."
    rm "$PATCH_FILE"
else
    echo "==> wrote $PATCH_FILE ($(wc -l < "$PATCH_FILE") lines)."
fi
