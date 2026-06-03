# AENEAS.md — runbook for the periodic Aeneas extraction survey

This file is a **runbook**, not a report. When the user says **"run AENEAS.md"**,
follow the steps below to produce a fresh, dated obstruction report under
`aeneas-obstructions/`.

The goal: track how the [Aeneas](https://github.com/AeneasVerif/aeneas) /
[Charon](https://github.com/AeneasVerif/charon) toolchain progresses at
extracting the Plonky3 crates — which upstream commits fix which blockers — and
keep a committed, dated record. Past reports live in
[`aeneas-obstructions/`](aeneas-obstructions/) (see its README for the index).

> **Scope guardrails (read first).**
> - Commit **only** `aeneas-obstructions/` and this `AENEAS.md`. Never `git add`
>   extracted code, `.llbc`, Lean output, `*/proofs/`, or anything in `/tmp`.
> - `aeneas-obstructions/issue-drafts/` is **gitignored** (see its `.gitignore`):
>   the per-obstruction upstream issue drafts (step 7) are regenerated each run
>   and are **never committed** — working material only.
> - All extraction output goes to `/tmp/aeneas-extract/` via the runner script.
>   Nothing is written inside the repo.
> - The hax workflow (`*/proofs/`, `koala-bear/proofs/...` patches, `SYNC.md`,
>   `TCB.md`, `build-proofs.sh`) is a **separate, unrelated** verification
>   pipeline. Ignore it entirely — do not touch, regenerate, or report on it.

---

## 0. Locations & the fixed crate sample

| Thing | Path / value |
| --- | --- |
| aeneas repo | `~/devel/fv-tools/aeneas` (branch `main`) |
| charon checkout | `~/devel/fv-tools/aeneas/charon` |
| charon pin file | `~/devel/fv-tools/aeneas/charon-pin` (records the commit aeneas expects) |
| charon version | `~/devel/fv-tools/aeneas/charon/charon/Cargo.toml` (`version = …`) |
| aeneas binary | `~/devel/fv-tools/aeneas/bin/aeneas` (on PATH; **no** `--version` flag) |
| charon binary | `~/devel/fv-tools/aeneas/charon/bin/charon` (on PATH; **no** `--version` flag) |
| build command | `gmake build` (from the aeneas repo root) |
| runner script | `aeneas-obstructions/run-extract.sh` |
| output (ephemeral) | `/tmp/aeneas-extract/<crate>/` |

**Fixed crate sample** — survey exactly these 13, every run, so reports are
comparable over time (the set the first report covered):

```
util  keccak  maybe-rayon  koala-bear  poseidon2  field
air   commit  monty-31     challenger  mds        symmetric  merkle-tree
```

If a previously-blocked crate now extracts (or a new crate becomes interesting),
note it, but keep these 13 as the stable baseline. Crate dir name → cargo
package is `p3_<name with - → _>` (e.g. `koala-bear` → `p3_koala_bear`).

---

## 1. Update & rebuild the toolchain

The point of the survey is tracking aeneas progress, so refresh to latest each
run. **Build failures are recorded, not fatal** — if the build breaks, note it
in the report and proceed with whatever binaries currently exist (or stop and
report the breakage if no usable binary exists).

1. Record the **before** state: `git -C ~/devel/fv-tools/aeneas rev-parse HEAD`
   and the current charon HEAD (`git -C ~/devel/fv-tools/aeneas/charon rev-parse HEAD`).
2. Update aeneas: `git -C ~/devel/fv-tools/aeneas pull --ff-only`.
3. Sync charon to the new pin:
   - read the pinned commit from `~/devel/fv-tools/aeneas/charon-pin`;
   - `git -C ~/devel/fv-tools/aeneas/charon fetch` then
     `git -C ~/devel/fv-tools/aeneas/charon checkout <pinned-commit>`.
4. Rebuild: `cd ~/devel/fv-tools/aeneas && gmake build`. (This runs `check-charon`
   then builds the OCaml + binaries. Charon itself is rebuilt by its own build if
   needed — if the charon binary is stale, build it per the charon repo's
   instructions.)
5. Record the **after** state: aeneas HEAD (short + subject), charon HEAD
   (short + subject), charon version string, and how many commits aeneas moved
   (`git -C ~/devel/fv-tools/aeneas log --oneline <before>..<after>` — this list
   is the raw material for the "delta vs previous" section).

> Memory note: aeneas/hax tools sometimes print errors but still produce usable
> output. Don't abort the whole survey on noisy output — capture it and judge
> from the artifacts.

---

## 2. Extract each crate

Run the committed script over the sample, into `/tmp` only:

```sh
for c in util keccak maybe-rayon koala-bear poseidon2 field \
         air commit monty-31 challenger mds symmetric merkle-tree; do
  aeneas-obstructions/run-extract.sh "$c"
done
```

Each crate gets a fresh isolated `CARGO_TARGET_DIR` (the script handles this) so
a cached `p3-field` cannot mask the clean-build charon panic. Per-crate output
lands in `/tmp/aeneas-extract/<crate>/`:
`charon.log`, `aeneas.log`, `aeneas.log.clean` (ANSI-stripped), `lean/`, `<pkg>.llbc`.
The script prints a per-crate SUMMARY (charon/aeneas exit codes, error & warn
counts, lean file & line counts).

---

## 3. Parse the logs → crate-by-crate table

For each crate, from its `/tmp/aeneas-extract/<crate>/` logs, record:

- **charon**: OK / OK(Nw warnings) / **PANIC** (and whether the panic is on the
  crate itself or transitive on `p3-field`).
- **aeneas errors**: `grep -c '\[Error\]' aeneas.log.clean`.
- **aeneas warns**: `grep -c '\[Warn \]' aeneas.log.clean`.
- **files / lines**: count of `*.lean` under `lean/` and their total line count.
- **verdict**: one short phrase (clean / partial-with-X / blocked-on-Y).

Distinguish a charon **panic** (no `.llbc`, aeneas skipped) from aeneas errors
(charon produced a `.llbc`, aeneas emitted partial Lean).

---

## 4. Categorize the obstructions

Group distinct failures into numbered issues (the "Issue #N" pattern the reports
use). For each: a representative error line, the Rust/OCaml source location if
the message gives one, which crates it hits, and rough occurrence count. Reuse
the issue numbering/titles from the most recent prior report where the
obstruction is the same one, so they can be tracked across reports.

---

## 5. Cross-reference against upstream issues/PRs

For each obstruction, search the **open** issues *and* pull requests on **both**
repos:

- `AeneasVerif/aeneas` — https://github.com/AeneasVerif/aeneas/issues
- `AeneasVerif/charon` — https://github.com/AeneasVerif/charon/issues

Prefer the `gh` CLI when available (it's fastest and searches both issues & PRs):

```sh
gh search issues --repo AeneasVerif/aeneas  --state open "<keyword>"
gh search prs    --repo AeneasVerif/aeneas  --state open "<keyword>"
gh search issues --repo AeneasVerif/charon  --state open "<keyword>"
gh search prs    --repo AeneasVerif/charon  --state open "<keyword>"
```

Fall back to `WebFetch`/`WebSearch` on the issue search URLs if `gh` is
unavailable or unauthenticated. Search by the distinctive tokens in each error
(e.g. `GenericsMismatch`, `trait_const_id`, `trait_impl_is_builtin`,
`Mixed declaration groups`, `raw pointers`, `FnOnce name clash`, `GAT`).

Classify each obstruction as: **Represented** (a matching open ticket/PR),
**Partial** (related ticket, different symptom), or **Not represented** (no
matching ticket). Capture the ticket numbers + links. Note any PR that looks
like it *would* fix the blocker once merged.

---

## 6. Write the dated report

Write to `aeneas-obstructions/<YYYY-MM-DD>.md` (today's date). Use the template
in the appendix below. It **must** include:

- toolchain versions with **before/after** aeneas + charon commits and charon
  version;
- a **Delta vs previous report** section comparing toolchain commits and
  per-crate verdicts against the most recent prior report in
  `aeneas-obstructions/` — explicitly call out which commits fixed/regressed
  which obstruction (this is the whole reason for the exercise);
- the crate-by-crate results table;
- the obstruction catalog;
- the upstream cross-reference table (aeneas + charon, with links);
- a dedicated **"Obstructions with no upstream issue/PR"** section listing
  blockers that have *no* matching open ticket — these are the candidates to
  file upstream;
- a short recommendation / "what changed since last time".

---

## 7. Draft a writeup for each unrepresented obstruction

For **every** obstruction classified **"Not represented"** in step 5 (i.e. each
entry in the report's *"Obstructions with no upstream issue/PR"* section),
produce a ready-to-file GitHub issue draft. These are working material — they
live in `aeneas-obstructions/issue-drafts/`, which is **gitignored and never
committed**. Regenerate them fresh each run (overwrite the directory).

For each one:

- Write `aeneas-obstructions/issue-drafts/<NN>-<repo>-<slug>.md` (e.g.
  `01-charon-genericsmismatch-panic.md`), numbered highest-blocker-first.
- Start with a header noting it is an **unfiled draft**, the run date, and which
  report Issue #N it maps to.
- Then a ready-to-paste issue: **suggested title**, **which repo to file on**
  (`AeneasVerif/aeneas` vs `AeneasVerif/charon`), suggested labels, and a body
  with: Summary, Environment (the run's aeneas/charon commits + version, rustc,
  platform), Repro, Observed (verbatim error text / backtrace / trace), Expected,
  and Notes/triage (including whether it may be downstream of another obstruction).
- **Capture real evidence**, don't paraphrase: for a charon panic, re-run that
  crate's extraction with `RUST_BACKTRACE=1` and paste the trimmed backtrace; for
  an OCaml exception, paste the full `Called from …` trace from `aeneas.log.clean`;
  for a lookup-failure cascade, paste representative verbatim lines + counts.
- Refresh `aeneas-obstructions/issue-drafts/README.md` — a table of the drafts
  (file, target repo, mapped Issue #, one-line gist).

(If a previously-unrepresented obstruction has since gained an upstream ticket,
it is no longer "Not represented" and gets no draft — it moves to the
cross-reference table instead.)

---

## 8. Update the index

Add a row (newest first) to the table in `aeneas-obstructions/README.md`: date
(linked to the new report), aeneas commit, charon commit + version, and a
one-line headline.

---

## 9. Commit — scoped, output excluded

Stage **only** the report artifacts and this runbook:

```sh
git add aeneas-obstructions/ AENEAS.md
git status   # confirm NOTHING else is staged — no proofs/, no /tmp, no *.lean,
             # no issue-drafts/ (it is gitignored)
git commit -m "aeneas survey <YYYY-MM-DD>: <one-line headline>"
```

Never `git add -A` / `git add .` — that would sweep in hax `*/proofs/` output
and any stray extraction artifacts. `aeneas-obstructions/issue-drafts/` is
gitignored, so `git add aeneas-obstructions/` will not pick it up. Commit on the
current branch (`aeneas-experiments` unless told otherwise). Push only if asked.

---

## Appendix — report template

```markdown
# Aeneas extraction status (<YYYY-MM-DD>)

<one-paragraph summary: usable yet? top blocker? net change since last report?>

## Tool versions

| Tool   | Before          | After           | Notes |
| ------ | --------------- | --------------- | ----- |
| aeneas | `<short>`       | `<short>`       | <N commits, branch main> |
| charon | `<short>`       | `<short>`       | v<X.Y.Z>, pinned by aeneas |

Build: `gmake build` — <succeeded / failed with …>.

## Delta vs previous report (<prev date>)

- aeneas moved `<prev>` → `<now>` (`git log --oneline <prev>..<now>` highlights).
- Fixed: <obstruction> — by commit `<hash>` / PR #<n> (if identifiable).
- Regressed / new: <obstruction>.
- Per-crate verdict changes: <crate>: <old> → <new>.
- (If first report or no change: say so.)

## Invocation

`--preset aeneas` is required (else "Hash-consing key not found … serialization
mismatch"). Per-crate isolated `CARGO_TARGET_DIR` so a cached `p3-field` can't
mask the clean-build panic. Driven by `aeneas-obstructions/run-extract.sh`.

## Crate-by-crate results

| Crate | charon | aeneas errors | aeneas warns | files | lines | Verdict |
| --- | --- | --- | --- | --- | --- | --- |
| … | … | … | … | … | … | … |

`*` = charon panics while compiling `p3-field` as a dependency (transitive).

## Obstruction catalog

### Issue #N — <title>
<representative error text, source location, which crates, occurrence count>

## Upstream cross-reference (<YYYY-MM-DD>)

| Local issue | Status | Matching tickets (aeneas / charon) |
| --- | --- | --- |
| #N … | Represented / Partial / Not represented | links |

## Obstructions with no upstream issue/PR

<blockers with NO matching open ticket on either repo — candidates to file,
highest blocker first, with repro and suggested repo (aeneas vs charon)>

## Recommendation

<is it usable yet; what to file; what to watch; closest-to-clean crates>
```
