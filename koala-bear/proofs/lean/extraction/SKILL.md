# Claude Skill for Syncing Updates to this Fork

Hey Claude, the repository we're in is a fork of [Plonky3](https://github.com/Plonky3/Plonky3) that adds proof infrastructure.
This directory, `proofs/`, contains all of the proof infrastructure relating to the `koala-bear` crate.
If you investigate you can see that we are using `cargo hax` (the [Hax toolchain](https://github.com/cryspen/hax)) from `../` to extract the
source Rust code into this directory.

Currently, this doesn't fully extract cleanly. Each time we run `cargo hax into lean` it only edits the `proofs/lean/extraction/p3_koala_bear.lean` 
file; we then apply the patch in `proofs/lean/extraction/patches/` and then we build. As you can see, if the patch doesn't apply
cleanly, we'll need to manually edit the extracted file (in the style that it is currently, with `-- PATCHED` flags at edit sites)
and re-generate the patch file.

You should adapt the previous patch to the new file in a way that preserves as much as possible (and relevant) of the previous patch.
- If a previous patch has to `sorry` out a proof that doesn't compile, opt for the now-compiling proof.
- If a previous patch includes imports, keep those imports as much as possible.
- If a previous patch has to modify a function or definition, keep the spirit of that modification as much as possible (hopefully this never happens).

From there, we want to run `lake build` in the `proofs/lean/extraction` directory. This will check the extracted file wrt the imported specs.
Your goal is to keep those proofs as intact as possible. If you had to make edits to the extracted file that affects the proofs, make those 
corresponding changes. Avoid introducing `sorry`s; if proofs break, attempt to fix the proofs. Avoid changing the statements of the theorems
in the specification; but if you absolutely must change the specs, do everything you can to preserve the semantics from before.