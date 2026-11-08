# Digital Circuits and Microprocessor Fundamentals — textbook (LaTeX source)

*From Boolean Algebra to Dedicated Microprocessors with VHDL* — textbook for courses 010113025 (*Digital Circuit and Logic Design*) and 010153101 (*Digital Circuit and Microprocessor Fundamental*), KMUTNB. The second course (`../digital_n_micro`) includes this repository as its `common` git submodule, so the book is shared automatically once it is committed here.
Built from the lecture slides in `../lecture_*.md`, the TikZ figures in `../tex/` and the VHDL in `../vhdl/`.

## Build

```bash
cd textbook
make            # compiles the TikZ figures (../tex -> figures/*.pdf) and then the book
make book       # book only
make clean
```

Needs TeX Live with **XeLaTeX**, `latexmk`, `bibtex`, `makeindex` (all standard). The output is
`Digital_Circuits_and_Microprocessor_Fundamentals.pdf` (B5-like “8-page-sheet” format, 190 × 265 mm).
Fonts used: TeX Gyre Pagella / Heros and Fira Mono (all shipped with TeX Live).

## Layout

| Path | Content |
|---|---|
| `main.tex`, `preamble.tex`, `metadata.tex` | document, styles/macros, title-page data (**edit `metadata.tex`**) |
| `frontmatter/` | title page, copyright page, dedication, preface, acknowledgements, about the author, introduction |
| `chapters/ch01.tex … ch10.tex` | the ten chapters (one per lecture 1–10; lecture 0 → Introduction/Preface) |
| `backmatter/` | A VHDL quick reference · B reference tables · C complete VHDL listings · D answers · glossary |
| `refs.bib` | bibliography (BibTeX, IEEEtran style) |
| `listings/` | VHDL taken verbatim from the lecture slides (with small fixes) |
| `figures/` | generated PDFs of your TikZ/circuitikz sources (`make figures`) |

Macros: `\term{x}` (italic + index entry), `\fig{file}{caption}{label}`, `\vhdlfile{path}{caption}{label}`,
`\code{...}`, environments `objectives`, `example`, `definition`, `keypoint`, `caution`, `chaptersummary`, `exlist`.

## How the book follows the MU-PRESS and KMUTNB criteria

| Criterion (from the two PDFs) | Where / how |
|---|---|
| Components: title, dedication, contents, preface, acknowledgements, contributors/author, introduction, content, appendix, glossary, bibliography, index | all present (`main.tex` order) |
| Foreword (คำนิยม) by a third party | deliberately **not** included — the slides advise against inviting a reviewer to write one |
| Size: ผศ. ≈ 30 / รศ. ≈ 50 / ศ. ≈ 80 pages of a standard “8-page-sheet” book | 317 pages in 190 × 265 mm (about 230 pages of chapters) |
| Content must be systematic, accurate, up to date, suited to university level | ten chapters following the course syllabus; every worked result was re-derived while writing |
| Each chapter: objectives, content with examples, summary, exercises, references | every chapter has *Learning objectives*, boxed *Examples*, *Chapter summary*, *Exercises*, *Further reading*; answers in App. D |
| Figures/tables must be the author's own, captioned, and sourced | all figures are your TikZ/circuitikz drawings, your Quartus/ModelSim/Logisim screenshots, or new drawings; **third-party photos were left out** (see below); tables of external data carry a source note |
| No copying/translation; credit sources | prose is original; Brown–Vranesic, Hwang, Mano–Ciletti, Wakerly etc. cited; EC-1/EC-2 attributed to Hwang |
| Consistent, current references | one style (IEEEtran), 20 entries — **please verify bibliographic details** |
| Index (ดรรชนี) with useful entries; glossary | ≈ 150 index entries (`\term`), 70 glossary entries |
| ISBN, publisher, cataloguing data | placeholders on the copyright page (`metadata.tex`) |
| Terminology consistent | British spelling throughout (*optimisation*, *quantisation*) |

## Figure policy (readability and symbol consistency)

* Figures are produced from **patched copies** of your TikZ sources (`patch_figures.py` → `figsrc/`; the originals in `../tex/` are never changed). The patch makes every flip-flop symbol the same size, enlarges the tiny pin labels of flip-flops/register blocks, and removes a stray scale in one file.
* In the book all figures of one kind are printed at **one fixed scale**, so a gate, a flip-flop, a K-map cell or a state circle looks the same size everywhere: logic/block diagrams ×0.75, K-maps ×0.90, state diagrams ×0.80 (a few very large circuits are shrunk by ≤ 8 % to stay on a portrait page).
* Figures that are wider than the text block at that scale are placed on **rotated (landscape) pages** (`sidewaysfigure`); sub-figures are repacked into rows that fit, and tall figure groups are split into continued floats.
* Wide Questa/ModelSim waveform screenshots are cut into **strips that each keep the signal-name column** (`images/`, `\wavesplit`), because at full width their text would print at 3–4 pt. The original screenshots are untouched.
* `tools/figinfo.py` + `tools/figreport.sty` measure the printed text size of every figure (add `\usepackage{figreport}` to `main.tex` temporarily to log it).

## Things only you can complete / decide

1. **`metadata.tex`**: ISBN, publisher name/address, edition and year.
2. **`frontmatter/about.tex`**: filled in from your CV (education, interests, awards, 6 selected publications, e-mail). Date of birth, mobile number and the academic rank were left out on purpose; edit the file to add more.
3. **Peer review** (needed for รศ./ศ. use): the criteria require evidence of review by external experts.
4. **Check `refs.bib`** against the physical books (publisher cities, editions). The Wikipedia-sourced photos of the slides were excluded; if you want them back you need the licence/permission text and a credit line next to each figure.
5. The **Thai** parts of the criteria (e.g., Thai preface or Thai/English glossary) are not included because you chose a fully English book.

## Corrections made to the lecture content (please also fix the slides)

* **Lecture 6, JK synthesis of the 101 detector:** the slide gives `K_A = x`; the slide's own excitation table requires `K_A = 1` (state 10 must return to 00 for both inputs). The circuit figure `lect_6_sequence_detector_jk_circuit` draws the same error and is **not used**.
* **Lecture 6, structural VHDL of the detector:** instantiates `d_ff` with a `rst` port that the `d_ff` on the previous slide does not have → book uses a matching `d_ff_r`.
* **Lecture 9, if-then-else control unit:** the state-assignment line (`S_notequal=010`, `S_equal=011`) and the equations (`Muxsel = Q0`) agree, but the output table has the two names swapped (`S_equal`: Muxsel 0). The book uses the consistent version (Muxsel = 1 selects the constant 8).
* **Lecture 7:** the counter function table uses an active-low `Clear` while the VHDL uses an active-high `CLR`; the book follows the VHDL.
* **Lecture 8/9:** the “Mealy elevator” and the sum-1-to-10 control-word table were ambiguous; the book defines its own explicit versions.
* **Lecture 10:** the EC-1 vs EC-2 table says EC-1 has “no memory”, but EC-1 has a 16-word ROM; corrected.
* VHDL in `listings/ch08_oneshot_mealy.vhd` lacked `end Behavioral;` and several listings lacked library clauses (added).

## Figures that were replaced

Datapath pictures that exist in the repository only as PNG and appear to come from a textbook (`lect_9_datapath_*.png`,
`lect_9_gcd_datapath.png`, `lect_10_ec1_datapath.png`, `lect_10_ec-2_datapath.png`, …) were **redrawn in TikZ** (Chapters 9 and 10) or replaced by
your own TikZ sources. Photos of people, historic hardware and chips (`lect_1_*.jpg`, Boole, Shannon, …) were replaced by timeline/graph drawings made for the book.

## Not verified here

No VHDL simulator was available in this environment, so the listings (taken from your slides/`vhdl/`) were not re-simulated; the equations and tables in the text were checked by hand.
