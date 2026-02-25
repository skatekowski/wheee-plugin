---
name: wheee:settings
description: Workflow/Profil konfigurieren
allowed-tools:
  - Read
  - Write
  - Edit
---

<objective>
Configure workflow settings and project profile.
</objective>

<process>
1. Read `project/wheee-config.json` for current settings.
2. Show current configuration to the user.
3. Allow changes to: mode (S/M/L/D), modules, iteration settings.
4. Write updated config back to `project/wheee-config.json`.
</process>
