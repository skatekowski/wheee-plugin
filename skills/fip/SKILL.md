---
name: fip
description: "Functionality Isolation Protocol — analyze dependencies for a file or symbol to understand the blast radius of changes. Use when running 'fip', 'dependency analysis', 'impact analysis', or before refactoring."
model: haiku
allowed-tools:
  - Read
  - Grep
  - Glob
---

# FIP — Functionality Isolation Protocol

Analyze the dependency graph of a file or symbol to understand what a change will affect.

## Process

1. Identify the target (file path or symbol name from $ARGUMENTS)
2. Find all files that import/require the target
3. Find all files that the target imports/requires
4. Map the dependency tree (2 levels deep)
5. Identify protected zones (files that should NOT be modified)
6. Report the FIP scope

## Output Format

```
## FIP Analysis: [target]

### Direct Dependencies (imports)
- [file] — imports [symbol]

### Reverse Dependencies (imported by)
- [file] — uses [symbol]

### FIP Scope (safe to modify)
- [file 1]
- [file 2]

### Protected (DO NOT modify)
- [file] — [reason: external API, shared config, etc.]

### Blast Radius
- X files in scope
- Y files protected
- Risk level: LOW / MEDIUM / HIGH
```

## Rules

- Always check for circular dependencies
- Flag shared state (global variables, singletons, shared configs)
- Include test files that test the target
- Protected files: package.json, lock files, CI configs, shared types
