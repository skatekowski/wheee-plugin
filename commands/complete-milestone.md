---
name: wheee:complete-milestone
description: Milestone archivieren
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
---

<objective>
Archive the completed milestone and prepare for the next cycle.
</objective>

<process>
1. Verify milestone audit passed (run `/wheee:audit-milestone` if not done).
2. Create milestone archive summary in `.planning/`.
3. Update `project/changelog.md` with milestone achievements.
4. Update `project/process-journal.md` with lessons learned.
5. Update `.planning/STATE.md` to reflect milestone completion.
6. Report completion and suggest `/wheee:new-milestone` for the next cycle.
</process>
