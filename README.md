# CV — GitHub Pages

Static site that displays [Pedro Primor](https://pprimor.github.io/cv/)’s résumé as an embedded PDF.

**Live site:** [https://pprimor.github.io/cv/](https://pprimor.github.io/cv/)

## Repository layout

| File | Purpose |
|------|---------|
| `CV.pdf` | Résumé shown on the site (update this to publish changes) |
| `index.html` | Landing page; embeds `CV.pdf` in a full-page iframe |
| `cover_letter.pdf` | Optional asset (not linked from the homepage) |
| `_config.yml` | Jekyll theme for GitHub Pages (`jekyll-theme-minimal`) |

## Update the CV

1. Replace or edit `CV.pdf` (keep the filename unless you also change `index.html`).
2. Commit and push to `main`.
3. After GitHub Pages rebuilds (usually 1–3 minutes), verify [https://pprimor.github.io/cv/](https://pprimor.github.io/cv/). Use a hard refresh if the PDF looks cached.

Prefer a branch and pull request for non-trivial edits:

```bash
git checkout -b update-cv
git add CV.pdf
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

**Jekyll (closer to GitHub Pages)**

```bash
gem install bundler jekyll
jekyll serve
```

## Deployment

Pushes to `main` trigger a [GitHub Pages](https://docs.github.com/pages) build (Jekyll, legacy). No CI, database, or application server in this repo.

## Troubleshooting

- **PDF does not update on the site** — Wait for the Pages build, then hard-refresh or try a private window.
- **Iframe blank in some browsers** — Open [CV.pdf](https://pprimor.github.io/cv/CV.pdf) directly; the embed uses a same-origin relative path, not Google Docs viewer.
- **Wrong repo in links** — Remote and Pages URL use `pprimor/cv`; keep GitHub URLs in docs aligned with that.
