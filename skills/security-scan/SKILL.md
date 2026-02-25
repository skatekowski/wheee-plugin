---
name: security-scan
description: "Scan code for security vulnerabilities using the SECURITY-CHECKLIST. Use when running 'security scan', 'vulnerability check', 'wheee vulns', or before deployment."
model: sonnet
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
---

# Security Scan

Scan the project for security vulnerabilities against the SECURITY-CHECKLIST.

## Process

1. Read `references/SECURITY-CHECKLIST.md`
2. Determine scope (changed files or full project)
3. Check each of the 14 security sections:
   - Input Validation & Sanitization
   - Authentication & Authorization
   - Session Management
   - Data Protection
   - API Security
   - Error Handling & Logging
   - Dependency Security
   - File Operations
   - Database Security
   - Configuration Security
   - Client-Side Security
   - Infrastructure
   - Business Logic
   - Compliance
4. For dependency vulnerabilities, run: `npm audit` / `pip audit` / `cargo audit` as appropriate
5. Report all findings with severity ratings

## Output Format

```
## Security Scan Report

### Critical Vulnerabilities
- [file:line] — [CVE/issue] — [remediation]

### High Risk
- [file:line] — [issue] — [remediation]

### Medium Risk
- [file:line] — [issue] — [suggestion]

### Dependency Audit
- X vulnerabilities found (Y critical, Z high)

### Verdict: SECURE / VULNERABILITIES FOUND
```
