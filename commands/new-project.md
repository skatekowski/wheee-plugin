---
name: wheee:new-project
description: Neues Projekt initialisieren (Discovery & Research)
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
Initialize a new project with the Wheee/GSD protocol. Run Discovery & Research phase.
</objective>

<process>
1. Run `wheee init` in the project root to scaffold the Wheee structure (.planning/, project/, tools/).
2. Read `.planning/ROADMAP.md` and `.planning/STATE.md` to confirm initialization.
3. Start Discovery: Ask the user the 5 B.L.A.S.T. Blueprint questions:
   - What problem does this project solve?
   - Who is the target user?
   - What is the core feature set (MVP)?
   - What technology stack and constraints exist?
   - What are the success criteria?
4. Document answers in `.planning/PROJECT.md` and `.planning/REQUIREMENTS.md`.
5. Create initial roadmap in `.planning/ROADMAP.md` with Phase 01.
6. Update `.planning/STATE.md` with current status.
7. Report what was created and next steps.
</process>
