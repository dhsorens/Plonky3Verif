#!/usr/bin/env bash
# Regenerate the mersenne-31 Lean extraction from Rust source.
#
# mersenne-31 is the prime field F_p, p = 2^31 - 1. It carries hand-written SIMD
# packings (aarch64 NEON, x86_64 AVX2/AVX512) that hax cannot model — the
# intrinsics have no proof-lib mapping — plus DFT modules (dft, radix_2_dit) that
# are FFT machinery, not field arithmetic. Rather than emit unbuildable NEON
# references and stub the DFT's p3-dft/p3-matrix surface, we drop the SIMD and DFT
# modules *before* extraction with a small, behaviour-preserving Rust source patch
# that gates them on `not(hax)` and forces the portable `no_packing` path under
# `--cfg hax` (hax always sets `--cfg hax`). A normal `cargo build` is unaffected.
#
# Flow (mirrors koala-bear's build-proofs.sh, plus the source-patch step):
#   0. clean-tree guard on src/; trap-revert; `git apply` the source patch.
#   1. `cargo hax into lean` in an ISOLATED CARGO_TARGET_DIR (REQUIRED — the
#      shared target/hax serves stale cached Lean that ignores the patch).
#   2. trap fires → src/ restored to pristine.
#   3. snapshot the pristine Lean output (for update-patch.sh).
#   4. apply patches/p3_mersenne_31.patch (the Lean patch).
#   5. `lake build`. Failure is reported, not fatal, so you can inspect.
#
# When hax output drifts and the patch no longer applies, hand-edit
# p3_mersenne_31.lean until it compiles, then run patches/update-patch.sh.

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CRATE_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
REPO_ROOT="$(cd "$CRATE_ROOT/.." && pwd)"
EXTRACT_DIR="$SCRIPT_DIR"
PATCH_DIR="$EXTRACT_DIR/patches"
TARGET="$EXTRACT_DIR/p3_mersenne_31.lean"
PRISTINE="$PATCH_DIR/pristine.snapshot.lean"
PATCH_FILE="$PATCH_DIR/p3_mersenne_31.patch"
SRC_PATCH="$CRATE_ROOT/proofs/rust-patch/patches/p3_mersenne_31.src.patch"

# ---- 0. source patch: clean-tree guard + guaranteed revert + apply ----------
SRC_REL="mersenne-31/src"
if [ -f "$SRC_PATCH" ]; then
    if ! git -C "$REPO_ROOT" diff --quiet -- "$SRC_REL" \
       || ! git -C "$REPO_ROOT" diff --cached --quiet -- "$SRC_REL"; then
        echo "error: $SRC_REL has uncommitted changes; aborting so we never" >&2
        echo "       overwrite your work. Commit/stash first, then re-run." >&2
        exit 1
    fi
    revert() { git -C "$REPO_ROOT" checkout -- "$SRC_REL" 2>/dev/null || true; }
    trap revert EXIT
    echo "==> applying source patch $SRC_PATCH"
    git -C "$REPO_ROOT" apply "$SRC_PATCH"
fi

# ---- 1. extract (isolated target dir is REQUIRED for the patch to take) ------
echo "==> cargo hax into lean"
isolated="${HAX_ISOLATED_TARGET:-/tmp/hax-extract/target-mersenne-31-lean}"
rm -rf "$isolated"
( cd "$CRATE_ROOT" && \
  CARGO_TARGET_DIR="$isolated" \
  HAX_ENGINE_BINARY="${HAX_ENGINE_BINARY:-$HOME/.opam/default/bin/hax-engine}" \
  RUSTUP_TOOLCHAIN="${HAX_TOOLCHAIN:-nightly-2025-11-08}" \
  RUSTFLAGS="${RUSTFLAGS:-} -Zcrate-attr=feature(maybe_uninit_slice)" \
  cargo hax into lean ) || echo "WARNING: cargo hax exited non-zero (HAX0001 etc.); the .lean is usually still written — judging from lake build below." >&2
# mersenne-31's qm31.rs hits HAX0001 (#1923, assoc-type equality constraints) on
# the BasedVectorSpace `from_basis_coefficients_*` methods, so hax exits non-zero
# but still writes a usable p3_mersenne_31.lean. Do NOT abort here (see koala note);
# the Lean patch sorries those methods. `set -e` must not kill us on this.
if [ ! -f "$TARGET" ]; then echo "ERROR: hax wrote no $TARGET" >&2; exit 1; fi

# ---- 2. revert source patch (also fires on any earlier exit via trap) -------
if [ -f "$SRC_PATCH" ]; then
    revert
    trap - EXIT
    git -C "$REPO_ROOT" diff --quiet -- "$SRC_REL" \
      && echo "==> source reverted (src/ clean)" \
      || echo "WARNING: $SRC_REL still dirty after revert" >&2
fi

# ---- 3. snapshot pristine ----------------------------------------------------
echo "==> snapshotting pristine output"
mkdir -p "$PATCH_DIR"
cp "$TARGET" "$PRISTINE"

# ---- 4. apply Lean patch -----------------------------------------------------
if [ -f "$PATCH_FILE" ]; then
    echo "==> applying $PATCH_FILE"
    patch "$TARGET" < "$PATCH_FILE"
else
    echo "==> no Lean patch yet; skipping (hand-edit, then run patches/update-patch.sh)" >&2
fi

# ---- 5. lake build (committed manifest pins; no `lake update`) ---------------
# Hax-only manifest (no mathlib/CompPoly), so no `lake exe cache get` here.
echo "==> lake build"
if (cd "$EXTRACT_DIR" && lake build); then
    echo "==> done; build succeeded."
else
    echo "WARNING: lake build failed. The (patched) file is in place; inspect for drift." >&2
fi
