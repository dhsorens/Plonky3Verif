#!/usr/bin/env bash
#
# build-lean.sh — regenerate p3_blake3.lean and compile it with Lake.
#
# Counterpart to keccak's build-lean.sh. The `blake3` crate is external
# (crates.io), so its SIMD internals are NOT extracted — unlike keccak, no
# `-C target-feature` flag is needed; a plain extraction is already scalar.
#
#   1. `cargo hax into lean` (isolated CARGO_TARGET_DIR to avoid stale cached Lean).
#   2. Two post-extraction rewrites of the generated p3_blake3.lean (it's hax
#      output; like koala-bear we post-process the *output*, never blake3/src):
#        a. inject `import p3_blake3.dependencies` (pulls in the stubs);
#        b. drop the bogus `(associatedTypes := { … with Item := … })` overrides
#           — the engine emits an `IntoIterator<Item=…>` encoding whose `Item`
#           field does not exist in this proof-lib (engine/proof-lib skew).
#   3. `lake build`.
#
# `Blake3::hash_iter` and `hash_iter_slices` keep hax's `sorry` placeholders for
# their closure bodies (mutable-capture / `&mut Self`-returning `update`, which
# hax can't translate) — that's fine, `sorry` compiles.

set -eu
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"   # …/proofs/lean/extraction
CRATE_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"             # blake3/
TARGET="$SCRIPT_DIR/p3_blake3.lean"

echo "==> cargo hax into lean"
isolated="${HAX_ISOLATED_TARGET:-/tmp/hax-extract/target-blake3-lean}"
rm -rf "$isolated"
( cd "$CRATE_ROOT" && \
  CARGO_TARGET_DIR="$isolated" \
  HAX_ENGINE_BINARY="${HAX_ENGINE_BINARY:-$HOME/.opam/default/bin/hax-engine}" \
  RUSTUP_TOOLCHAIN="${HAX_TOOLCHAIN:-nightly-2025-11-08}" \
  RUSTFLAGS="${RUSTFLAGS:-} -Zcrate-attr=feature(maybe_uninit_slice)" \
  cargo hax into lean )

echo "==> post-process: inject dependency import"
grep -q '^import p3_blake3.dependencies' "$TARGET" || \
  perl -i -pe 's/^(import Hax)$/$1\nimport p3_blake3.dependencies/ if !$d && /^import Hax$/ and ($d=1)' "$TARGET"

echo "==> post-process: drop bogus IntoIterator Item overrides"
perl -0777 -i -pe 's/\s*\(associatedTypes := \{.*?with Item := .*?\}\)//gs' "$TARGET"

echo "==> lake build"
( cd "$SCRIPT_DIR" && lake build )
echo "==> done."
