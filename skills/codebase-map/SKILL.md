---
name: codebase-map
description: "Analyze and map the current codebase structure, key files, and architecture. Use when running 'map codebase', 'analyze project', or when starting work on an unfamiliar project."
model: haiku
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
---

# Codebase Map

Analyze the project structure and produce a comprehensive codebase overview.

## Process

1. Read project root files: package.json, Cargo.toml, pyproject.toml, go.mod, etc.
2. Map directory structure (2 levels deep)
3. Identify framework and language
4. Find entry points (main, index, app, server)
5. Map key architectural layers:
   - Routes / API endpoints
   - Data models / schemas
   - Business logic / services
   - Configuration / environment
   - Tests
6. Count files by type and estimate project size
7. Check for existing documentation (README, ARCHITECTURE, CLAUDE.md)

## Output Format

```
## Codebase Map

### Project
- Name: [name]
- Language: [lang] / Framework: [framework]
- Size: ~X files, ~Y lines

### Structure
[directory tree, 2 levels]

### Entry Points
- [file] — [purpose]

### Architecture Layers
- **Routes**: [directory/pattern]
- **Models**: [directory/pattern]
- **Services**: [directory/pattern]
- **Config**: [directory/pattern]
- **Tests**: [directory/pattern]

### Key Files
- [file] — [why it matters]

### Dependencies
- X production deps, Y dev deps
- Notable: [key libraries]
```
