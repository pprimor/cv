# CV — Cloudflare Pages

[![Build CV](https://github.com/pprimor/cv/actions/workflows/build-cv.yml/badge.svg)](https://github.com/pprimor/cv/actions/workflows/build-cv.yml)

Static site that displays [Pedro Primor](https://cv.primor.me/)’s résumé as an embedded PDF, with an **EN** / **PT** language switcher.

**Live site:** [https://cv.primor.me/](https://cv.primor.me/)

## Repository layout

| File | Purpose |
|------|---------|
| `cv_en.tex` | LaTeX source (English) |
| `cv_pt.tex` | LaTeX source (European Portuguese) |
| `CV.pdf` | Built English résumé (default on the site) |
| `CV_pt.pdf` | Built Portuguese résumé |
| `index.html` | Landing page; EN/PT toggle embeds `CV.pdf` or `CV_pt.pdf` |
| `cover_letter.pdf` | Optional asset (not linked from the homepage) |
| `scripts/build-site.sh` | Packages static assets into `dist/` for Cloudflare Pages |
| `Makefile` | Build PDFs (`make cv`) and site bundle (`make site`) |

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
make site        # dist/ for Cloudflare Pages (run after make cv if .tex changed)
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
4. After Cloudflare Pages redeploys (usually 1–2 minutes), verify [https://cv.primor.me/](https://cv.primor.me/) and toggle EN/PT. Use a hard refresh if a PDF looks cached.

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

**Homepage (iframe + language toggle, matches production layout)**

```bash
make site
python3 -m http.server 8080 --directory dist
# http://localhost:8080/
```

Run `make cv` before `make site` if you changed either `.tex` file so the embedded PDFs match the sources.

## Deployment

Hosting is [Cloudflare Pages](https://developers.cloudflare.com/pages/) on **`cv.primor.me`**. Apex `primor.me` is not served by this project.

### One-time Cloudflare setup

1. In Cloudflare: **Workers & Pages** → **Create** → **Pages** → **Connect to Git** → `pprimor/cv`.
2. Build settings (production branch `main`):

   | Setting | Value |
   |---------|--------|
   | Framework preset | None |
   | Build command | `bash scripts/build-site.sh` |
   | Build output directory | `dist` |

3. Deploy once and confirm the `*.pages.dev` preview serves `index.html` and both PDFs.
4. **Custom domains** → add **`cv.primor.me`** (CNAME `cv` → your Pages hostname). Do not attach apex `primor.me` or `www` to this project.
5. Disable [GitHub Pages](https://github.com/pprimor/cv/settings/pages) for this repo after cutover.

Pushes to `main` trigger a Pages deploy. The [Build CV](https://github.com/pprimor/cv/actions/workflows/build-cv.yml) workflow keeps `CV.pdf` and `CV_pt.pdf` in sync with the LaTeX sources; Pages serves the packaged static files. No database or application server in this repo.

`CV.pdf` remains the canonical English URL for bookmarks and external links (`https://cv.primor.me/CV.pdf`). Portuguese is available at `CV_pt.pdf` and via the site toggle.

If you add branch protection on `main`, allow `github-actions[bot]` to push (or exempt its `[skip ci]` commits) so auto-rebuilt PDFs can land after tex-only merges.

## Troubleshooting

- **PR failed on PDF drift** — CI rebuilt one or both PDFs and they did not match your branch. Run `make cv` locally, commit the updated `CV.pdf` and/or `CV_pt.pdf`, and push.
- **PR failed on page count** — Each PDF must be exactly one page. Trim content or spacing in the relevant `.tex` file, run `make cv`, and verify with `pdfinfo CV.pdf CV_pt.pdf | awk '/^Pages:/'`.
- **PDF does not update on the site** — Wait for the Pages deploy, then hard-refresh or try a private window.
- **Iframe blank in some browsers** — Open [CV.pdf](https://cv.primor.me/CV.pdf) or [CV_pt.pdf](https://cv.primor.me/CV_pt.pdf) directly; the embed uses same-origin relative paths, not Google Docs viewer.
- **Wrong repo in links** — Remote uses `pprimor/cv`; keep GitHub URLs in docs aligned with that.
- **`tlmgr: command not found` under sudo** — Use `sudo /Library/TeX/texbin/tlmgr …` (sudo resets `PATH`).
- **`latexmk` or `pdflatex` not found** — Run `eval "$(/usr/libexec/path_helper)"` or open a new terminal; install `latexmk` with `tlmgr` as above.
