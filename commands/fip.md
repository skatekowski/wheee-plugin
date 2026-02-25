---
name: wheee:fip
description: "Abhaengigkeiten fuer Datei/Symbol finden (wheee fip <target>)"
allowed-tools:
  - Bash
  - Read
---

<objective>
Run `wheee fip` with the target file/symbol to find dependencies before making changes.
</objective>

<process>
1. Run `wheee fip <target>` (with arguments the user provided) in the project root.
2. Show the dependency analysis to the user.
</process>
