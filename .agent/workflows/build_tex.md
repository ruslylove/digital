---
description: Build a TeX file to SVG using latex and dvisvgm
---

1. Ask the user which TeX file to build if not specified.
2. Change directory to `tex`.
// turbo
3. Run `latex <filename>.tex`
// turbo
4. Run `dvisvgm --no-fonts <filename>.dvi -o ../public/<filename>.svg`
