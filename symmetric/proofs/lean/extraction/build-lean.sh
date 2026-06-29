#!/usr/bin/env bash
#
# build-lean.sh — regenerate p3_symmetric.lean and compile it with Lake.
#
# SCOPED to the essential interface: keccak/blake3 (and koala-bear) only consume
# p3_symmetric's *trait classes* (`hasher.CryptographicHasher`,
# `permutation.{Permutation,CryptographicPermutation}`). The crate's sponge / hash
# / serializing / compression IMPL modules pull in a large surface the pinned Hax
# proof-lib can't type-check (num-bigint, serde, itertools, the p3_field
# hierarchy, missing iterator combinators). The "full crate" was tried (all
# declarations kept, bodies sorried) but only compiled by cranking the typeclass
# search budget to millions of heartbeats — too slow/brittle to be worth it for a
# non-priority crate. So we slice the extracted file down to the trait-class
# namespaces, which depend only on `core_models`/Hax. (See TCB.md.)
#
#   1. `cargo hax into lean` (isolated CARGO_TARGET_DIR; symmetric is pure Rust,
#      so no `-C target-feature` flag).
#   2. Post-process the generated p3_symmetric.lean (hax output; never src):
#        a. inject `import p3_symmetric.dependencies`;
#        b. SLICE to the `p3_symmetric.hasher` + `p3_symmetric.permutation`
#           namespace blocks that define `class`es (drop everything else);
#        c. drop the bogus `(associatedTypes := { … with Item := … })` overrides;
#        d. `sorry` the trait methods' default bodies.
#   3. `lake build`.

set -eu
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CRATE_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
TARGET="$SCRIPT_DIR/p3_symmetric.lean"

echo "==> cargo hax into lean"
isolated="${HAX_ISOLATED_TARGET:-/tmp/hax-extract/target-symmetric-lean}"
rm -rf "$isolated"
( cd "$CRATE_ROOT" && \
  CARGO_TARGET_DIR="$isolated" \
  HAX_ENGINE_BINARY="${HAX_ENGINE_BINARY:-$HOME/.opam/default/bin/hax-engine}" \
  RUSTUP_TOOLCHAIN="${HAX_TOOLCHAIN:-nightly-2025-11-08}" \
  RUSTFLAGS="${RUSTFLAGS:-} -Zcrate-attr=feature(maybe_uninit_slice)" \
  cargo hax into lean )

echo "==> post-process: inject dependency import"
grep -q '^import p3_symmetric.dependencies' "$TARGET" || \
  perl -i -pe 's/^(import Hax)$/$1\nimport p3_symmetric.dependencies/ if !$d && /^import Hax$/ and ($d=1)' "$TARGET"

echo "==> post-process: slice to the trait-class namespaces (essential interface)"
awk '
  BEGIN { header = 1; inns = 0 }
  /^namespace p3_symmetric\./ { header = 0; inns = 1; ns = $2; buf = $0 "\n"; hasclass = 0; next }
  inns == 1 {
    buf = buf $0 "\n"
    if ($0 ~ /^class /) hasclass = 1
    if ($0 ~ /^end p3_symmetric\./) {
      inns = 0
      if ((ns == "p3_symmetric.hasher" || ns == "p3_symmetric.permutation") && hasclass) printf "%s", buf
    }
    next
  }
  header == 1 { print }
' "$TARGET" > "$TARGET.tmp" && mv "$TARGET.tmp" "$TARGET"

echo "==> post-process: drop bogus IntoIterator Item overrides"
perl -0777 -i -pe 's/\s*\(associatedTypes := \{[^{}]*with Item := [^{}]*\}\s*\)//g' "$TARGET"

echo "==> post-process: sorry out trait default-method bodies"
perl -0777 -i -pe 's/(:RustM[\s\w]*?:=)\s*do\b.*?(?=\n  [a-zA-Z_]+ \(Self\)|\n\s*attribute |\n\s*end )/$1 sorry/gs' "$TARGET"

echo "==> lake build"
( cd "$SCRIPT_DIR" && lake build )
echo "==> done."
