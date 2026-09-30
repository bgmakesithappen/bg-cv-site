#!/usr/bin/env bash
set -uo pipefail

echo "=== Repo Map (depth 3) ==="
find . -maxdepth 3 \
  -not -path './.git*' \
  -not -path './node_modules*' \
  -not -path './vendor*' \
  -not -path './dist*' \
  -not -path './build*' \
  -not -path './target*' \
  -not -path './.venv*' \
  -not -path './public*' \
  -not -path './resources*' \
  -not -name '*.lock' \
  -not -name 'package-lock.json' \
  | sort | head -80

echo ""
echo "=== Entry Points ==="
echo "hugo.toml        - Hugo site configuration (base URL, theme, params)"
echo "content/         - Markdown source for all site pages"
echo "layouts/         - Hugo HTML templates (override theme defaults)"
echo "themes/hugo-noir - Theme templates and static assets"
echo "static/          - Static files served at site root"
echo "vercel.json      - Vercel deployment configuration"

echo ""
echo "=== Top-level Directories ==="
echo "content/   Source content (Markdown) for all site pages"
echo "data/      Hugo data files (YAML/JSON/TOML) used in templates"
echo "layouts/   Template overrides for Hugo rendering"
echo "static/    Static assets (images, CSS, JS) copied to output root"
echo "themes/    Hugo theme(s) providing base layouts and styles"
