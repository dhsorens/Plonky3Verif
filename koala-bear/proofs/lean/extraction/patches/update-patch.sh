#!/usr/bin/env bash
# Regenerate p3_koala_bear.patch from the current p3_koala_bear.lean.
#
# Use after you have hand-edited p3_koala_bear.lean to make it compile (e.g.
# after a hax upgrade changed the pristine output and the existing patch no
# longer applies). This captures the new diff between fresh hax output and
# the now-verified state.
#
# Requires pristine.snapshot.lean to exist alongside this script. It is
# normally created by regenerate.sh; if missing, run `cargo hax into lean`
# from the koala-bear crate root and copy the result here.

set -eu

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTRACT_DIR="$(dirname "$HERE")"
TARGET="$EXTRACT_DIR/p3_koala_bear.lean"
PRISTINE="$HERE/pristine.snapshot.lean"
PATCH_FILE="$HERE/p3_koala_bear.patch"

if [ ! -f "$PRISTINE" ]; then
    echo "ERROR: $PRISTINE not found." >&2
    echo "Run regenerate.sh from the koala-bear crate root first to populate it," >&2
    echo "or copy a fresh \`cargo hax into lean\` output to that path manually." >&2
    exit 1
fi

if [ ! -f "$TARGET" ]; then
    echo "ERROR: $TARGET not found." >&2
    exit 1
fi

# `diff -u` exits 1 when files differ; that's the normal case here.
# Run from the patches dir so the diff header uses short relative paths.
(cd "$HERE" && diff -u "pristine.snapshot.lean" "../p3_koala_bear.lean") > "$PATCH_FILE" || true

if [ ! -s "$PATCH_FILE" ]; then
    echo "==> no differences; removing empty patch file."
    rm "$PATCH_FILE"
else
    echo "==> wrote $PATCH_FILE ($(wc -l < "$PATCH_FILE") lines)."
fi
