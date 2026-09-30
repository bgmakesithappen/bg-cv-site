---
name: diff-summary
description: Runs `git diff --stat` vs origin/main and lists changed function/class names per file. Use instead of reading full diffs.
---
Run: `bash .claude/skills/diff-summary/run.sh [base-ref]`
Output: `git diff --stat` output plus changed symbols per file, capped at 60 lines.
Fall back to the raw command only if this output is insufficient to diagnose.
