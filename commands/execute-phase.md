---
name: wheee:execute-phase
description: "Phase ausfuehren – Wave-basiert (execute-phase [N])"
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
Execute a phase wave-based according to its PLAN.md. If the user provides a phase number N, use that phase. Otherwise infer from `.planning/ROADMAP.md` or `STATE.md`.
</objective>

<process>
1. Read the phase PLAN.md from `.planning/phases/XX-name/`.
2. **Mandatory Gate**: Verify PLAN.md exists. If not, stop and inform user to run `/wheee:plan-phase` first.
3. Execute tasks from the plan sequentially:
   - Follow FIP scope — do not touch protected areas.
   - After each significant task, verify it works.
   - Document decisions and challenges in `project/process-journal.md`.
4. After all tasks complete, run verification (tests, lint, smoke test).
5. Create phase summary in `.planning/phases/XX-name/XX-01-SUMMARY.md`.
6. Update `.planning/STATE.md` and `.planning/ROADMAP.md`.
7. Report phase completion to the user with a summary of what was done.
</process>
