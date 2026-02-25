---
name: wheee:audit-milestone
description: Milestone-Audit vor Abschluss
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

<objective>
Audit the current milestone before completion — check all phases, gaps, and quality.
</objective>

<process>
1. Read `.planning/ROADMAP.md` for all phases in the current milestone.
2. For each phase, verify:
   - PLAN.md exists and was followed.
   - SUMMARY.md exists with results.
   - Success criteria were met.
3. Run `wheee audit` for compliance check.
4. Identify gaps: phases without summaries, unmet criteria, missing documentation.
5. Report audit results with pass/fail per phase.
6. If gaps found, suggest `/wheee:plan-milestone-gaps`.
</process>
