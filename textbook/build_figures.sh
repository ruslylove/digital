#!/usr/bin/env bash
# Compile every standalone TikZ/circuitikz figure in ../tex to a PDF in ./figures
# (the sources in ../tex are never modified; all intermediates go to ./build_aux).
# Usage: ./build_figures.sh            # build everything that is out of date
#        ./build_figures.sh lect_3_*   # build selected basenames
set -u
cd "$(dirname "$0")"
python3 patch_figures.py
SRC=figsrc
OUT=figures
AUX=build_aux
mkdir -p "$OUT" "$AUX"

if [ $# -gt 0 ]; then
  list=$(for p in "$@"; do ls "$SRC"/$p.tex 2>/dev/null; done)
else
  list=$(ls "$SRC"/*.tex | grep -v -E '/(live\.main)\.tex$')
fi

build_one() {
  f="$1"; b=$(basename "$f" .tex)
  if [ -f "figures/$b.pdf" ] && [ "figures/$b.pdf" -nt "$f" ]; then return 0; fi
  mkdir -p "build_aux/$b"
  if TEXINPUTS="figsrc:../tex:" pdflatex -interaction=nonstopmode -halt-on-error \
       -output-directory="build_aux/$b" "$f" >"build_aux/$b/log.txt" 2>&1; then
    cp "build_aux/$b/$b.pdf" "figures/$b.pdf"
  else
    echo "FAILED: $b"
  fi
}
export -f build_one
echo "$list" | xargs -n1 -P 8 -I{} bash -c 'build_one {}'
echo "figures built: $(ls figures/*.pdf 2>/dev/null | wc -l)"
