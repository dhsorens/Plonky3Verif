# Hax extraction obstructions

A snapshot of how well **hax** (`cargo hax into lean`) extracts the Plonky3
workspace crates in this repo, and what blocks it. This is the **hax** workflow
(the one that drives `*/proofs/lean/extraction/`), which is *separate* from the
Aeneas/Charon survey that produces the dated reports in this directory — see
[`README.md`](README.md). The reference extraction is
[`koala-bear/proofs/lean/extraction/`](../koala-bear/proofs/lean/extraction/);
this document covers the *other* 39 workspace crates.

| | |
| --- | --- |
| **Date** | 2026-06-25 (baseline) · **updated 2026-08-18** (see the dated section below) |
| **hax** | `untagged-git-rev-ad110bfa7a` (commit `ad110bfa`, hax repo HEAD 2026-05-07) |
| **OCaml engine** | `~/.opam/default/bin/hax-engine` (built 2026-05-20) |
| **rustc** | `nightly-2025-11-08` (hax's pinned driver toolchain) |
| **Crates surveyed** | all 40 workspace members |

---

## 2026-08-18 update — progress re-survey (13-crate sample, two backends)

A progress test against the 2026-06-25 baseline: hax updated `ad110bfa`
(2026-05-07) → `e11615541` (2026-08-18 HEAD, **387 commits**), surveyed on the
13-crate aeneas-survey sample, then **reverted to `ad110bfa`** (see the install
gate at the end). Headline: **the biggest movement either extraction track has
ever recorded** — `koala-bear` now extracts **clean (0 errors, 0 sorries,
exit 0)** where the committed reference needed a ≈42-sorry hand patch;
`commit`'s rustc ICE is **fixed**; `merkle-tree` **emits for the first time**;
`air` dropped 145 → 43 sorries. Separately, hax's `lean` backend is now a
**completely different pipeline** that independently reproduces our aeneas
survey.

| | Before (2026-06-25 baseline) | This run |
| --- | --- | --- |
| hax | `ad110bfa` (2026-05-07) | `e11615541` (2026-08-18), +387 commits |
| OCaml engine | 2026-05-20 build, opam `default` switch | hax-engine **0.3.7**, rebuilt via `setup.sh` under the opam **`hax`** switch (OCaml 5.1.1) → `~/.opam/hax/bin/hax-engine` |
| rustc | `nightly-2025-11-08` | unchanged |
| Crates | all 40 | the 13-crate aeneas-survey sample |

**⚠️ The backends were renamed (hax PR #2064, 2026-07-16).** Everything this
document's baseline calls `cargo hax into lean` is now
**`cargo hax into legacy-lean`**, and it writes to a **new path**:
`<crate>/proofs/legacy-lean/extraction/<pkg>.lean` (no longer
`proofs/lean/extraction/`). `cargo hax into lean` now runs a **new
aeneas-based backend**: charon compiles the crate to
`proofs/lean/llbc/<pkg>.llbc`, aeneas translates it to
`proofs/lean/<PascalPkg>/Extraction/{Funs,Types,…}.lean` (plus
`proofs/lean/aeneas-error.log`). The aeneas/charon binaries are auto-downloaded
and pinned per hax release (PR #2085: `hax.toml`, `cargo hax tools show`,
cache under `~/.cache/hax/tools/`). This run's pins: **aeneas
`nightly-2026.08.18-ae2f343`** (the cryspen/aeneas fork = AeneasVerif `main`
at ≈`daa85d7e` — the exact commit of our 2026-08-18 aeneas survey — plus 11
hax-integration commits), **charon `nightly-2026.07.24`** (one week older than
our surveyed `340b1af4`), Lean `v4.31.0`, `hax-lean-lib v0.3.0`. The new
backend does not use the OCaml engine at all.

Also new: the error taxonomy grew. The baseline's single `[HAX0001]` is now
`[HAX0001]` (not implemented), `[HAX0002]` ("impossible occurred"),
`[HAX0003]` (`&mut` mutation not allowed here), `[HAX0006]` (closure captures
mutated binding — issue [#1060](https://github.com/hacspec/hax/issues/1060)),
`[HAX0008]` (explicit engine-phase rejection), `[HAX0010]` (expected `&mut _`
shape). All six baseline-tracked issues
([#1923](https://github.com/hacspec/hax/issues/1923),
[#1924](https://github.com/hacspec/hax/issues/1924),
[#1921](https://github.com/hacspec/hax/issues/1921),
[#1791](https://github.com/hacspec/hax/issues/1791),
[#156](https://github.com/hacspec/hax/issues/156),
[#923](https://github.com/hacspec/hax/issues/923)) are **still OPEN** — the
improvements below came from engine/printer work, not from closing them.

**Confound:** the Plonky3 source synced with upstream twice since the baseline
(~152 commits on 2026-06-29, ~60 on 2026-07-27), so line/sorry deltas are not
purely toolchain-attributable. Line-count growth in particular is largely
source growth.

### Survey A — `legacy-lean` (the baseline's backend), pristine source

| Crate | Lines (06-25 → now) | `sorry` (06-25 → now) | Own-source errors now (by code) | Note |
| --- | --- | --- | --- | --- |
| `koala-bear` | 4731 → 5121 | ≈42 → **0** | **0** — **exit 0, fully clean** | **the committed hand-patch era is over on new hax** |
| `keccak` | 924 → 984 | 1 → 1 | 2 (0003, 0006) | unchanged; the 1 sorry is still the `apply_to_chunks` closure (#1060) |
| `commit` | **emitted nothing (rustc ICE, exit 101)** → 4453 | — → **3** | 3 (0001, 0003, 0008) | **Pcs-impl frontend ICE fixed** (`circle`/`fri` not in sample — untested) |
| `merkle-tree` | **emitted nothing (exit 1)** → 7349 | — → **10** | 19 | **emits for the first time** — the `air` trait-machinery kill no longer fatal |
| `poseidon2` | 1488 → 1564 | 4 → 4 | 8 | unchanged |
| `mds` | 1501 → 1732 | 8 → 8 | 10 | unchanged |
| `symmetric` | 2838 → 3202 | 9 → 9 | 17 | unchanged |
| `challenger` | 5732 → 7633 | 15 → 15 | 36 | unchanged |
| `util` | 2181 → 2849 | 31 → 34 | 91 (61× 0008, …) | ~unchanged |
| `maybe-rayon` | 634 → 822 | 67 → **39** | 13 | −28 sorries |
| `air` | 9247 → 13067 | 145 → **43** | 27 (9× 0001, 16× 0008) | **−102 sorries**; the #1923/#1924 family now errs loudly instead of sorry-ing |
| `monty-31` | 14336 → 17867 | 91 → 95 | 188 | ~unchanged (SIMD-heavy) |
| `field` | 24884 → 38390 | 98 → 140 | 161 | grew with source; most errors are 0003 (`&mut` mutation) |

All emitters exit 1 except clean `koala-bear` (errors are non-fatal, as
before). Note the error counts are **not comparable** to the baseline's "loud
errors" column: much of what used to become a quiet `sorry` is now a loud
`HAX0003`/`HAX0006`/`HAX0008` — the same underlying gap (Obstruction 10,
imperative mutation), reported better.

### Survey B — the new aeneas-based `lean` backend

Ran on the same 13 crates. The result **independently reproduces our aeneas
survey** (same-day report [`2026-08-18.md`](2026-08-18.md)) through hax's own
toolchain pins — same five crates emit Lean, same obstructions kill the rest:

| Crate | Result | Aeneas-survey obstruction it matches |
| --- | --- | --- |
| `maybe-rayon` | **✅ clean — exit 0**, 4 files, 768 lines, 0 sorries | the aeneas survey's one clean crate |
| `keccak` | partial, 990 lines, aeneas 2 errors (1 unique: `Unreachable` at `lib.rs:69/99`) | closest-to-clean there too (different last error) |
| `poseidon2` | partial, 541 lines | partial there too |
| `challenger` | partial, 2704 lines | partial there too |
| `koala-bear` | partial, 110 lines; aeneas exit 2 on mixed mutually-recursive groups + 2 charon type errors | **#6** + **#16** |
| `field`, `air`, `commit` | **charon stack overflow, SIGABRT** — no `.llbc` | **#9**, reproduced in a second, independently-built charon (`nightly-2026.07.24`) |
| `monty-31`, `symmetric`, `merkle-tree` | charon `Type error after transformations`; no Lean | **#16** (hax at least fails the run loudly) |
| `mds` | aeneas exit 2, mixed mutually-recursive groups; no Lean | **#6 → #11** |
| `util` | aeneas exit 2, `unsupported statement: InlineAsm`; no Lean | **#4** |

Two consequences worth recording: (1) the two verification tracks have
**converged upstream** — hax's `lean` backend *is* an aeneas pipeline now, so
every aeneas-survey obstruction is automatically a hax obstruction; (2) the #9
stack overflow and #16 ill-typed-LLBC findings now have confirmation in an
independent charon build, strengthening the case for filing both (see the
aeneas survey's issue drafts).

### Install gate: reverted to `ad110bfa`

Adopting the new hax was gated on the official committed extraction not
drifting. It drifts, structurally and textually: `build-proofs.sh` invokes
`cargo hax into lean`, which is now the aeneas backend (wrong pipeline, wrong
output path), and the pristine `legacy-lean` output (5121 lines, 0 sorries) no
longer matches the committed reference (3362 lines, patched). Per the agreed
policy the toolchain was **reverted**: hax clone checked out at `ad110bfa`,
Rust binaries reinstalled (`cargo install --locked`), old OCaml engine
untouched at `~/.opam/default/bin/hax-engine` (the new engine remains parked
at `~/.opam/hax/bin/hax-engine`, harmless). Verified after revert:
`cargo hax --version` reports `commit=ad110bfa…`, and the official koala-bear
source-patch + extraction flow runs green end-to-end on the old backend/path.
One pre-existing caveat surfaced while checking: the fresh pristine output no
longer matches `patches/pristine.snapshot.lean` — but the diff is pure
source drift from the not-yet-reconciled 2026-07-27 upstream sync
(`UniformSamplingField` moved `p3_challenger` → `p3_field` in upstream #1926,
new poseidon1 round constants), i.e. the koala-bear workspace is due its
normal per-crate SYNC.md re-extraction pass regardless of anything this
survey did.

### Recommendation

1. **Plan a deliberate hax upgrade as its own project.** The prize is large:
   on new hax, pristine `koala-bear` needs **no patch at all**, `air` loses
   2/3 of its sorries, and `commit`/`merkle-tree` join the emitters. The cost
   is mechanical but real: every official workspace's `build-proofs.sh` must
   switch to `into legacy-lean` + the new `proofs/legacy-lean/` output path,
   and every Lean-side patch must be re-reconciled against materially
   different (better) output. Worth scheduling; not worth doing as a side
   effect of a survey.
2. **The two survey tracks can partially merge.** hax now pins and ships
   aeneas+charon itself; a future aeneas survey can additionally note hax's
   pinned versions, and hax-side testing of the `lean` backend doubles as an
   aeneas regression check.
3. **Re-test `circle`/`fri`** (not in this sample) to confirm the Pcs-impl
   ICE fix covers all three former ICE crates, not just `commit`.
4. **`maybe-rayon` through the new backend is clean** — a good candidate for
   the first end-to-end `cargo hax into lean` → `lake build` experiment, and a
   natural companion to the aeneas survey's standing "lake-build the clean
   crates" action item.

---

## How to reproduce

`cargo hax into lean`, run from each crate directory. Three things must be set,
exactly as in [`koala-bear`'s `build-proofs.sh`](../koala-bear/proofs/lean/extraction/build-proofs.sh):

```sh
export HAX_ENGINE_BINARY="$HOME/.opam/default/bin/hax-engine"   # see Obstruction 0
export RUSTUP_TOOLCHAIN="nightly-2025-11-08"                    # accept -Z flags
export RUSTFLAGS="-Zcrate-attr=feature(maybe_uninit_slice)"     # p3-util needs it
cargo hax into lean        # writes proofs/lean/extraction/<pkg>.lean
```

Output lands in each crate's own `proofs/lean/extraction/<pkg>.lean`. **Note:**
hax also writes a `<dep>.lean` into every *dependency* crate's `proofs/` dir, so
a single extraction touches many `proofs/` trees. Per AENEAS.md scope rules,
only `koala-bear`'s extraction is committed; the rest are regenerated/discarded.

---

## Results

**31 of 40 crates emit their own `.lean`; 9 emit nothing.** But "emits a file"
is a weak bar: every untranslatable item is rendered as a Lean `sorry`, and
there are **~987 `sorry`s across the 31 emitted files**. Counting those, **only
`baby-bear` and `examples` are `sorry`-free** — even `koala-bear`'s pristine
output has 42 (which is why it needs its hand-written patch). The 22 crates
flagged "clean" below means *no loud `[HAX0001]` error in their own source*, not
*fully translated*. (No file has been `lake build`-checked, so even the two
`sorry`-free ones aren't confirmed to typecheck.)

The loud `[HAX0001]` errors (Obstructions 1–9) block whole crates; the quiet
`sorry` placeholders (Obstruction 10) are what stop the crates that *do* emit
from being usable. See the [feature wishlist](#feature-wishlist-by-leverage) and
the [Rust-source patch workflow](#rust-source-patch-workflow) for closing them.

In the table, `sorry` is the pristine (unpatched) count; an inline `→ N` marks a
crate whose behaviour-preserving Rust patch (via the workflow below) lowers it.

### Emit a `.lean` file

Sorted by `sorry` count (translation completeness). `sorry` = an item hax could
not translate; lower is better. The "loud errors" column lists `[HAX0001]`
errors in the crate's *own* source (blank = none, but `sorry`s may still exist).

| Crate | Lines | `sorry` | Loud own-source errors |
| --- | ---: | ---: | --- |
| baby-bear | 4486 | **0** | — |
| examples | 6458 | **0** | — |
| keccak | 924 | 1 → **0** ✓ | — (patched: closure→loop, see [Rust-patch workflow](#rust-source-patch-workflow)) |
| blake3 | 106 | 2 | — |
| sha256 | 196 | 2 | — |
| poseidon2 | 1488 | 4 | — |
| lookup | 5024 | 5 | — |
| monolith | 1652 | 6 | — |
| mds | 1501 | 8 | #1921 (`karatsuba_convolution.rs`) |
| batch-stark | 3690 | 9 | — |
| symmetric | 2838 | 9 | — |
| poseidon1 | 3104 | 11 | — |
| monolith-air | 1559 | 13 | — |
| challenger | 5732 | 15 | — |
| poseidon2-air | 2249 | 19 | — |
| poseidon1-air | 2286 | 20 | — |
| util | 2181 | 31 | #1923 (`lib.rs`), inline-asm ICE (`transpose/rectangular.rs`) |
| field-testing | 10992 | 32 | — |
| dft | 3113 | 33 | #156 (`radix_2_bowers.rs`), #1791 (`radix_2_dit_parallel.rs`) |
| bn254 | 2165 | 35 | — |
| matrix | 4746 | 35 | #156 declare-first `let` |
| multilinear-util | 5427 | 36 | #923 ConstBlock, `reject_RawOrMutPointer` (`split_eq/packed_kernel.rs`) |
| koala-bear | 4731 | (ref) | — (patched reference; pristine ≈42) |
| rescue | 2274 | 46 | — |
| mersenne-31 | 10927 | 53 | — |
| maybe-rayon | 634 | 67 | #1923, #1924 (`lib.rs`, `serial.rs`) |
| goldilocks | 14360 | 75 | — |
| monty-31 | 14336 | 91 | — |
| field | 24884 | 98 | #1923 (`op_assign_macros.rs`) |
| air | 9247 | 145 | #1923 (`utils.rs`), #1924 (`builder.rs`) |

> ⚠️ **`sorry` ≠ visible error.** An item that hits a `[HAX0001]` error is
> *dropped* from the file (e.g. `util`'s `prefetch_write` is simply absent); an
> item hax translates partially gets a `sorry` placeholder. Most `sorry`s here
> are **not** from the loud obstructions — they are imperative loop/mutation
> bodies (Obstruction 10), which is why even "no-error" crates score badly.

### Emit nothing

| Crate | Exit | Blocker |
| --- | --- | --- |
| blake3-air | 1 | dependency trait machinery (#1923/#1924 in `air`) |
| keccak-air | 1 | dependency trait machinery (#1923/#1924 in `air`) |
| merkle-tree | 1 | dependency trait machinery (#1923/#1924) |
| uni-stark | 1 | dependency trait machinery (#1923/#1924 in `air`) |
| whir | 1 | dependency trait machinery (#1791 in `dft`) |
| zk-codes | 1 | dependency trait machinery (#156/#1791 in `dft`) |
| **circle** | 101 | rustc ICE in hax frontend (`Pcs` impl) |
| **commit** | 101 | rustc ICE in hax frontend (`Pcs` impl) |
| **fri** | 101 | rustc ICE in hax frontend (`Pcs` impl) |

> The six exit-1 crates have **no own-source obstruction** — every error hax
> reports for them lives in a *dependency*. They are too trait-generic to
> produce standalone items, and the fatal dependency error (most often `air`'s
> `AirBuilder`) prevents their own module from being written.

---

## Obstruction catalogue

### 0. (environment) `hax-rust-engine` can't find the OCaml engine

Not a Plonky3 bug, but it blocks *everything* and must be fixed first. The
current hax splits into a Rust driver (`hax-rust-engine`) that spawns the OCaml
engine binary `hax-engine`. The OCaml engine is installed under opam
(`~/.opam/default/bin/hax-engine`) but is **not on `PATH`**, so the Rust engine
panics:

```
thread 'main' panicked at rust-engine/src/ocaml_engine.rs:130:18:
called `Result::unwrap()` on an `Err` value: Os { code: 2, kind: NotFound, ... }
```

`ocaml_engine.rs:130` does `Command::new(env "HAX_ENGINE_BINARY" else "hax-engine").spawn().unwrap()`.
**Fix:** export `HAX_ENGINE_BINARY=$HOME/.opam/default/bin/hax-engine` (or put it
on `PATH` via `eval $(opam env)`). `koala-bear`'s `build-proofs.sh` does neither
— it relies on an active opam env; document this or it bites every run.

### 1. Associated-type equality constraints on a parent trait — *the dominant blocker*

- **hax issue:** [#1923](https://github.com/hacspec/hax/issues/1923) · context `Lean Printer` · `[HAX0001]`
- **Message:** `Unsupported equality constraints on associated types of parent trait`
- **Seen at:** `air/src/utils.rs` (`pack_bits_le`), `field/src/op_assign_macros.rs`,
  `maybe-rayon/src/{lib,serial}.rs`, `util/src/lib.rs`. **35 occurrences**, by far the most common error.
- **Impact:** the offending item is dropped from output. Because this pattern
  pervades `air`'s `AirBuilder` and the `Field`/`AbstractField` trait families,
  it transitively kills the AIR/STARK crates (`*-air`, `merkle-tree`, `uni-stark`).
  This is the single highest-leverage fix.

### 2. Associated-type projection variant

- **hax issue:** [#1924](https://github.com/hacspec/hax/issues/1924) · context `Lean Printer` · `[HAX0001]`
- **Message:** `Unsupported variant of associated type projection`
- **Seen at:** `air/src/builder.rs` (`AirBuilder`), `maybe-rayon/src/serial.rs`. **31 occurrences.**
- **Impact:** same family as #1 — together #1923 + #1924 account for 66 of the
  ~70 print-time errors and explain all six exit-1 crates.

### 3. Equality constraints on associated types (non-parent)

- **hax issue:** [#1921](https://github.com/hacspec/hax/issues/1921) · context `Lean Printer` · `[HAX0001]`
- **Message:** `Unsupported equality constraints on associated types`
- **Seen at:** `mds/src/karatsuba_convolution.rs`. 2 occurrences.

### 4. Function parameters containing patterns

- **hax issue:** [#1791](https://github.com/hacspec/hax/issues/1791) · context `Lean Printer` · `[HAX0001]`
- **Message:** `Function parameters must not contain patterns`
- **Seen at:** `dft/src/radix_2_dit_parallel.rs`, `sumcheck/src/strategy.rs`.
  Propagates into `whir` (depends on `dft`).

### 5. Declare-first `let` bindings

- **hax issue:** [#156](https://github.com/hacspec/hax/issues/156) · context `AST import` · embedded `hax::failure`
- **Message:** `Sorry, Hax does not support declare-first let bindings`
- **Seen at:** `dft`, `matrix`; propagates into `zk-codes`. 5 occurrences.
- **Impact:** rendered as an embedded `rust_primitives::hax::failure(...)` in the
  function body (vs. dropping the whole item).

### 6. Const-generic block (`ConstBlock`)

- **hax issue:** [#923](https://github.com/hacspec/hax/issues/923) · context `AST import` · embedded `hax::failure`
- **Message:** `something is not implemented yet. ConstBlock`
- **Seen at:** `multilinear-util/src/split_eq/packed_kernel.rs` (`basis_split_dot`,
  a `[[MaybeUninit<_>; 128]; D]` const-generic stack buffer).

### 7. Raw pointers rejected by engine phase

- **phase:** `reject_RawOrMutPointer` · context `reject_RawOrMutPointer` · embedded `hax::failure`
- **Message:** `a node of kind [Raw_pointer] have been found in the AST`
- **Seen at:** `multilinear-util/src/split_eq/packed_kernel.rs` (the
  `MaybeUninit` → `from_raw_parts`/`as_ptr` packing kernel). **14 occurrences.**

### 8. Inline assembly — "impossible" fatal

- **context:** `AST import` · embedded `hax::failure` (`expression Todo` / "Fatal error: something … impossible occurred")
- **Construct:** `InlineAsm` (`asm!("prfm pstl1keep, [...]")`)
- **Seen at:** `util/src/transpose/rectangular.rs:88` (`prefetch_write`, the
  aarch64/NEON software-prefetch intrinsic). hax has no inline-asm model.

### 9. rustc ICE in the hax frontend exporter — `Pcs` impls

- **Where:** `driver-hax-frontend-exporter` → rustc panic, **exit 101**, no Lean produced.
- **Signature:**
  ```
  thread 'rustc' panicked at .../rustc_type_ir/src/binder.rs:853:9:
  region parameter `'a/#3` ('a/#3/3) out of range when instantiating
  args=[<Pcs impl>, Challenge, Challenger]
  ```
- **Seen at:** `circle` (`CirclePcs`), `commit` (`TrivialPcs`), `fri` (`HidingFriPcs`).
  All three are `Pcs` trait implementations carrying a lifetime parameter that
  the frontend exporter instantiates out of range, ICE-ing the pinned nightly
  before any extraction happens. This is the only *hard crash* (vs. graceful
  `[HAX0001]`) and likely a frontend-exporter / rustc-internal-API bug rather
  than a missing feature.

### 10. Imperative in-place mutation & loops — *the pervasive quiet blocker*

- **Symptom:** rendered as `sorry`, not a `[HAX0001]` error. **~987 `sorry`s
  across the 31 emitted files** — the dominant reason no crate is `sorry`-free.
- **Forms (by frequency):**
  - `let _ := sorry;` (~338): a statement run for its side effects — almost
    always a `for`/`while` loop mutating a slice/array in place — that hax drops.
  - `(pure sorry)` (~286): an entire effectful function/closure body replaced.
    These are unit-returning fns that mutate their `&mut [T]`/`&mut [[T]]`
    argument (FFT butterflies, MDS `permute`, Poseidon rounds).
  - `fun … => … sorry` (~32): closures passed to combinators (`for_each`, `fold`).
  - `match sorry with ControlFlow.Break/Continue`: a `loop { … break v }` /
    `while` with break-value (rejection-sampling search loops).
- **Seen at (representative):** `monty-31` DIT/DIF butterflies, `goldilocks`
  `MdsMatrixGoldilocks::permute` and `StandardUniform::sample`, `keccak`/`blake3`
  `hash_iter`/`apply_to_chunks`, and the bodies behind most counts in the table.
- **Why it dominates:** Plonky3's hot code — field arithmetic, NTTs, MDS
  matrices, hash permutations — is written as imperative in-place mutation over
  fixed-size arrays and slices. hax's functional core can't yet model element
  assignment through `&mut`, so these bodies become `sorry` even when the
  function's *signature* extracts fine. This, not the loud trait errors, is what
  separates "emits a file" from "usable."

---

## Feature wishlist (by leverage)

What hax would need to support, ranked by impact on *this* codebase:

1. **In-place mutation through loops** (`for i in 0..n { buf[i] = … }`, element
   assignment via `&mut [T]`) — Obstruction 10. Highest value: it's the core
   Plonky3 idiom and the source of nearly all ~987 `sorry`s. Fixing the loud
   trait errors without this still yields `sorry`-riddled, unusable output.
2. **`loop`/`while` with `break`-value** (`ControlFlow` lowering) — Obstruction 10.
3. **Associated-type equality constraints on (super)traits**
   ([#1923](https://github.com/hacspec/hax/issues/1923)/[#1924](https://github.com/hacspec/hax/issues/1924))
   — Obstructions 1–2. Gates the most *whole crates*: unblocks all six
   zero-output crates (the `*-air` family, `merkle-tree`, `uni-stark`, `whir`,
   `zk-codes`) by fixing `air`'s `AirBuilder`, and removes type-position `sorry`.
4. **Effectful closures / iterator combinators with mutable capture**
   (`for_each`, `fold`) — Obstruction 10 / hashing drivers.
5. **The long tail:** pattern parameters ([#1791](https://github.com/hacspec/hax/issues/1791)),
   declare-first `let` ([#156](https://github.com/hacspec/hax/issues/156)),
   const-generic blocks ([#923](https://github.com/hacspec/hax/issues/923)),
   raw pointers (`reject_RawOrMutPointer`), inline asm (niche, `util` only).
6. **Frontend ICE on `Pcs` impls** (Obstruction 9) — not a language feature; a
   frontend-exporter/rustc bug to file upstream. Blocks `circle`/`commit`/`fri`.

---

## Rust-source patch workflow

`koala-bear` patches the *Lean output* of hax (kept in `proofs/`, never touching
`src/`). We extend this to patch the *Rust source*: a small, behaviour-preserving
rewrite into the hax-supported subset, kept as a committed diff in
`<crate>/proofs/rust-patch/patches/<pkg>.patch` and applied **only** during
extraction, then reverted — so the committed Rust is never changed.

**Driver:** `aeneas-obstructions/hax-extract.sh <crate>` — refuses to run on a
dirty `src/`, installs a `trap` that `git checkout`s the source back on *any*
exit (success, failure, or Ctrl-C), applies the patch, runs `cargo hax into lean`
in an **isolated `CARGO_TARGET_DIR`** (required — the shared `target/hax` serves
stale Lean; see gotcha below), and reports the `sorry` count. Per-crate
`extract.sh`/`update-patch.sh` shims live alongside the patch.

**Two patch classes:**
- **Class A** — pure behaviour-preserving rewrite (iterator/closure → explicit
  `for` loop, `iter_mut` → index loop). No new trust, no new deps.
- **Class B** — `#[hax_lib::opaque]` (+ temporary `hax-lib` dep) for constructs
  that can't be expressed in the subset (RNG/SHAKE state, `const{assert!}`). The
  opaque body becomes **trusted (TCB)**, not extracted; flagged in its README.

**Pilot — `keccak` (Class A): 1 → 0 `sorry`.** `Keccak256Hash::hash_iter` used
`p3_util::apply_to_chunks(input, |buf| hasher.update(buf))` — a mutable-capture
closure (Obstruction 10) → `(pure sorry)`. Rewritten to
`for byte in input { hasher.update(&[byte]); }`, the exact loop shape its sibling
`hash_iter_slices` already extracts cleanly. Behaviour-identical (Keccak's
`update` is incremental, so byte grouping doesn't change the digest); hax lowers
the loop to an `Iterator.fold` threading `hasher`. Verified: 0 `sorry`, `src/`
reverted clean, patch re-applies (`git apply --check`). See
`keccak/proofs/rust-patch/README.md`. Next targets: `blake3`, `sha256`,
`poseidon2`.

---

## Survey methodology notes / gotchas

- **Engine binary** — see Obstruction 0; without `HAX_ENGINE_BINARY` the run
  panics immediately and looks like a per-crate failure when it is not.
- **Dependency build caching** — with a shared `target/hax`, a crate compiled as
  a *dependency* of an earlier extraction gets a cached fingerprint, so running
  `cargo hax into lean` in it later finishes in ~0.04s and the driver never runs
  (no output, exit 0). `cargo clean -p <pkg>` does **not** help (wrong target
  dir); `touch`-ing the crate's sources forces a recompile and a real run. Six
  crates (`fri`, `lookup`, `matrix`, `maybe-rayon`, `merkle-tree`, `uni-stark`)
  were re-run this way before being judged.
- **Dependency error bleed** — hax extracts the whole dependency closure, so a
  crate's log contains its dependencies' errors too. Error→crate attribution in
  this report is by the source path in each error's `-->` location, not by which
  crate's log it appeared in.
- **"Emits a file" ≠ "complete"** — unsupported items are dropped (print errors)
  or replaced with `hax::failure` placeholders (AST-import errors); the file
  still builds-or-not independently of how many items it silently omits.
