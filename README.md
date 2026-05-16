# CV — GitHub Pages

[![Build CV](https://github.com/pprimor/cv/actions/workflows/build-cv.yml/badge.svg)](https://github.com/pprimor/cv/actions/workflows/build-cv.yml)

Static site that displays [Pedro Primor](https://pprimor.github.io/cv/)’s résumé as an embedded PDF, with an **EN** / **PT** language switcher.

**Live site:** [https://pprimor.github.io/cv/](https://pprimor.github.io/cv/)

## Repository layout

| File | Purpose |
|------|---------|
| `cv_en.tex` | LaTeX source (English) |
| `cv_pt.tex` | LaTeX source (European Portuguese) |
| `CV.pdf` | Built English résumé (default on the site) |
| `CV_pt.pdf` | Built Portuguese résumé |
| `index.html` | Landing page; EN/PT toggle embeds `CV.pdf` or `CV_pt.pdf` |
| `cover_letter.pdf` | Optional asset (not linked from the homepage) |
| `_config.yml` | Jekyll theme for GitHub Pages (`jekyll-theme-minimal`) |
| `Makefile` | Build both PDFs from `cv_en.tex` and `cv_pt.tex` |

## Prerequisites (macOS + BasicTeX)

Install a minimal TeX distribution and the packages used by the CV sources:

```bash
brew install --cask basictex
eval "$(/usr/libexec/path_helper)"   # or open a new terminal

# sudo does not inherit /Library/TeX/texbin — use the full path or env PATH=...
sudo /Library/TeX/texbin/tlmgr update --self
sudo /Library/TeX/texbin/tlmgr install latexmk \
  preprint tools hyperref pdftex babel-english babel-portuges xcolor \
  enumitem titlesec fancyhdr marvosym ragged2e footmisc \
  fontawesome collection-fontsrecommended
```

`tabularx` lives in the `tools` package (there is no separate `tlmgr install tabularx`). `fullpage.sty` comes from `preprint`. If the first build still fails, install the name from the log, e.g. `sudo /Library/TeX/texbin/tlmgr install preprint`.

## Build from source

```bash
make cv          # both PDFs
make cv-en       # cv_en.tex → CV.pdf only
make cv-pt       # cv_pt.tex → CV_pt.pdf only
open CV.pdf      # macOS
open CV_pt.pdf
```

`make` and `make cv` are equivalent. `make clean` removes LaTeX intermediates and both PDFs; run `make cv` again to regenerate.

## Update the CV

| Path | What you do | What CI does |
|------|-------------|--------------|
| **Pull request** | Edit `cv_en.tex` and/or `cv_pt.tex`, run `make cv`, commit matching PDF(s) | Fails if `CV.pdf` or `CV_pt.pdf` ≠ build output, or either PDF is not exactly **1 page** |
| **Push to `main`** | May commit `.tex` only | Rebuilds and commits `CV.pdf` and `CV_pt.pdf` if needed |

1. Edit `cv_en.tex` and/or `cv_pt.tex` (keep structure in sync when both languages should match).
2. Run `make cv` and spot-check both PDFs (header icons, links, one page each).
3. Commit and push (see table above).
4. After GitHub Pages rebuilds (usually 1–3 minutes), verify [https://pprimor.github.io/cv/](https://pprimor.github.io/cv/) and toggle EN/PT. Use a hard refresh if a PDF looks cached.

Prefer a branch and pull request for non-trivial edits:

```bash
git checkout -b update-cv
# edit cv_en.tex and/or cv_pt.tex, then make cv
git add cv_en.tex cv_pt.tex CV.pdf CV_pt.pdf
git commit -m "Update CV"
git push -u origin update-cv
gh pr create --web
```

## Local preview

**PDF only**

```bash
open CV.pdf          # macOS
open CV_pt.pdf
```

**Homepage (iframe + language toggle)**

```bash
python3 -m http.server 8080
# http://localhost:8080/index.html
```

Run `make cv` before committing if you changed either `.tex` file so the embedded PDFs match the sources.

**Jekyll (closer to GitHub Pages)**

```bash
gem install bundler jekyll
jekyll serve
```

## Deployment

Pushes to `main` trigger a [GitHub Pages](https://docs.github.com/pages) build (Jekyll, legacy). The [Build CV](https://github.com/pprimor/cv/actions/workflows/build-cv.yml) workflow keeps `CV.pdf` and `CV_pt.pdf` in sync with the LaTeX sources on `main`; Pages serves the committed PDFs plus `index.html`. No database or application server in this repo.

`CV.pdf` remains the canonical English URL for bookmarks and external links. Portuguese is available at `CV_pt.pdf` and via the site toggle.

If you add branch protection on `main`, allow `github-actions[bot]` to push (or exempt its `[skip ci]` commits) so auto-rebuilt PDFs can land after tex-only merges.

## Troubleshooting

- **PR failed on PDF drift** — CI rebuilt one or both PDFs and they did not match your branch. Run `make cv` locally, commit the updated `CV.pdf` and/or `CV_pt.pdf`, and push.
- **PR failed on page count** — Each PDF must be exactly one page. Trim content or spacing in the relevant `.tex` file, run `make cv`, and verify with `pdfinfo CV.pdf CV_pt.pdf | awk '/^Pages:/'`.
- **PDF does not update on the site** — Wait for the Pages build, then hard-refresh or try a private window.
- **Iframe blank in some browsers** — Open [CV.pdf](https://pprimor.github.io/cv/CV.pdf) or [CV_pt.pdf](https://pprimor.github.io/cv/CV_pt.pdf) directly; the embed uses same-origin relative paths, not Google Docs viewer.
- **Wrong repo in links** — Remote and Pages URL use `pprimor/cv`; keep GitHub URLs in docs aligned with that.
- **`tlmgr: command not found` under sudo** — Use `sudo /Library/TeX/texbin/tlmgr …` (sudo resets `PATH`).
- **`latexmk` or `pdflatex` not found** — Run `eval "$(/usr/libexec/path_helper)"` or open a new terminal; install `latexmk` with `tlmgr` as above.
