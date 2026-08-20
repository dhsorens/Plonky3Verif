#!/usr/bin/env python3
"""Post-extraction reconciliation for the aeneas-backend keccak extraction.

Deterministic transform of the generated P3Keccak/Extraction/Funs.lean (run it
after every `cargo hax into lean`; idempotent). Closes the known
generator↔proof-lib gaps of hax e11615541 / hax-lean v0.3.0:

1. duplicate structure-field names: the generator emits `corecloneCloneInst`
   once per Clone parent-clause; Lean needs distinct names. Rename the 2nd,
   3rd, … occurrence inside each instance literal to `corecloneCloneInst1/2/…`
   (the hand-modeled trait structures in TypesExternal.lean use these names).
2. hash_iter_slices loop cluster: the generator loses the iterator's Item type
   (aeneas `type_var_id` bug) and projects an `iteratorIteratorInst` field that
   hax-lean's IntoIterator does not carry. Thread an explicit
   `Iterator Clause0_IntoIter (Slice U8)` instance through body/loop/caller.
3. closure Fn* encodings: the generator emits aeneas's backward-function shape
   for call_mut/call_once; hax-lean's CoreModels FnMut/FnOnce use
   state-threading (`Result (Out × Self)` / `Result Out`). Rewrite both.
"""
import re, sys, pathlib

p = pathlib.Path(__file__).resolve().parents[1] / "P3Keccak/Extraction/Funs.lean"
src = p.read_text()
orig = src

# ---- 1. duplicate corecloneCloneInst fields in instance literals ------------
def fix_dup_fields(text):
    out, pos = [], 0
    for m in re.finditer(r":= \{", text):
        start = m.end()
        # find the matching closing brace at column 0 ('\n}')
        end = text.find("\n}", start)
        if end == -1:
            continue
        block = text[start:end]
        occ = list(re.finditer(r"corecloneCloneInst :=", block))
        if len(occ) > 1:
            newblock, delta = block, 0
            for i, om in enumerate(occ[1:], start=1):
                s = om.start() + delta
                repl = f"corecloneCloneInst{i} :="
                newblock = newblock[:s] + repl + newblock[s + len("corecloneCloneInst :="):]
                delta += len(repl) - len("corecloneCloneInst :=")
            out.append((start, end, newblock))
    for start, end, newblock in reversed(out):
        text = text[:start] + newblock + text[end:]
    return text

src = fix_dup_fields(src)

# ---- 2. hash_iter_slices loop cluster ---------------------------------------
bad_param = """  (coreitertraitscollectIntoIteratorPSharedSliceU8Clause0_IntoIterInst :
  core.iter.traits.collect.IntoIterator
  sorry /- Could not find: type_var_id: 0 from ExtractBase.Item-/ (Slice
  Std.U8) Clause0_IntoIter) (iter : Clause0_IntoIter)"""
good_param = """  (iterIteratorInst :
  core.iter.traits.iterator.Iterator Clause0_IntoIter (Slice Std.U8))
  (iter : Clause0_IntoIter)"""
src = src.replace(bad_param, good_param)

src = src.replace("""  let (o, iter1) ←
    coreitertraitscollectIntoIteratorPSharedSliceU8Clause0_IntoIterInst.iteratorIteratorInst.next
      iter""",
"""  let (o, iter1) ← iterIteratorInst.next iter""")

src = src.replace("""      Keccak256Hash.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices_loop.body
      coreitertraitscollectIntoIteratorPSharedSliceU8Clause0_IntoIterInst iter1
      hasher1""",
"""      Keccak256Hash.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices_loop.body
      iterIteratorInst iter1 hasher1""")

src = src.replace("""  (coreitertraitscollectIntoIteratorISharedASliceU8Clause0_IntoIterInst :
  core.iter.traits.collect.IntoIterator I (Slice Std.U8) Clause0_IntoIter)
  (self : Keccak256Hash) (input : I) :""",
"""  (coreitertraitscollectIntoIteratorISharedASliceU8Clause0_IntoIterInst :
  core.iter.traits.collect.IntoIterator I (Slice Std.U8) Clause0_IntoIter)
  (iterIteratorInst :
  core.iter.traits.iterator.Iterator Clause0_IntoIter (Slice Std.U8))
  (self : Keccak256Hash) (input : I) :""")

src = src.replace("""    Keccak256Hash.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices_loop
      coreitertraitscollectIntoIteratorISharedASliceU8Clause0_IntoIterInst iter
      hasher""",
"""    Keccak256Hash.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices_loop
      iterIteratorInst iter hasher""")

# the hasher instance literal: pass the extra Iterator instance through
src = src.replace("""  hash_iter_slices := fun {I : Type} {Clause0_IntoIter : Type}
    (coreitertraitscollectIntoIteratorPSharedSliceU8PInst :
    core.iter.traits.collect.IntoIterator I (Slice Std.U8) Clause0_IntoIter) =>
    Keccak256Hash.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices
    coreitertraitscollectIntoIteratorPSharedSliceU8PInst""",
"""  hash_iter_slices := fun {I : Type} {Clause0_IntoIter : Type}
    (coreitertraitscollectIntoIteratorPSharedSliceU8PInst :
    core.iter.traits.collect.IntoIterator I (Slice Std.U8) Clause0_IntoIter)
    (iterIteratorInst :
    core.iter.traits.iterator.Iterator Clause0_IntoIter (Slice Std.U8)) =>
    Keccak256Hash.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices
    coreitertraitscollectIntoIteratorPSharedSliceU8PInst iterIteratorInst""")

# ---- 3. closure Fn* encodings ------------------------------------------------
src = src.replace("""  Result ((CryptographicHasherKeccak256HashU8ArrayU832.hash_iter.closure I
    Clause0_IntoIter) ×
    (CryptographicHasherKeccak256HashU8ArrayU832.hash_iter.closure I
    Clause0_IntoIter →
    CryptographicHasherKeccak256HashU8ArrayU832.hash_iter.closure I
    Clause0_IntoIter))
  := do
  let k ←
    tiny_keccak.keccak.Keccak.Insts.Tiny_keccakHasher.update c tupled_args
  let back := fun c1 => c1
  ok (k, back)""",
"""  Result (Unit × (CryptographicHasherKeccak256HashU8ArrayU832.hash_iter.closure
    I Clause0_IntoIter))
  := do
  let k ←
    tiny_keccak.keccak.Keccak.Insts.Tiny_keccakHasher.update c tupled_args
  ok ((), k)""")

src = src.replace("""  Result (CryptographicHasherKeccak256HashU8ArrayU832.hash_iter.closure I
    Clause0_IntoIter)
  := do
  let (c1, call_mut_back) ←
    CryptographicHasherKeccak256HashU8ArrayU832.hash_iter.closure.Insts.CoreOpsFunctionFnMutTupleSharedSliceU8Tuple.call_mut
      coreitertraitscollectIntoIteratorIU8Clause0_IntoIterInst c s
  ok (call_mut_back c1)""",
"""  Result Unit
  := do
  let _ ←
    CryptographicHasherKeccak256HashU8ArrayU832.hash_iter.closure.Insts.CoreOpsFunctionFnMutTupleSharedSliceU8Tuple.call_mut
      coreitertraitscollectIntoIteratorIU8Clause0_IntoIterInst c s
  ok ()""")

p.write_text(src)
print("reconcile: changed" if src != orig else "reconcile: no-op (already applied?)")
