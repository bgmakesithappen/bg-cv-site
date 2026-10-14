#!/usr/bin/env bash
set -uo pipefail
cd "$(git rev-parse --show-toplevel)" || exit 1
out=$(mktemp) || exit 1
trap 'rm -f "$out"' EXIT
(
  echo "## Entry points"
  for f in hugo.toml package.json vercel.json layouts/index.html assets/css/site.css; do
    [ -e "$f" ] && echo "$f"
  done
  echo "## Top-level dirs"
  for d in */; do
    d=${d%/}
    case "$d" in
      content) p="Markdown source pages (content/en/)" ;;
      data) p="Hugo data files used by templates" ;;
      layouts) p="template overrides; take precedence over the theme" ;;
      static) p="static assets served at site root" ;;
      assets) p="Hugo Pipes inputs (Tailwind CSS, icons)" ;;
      themes) p="hugo-noir theme; do not edit, override in layouts/" ;;
      node_modules|public|resources) continue ;;
      *) p="(no description)" ;;
    esac
    echo "$d: $p"
  done
  echo "## Files (depth 3; themes/ collapsed)"
  find . -maxdepth 3 \
    \( -name .git -o -name node_modules -o -name vendor -o -name dist -o -name build -o -name target -o -name .venv \
       -o -path ./public -o -path ./resources -o -path './themes/*' \) -prune -o \
    ! -name '*.lock' ! -name 'package-lock.json' -print | sed 's|^\./||' | grep -v '^\.$' | sort
  frc=${PIPESTATUS[0]}
  exit "$frc"
) > "$out" 2>&1
rc=$?
head -n 80 "$out"
exit $rc
