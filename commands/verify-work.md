---
name: wheee:verify-work
description: Gebaute Features durch UAT validieren
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

<objective>
Validate built features through User Acceptance Testing (UAT).
</objective>

<process>
1. Read current phase PLAN.md and SUMMARY.md to understand what was built.
2. For each success criterion in the plan:
   - Verify the feature works as specified.
   - Run relevant tests (unit, e2e, lint).
   - Check for regressions in protected areas (FIP).
3. Document results: pass/fail for each criterion.
4. If issues found (< 5 low-level): create UAT-FIX-BATCH.md for Fast-Track fixing.
5. If major issues: report and suggest re-execution or plan revision.
6. Update `.planning/STATE.md` with verification status.
</process>
