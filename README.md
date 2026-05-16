# CV — GitHub Pages

[![Build CV](https://github.com/pprimor/cv/actions/workflows/build-cv.yml/badge.svg)](https://github.com/pprimor/cv/actions/workflows/build-cv.yml)

Static site that displays [Pedro Primor](https://pprimor.github.io/cv/)’s résumé as an embedded PDF.

**Live site:** [https://pprimor.github.io/cv/](https://pprimor.github.io/cv/)

## Repository layout

| File | Purpose |
|------|---------|
| `cv_en.tex` | LaTeX source for the résumé |
| `CV.pdf` | Built résumé shown on the site (`make cv` from `cv_en.tex`) |
| `index.html` | Landing page; embeds `CV.pdf` in a full-page iframe |
| `cover_letter.pdf` | Optional asset (not linked from the homepage) |
| `_config.yml` | Jekyll theme for GitHub Pages (`jekyll-theme-minimal`) |
| `Makefile` | Build `CV.pdf` from `cv_en.tex` |

## Prerequisites (macOS + BasicTeX)

Install a minimal TeX distribution and the packages used by `cv_en.tex`:

```bash
brew install --cask basictex
eval "$(/usr/libexec/path_helper)"   # or open a new terminal

# sudo does not inherit /Library/TeX/texbin — use the full path or env PATH=...
sudo /Library/TeX/texbin/tlmgr update --self
sudo /Library/TeX/texbin/tlmgr install latexmk \
  preprint tools hyperref babel-english xcolor \
  enumitem titlesec fancyhdr marvosym ragged2e footmisc \
  fontawesome collection-fontsrecommended
```

`tabularx` and `multicol` live in the `tools` package (there is no separate `tlmgr install tabularx`). `fullpage.sty` comes from `preprint`. If the first build still fails, install the name from the log, e.g. `sudo /Library/TeX/texbin/tlmgr install preprint`.

## Build from source

```bash
make cv          # cv_en.tex → CV.pdf
open CV.pdf      # macOS
```

`make` and `make cv` are equivalent. `make clean` removes LaTeX intermediates and `CV.pdf`; run `make cv` again to regenerate the PDF.

## Update the CV

| Path | What you do | What CI does |
|------|-------------|--------------|
| **Pull request** | Edit `cv_en.tex`, run `make cv`, commit **both** files | Fails if `CV.pdf` ≠ build output |
| **Push to `main`** | May commit `cv_en.tex` only | Rebuilds and commits `CV.pdf` if needed |

1. Edit `cv_en.tex`.
2. Run `make cv` and spot-check `CV.pdf` (header icons and links).
3. Commit and push (see table above).
4. After GitHub Pages rebuilds (usually 1–3 minutes), verify [https://pprimor.github.io/cv/](https://pprimor.github.io/cv/). Use a hard refresh if the PDF looks cached.

Prefer a branch and pull request for non-trivial edits:

```bash
git checkout -b update-cv
# edit cv_en.tex, then make cv
git add cv_en.tex CV.pdf
git commit -m "Update CV"
git push -u origin update-cv
gh pr create --web
```

## Local preview

**PDF only**

```bash
open CV.pdf          # macOS
```

**Homepage (iframe)**

```bash
python3 -m http.server 8080
# http://localhost:8080/index.html
```

Run `make cv` before committing if you changed `cv_en.tex` so the embedded PDF matches the source.

**Jekyll (closer to GitHub Pages)**

```bash
gem install bundler jekyll
jekyll serve
```

## Deployment

Pushes to `main` trigger a [GitHub Pages](https://docs.github.com/pages) build (Jekyll, legacy). The [Build CV](https://github.com/pprimor/cv/actions/workflows/build-cv.yml) workflow keeps `CV.pdf` in sync with `cv_en.tex` on `main`; Pages serves the committed PDF plus `index.html`. No database or application server in this repo.

If you add branch protection on `main`, allow `github-actions[bot]` to push (or exempt its `[skip ci]` commits) so auto-rebuilt PDFs can land after tex-only merges.

## Troubleshooting

- **PR failed on PDF drift** — CI rebuilt `CV.pdf` and it did not match your branch. Run `make cv` locally, commit the updated `CV.pdf`, and push.
- **PDF does not update on the site** — Wait for the Pages build, then hard-refresh or try a private window.
- **Iframe blank in some browsers** — Open [CV.pdf](https://pprimor.github.io/cv/CV.pdf) directly; the embed uses a same-origin relative path, not Google Docs viewer.
- **Wrong repo in links** — Remote and Pages URL use `pprimor/cv`; keep GitHub URLs in docs aligned with that.
- **`tlmgr: command not found` under sudo** — Use `sudo /Library/TeX/texbin/tlmgr …` (sudo resets `PATH`).
- **`latexmk` or `pdflatex` not found** — Run `eval "$(/usr/libexec/path_helper)"` or open a new terminal; install `latexmk` with `tlmgr` as above.
