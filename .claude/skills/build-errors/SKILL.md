---
name: build-errors
description: Runs `hugo build --gc --minify` in memory and prints deduplicated `file:line: message` errors and warnings, then a total count. Use instead of running the build or typechecker directly.
---
Run: `bash .claude/skills/build-errors/run.sh [args]`
Output: deduplicated `file:line: message` lines (max 50), then `Total: N`.
Fall back to the raw command only if this output is insufficient to diagnose.
