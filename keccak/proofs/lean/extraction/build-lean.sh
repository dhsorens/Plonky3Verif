#!/usr/bin/env bash
#
# build-lean.sh — regenerate p3_keccak.lean and compile it with Lake.
#
# Counterpart to koala-bear's build-proofs.sh, for keccak. Produces a *clean
# scalar* extraction (no aarch64 SHA3/NEON SIMD) and makes it build against the
# hand-written stubs in p3_keccak/.
#
#   1. `cargo hax into lean` with `-C target-feature=-sha3` so keccak takes its
#      portable scalar path (tiny_keccak::keccakf) instead of the NEON module.
#      The NEON path can't compile here anyway: it needs `core_arch` SIMD
#      intrinsics the Hax proof-lib lacks, and emits `RustM.of_isOk (transmute …)
#      (by rfl)` which can't typecheck (`transmute` is opaque).
#   2. Two post-extraction rewrites of the generated p3_keccak.lean (the file is
#      hax output; like koala-bear we post-process it, not the Rust source):
#        a. inject `import p3_keccak.dependencies` (pulls in the stubs);
#        b. drop the bogus `(associatedTypes := { … with Item := … })` overrides
#           — the engine emits an `IntoIterator<Item=…>` encoding whose `Item`
#           field does not exist in this proof-lib (engine/proof-lib skew).
#   3. `lake build`.
#
# `hash_iter` here is hax's `sorry` placeholder (it can't translate the
# mutable-capture closure `apply_to_chunks(input, |buf| hasher.update(buf))`),
# which is fine — `sorry` compiles.

set -eu
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"   # …/proofs/lean/extraction
CRATE_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"             # keccak/
TARGET="$SCRIPT_DIR/p3_keccak.lean"

echo "==> cargo hax into lean (scalar; -C target-feature=-sha3)"
isolated="${HAX_ISOLATED_TARGET:-/tmp/hax-extract/target-keccak-lean}"
rm -rf "$isolated"
( cd "$CRATE_ROOT" && \
  CARGO_TARGET_DIR="$isolated" \
  HAX_ENGINE_BINARY="${HAX_ENGINE_BINARY:-$HOME/.opam/default/bin/hax-engine}" \
  RUSTUP_TOOLCHAIN="${HAX_TOOLCHAIN:-nightly-2025-11-08}" \
  RUSTFLAGS="${RUSTFLAGS:-} -Zcrate-attr=feature(maybe_uninit_slice) -C target-feature=-sha3" \
  cargo hax into lean )

echo "==> post-process: inject dependency import"
grep -q '^import p3_keccak.dependencies' "$TARGET" || \
  perl -i -pe 's/^(import Hax)$/$1\nimport p3_keccak.dependencies/ if !$d && /^import Hax$/ and ($d=1)' "$TARGET"

echo "==> post-process: drop bogus IntoIterator Item overrides"
perl -0777 -i -pe 's/\s*\(associatedTypes := \{.*?with Item := .*?\}\)//gs' "$TARGET"

echo "==> lake build"
( cd "$SCRIPT_DIR" && lake build )
echo "==> done."
