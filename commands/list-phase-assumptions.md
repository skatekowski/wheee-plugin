---
name: wheee:list-phase-assumptions
description: Annahmen zu Phase anzeigen
allowed-tools:
  - Read
  - Glob
  - Grep
---

<objective>
List all assumptions made for a phase so they can be validated.
</objective>

<process>
1. Read the current phase PLAN.md, CONTEXT.md, and RESEARCH.md.
2. Identify explicit and implicit assumptions (technology choices, API behavior, data formats, etc.).
3. List each assumption with its risk level (low/medium/high).
4. Suggest which assumptions should be validated before execution.
</process>
