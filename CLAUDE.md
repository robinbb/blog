# CLAUDE.md

## Project Overview

This is the source for Robin Bate Boerop's personal blog and professional
website at https://robinbb.com. It is a Hugo static site deployed to Netlify.

## Tech Stack

- **Hugo** static site generator (TOML config)
- **Netlify** for hosting and deployment
- **Nix flake** dev environment (`flake.nix` provides `hugo` and `netlify-cli`)

## Repository Layout

```
src/hugo/           Hugo project root
  config.toml       Site configuration
  content/          Markdown content (blog posts, pages)
  layouts/          HTML templates and partials
  theme-src/        Custom theme source (has its own build script)
  data/             Data files (asset manifests)
build               Shell script: builds theme then runs Hugo
deploy              Shell script: runs `netlify deploy --prod`
netlify.toml        Netlify build and redirect config
flake.nix           Nix flake development environment
```

## Building

```sh
./build
```

This builds the theme from `src/hugo/theme-src/` and then runs Hugo. Output
goes to `src/hugo/public/`.

## Development Workflow

- **Trunk-based development**: no branches, just commits on `main`.
- Netlify does **not** auto-deploy. After pushing, run `./deploy` to deploy.

## Git Commits

- Never add "Co-Authored-By" lines or any other Claude/AI mentions to commit messages.
