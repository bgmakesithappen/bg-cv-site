#!/usr/bin/env bash
set -uo pipefail
cd "$(git rev-parse --show-toplevel)" || exit 1
base=${1:-origin/main}
out=$(mktemp) || exit 1
trap 'rm -f "$out"' EXIT
git diff --stat "$base"...HEAD > "$out" 2>&1
rc=$?
if [ "$rc" -eq 0 ]; then
  echo "## Changed sections" >> "$out"
  # Hunk-header context plus added/removed define/block names, TOML tables and Markdown headings.
  git diff -U0 --no-color "$base"...HEAD | awk '
    /^\+\+\+ / { file = substr($0, 7); next }
    /^@@/ { sub(/^@@[^@]*@@ ?/, ""); if ($0 != "") add(file, $0); next }
    /^[+-]/ && match($0, /\{\{-? *(define|block) +"[^"]+"/) { t = substr($0, RSTART, RLENGTH); sub(/"$/, "", t); sub(/.*"/, "", t); add(file, t); next }
    /^[+-]\[/ { s = substr($0, 2); sub(/[[:space:]]*(#.*)?$/, "", s); add(file, s); next }
    /^[+-]#+ / { s = substr($0, 2); add(file, s); next }
    function add(f, n) { if (index(seen[f], "\034" n "\034") == 0) { seen[f] = seen[f] "\034" n "\034"; names[f] = names[f] ", " n } }
    END { for (f in names) print f ": " substr(names[f], 3) }
  ' | cut -c1-200 | sort >> "$out"
fi
head -n 60 "$out"
exit $rc
