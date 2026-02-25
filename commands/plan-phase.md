---
name: wheee:plan-phase
description: "Ausfuehrungsplan (PLAN.md) erstellen (plan-phase [N])"
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
  - Grep
---

<objective>
Create an execution plan (PLAN.md) for a phase. If the user provides a phase number N, use that phase. Otherwise infer from `.planning/ROADMAP.md` or `STATE.md`.
</objective>

<process>
1. Read `.planning/ROADMAP.md`, `.planning/STATE.md`, and phase context/research files.
2. Create `.planning/phases/XX-name/XX-01-PLAN.md` with:
   - **Goal**: What this phase achieves.
   - **Prerequisites**: What must be in place before starting.
   - **Tasks**: Numbered, actionable tasks with clear deliverables.
   - **Success Criteria**: How to verify the phase is complete.
   - **FIP Scope**: Files/functions in scope, protected areas.
3. Update `.planning/STATE.md` to reflect the planned phase.
4. Report the plan summary and ask for approval before execution.
</process>
