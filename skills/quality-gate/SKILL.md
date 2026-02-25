---
name: quality-gate
description: "Run a complete code quality and security audit against both checklists. Use when reviewing code, before merging, or when running 'quality gate', 'code quality check', or 'audit code'."
model: sonnet
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
---

# Quality Gate

Run a comprehensive quality and security audit against both checklists.

## Process

1. Read `references/CODE-QUALITY-CHECKLIST.md` and `references/SECURITY-CHECKLIST.md`
2. Determine scope: What files/modules are being audited?
   - If recent changes exist: `git diff --name-only HEAD~1` to find changed files
   - If a specific scope is given: use that
   - If no scope: audit the entire project
3. Run each checklist section against the scoped files
4. For each finding, include:
   - File path and line number
   - Severity: CRITICAL / WARNING / INFO
   - What's wrong and how to fix it
5. Produce a summary report with pass/fail counts per section

## Output Format

```
## Quality Gate Report

### Code Quality (X/12 sections passed)
- [PASS] Section 1: ...
- [FAIL] Section 2: ... (3 issues found)

### Security (X/14 sections passed)
- [PASS] Section 1: ...
- [FAIL] Section 2: ... (1 critical issue)

### Findings (by severity)
#### Critical
- [file:line] — [issue]

#### Warnings
- [file:line] — [issue]

### Verdict: PASS / FAIL
```

## Gate Levels

Adapt the depth based on change size:
- **Level 0** (< 3 files): Quick scan — OWASP Top 3, obvious bugs
- **Level 1** (3-10 files): Standard — full code quality checklist
- **Level 2** (10-30 files): Deep — both checklists, dependency check
- **Level 3** (> 30 files): Full audit — everything + architecture review
