#!/usr/bin/env bash
# Extract p3-keccak to Lean through the Rust-source patch in patches/.
# Thin shim over the shared driver. Applies patches/p3_keccak.patch, runs
# `cargo hax into lean`, then reverts keccak/src to pristine. Output lands in
# ../lean/extraction/p3_keccak.lean. See ../../../aeneas-obstructions/hax-extract.sh.
set -eu
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"          # keccak/proofs/rust-patch
REPO="$(cd "$HERE/../../.." && pwd)"                          # repo root
exec "$REPO/aeneas-obstructions/hax-extract.sh" keccak
