---
name: wheee:add-phase
description: Neue Phase am Ende der Roadmap hinzufuegen
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
---

<objective>
Add a new phase at the end of the current roadmap.
</objective>

<process>
1. Read `.planning/ROADMAP.md` to determine the next phase number.
2. Ask the user for the phase name and goal (if not provided).
3. Create directory `.planning/phases/XX-name/`.
4. Create initial context file `.planning/phases/XX-name/XX-00-CONTEXT.md`.
5. Update `.planning/ROADMAP.md` with the new phase entry.
6. Report the new phase and suggest next steps (`/wheee:discuss-phase` or `/wheee:plan-phase`).
</process>
