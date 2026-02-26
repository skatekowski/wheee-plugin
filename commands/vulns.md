---
name: wheee:vulns
description: Sicherheitsluecken scannen gegen SECURITY-CHECKLIST.md (wheee vulns)
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
  - Task
---

<objective>
Scanne das Projekt auf Sicherheitsluecken — systematisch gegen die Wheee SECURITY-CHECKLIST.md.
Dies ist KEIN oberflaechlicher pnpm-audit. Dies ist ein vollstaendiger Security-Review.
</objective>

<context>
Die Security-Checklist liegt an diesen Stellen (Reihenfolge pruefen):
1. Im Wheee-Plugin: `skills/security-scan/references/SECURITY-CHECKLIST.md`
2. Im Projekt unter: `.planning/` (falls projekt-spezifische Checklist existiert)

Fuer Code-Qualitaet: `wheee quality-gate` (inkl. Security)
Fuer Wheee-Compliance: `wheee audit`
</context>

<process>
## 1. Checklist laden

Lies `SECURITY-CHECKLIST.md` vollstaendig. Sie hat 14 Abschnitte mit ~90 Pruefpunkten.

## 2. Projekt-Scope bestimmen

1. Finde Projekt-Root und Tech-Stack (package.json, Dockerfile, etc.)
2. Identifiziere relevante Abschnitte (z.B. kein GraphQL = Section 5.7-5.9 N/A)
3. Melde dem User den Scope: "Pruefe [Stack] gegen 14 Security-Abschnitte"

## 3. Systematisch pruefen — ALLE 14 Abschnitte

Starte einen Background-Agent (Task tool, subagent_type: feature-dev:code-reviewer) der JEDEN Abschnitt prueft:

1. **Secrets & Credentials (1.1-1.9)** — Grep nach hardcoded Keys, .env in .gitignore, Docker Secrets
2. **Injection (2.1-2.6)** — SQL Injection, XSS, Command Injection, ReDoS
3. **Auth & Authz (3.1-3.10)** — Auth auf allen Endpoints, IDOR, Mass Assignment
4. **JWT & OAuth (4.1-4.10)** — Token Storage, Expiration, PKCE
5. **API Security (5.1-5.12)** — Rate Limiting, Input Validation, Pagination Limits
6. **HTTP Headers (6.1-6.8)** — CSP, HSTS, X-Frame-Options, CORS
7. **Cookie Security (7.1-7.5)** — HttpOnly, Secure, SameSite
8. **Data Validation (8.1-8.8)** — File Upload, Path Traversal, SSRF
9. **CSRF (9.1-9.3)** — Tokens, SameSite
10. **Dependencies (10.1-10.7)** — pnpm/npm audit, Lock-Files, Lizenzen
11. **Database (11.1-11.7)** — Least Privilege, RLS, Encryption
12. **Environment (12.1-12.10)** — HTTPS, Docker, CI/CD, Production Hardening
13. **Logging (13.1-13.7)** — PII in Logs, Stack Traces, Security Events
14. **Business Logic (14.1-14.5)** — Idempotency, Race Conditions

Jeder Punkt bekommt: **PASS**, **WARN** (mit Datei+Zeile), **FAIL** (mit Datei+Zeile+Fix), oder **N/A** (mit Begruendung)

## 4. Dependency Scan

Zusaetzlich zum Code-Review:
```bash
pnpm audit 2>&1 || npm audit 2>&1 || pip audit 2>&1 || cargo audit 2>&1
```

## 5. Report ausgeben

```
# Security Scan Report — [Projektname]
Datum: YYYY-MM-DD
Stack: [Tech-Stack]

## Score nach Abschnitt
| # | Abschnitt | PASS | FAIL/WARN | Score |
|---|-----------|------|-----------|-------|
| 1 | Secrets | X/9 | X/9 | XX% |
| ... | | | | |
| GESAMT | | X/90 | X/90 | XX% |

## CRITICAL Findings (Sofort fixen)
1. [FAIL] ...

## IMPORTANT Findings (Vor Release fixen)
1. [WARN] ...

## Empfohlene Prioritaeten
1. Sofort: ...
2. Diese Woche: ...
3. Naechster Sprint: ...
```

## WICHTIG
- **NICHT nur `pnpm audit` laufen lassen und fertig.** Das ist nur Abschnitt 10.1 von 14 Abschnitten.
- **JEDEN Abschnitt einzeln pruefen.** Code lesen, Patterns suchen, Dateien oeffnen.
- **Konkrete Dateien und Zeilen angeben** bei FAIL/WARN.
- **Fix-Vorschlaege** bei jedem FAIL.

## Selbst-Validierung (PFLICHT vor Abgabe)

Beantworte diese Fragen ehrlich. Bei NEIN → zurueckgehen und beheben.

- [ ] Habe ich JEDE Checklist-Sektion einzeln durchgearbeitet oder nur ueberflogen?
- [ ] Habe ich mindestens 3 konkrete Datei-Zeilen als Beleg fuer meine Findings zitiert?
- [ ] Habe ich bei einer Sektion "alles gut" geschrieben ohne den Code gelesen zu haben? (Falls ja: zurueck und lesen)
- [ ] Habe ich tatsaechlich `grep` oder `Grep` benutzt um nach Patterns zu suchen, oder nur geraten?
</process>
