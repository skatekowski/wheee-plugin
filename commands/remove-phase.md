---
name: wheee:remove-phase
description: "Phase entfernen und folgende neu nummerieren (remove-phase [N])"
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
---

<objective>
Remove a phase and renumber all following phases.
</objective>

<process>
1. Read `.planning/ROADMAP.md` to identify the phase to remove.
2. Confirm with the user before deleting.
3. Archive or remove the phase directory.
4. Renumber subsequent phase directories and their files.
5. Update `.planning/ROADMAP.md` and `.planning/STATE.md`.
6. Report what was removed and the new phase structure.
</process>
