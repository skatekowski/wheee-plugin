---
name: wheee:debug
description: Systematisches Debugging
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
  - Grep
---

<objective>
Systematic debugging following GSD discipline — analyze root cause, not symptoms.
</objective>

<process>
1. Gather the error: exact message, stack trace, reproduction steps.
2. Search `project/process-journal.md` for similar past issues (Proven Solutions).
3. Analyze root cause:
   - Read relevant source files.
   - Check dependencies and versions.
   - Trace the execution path.
4. Fix the root cause, not the symptom.
5. Verify the fix (tests, manual verification).
6. Document the solution in `project/process-journal.md` as a Proven Solution.
</process>
