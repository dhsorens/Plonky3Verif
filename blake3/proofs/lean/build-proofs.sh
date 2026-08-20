#!/usr/bin/env bash
# Regenerate the blake3 Lean extraction via hax's aeneas-based `lean` backend.
#
# Pipeline (hax e11615541+: `cargo hax into lean` = charon -> .llbc -> aeneas):
#   0. clean-tree guard; trap-revert; apply the pre-extraction Rust source
#      patches (the p3-field / p3-symmetric hax gates that
#      remove the charon-mistranslated RawDataSerializable stream methods).
#      NOTE: the gates fire on `--cfg hax`, which `cargo hax` does NOT set for
#      dependency crates — so we set it globally via RUSTFLAGS.
#   1. `cargo hax into lean` in an isolated CARGO_TARGET_DIR. Writes
#      P3Blake3/Extraction/{Types,Funs,*_Template}.lean + llbc/ (gitignored).
#      aeneas reports 2 errors (derive(Debug) `Unreachable` + a `type_var_id` in the slices loop, both reconciled) and
#      exits non-zero; the output is still complete — the Debug fmts are
#      axiomatized in FunsExternal.lean.
#   2. revert the source patches (trap).
#   3. snapshot the pristine generated Funs.lean, then run
#      patches/reconcile.py (deterministic transform closing the known
#      generator<->hax-lean-v0.3.0 gaps; see its docstring).
#   4. `lake build` — must end green (no sorries; externals are axioms, see
#      TCB.md).
#
# Hand-maintained files (NEVER regenerated; edit them directly):
#   lakefile.toml lean-toolchain P3Blake3.lean
#   P3Blake3/Extraction/TypesExternal.lean P3Blake3/Extraction/FunsExternal.lean

set -eu
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"    # …/proofs/lean
CRATE_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"                 # blake3/
REPO_ROOT="$(cd "$CRATE_ROOT/.." && pwd)"

SRC_PATCHES=(
  "field/proofs/rust-patch/patches/p3_field.src.patch"
  "symmetric/proofs/rust-patch/patches/p3_symmetric.src.patch"
)
REVERT_PATHS=(field/src symmetric/src)

# ---- 0. source patches: clean-tree guard + guaranteed revert + apply --------
for p in "${REVERT_PATHS[@]}"; do
    if ! git -C "$REPO_ROOT" diff --quiet -- "$p" \
       || ! git -C "$REPO_ROOT" diff --cached --quiet -- "$p"; then
        echo "error: $p has uncommitted changes; aborting so we never overwrite" >&2
        echo "       your work. Commit/stash first, then re-run." >&2
        exit 1
    fi
done
revert() { git -C "$REPO_ROOT" checkout -- "${REVERT_PATHS[@]}" 2>/dev/null || true; }
trap revert EXIT
for p in "${SRC_PATCHES[@]}"; do
    echo "==> applying $p"
    git -C "$REPO_ROOT" apply "$REPO_ROOT/$p"
done

# ---- 1. extract ---------------------------------------------------------------
echo "==> cargo hax into lean   (aeneas backend)"
isolated="${HAX_ISOLATED_TARGET:-/tmp/hax-extract/target-blake3-aeneas}"
rm -rf "$isolated"
( cd "$CRATE_ROOT" && \
  CARGO_TARGET_DIR="$isolated" \
  RUSTUP_TOOLCHAIN="${HAX_TOOLCHAIN:-nightly-2025-11-08}" \
  RUSTFLAGS="${RUSTFLAGS:-} --cfg hax --check-cfg cfg(hax) -Zcrate-attr=feature(maybe_uninit_slice)" \
  cargo hax into lean ) \
  || echo "WARNING: cargo hax exited non-zero (expected: 2 aeneas errors, reconciled below); judging from lake build below." >&2

# ---- 2. revert source patches -------------------------------------------------
revert; trap - EXIT
echo "==> source patches reverted"

# ---- 3. snapshot + reconcile ----------------------------------------------------
cp "$SCRIPT_DIR/P3Blake3/Extraction/Funs.lean" "$SCRIPT_DIR/patches/Funs.pristine.lean"
python3 "$SCRIPT_DIR/patches/reconcile.py"

# ---- 4. lake build --------------------------------------------------------------
echo "==> lake build"
if (cd "$SCRIPT_DIR" && lake build); then
    echo "==> done; build succeeded."
else
    echo "WARNING: lake build failed — inspect for generator drift (compare" >&2
    echo "         patches/Funs.pristine.lean against the last committed one)." >&2
    exit 1
fi
