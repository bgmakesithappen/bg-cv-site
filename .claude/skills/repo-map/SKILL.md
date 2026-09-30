---
name: repo-map
description: Prints tree to depth 3 (excluding generated/vendor dirs), entry points, and a one-line purpose per top-level dir. Use before exploring an unfamiliar area of the repo.
---
Run: `bash .claude/skills/repo-map/run.sh`
Output: Depth-3 tree, entry points, and annotated top-level directory purposes.
Fall back to the raw command only if this output is insufficient to diagnose.
