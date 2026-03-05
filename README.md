# crux.github.io

Personal blog of [Dirk Lüsebrink](http://sebrink.de), built with Jekyll 4 and hosted on GitHub Pages.

## Local development

```bash
make install   # install dependencies (first time / after Gemfile changes)
make serve     # live preview at http://localhost:4000
make drafts    # same, but includes _drafts/
```

## Publishing

Commit and push to `main` — GitHub Actions builds and deploys automatically.

```bash
git add .
git commit -m "your message"
git push origin main
```

## Writing

- **Posts:** add a file to `_posts/` named `YYYY-MM-DD-title.md` with front matter
- **Drafts:** work in `_drafts/` (no date prefix needed), preview with `make drafts`
- **Projects:** add a file to `_projects/`
