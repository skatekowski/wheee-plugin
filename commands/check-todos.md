---
name: wheee:check-todos
description: Offene Todos anzeigen
allowed-tools:
  - Read
  - Glob
  - Grep
---

<objective>
Show all open todos from project planning files.
</objective>

<process>
1. Search for unchecked items (`- [ ]`) in:
   - `.planning/ROADMAP.md`
   - `.planning/STATE.md`
   - `.planning/phases/*/PLAN.md`
   - `project/task_plan.md`
2. Group by phase/area.
3. Report all open todos with their source location.
</process>
