# Build the textbook:   make           (figures + book)
#                       make book      (book only, figures already built)
#                       make figures   (re-compile TikZ figures from ../tex)
#                       make clean
BOOK = main
OUT  = Digital_Circuits_and_Microprocessor_Fundamentals.pdf

all: figures book

figures:
	./build_figures.sh

book:
	mkdir -p build/frontmatter build/chapters build/backmatter
	latexmk -xelatex $(BOOK).tex
	cp build/$(BOOK).pdf $(OUT)

clean:
	latexmk -C $(BOOK).tex
	rm -rf build

.PHONY: all figures book clean
