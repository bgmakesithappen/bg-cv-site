#!/usr/bin/env bash
set -uo pipefail

output=$(hugo build 2>&1) || true
exit_code=$?

echo "$output" \
  | grep -E '(ERROR|error|WARN|warn|failed)' \
  | sort -u \
  | head -50

count=$(echo "$output" | grep -cE '(ERROR|error|failed)' || true)
echo ""
echo "Total errors: $count"

exit $exit_code
