# Claude Skill for Syncing Updates to this Fork

Hey Claude, the repository we're in is a fork of [Plonky3](https://github.com/Plonky3/Plonky3) that adds proof infrastructure.
This directory, `proofs/`, contains all of the proof infrastructure relating to the `koala-bear` crate.
If you investigate you can see that we are using `cargo hax` (the [Hax toolchain](https://github.com/cryspen/hax)) from `../` to extract the
source Rust code into this directory.

Currently, this doesn't fully extract cleanly. Each time we run `cargo hax into lean` it **only** overwrites
`proofs/lean/extraction/p3_koala_bear.lean`. Everything else under `proofs/lean/extraction/` is hand-maintained:

| Path | Role |
|------|------|
| `p3_koala_bear.lean` | Hax output → then apply `patches/p3_koala_bear.patch` |
| `p3_koala_bear/` | Stubs for crates Hax does not extract (`dependencies.lean` wires them; no need to change now) |
| `p3_koala_bear_proofs/` | Proof modules against the imported specs |
| `p3_koala_bear_proofs.lean` | Root import(s) for the `p3_koala_bear_proofs` Lake library |

We then apply the patch in `proofs/lean/extraction/patches/` and build. If the patch doesn't apply
cleanly, manually edit the extracted file (style: `-- PATCHED` at edit sites) and re-generate the patch file.
Upstream extraction changes can also require small edits in `p3_koala_bear_proofs/` or stubs if imports or types shift.

You should adapt the previous patch to the new file in a way that preserves as much as possible (and relevant) of the previous patch.
- If a previous patch has to `sorry` out a proof that doesn't compile, opt for the now-compiling proof.
- If a previous patch includes imports, keep those imports as much as possible.
- If a previous patch has to modify a function or definition, keep the spirit of that modification as much as possible (hopefully this never happens).

From there, we want to run `lake build` in the `proofs/lean/extraction` directory. This will check the extracted file wrt the imported specs.
Your goal is to keep those proofs as intact as possible. If you had to make edits to the extracted file that affects the proofs, make those 
corresponding changes. Avoid introducing `sorry`s; if proofs break, attempt to fix the proofs. Avoid changing the statements of the theorems
in the specification; but if you absolutely must change the specs, do everything you can to preserve the semantics from before.