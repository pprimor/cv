export PATH := /Library/TeX/texbin:$(PATH)

TEX_EN := cv_en.tex
TEX_PT := cv_pt.tex
PDF_EN := CV.pdf
PDF_PT := CV_pt.pdf

.PHONY: all cv cv-en cv-pt clean

all: cv

cv: cv-en cv-pt

cv-en: $(PDF_EN)

cv-pt: $(PDF_PT)

$(PDF_EN): $(TEX_EN)
	latexmk -pdf -interaction=nonstopmode -jobname=CV $(TEX_EN)

$(PDF_PT): $(TEX_PT)
	latexmk -pdf -interaction=nonstopmode -jobname=CV_pt $(TEX_PT)

clean:
	latexmk -c -jobname=CV $(TEX_EN)
	latexmk -c -jobname=CV_pt $(TEX_PT)
	rm -f $(PDF_EN) $(PDF_PT)
