---
description: Build a TeX file to SVG using latex and dvisvgm
---

1. Ask the user for the TeX file basename (e.g., `my_file` for `my_file.tex`) if not provided.
2. Change directory to `tex`.
// turbo
3. Run `latex -interaction=nonstopmode <basename>.tex`
// turbo
4. Run `dvisvgm --no-fonts <basename>.dvi -o ../public/<basename>.svg`
