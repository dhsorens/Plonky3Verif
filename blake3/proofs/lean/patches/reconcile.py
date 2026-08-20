#!/usr/bin/env python3
"""Post-extraction reconciliation for the aeneas-backend blake3 extraction.

Deterministic, idempotent transform of the generated
P3Blake3/Extraction/Funs.lean; run after every `cargo hax into lean`. Closes
the same generator<->hax-lean-v0.3.0 gaps as keccak's reconcile.py (see its
docstring): duplicate Clone parent-clause field names, the hash_iter_slices
loop cluster (lost Item type + phantom `iteratorIteratorInst` projection), and
the closure FnMut/FnOnce encoding mismatch.
"""
import re, pathlib

p = pathlib.Path(__file__).resolve().parents[1] / "P3Blake3/Extraction/Funs.lean"
src = p.read_text()
orig = src

# ---- 1. duplicate corecloneCloneInst fields in instance literals ------------
def fix_dup_fields(text):
    out = []
    for m in re.finditer(r":= \{", text):
        start = m.end()
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
  Std.U8) Clause0_IntoIter) (iter : Clause0_IntoIter) (hasher : blake3.Hasher)"""
good_param = """  (iterIteratorInst :
  core.iter.traits.iterator.Iterator Clause0_IntoIter (Slice Std.U8))
  (iter : Clause0_IntoIter) (hasher : blake3.Hasher)"""
src = src.replace(bad_param, good_param)

src = src.replace("""  let (o, iter1) ←
    coreitertraitscollectIntoIteratorPSharedSliceU8Clause0_IntoIterInst.iteratorIteratorInst.next
      iter""",
"""  let (o, iter1) ← iterIteratorInst.next iter""")

src = src.replace("""      Blake3.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices_loop.body
      coreitertraitscollectIntoIteratorPSharedSliceU8Clause0_IntoIterInst iter1
      hasher1""",
"""      Blake3.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices_loop.body
      iterIteratorInst iter1 hasher1""")

src = src.replace("""  (coreitertraitscollectIntoIteratorISharedASliceU8Clause0_IntoIterInst :
  core.iter.traits.collect.IntoIterator I (Slice Std.U8) Clause0_IntoIter)
  (self : Blake3) (input : I) :""",
"""  (coreitertraitscollectIntoIteratorISharedASliceU8Clause0_IntoIterInst :
  core.iter.traits.collect.IntoIterator I (Slice Std.U8) Clause0_IntoIter)
  (iterIteratorInst :
  core.iter.traits.iterator.Iterator Clause0_IntoIter (Slice Std.U8))
  (self : Blake3) (input : I) :""")

src = src.replace("""    Blake3.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices_loop
      coreitertraitscollectIntoIteratorISharedASliceU8Clause0_IntoIterInst iter
      hasher""",
"""    Blake3.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices_loop
      iterIteratorInst iter hasher""")

src = src.replace("""  hash_iter_slices := fun {I : Type} {Clause0_IntoIter : Type}
    (coreitertraitscollectIntoIteratorPSharedSliceU8PInst :
    core.iter.traits.collect.IntoIterator I (Slice Std.U8) Clause0_IntoIter) =>
    Blake3.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices
    coreitertraitscollectIntoIteratorPSharedSliceU8PInst""",
"""  hash_iter_slices := fun {I : Type} {Clause0_IntoIter : Type}
    (coreitertraitscollectIntoIteratorPSharedSliceU8PInst :
    core.iter.traits.collect.IntoIterator I (Slice Std.U8) Clause0_IntoIter)
    (iterIteratorInst :
    core.iter.traits.iterator.Iterator Clause0_IntoIter (Slice Std.U8)) =>
    Blake3.Insts.P3_symmetricHasherCryptographicHasherU8ArrayU832.hash_iter_slices
    coreitertraitscollectIntoIteratorPSharedSliceU8PInst iterIteratorInst""")

# ---- 3. closure Fn* encodings ------------------------------------------------
src = src.replace("""  Result ((CryptographicHasherBlake3U8ArrayU832.hash_iter.closure I
    Clause0_IntoIter) ×
    (CryptographicHasherBlake3U8ArrayU832.hash_iter.closure I Clause0_IntoIter
    → CryptographicHasherBlake3U8ArrayU832.hash_iter.closure I
    Clause0_IntoIter))
  := do
  let (h, update_back) ← blake3.Hasher.update c tupled_args
  let h1 := update_back h
  let back := fun c1 => c1
  ok (h1, back)""",
"""  Result (Unit × (CryptographicHasherBlake3U8ArrayU832.hash_iter.closure
    I Clause0_IntoIter))
  := do
  let (h, update_back) ← blake3.Hasher.update c tupled_args
  let h1 := update_back h
  ok ((), h1)""")

src = src.replace("""  Result (CryptographicHasherBlake3U8ArrayU832.hash_iter.closure I
    Clause0_IntoIter)
  := do
  let (c1, call_mut_back) ←
    CryptographicHasherBlake3U8ArrayU832.hash_iter.closure.Insts.CoreOpsFunctionFnMutTupleSharedSliceU8Tuple.call_mut
      coreitertraitscollectIntoIteratorIU8Clause0_IntoIterInst c s
  ok (call_mut_back c1)""",
"""  Result Unit
  := do
  let _ ←
    CryptographicHasherBlake3U8ArrayU832.hash_iter.closure.Insts.CoreOpsFunctionFnMutTupleSharedSliceU8Tuple.call_mut
      coreitertraitscollectIntoIteratorIU8Clause0_IntoIterInst c s
  ok ()""")

p.write_text(src)
print("reconcile: changed" if src != orig else "reconcile: no-op (already applied?)")
