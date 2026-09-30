# CLAUDE.md

## Project
Hugo static site deployed via Vercel at bengregory.me. Theme: `hugo-noir` (in `themes/`).

## Architecture
- `content/en/` — Markdown source pages
- `layouts/` — Template overrides (take precedence over theme)
- `static/` — Static assets served at site root
- `hugo.toml` — Site config (base URL, params, PostHog analytics, menu)
- `vercel.json` — Deployment config

## Conventions
- Override theme templates in `layouts/` rather than editing `themes/hugo-noir/` directly.
- PostHog API key is read from `HUGO_POSTHOG_API_KEY` env var; never hardcode it.
- `relativeURLs = true` and `canonifyURLs = true` are set; keep all links relative.

## Forbidden
- Do not edit files under `themes/hugo-noir/` — override in `layouts/` instead.
- Do not commit `public/` or `resources/` (generated output).
- Do not hardcode secrets or API keys.

## Tooling
- Use the skills test-failures, build-errors, lint-summary, repo-map, diff-summary instead of raw commands.
- Delegate codebase exploration to the scout agent instead of reading files directly.
