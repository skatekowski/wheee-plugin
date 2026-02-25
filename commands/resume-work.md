---
name: wheee:resume-work
description: Arbeit mit Kontext fortsetzen
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

<objective>
Resume work by loading context from the handoff document and project state.
</objective>

<process>
1. Read `.planning/STATE.md` for current status.
2. Look for HANDOFF documents in `.planning/`.
3. Read current phase PLAN.md and any partial SUMMARY.
4. Read `project/process-journal.md` for recent entries.
5. Report:
   - Where work was paused.
   - What remains to be done.
   - Suggested next action with the appropriate `/wheee:` command.
</process>
