---
name: wheee:pause-work
description: Context-Handoff beim Pausieren
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
---

<objective>
Create a context handoff document so work can be resumed later (by any Claude session).
</objective>

<process>
1. Read current `.planning/STATE.md` and active phase files.
2. Create/update a HANDOFF document with:
   - Current status: what was being worked on.
   - What is done and what remains.
   - Any open decisions or blockers.
   - Files that were being modified.
   - Next steps when resuming.
3. Update `.planning/STATE.md` with paused status.
4. Report the handoff summary.
</process>
