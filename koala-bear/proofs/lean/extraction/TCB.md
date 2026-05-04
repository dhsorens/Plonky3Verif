# The Trusted Codebase

Everything that, if wrong, could compromise the soundness of the koala-bear
verification effort *without* a Lean proof error to flag it. Anything outside
this document is part of the verified side: it is either an extracted
definition under audit, a theorem with a proof, or unreachable code.

The TCB has five layers, from outermost to innermost:

1. The Lean toolchain.
2. The Hax proof library (provided by `cryspen/hax`).
3. Hand-written dependency stubs in `p3_koala_bear/`.
4. The unified-diff patch in `patches/p3_koala_bear.patch`.
5. The hax extractor (`cargo hax into lean`) — the assumption that its
   translation of the Rust source is faithful.

Cumulatively this is roughly **930 lines of hand-written Lean stubs** plus
**~50 hunks of patches** on top of the hax-generated `p3_koala_bear.lean`.
This document is the record of what's in there, why, and how to keep it
auditable.

## 1. The Lean toolchain

- **Pin**: `leanprover/lean4:v4.29.0-rc1` (`lean-toolchain`).
- **Build tool**: `lake`.

The TCB inherits Lean's own kernel, elaboration, and tactic framework. We do
not re-audit Lean.

## 2. The Hax proof library

- **Source**: `https://github.com/cryspen/hax`, subdir
  `hax-lib/proof-libs/lean`.
- **Pin**: commit `492a34e33c8744b9672eb3cf1c982ac40469f7d4`
  (`lake-manifest.json`; `inputRev: main`).

Hax provides the Lean shadows of Rust primitives this extraction relies on:
`RustM`, `RustArray`, `RustSlice`, integer types (`u32`, `i64`, `usize`, …),
`core_models.*` shadows of Rust's `core` and `alloc`, and the `do`-notation
plumbing. Soundness of the extraction rests on Hax modeling Rust faithfully.

## 3. Hand-written dependency stubs

Lives in `proofs/lean/extraction/p3_koala_bear/`. Every Lean file in this
directory was hand-written: hax does not produce them. They exist because
the upstream Plonky3 dependency crates (`p3-field`, `p3-monty-31`,
`p3-poseidon1`, `p3-poseidon2`, `p3-mds`, `p3-symmetric`, `p3-challenger`)
do not yet have working hax extractions of their own, so we declare just
enough of each to type-check `p3_koala_bear.lean`.

`dependencies.lean` simply re-exports the seven stub files. The remaining
files break down as follows.

### `p3_field.lean` (34 lines)

| Symbol | Status | Notes |
|---|---|---|
| `p3_field.field.PrimeCharacteristicRing.AssociatedTypes` | empty class | placeholder |
| `p3_field.field.PrimeCharacteristicRing` | class with `double` method | `double` has no body — required by trait constraints only |
| `p3_field.field.Algebra.AssociatedTypes` | empty class | |
| `p3_field.field.Algebra` | empty class | |
| `p3_field.exponentiation.exp_1420470955` | `def … := pure val` | Stand-in for the cube-root algorithm; the `Impl_5` `RelativelyPrimePower` instance calls this. We trust that the real (cube-root) function is what hax extracts upstream; here we have the wrong body. |

### `p3_monty_31.lean` (705 lines)

This is the largest stub. It also hosts a few **Hax library extensions**
(opaque types/functions added at the top, outside any `p3_monty_31.*`
namespace) that the upstream Hax proof-libs/lean tree does not yet provide:

```lean
namespace core_models.core_arch.arm_shared.neon
opaque uint32x4_t : Type
opaque int32x4_t : Type
end core_models.core_arch.arm_shared.neon

namespace core_models.intrinsics
opaque transmute (A : Type) (B : Type) (a : A) : RustM B
end core_models.intrinsics
```

These three `opaque` declarations are part of the TCB: any reasoning that
manipulates packed NEON SIMD vectors is reasoning over symbols whose
behavior is not specified in Lean.

The substantive content is split across these namespaces:

- **`p3_monty_31.data_traits`**: `MontyParameters`, `BarrettParameters`,
  `RelativelyPrimePower`, `TwoAdicData`, `BinomialExtensionData`,
  `TrinomialQuinticData`, `PackedMontyParameters`, `FieldParameters`.
  These are mostly classes capturing field constants (e.g. `PRIME`,
  `MONTY_BITS`, `MONTY_MU`, `TWO_ADICITY`, the various `ROOTS_*` arrays)
  that the koala-bear instance pins.
- **`p3_monty_31.monty_31`**: `structure MontyField31` (one `value : u32`
  field plus phantom data); `def Impl.new`, `Impl.new_array`,
  `Impl.new_2d_array` — all bodied with `sorry`. Constructors that the
  koala-bear instance uses to build constant arrays of field elements; we
  trust these are well-typed but not their specific results.
- **`p3_monty_31.mds`**: `MDSUtils` class (six `MATRIX_CIRC_MDS_*_COL`
  fields), `MdsMatrixMontyField31` structure, opaque `Default` instance.
- **`p3_monty_31.poseidon1`** and **`p3_monty_31.poseidon2`**:
  `GenericPoseidon1/2LinearLayersMonty31` structures (phantom-only),
  `PartialRoundBaseParameters`, `PartialRoundParameters` (poseidon1),
  `InternalLayerBaseParameters`, `InternalLayerParameters` (poseidon2).
- **`p3_monty_31.aarch64_neon.packing`**: `MontyParametersNeon` class,
  `opaque PackedMontyField31Neon`.
- **`p3_monty_31.aarch64_neon.poseidon1`**: `Poseidon1ExternalLayerMonty31`,
  `Poseidon1InternalLayerMonty31` (phantom-only structures);
  `PartialRoundParametersNeon` empty class.
- **`p3_monty_31.aarch64_neon.poseidon2`**: analogous;
  `InternalLayerParametersNeon` carries an `ArrayLike : Type` member,
  a `diagonal_mul_remainder` method, and `NUM_POS : usize`.
- **`p3_monty_31.aarch64_neon.utils`**: `opaque mul_2exp_neg_n_neon` and
  `opaque mul_2exp_neg_two_adicity_neon`.

The structures with only `_phantom : PhantomData` fields trust that
upstream's actual fields (round constants, packed coefficient tables, etc.)
exist and are well-typed — we don't have those values in Lean, only their
types.

### `p3_mds.lean` (16 lines)

| Symbol | Status |
|---|---|
| `p3_mds.util.first_row_to_first_col` | `def … := pure v` — trusted to be the column-extraction Rust does, but body is a no-op. |

### `p3_poseidon1.lean` (32 lines)

| Symbol | Status |
|---|---|
| `p3_poseidon1.Poseidon1` | structure with two layer fields + phantom |
| `p3_poseidon1.Poseidon1Constants` | structure with `rounds_f`, `rounds_p`, `mds_circ_col`, `round_constants` |
| `p3_poseidon1.Impl_1.new` | `opaque` constructor |

### `p3_poseidon2.lean` (42 lines)

| Symbol | Status |
|---|---|
| `p3_poseidon2.Poseidon2` | structure with two layer fields + phantom |
| `p3_poseidon2.ExternalLayerConstants` | structure with `initial`, `terminal` round-constant vectors |
| `p3_poseidon2.Impl.new` | `opaque` constructor |
| `p3_poseidon2.external.Impl_4.new` | `opaque` ExternalLayerConstants constructor |

### `p3_challenger.lean` (15 lines)

| Symbol | Status |
|---|---|
| `p3_challenger.duplex_challenger.UniformSamplingField` | class with `MAX_SINGLE_SAMPLE_BITS : usize` and `SAMPLING_BITS_M : RustArray u64 64` — concrete, real fields |

### `p3_symmetric.lean` (35 lines)

| Symbol | Status |
|---|---|
| `p3_symmetric.permutation.Permutation` | class with `permute_mut` method (no body) |

## 4. The patch

`proofs/lean/extraction/patches/p3_koala_bear.patch` is a unified diff
applied to the file hax produces. It is regenerable from
`update-patch.sh` and applied automatically by `koala-bear/proofs/lean/extraction/build-proofs.sh`.

Current state: **2185 lines, 48 hunks**. Categories:

### a. Import redirect (1 hunk)

```diff
-import p3_koala_bear.interface
+import p3_koala_bear.dependencies -- PATCHED
```

Hax emits an import of an empty placeholder file; we redirect to our
hand-curated stub aggregator.

### b. KoalaBear abbrev constraints (1 hunk)

```diff
-abbrev KoalaBear :
+abbrev KoalaBear
+  [ p3_monty_31.data_traits.MontyParameters.AssociatedTypes KoalaBearParameters ]
+  [ p3_monty_31.data_traits.MontyParameters KoalaBearParameters ] :
   Type :=
   (p3_monty_31.monty_31.MontyField31 KoalaBearParameters)
```

Hax does not infer that `KoalaBearParameters` must satisfy
`MontyParameters` for `MontyField31` to be applied; we add the constraints
by hand.

### c. `(by rfl)` → `(by sorry) -- PATCHED` (36 hunks)

The `RustM.of_isOk` proof obligation that hax emits as `(by rfl)` cannot
reduce when the value depends on a `sorry`-bodied stub method (e.g.
`Impl.new`, `Impl.new_array`, `first_row_to_first_col`,
`Default.default` on `MdsMatrixMontyField31`). We replace the tactic with
`(by sorry)` and preserve the original next to it for traceability:

```diff
   ROOTS_8 := RustM.of_isOk
     (do (rust_primitives.unsize (← (p3_monty_31.monty_31.Impl.new_array ...))))
-    (by rfl)
+    (by sorry) -- PATCHED
+    -- (by rfl)
```

This admits the constant value (round constants, two-adic generators, MDS
matrix coefficients, etc.) into the trusted base. We trust the *literal
values* hax emits; we do not trust that `(by rfl)` would have proved them
correct because we never run that proof.

### d. Body sorry'ing (6 hunks)

For lambdas whose hax-emitted body uses dependency methods we have only
sorry'd or omitted (`PrimeCharacteristicRing.halve`, `.div_2exp_u64`,
`p3_field.dup.Dup.dup`, `core_models.ops.arith.AddAssign.add_assign`,
etc.), the body is replaced with `sorry`:

| Lambda | Where |
|---|---|
| `mul_w` | `Impl_7` (BinomialExtensionData width 4) |
| `mul_w` | `Impl_8` (BinomialExtensionData width 8) |
| `mds_permute` | `Impl` (PartialRoundBaseParameters width 16) |
| `internal_layer_mat_mul` | `Impl` (InternalLayerBaseParameters width 16) |
| `internal_layer_mat_mul` | `Impl_1` (InternalLayerBaseParameters width 24) |
| `internal_layer_mat_mul` | `Impl_4` (InternalLayerBaseParameters width 32) |

```diff
-      ] (a : A) => do
-    (core_models.ops.arith.Add.add A A
-      (← (p3_field.field.PrimeCharacteristicRing.double A a)) a)
+        ] (a : A) => sorry -- PATCHED
+    -- (do (core_models.ops.arith.Add.add ...))
```

The whole behavior of these six lambdas is trusted. They are linear-layer
matrix multiplications and field operations whose hax-emitted definitions
match the Rust source; we accept that without giving Lean the means to
check it.

### e. Cosmetic / blank-line normalization (~4 hunks)

Stray hunks that adjust doc-comment paragraph separators (lines that
should be `-- ` vs blank). Not load-bearing; they exist only because the
verified-state snapshot was produced through a `sed` pass that mangled
some blank-comment-only lines. Future `update-patch.sh` runs can collapse
these as cleanup.

## 5. The hax extractor

`cargo hax into lean` is invoked by `build-proofs.sh`. We trust:

- That the Rust source (`koala-bear/src/`) is faithfully translated to
  the Lean we then patch.
- That hax's `proof-libs/lean` correctly models Rust semantics for the
  primitives koala-bear uses (integers, slices, `do`/`?`/error
  propagation, panics).

Hax is a research tool; this assumption deserves the most scrutiny. Any
discrepancy here is invisible to Lean's kernel.

## What is **not** in the TCB

- The Rust source of `p3-koala-bear` and its dependency crates. We don't
  trust them — we extract them. Bugs there appear in the extracted Lean.
- The numerical correctness of round constants, two-adic generators,
  MDS coefficients, etc. They live in `p3_koala_bear.lean` itself, not in
  this directory; they are extracted from Rust source (which is trusted)
  and ride along with whatever the hax extraction produces.
- Any theorem or proof in `p3_koala_bear_proofs.lean` or downstream
  files. Those are the verification target.
- The dependency *crates'* own `proofs/lean/extraction/` directories;
  they are read-only references for stub authoring, not loaded into
  this build.

## How the TCB shrinks

Two healthy directions:

1. **Hax improves**: a hunk in `p3_koala_bear.patch` becomes redundant
   because hax now produces the correct form. After running
   `build-proofs.sh`, hand-edit (or simply re-run `update-patch.sh`) so
   the patch shrinks.

2. **Stubs get real**: an `opaque`/`sorry` in `p3_koala_bear/*.lean` is
   replaced by a real Lean definition or extracted upstream crate. Each
   such replacement removes a row from §3 of this document.

The patch length, the stub `wc -l`, and the number of `sorry`/`opaque`
declarations in the stubs are blunt but useful TCB-size proxies. Track
them in PR descriptions when they move.

## Audit checklist

A reviewer checking the TCB should be able to answer:

- [ ] Does `lean-toolchain` match what's pinned (and trusted) here?
- [ ] Does `lake-manifest.json` Hax `rev` match the trusted commit?
- [ ] Is every `sorry`/`opaque` in `p3_koala_bear/*.lean` either listed
      in §3 above or accompanied by a comment explaining why it's safe?
- [ ] Does every hunk in `patches/p3_koala_bear.patch` fit into one of
      the categories in §4? Anything that doesn't is a TCB extension
      that needs documentation here.
- [ ] Does `build-proofs.sh` end with a green `lake build` (no errors,
      only `sorry` warnings)?
- [ ] Has the diff between fresh hax output and the verified file been
      reviewed for unintentional drift?
