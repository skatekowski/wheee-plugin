---
name: wheee:progress
description: Fortschritt pruefen, naechste Aktion zeigen
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

<objective>
Check project progress and show the next recommended action.
</objective>

<process>
1. Read `.planning/STATE.md` for current status.
2. Read `.planning/ROADMAP.md` for overall progress.
3. Check current phase directory for existing artifacts (CONTEXT, RESEARCH, PLAN, SUMMARY).
4. Report:
   - Current milestone and phase.
   - What has been completed.
   - What is the next action (discuss, research, plan, execute, verify).
5. Suggest the appropriate `/wheee:` command for the next step.
</process>
