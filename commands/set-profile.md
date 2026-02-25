---
name: wheee:set-profile
description: Modell-Profil wechseln
allowed-tools:
  - Read
  - Write
  - Edit
---

<objective>
Switch the model profile for the current project.
</objective>

<process>
1. Read `project/wheee-config.json` for current profile.
2. Show available profiles and current selection.
3. Update the profile based on user choice.
4. Report the change.
</process>
