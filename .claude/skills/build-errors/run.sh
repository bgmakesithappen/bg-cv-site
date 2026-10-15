#!/usr/bin/env bash
set -uo pipefail
cd "$(git rev-parse --show-toplevel)" || exit 1
export CI=1
log=$(mktemp) || exit 1
out=$(mktemp) || exit 1
trap 'rm -f "$log" "$out"' EXIT
hugo build --gc --minify --renderToMemory "$@" > "$log" 2>&1
rc=$?
root=$(pwd)
# Hugo reports locations as "/abs/path/file:line:col": message; rewrite to file:line: message.
grep -E '^(ERROR|WARN|Error)' "$log" \
  | sed -E -e "s|$root/||g" \
        -e 's/^(ERROR|WARN|Error:)[[:space:]]*//' \
        -e 's/^.*"([^"]*):([0-9]+):[0-9]+": *(.*)$/\1:\2: \3/' \
  | sort -u > "$out"
n=$(grep -c '' "$out")
head -n 50 "$out"
echo "Total: $n"
exit $rc
