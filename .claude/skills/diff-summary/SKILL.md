---
name: diff-summary
description: Prints `git diff --stat` against a base ref (default origin/main) plus changed Hugo template defines, TOML tables and Markdown headings per file. Use instead of reading full diffs.
---
Run: `bash .claude/skills/diff-summary/run.sh [args]`
Output: diffstat, then `file: name, name` lines for changed sections (max 60 lines).
Fall back to the raw command only if this output is insufficient to diagnose.
