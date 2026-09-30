---
name: build-errors
description: Runs `hugo build` and prints deduplicated file:line errors with a total count. Use instead of running the build or typechecker directly.
---
Run: `bash .claude/skills/build-errors/run.sh`
Output: Deduplicated `file:line: message` lines, then total error count.
Fall back to the raw command only if this output is insufficient to diagnose.
