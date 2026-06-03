#!/usr/bin/env bash
#
# run-extract.sh — attempt an Aeneas/Charon extraction of one Plonky3 crate.
#
# Part of the AENEAS.md survey workflow. Output is written ONLY to
# /tmp/aeneas-extract/<crate>/ — never inside the repo — so extracted code is
# never accidentally committed. Commit only aeneas-obstructions/ reports.
#
# Usage (from the repo root):
#     aeneas-obstructions/run-extract.sh <crate-dirname>
#
# e.g.  aeneas-obstructions/run-extract.sh util
#       aeneas-obstructions/run-extract.sh koala-bear
#
# The crate dir is the directory name in the workspace (util, field, koala-bear,
# …); the cargo package name (p3_util, p3_field, …) is derived from it.
#
# Each invocation uses an ISOLATED CARGO_TARGET_DIR so a previously-built,
# cached p3-field cannot mask the charon panic that only fires on a clean
# compile of p3-field (see AENEAS.md / the dated reports, "Issue: charon panics
# on p3-field").
#
# Exit code is the worst of (charon, aeneas); a nonzero code still leaves
# whatever partial output was produced in place for inspection.

set -u -o pipefail

crate="${1:-}"
if [[ -z "$crate" ]]; then
  echo "usage: $0 <crate-dirname>   (e.g. util, field, koala-bear)" >&2
  exit 2
fi

# Repo root = parent of the dir holding this script.
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
crate_dir="$repo_root/$crate"

if [[ ! -f "$crate_dir/Cargo.toml" ]]; then
  echo "error: no Cargo.toml at $crate_dir — is '$crate' a crate dir?" >&2
  exit 2
fi

# cargo package name: p3_<crate-with-dashes-as-underscores>. Used for the
# .llbc filename only; charon picks the actual package from the crate dir.
pkg="p3_$(echo "$crate" | tr '-' '_')"

out="/tmp/aeneas-extract/$crate"
target="/tmp/aeneas-extract/target-$crate"   # isolated, per-crate clean build
rm -rf "$out"
mkdir -p "$out/lean"

echo "==> crate dir : $crate_dir"
echo "==> output    : $out"
echo "==> target    : $target  (isolated, forces clean p3-field compile)"

# ---- charon -----------------------------------------------------------------
# --preset aeneas is REQUIRED: it turns on the deduplicated serialization the
# OCaml side expects. Without it aeneas dies with
#   "Hash-consing key not found; serialization mismatch between Rust and OCaml".
echo "==> charon ..."
charon_rc=0
(
  cd "$crate_dir" || exit 3
  CARGO_TARGET_DIR="$target" charon cargo --preset aeneas \
    --dest-file "$out/$pkg.llbc"
) >"$out/charon.log" 2>&1 || charon_rc=$?
echo "    charon exit: $charon_rc  (log: $out/charon.log)"

# ---- aeneas -----------------------------------------------------------------
aeneas_rc=0
if [[ -f "$out/$pkg.llbc" ]]; then
  echo "==> aeneas ..."
  aeneas "$out/$pkg.llbc" -backend lean \
    -dest "$out/lean" -split-files -lean-default-lakefile \
    >"$out/aeneas.log" 2>&1 || aeneas_rc=$?
  # ANSI-stripped copy for easy grepping / error counting.
  sed -E 's/\x1b\[[0-9;]*m//g' "$out/aeneas.log" >"$out/aeneas.log.clean"
  echo "    aeneas exit: $aeneas_rc  (log: $out/aeneas.log.clean)"
else
  echo "==> aeneas: SKIPPED — charon produced no $pkg.llbc (charon failed)."
  aeneas_rc=10
fi

# ---- quick tallies ----------------------------------------------------------
errs=0; warns=0; lines=0; files=0
if [[ -f "$out/aeneas.log.clean" ]]; then
  errs=$(grep -c '\[Error\]'  "$out/aeneas.log.clean" || true)
  warns=$(grep -c '\[Warn \]' "$out/aeneas.log.clean" || true)
fi
if [[ -d "$out/lean" ]]; then
  files=$(find "$out/lean" -name '*.lean' | wc -l | tr -d ' ')
  lines=$(find "$out/lean" -name '*.lean' -exec cat {} + 2>/dev/null | wc -l | tr -d ' ')
fi

echo
echo "==> SUMMARY [$crate]"
echo "    charon exit : $charon_rc"
echo "    aeneas exit : $aeneas_rc"
echo "    aeneas errs : $errs"
echo "    aeneas warns: $warns"
echo "    lean files  : $files"
echo "    lean lines  : $lines"
echo "    output dir  : $out"

# Worst-of exit code.
if [[ "$charon_rc" -ne 0 ]]; then exit "$charon_rc"; fi
exit "$aeneas_rc"
