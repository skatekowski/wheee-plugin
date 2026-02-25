---
name: wheee:add-todo
description: Todo erfassen
allowed-tools:
  - Read
  - Write
  - Edit
---

<objective>
Capture a new todo item in the appropriate planning file.
</objective>

<process>
1. Ask the user for the todo description (if not provided as argument).
2. Determine the appropriate file: current phase PLAN.md or `project/task_plan.md`.
3. Add the todo as `- [ ] <description>` in the correct section.
4. Confirm where it was added.
</process>
