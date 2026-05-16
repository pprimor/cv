export PATH := /Library/TeX/texbin:$(PATH)

TEX_SOURCE := cv_en.tex
PDF_OUTPUT := CV.pdf

.PHONY: all cv clean

all: cv

cv: $(PDF_OUTPUT)

$(PDF_OUTPUT): $(TEX_SOURCE)
	latexmk -pdf -interaction=nonstopmode -jobname=CV $(TEX_SOURCE)

clean:
	latexmk -c -jobname=CV $(TEX_SOURCE)
	rm -f $(PDF_OUTPUT)
