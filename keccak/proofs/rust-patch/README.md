# Keccak — Rust-source patch for hax extraction

**What this is.** A behaviour-preserving rewrite of a small amount of
`keccak/src/` Rust into the subset that `cargo hax into lean` can translate
without emitting `sorry`. It mirrors [`koala-bear`](../../../koala-bear/proofs/lean/extraction/)’s
patch workflow, but patches the **Rust source** instead of the **Lean output**.

The committed Rust is *never* changed. The rewrite lives only in
[`patches/p3_keccak.patch`](patches/) and is applied for the duration of one
extraction, then reverted.

## Usage

```bash
# From anywhere — applies the patch, extracts, reverts keccak/src:
keccak/proofs/rust-patch/extract.sh
# (equivalently: aeneas-obstructions/hax-extract.sh keccak)
```

Output: `keccak/proofs/lean/extraction/p3_keccak.lean`. The driver refuses to run
if `keccak/src` has uncommitted changes, and reverts the source on any exit
(including Ctrl-C). To change the rewrite, edit the source and re-capture the
patch with [`update-patch.sh`](update-patch.sh).

## What the patch changes, and why it's behaviour-preserving

| Site | Before | After | Class |
|------|--------|-------|-------|
| `Keccak256Hash::hash_iter` (`src/lib.rs`) | `p3_util::apply_to_chunks::<512,_,_>(input, \|buf\| hasher.update(buf))` | `for byte in input { hasher.update(&[byte]); }` | A (pure rewrite) |

**Why hax choked on the original:** `apply_to_chunks` takes a **closure with a
mutable capture** of `hasher` (`H: FnMut(&[u8])`). hax's Lean backend does not
model mutable-capture closures, so the whole `hash_iter` body became
`(pure sorry)`.

**Why the rewrite is equivalent:** `apply_to_chunks` only *buffers* the input
byte stream into 512-byte chunks and calls `hasher.update(chunk)` on each
(see `util/src/lib.rs`). Keccak's sponge `update` is incremental —
`update(a); update(b)` is identical to `update(a ++ b)` — so feeding the bytes
one at a time produces the **same digest**. The only thing dropped is the
buffering *performance* optimisation, which is irrelevant here: the patched
source is compiled only during extraction and then reverted, never shipped.

**Why hax accepts the rewrite:** it is the exact `for x in input { hasher.update(x) }`
shape that the sibling method `hash_iter_slices` already uses — and that method
always extracted cleanly. hax lowers the loop to an `Iterator.fold` threading the
`hasher` state through its `RustM` monad. Result: **`hash_iter` extracts with 0
`sorry`** (the crate goes from 1 → 0).

## Trust (TCB) impact

**None.** This is a Class-A patch: a straight behaviour-preserving source
rewrite, no `#[hax_lib::opaque]`, no new dependencies. Nothing is moved into the
trusted base — the body is still fully extracted and translated. (Class-B
patches in other crates, which mark a body `#[hax_lib::opaque]`, *do* add that
body to the TCB; those are flagged explicitly in their own READMEs.)

## Keeping in sync

If `keccak/src/lib.rs` drifts upstream and the patch no longer applies,
`extract.sh` aborts with a "patch did not apply" message. Re-create the rewrite
on the new source and run `update-patch.sh` to regenerate the patch. A shrinking
or vanishing patch means hax improved and the rewrite is no longer needed.
