# The Trusted Codebase

Everything that, if wrong, could compromise the soundness of the koala-bear
verification effort *without* a Lean proof error to flag it. Anything outside
this document is part of the verified side: it is either an extracted
definition under audit, a theorem with a proof, or unreachable code.

KoalaBear *is* `MontyField31<KoalaBearParameters>`, so this extraction now
**`require`s the extracted [monty-31](../../../../monty-31/proofs/lean/extraction/)
Lean package** (Lake path dep) instead of re-stubbing it. Everything in
[monty-31's TCB](../../../../monty-31/proofs/lean/extraction/TCB.md) — its
`MontyField31`/`data_traits`/MDS/Poseidon extraction, its stubbed lower deps
(`p3_field`, `p3_mds`, `p3_poseidon{1,2}`, `p3_symmetric`, `p3_challenger`,
core/num/rand/serde shims), and its sorries — is therefore part of this TCB.
koala-bear layers the KoalaBear-specific instances + the CompPoly proofs on top.

The TCB has these layers, from outermost to innermost:

1. The Lean toolchain.
2. The Hax proof library (provided by `cryspen/hax`).
3. **The monty-31 dependency** (and its whole TCB).
4. Supplementary stubs in `p3_koala_bear/field_ext.lean` (koala-specific).
5. The unified-diff patch in `patches/p3_koala_bear.patch`.
6. The hax extractor (`cargo hax into lean`) — the assumption that its
   translation of the (source-patched) Rust source is faithful.

The `p3_koala_bear_proofs/` theorems are **proved** (no `sorry`) against
CompPoly; they are the verification target, not part of the TCB.

Snapshot: `p3_koala_bear.lean` ≈ **3362 lines, 46 `sorry`**. Rust source patch
38 lines; Lean patch ≈ 1229 lines. Toolchain `v4.30.0-rc2`; Hax pinned
`c1a93f0f`.

## 1. The Lean toolchain

- **Pin**: tracked in `proofs/lean/extraction/lean-toolchain`. The specific
  tag is not part of the TCB — we trust Lean as a system, not a particular
  release — but the file must point at an official `leanprover/lean4`
  release. Version-management procedure lives in `SYNC.md`.
- **Build tool**: `lake`.

The TCB inherits Lean's own kernel, elaboration, and tactic framework. We do
not re-audit Lean.

## 2. The Hax proof library

- **Source**: `https://github.com/cryspen/hax`, subdir
  `hax-lib/proof-libs/lean`.
- **Pin**: commit `c1a93f0f1d770d37d282737ff485937171d6a0ef`
  (`lake-manifest.json`). This **must match** the rev monty-31 and the shared
  `.lake/packages` build use; floating to `main` rebuilds a divergent Hax that
  breaks the monty-31 dependency (e.g. `Ord u32` synthesis). Trusted to match
  the shared build.

Hax provides the Lean shadows of Rust primitives this extraction relies on:
`RustM`, `RustArray`, `RustSlice`, integer types (`u32`, `i64`, `usize`, …),
`core_models.*` shadows of Rust's `core` and `alloc`, and the `do`-notation
plumbing. Soundness of the extraction rests on Hax modeling Rust faithfully.

## 3. The monty-31 dependency

`lakefile.toml` `require`s `p3_monty_31` (Lake path
`../../../../monty-31/proofs/lean/extraction`); `lake-manifest.json` carries
the matching `{"type":"path", …}` entry. This package — **not** local stubs —
now supplies `MontyField31`, all of `data_traits.*`, the MDS structs, the
Poseidon layer parameter types, **and the shared lower-dep stubs** (`p3_field`,
`p3_mds`, `p3_poseidon{1,2}`, `p3_symmetric`, `p3_challenger`, core/num/rand/
serde shims).

The former *local* koala stubs (`p3_koala_bear/{p3_monty_31, p3_field, p3_mds,
p3_poseidon1, p3_poseidon2, p3_symmetric, p3_challenger}.lean`, ~930 lines) are
**deleted**. The trusted content they held now lives in (and is documented by)
[monty-31's TCB](../../../../monty-31/proofs/lean/extraction/TCB.md) — including
the NEON `opaque` shadows and `core_models.intrinsics.transmute`. Wiring
baby-bear/koala-bear required **additively enriching** monty-31's shared stubs
(p3_field PCR `double`/`halve`/`div_2exp_u64` defaults; `Permutation.permute_mut`;
`p3_mds.util.first_row_to_first_col`; the Poseidon1/2 `Impl.new` constructors +
structs + generic-layer types); those additions are recorded in monty-31's TCB.

## 4. Supplementary stubs (`p3_koala_bear/field_ext.lean`)

The only stubs still local to koala-bear — koala-specific, not provided by
monty-31's field-agnostic shared layer. Hand-written, trusted (not extracted):

| Symbol | Status |
|---|---|
| `p3_field.exponentiation.exp_1420470955` | `opaque` — KoalaBear's per-field exponentiation (cube-root) helper, called by the `RelativelyPrimePower` instance. Monty-31's shared `p3_field` stub is field-agnostic and omits it. We trust the real (cube-root) function is what hax extracts upstream; here the body is opaque. |
| blanket `AsRef (RustArray T N) (RustSlice T)` | value `sorry` — satisfies monty-31's `BinomialExtensionData.ArrayLike` bound (`AsRef ArrayLike (RustSlice …)`), which fires only when a concrete field instantiates the class. monty-31 has the class but no concrete instance, so this lives with the consumer. |

`p3_koala_bear/dependencies.lean` simply `import p3_monty_31` +
`import p3_koala_bear.field_ext`.

## 5. The patch (`patches/p3_koala_bear.patch`)

A unified diff applied to the file hax produces, regenerable from
`update-patch.sh` and applied automatically by `build-proofs.sh`. Categories:

### a. Import redirect
Hax emits an import of an empty placeholder; we redirect to
`p3_koala_bear.dependencies` (the monty-31 import + field_ext aggregator).

### b. `(by rfl)` → `(by sorry) -- PATCHED` (35 sites)
The `RustM.of_isOk` obligation hax emits as `(by rfl)` cannot reduce when the
value depends on a `sorry`/opaque-bodied monty-31 stub method (`Impl.new`,
`Impl.new_array`, `first_row_to_first_col`, `MdsMatrixMontyField31.Default`,
`transmute`, …). We `(by sorry)` it and keep the original beside it. This
admits the literal constant values (round constants, two-adic generators, MDS
coefficients) into the trusted base; we trust the values hax emits, not that
`(by rfl)` would have proved them (we never run that proof).

### c. Generic-algebra-bound method bodies sorried
Instance/default methods bound by `[Algebra A F]` / `[PrimeCharacteristicRing R]`
that call `Dup`/`Add`/`Sub`/`PCR.*` on the generic parameter (which the stub
bound does not carry) — e.g. the Poseidon `GenericPoseidon{1,2}LinearLayers`
linear-layer multiplications and `BinomialExtensionData.mul_w` for the
extension widths. Their bodies are replaced with `sorry`. The whole behavior of
these lambdas is trusted; their hax-emitted definitions match the Rust source
and we accept them without giving Lean the means to check.

### d. Unused `WIDTH`-generic poseidon layer-alias abbrevs
`Poseidon{1,2}…LayerKoalaBear` are generic over `WIDTH`, but the base-params
instances exist only at the concrete WIDTH, so their bodies can't elaborate
generically — replaced with `:= sorry`. They are unused type aliases.

### e. One reorder (not a `sorry`)
The `KoalaBearParameters` cluster / `MontyParameters.AssociatedTypes` instance
is placed before `abbrev KoalaBear` (which needs
`MontyParameters.AssociatedTypes KoalaBearParameters` to form
`MontyField31 KoalaBearParameters`).

## 6. The hax extractor

`cargo hax into lean` is invoked by `build-proofs.sh`. We trust:

- That the **source-patched** Rust (`koala-bear/src/`, with SIMD modules gated
  off under `--cfg hax` — see §7) is faithfully translated to the Lean we patch.
- That hax's `proof-libs/lean` correctly models Rust semantics for the
  primitives koala-bear uses (integers, slices, `do`/`?`/error propagation,
  panics).

Hax is a research tool; this assumption deserves the most scrutiny. Any
discrepancy here is invisible to Lean's kernel.

`build-proofs.sh` runs the hax invocation with
`-Zcrate-attr=feature(maybe_uninit_slice)` (and pins `RUSTUP_TOOLCHAIN` to
hax's nightly); not load-bearing for soundness (a stdlib feature shim for the
older nightly). It also applies **both** koala-bear's and monty-31's Rust
source patches before extraction — see §7.

## 7. Pre-extraction Rust source patch (`../rust-patch/`)

`p3_koala_bear.src.patch` gates koala-bear's SIMD modules off under `--cfg hax`;
`build-proofs.sh` **also** applies monty-31's source patch, because `cargo hax`
sets `--cfg hax` only on the primary crate, so the monty-31 dependency would
otherwise compile with SIMD and fail. **Class A** (behaviour-preserving): the
extracted field semantics are the **portable** path, not the SIMD packings
(which are not extracted/verified). After extraction both patches are reverted;
`git status --porcelain koala-bear/src monty-31/src` must be clean.

## What is **not** in the TCB

- A normal `cargo build` of `p3-koala-bear` (the source patch is reverted after
  extraction). The SIMD packings are dropped, not verified.
- The Rust source of `p3-koala-bear` and its dependency crates. We don't
  trust them — we extract them. Bugs there appear in the extracted Lean.
- The numerical correctness of round constants, two-adic generators, MDS
  coefficients, etc. They live in `p3_koala_bear.lean` and ride along with
  whatever the hax extraction produces.
- Any theorem or proof in `p3_koala_bear_proofs/`. Those are **proved** against
  CompPoly (no `sorry`) — the verification target. (CompPoly itself is a pinned
  dependency the proofs trust.)
- `lake`/build tooling beyond the Lean kernel.

## How the TCB shrinks

1. **Hax improves**: a hunk in the patch becomes redundant because hax now
   produces the correct form. After `build-proofs.sh`, re-run `update-patch.sh`
   so the patch shrinks.
2. **Stubs get real**: an `opaque`/`sorry` in monty-31's shared stubs or in
   `p3_koala_bear/field_ext.lean` is replaced by a real definition or an
   extracted upstream crate. Each such replacement removes a row here or in
   monty-31's TCB.

Patch length, the `field_ext.lean` `wc -l`, and the `sorry` count in
`p3_koala_bear.lean` are blunt but useful TCB-size proxies. Track them in PR
descriptions when they move.

## Audit checklist

- [ ] Is `lean-toolchain` an official `leanprover/lean4` release tag?
- [ ] Does `lake-manifest.json` pin Hax to `c1a93f0f` — the shared rev monty-31
      uses? (No `lake update` in `build-proofs.sh`.)
- [ ] Does the `p3_monty_31` path require resolve, and are there **no**
      `p3_monty_31.aarch64_neon` references in `p3_koala_bear.lean`?
- [ ] Is every `sorry`/`opaque` in `p3_koala_bear/field_ext.lean` listed in §4?
- [ ] Does every hunk in `patches/p3_koala_bear.patch` fit a §5 category?
- [ ] Does `build-proofs.sh` end green (no errors, only `sorry` warnings, no
      `.rej`), with `git status --porcelain koala-bear/src monty-31/src` empty?
- [ ] Does `p3_koala_bear_proofs` still build (no new `sorry`s in proofs)?
- [ ] Do the counts in the snapshot line match `wc -l` / `grep -c`?
