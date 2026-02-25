---
name: wheee:quick
description: Schnelle Aufgabe mit GSD-Garantien
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - WebFetch
  - WebSearch
---

<objective>
Execute a quick task with GSD guarantees — no full phase planning needed, but still follows protocol discipline.
</objective>

<process>
1. Read `.planning/STATE.md` to understand current context.
2. Assess the task: Is it truly small (< 5 changes, low risk, no architectural impact)?
3. If yes — proceed with Fast-Track:
   - Implement the change.
   - Verify it works (tests, lint).
   - Document in `project/process-journal.md`.
4. If no — inform the user this needs a proper phase and suggest `/wheee:plan-phase`.
5. Update `.planning/STATE.md` if relevant.
</process>
