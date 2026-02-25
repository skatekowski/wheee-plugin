---
name: wheee:discuss-phase
description: "Phase-Kontext durch adaptives Fragen sammeln (discuss-phase [N])"
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
  - WebFetch
  - WebSearch
---

<objective>
Gather context for a phase through adaptive questioning. If the user provides a phase number N, use that phase. Otherwise infer from `.planning/ROADMAP.md` or `STATE.md`.
</objective>

<process>
1. Read `.planning/ROADMAP.md` and `.planning/STATE.md` to identify the target phase.
2. Read the phase directory `.planning/phases/XX-name/` for any existing context (BLUEPRINT, CONTEXT, RESEARCH).
3. Ask adaptive questions to understand:
   - What exactly should this phase achieve?
   - What are the inputs/dependencies?
   - What are known constraints or risks?
   - What does "done" look like for this phase?
4. Document the gathered context in `.planning/phases/XX-name/XX-00-CONTEXT.md`.
5. Suggest next step: `/wheee:research-phase` or `/wheee:plan-phase`.
</process>
