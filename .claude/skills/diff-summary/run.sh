#!/usr/bin/env bash
set -uo pipefail

BASE=${1:-origin/main}

echo "=== Diff stat vs $BASE ==="
git diff --stat "$BASE...HEAD" | head -50

echo ""
echo "=== Changed files ==="
changed_files=$(git diff --name-only "$BASE...HEAD")

if [ -z "$changed_files" ]; then
  echo "No changed files."
  exit 0
fi

echo "$changed_files" | while read -r file; do
  if [ -f "$file" ]; then
    # Extract function/template definitions for common file types
    case "$file" in
      *.html|*.gohtml)
        symbols=$(grep -n 'define\|block\|template\|{{-\? *define' "$file" 2>/dev/null | head -5 || true)
        ;;
      *.toml|*.yaml|*.yml)
        symbols=$(grep -n '^\[' "$file" 2>/dev/null | head -5 || true)
        ;;
      *.md)
        symbols=$(grep -n '^#' "$file" 2>/dev/null | head -5 || true)
        ;;
      *)
        symbols=""
        ;;
    esac
    echo "$file"
    [ -n "$symbols" ] && echo "$symbols" | sed 's/^/  /'
  fi
done | head -60
