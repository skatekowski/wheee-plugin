---
name: wheee:research-phase
description: "Recherche fuer Phase durchfuehren (research-phase [N])"
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
  - WebFetch
  - WebSearch
---

<objective>
Conduct research for a phase. Gather context, dependencies, options. Document findings. If the user provides a phase number N, use that phase. Otherwise infer from `.planning/ROADMAP.md` or `STATE.md`.
</objective>

<process>
1. Read `.planning/ROADMAP.md` and `.planning/STATE.md` to identify the target phase.
2. Read existing phase context from `.planning/phases/XX-name/`.
3. Research:
   - Check current versions of relevant tools/libraries (WebSearch, docs).
   - Verify API compatibility and available features.
   - Look for proven solutions in `project/process-journal.md`.
   - Analyze existing codebase for relevant patterns.
4. Document findings in `.planning/phases/XX-name/RESEARCH.md` and/or `project/findings.md`.
5. Report findings and suggest next step: `/wheee:plan-phase`.
</process>
