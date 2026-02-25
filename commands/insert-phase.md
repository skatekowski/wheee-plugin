---
name: wheee:insert-phase
description: Dringende Phase zwischen bestehenden einfuegen
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
---

<objective>
Insert an urgent phase between existing phases, renumbering subsequent phases.
</objective>

<process>
1. Read `.planning/ROADMAP.md` to understand current phase structure.
2. Ask the user where to insert and what the phase covers (if not provided).
3. Renumber subsequent phase directories and files.
4. Create new phase directory `.planning/phases/XX-name/`.
5. Update `.planning/ROADMAP.md` with the inserted phase.
6. Update `.planning/STATE.md` if needed.
7. Report changes and suggest next steps.
</process>
