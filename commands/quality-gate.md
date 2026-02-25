---
name: wheee:quality-gate
description: Komplett-Check Code Quality + Security gegen beide Checklisten (wheee quality-gate)
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
  - Task
---

<objective>
Fuehre einen vollstaendigen Code Quality + Security Audit gegen die beiden Wheee-Checklisten durch.
Dies ist der Stufe-3-Gate-Check — BEIDE Checklisten werden komplett durchgeprueft.
</objective>

<context>
Dieses Gate wird regelmaessig ausgefuehrt:
- Nach laengeren KI-Sessions (Vibe Coding Cleanup)
- Vor Milestone-Abschluss
- Wenn Qualitaetszweifel bestehen
- Mindestens einmal pro Woche bei aktiver Entwicklung

Die Checklisten liegen an diesen Stellen (in Reihenfolge pruefen):
1. Im Wheee-Protokoll Root: `CODE-QUALITY-CHECKLIST.md` und `SECURITY-CHECKLIST.md`
2. Im Projekt unter: `.planning/` oder `workspace/skills/dev/checklists/`
</context>

<process>
## Phase 1: Checklisten laden

Lies BEIDE Checklisten vollstaendig:
- `CODE-QUALITY-CHECKLIST.md` (12 Abschnitte, ~100 Pruefpunkte)
- `SECURITY-CHECKLIST.md` (14 Abschnitte, ~90 Pruefpunkte)

## Phase 2: Projekt-Scope bestimmen

1. Finde den Projekt-Root (package.json, .planning/, oder wie vom User angegeben)
2. Identifiziere alle Source-Verzeichnisse (src/, app/, modules/, packages/, lib/)
3. Zaehle die Dateien: `find <root> -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" | grep -v node_modules | wc -l`
4. Melde dem User: "Pruefe X Dateien in Y Verzeichnissen gegen 2 Checklisten (~190 Punkte)"

## Phase 3: Code Quality Check (CODE-QUALITY-CHECKLIST.md)

Starte einen Background-Agent (Task tool, subagent_type: feature-dev:code-reviewer) der JEDEN Abschnitt systematisch prueft:

1. **Clean Code Fundamentals (1.1-1.10)** — Funktionslaenge, Complexity, Nesting, Magic Numbers, any/ts-ignore, console.log
2. **Naming Conventions (2.1-2.8)** — Variablen, Funktionen, Booleans, Event-Handler
3. **DRY (3.1-3.8)** — Duplikation, Shared Logic, zentrale Konstanten, API-Aufrufe
4. **SOLID (4.1-4.6)** — SRP, OCP, LSP, ISP, DIP
5. **KISS & YAGNI (5.1-5.6)** — Over-Engineering, premature Abstraktionen
6. **Code Smells (6.1-6.8)** — God Classes, Dead Code, temporaere Hacks
7. **Error Handling (7.1-7.8)** — Externe Aufrufe, leere Catches, Fail Fast
8. **Testing (8.1-8.10)** — Unit/Integration/E2E Tests, Coverage
9. **Architecture (9.1-9.8)** — Schichtentrennung, Coupling, Datenfluss
10. **Performance (10.1-10.9)** — N+1, Pagination, Memory Leaks, Re-Renders
11. **Documentation (11.1-11.7)** — README, ADRs, Setup-Anleitung
12. **KI-spezifisch (12.1-12.12)** — Duplikation, Halluzinierte APIs, veraltete Patterns

Jeder Punkt bekommt: **PASS**, **WARN** (mit Erklaerung + Datei), oder **FAIL** (mit Erklaerung + Datei + Zeile)

## Phase 4: Security Check (SECURITY-CHECKLIST.md)

Starte einen zweiten Background-Agent (parallel) der JEDEN Abschnitt prueft:

1. **Secrets & Credentials (1.1-1.9)** — Hardcoded Keys, .env, Docker Secrets
2. **Injection (2.1-2.6)** — SQL, XSS, Command, NoSQL, XXE, ReDoS
3. **Auth & Authz (3.1-3.10)** — Endpoints, IDOR, RBAC, Mass Assignment
4. **JWT & OAuth (4.1-4.10)** — alg:none, Storage, PKCE, Lifetimes
5. **API Security (5.1-5.12)** — Rate Limiting, Input Validation, Pagination
6. **HTTP Headers (6.1-6.8)** — CSP, HSTS, CORS, X-Frame-Options
7. **Cookie Security (7.1-7.5)** — HttpOnly, Secure, SameSite
8. **Data Validation (8.1-8.8)** — File Upload, Path Traversal, SSRF
9. **CSRF (9.1-9.3)** — Tokens, SameSite
10. **Dependencies (10.1-10.7)** — pnpm/npm audit, Lock-Files, Lizenz
11. **Database (11.1-11.7)** — Least Privilege, Encryption, RLS Policies
12. **Environment (12.1-12.10)** — HTTPS, Docker, CI/CD
13. **Logging (13.1-13.7)** — PII, Stack Traces, Security Events
14. **Business Logic (14.1-14.5)** — Idempotency, Race Conditions

Jeder Punkt bekommt: **PASS**, **WARN**, **FAIL**, oder **N/A** (mit Begruendung)

## Phase 5: Report zusammenstellen

Erstelle einen strukturierten Report:

```
# Quality Gate Report — [Projektname]
Datum: YYYY-MM-DD
Dateien geprueft: X
Pruefpunkte: ~190

## Code Quality Score
| Abschnitt | Score | Findings |
|-----------|-------|----------|
| 1. Clean Code | X/10 | ... |
| ... | | |
| Gesamt | X/100 | |

## Security Score
| Abschnitt | Score | Findings |
|-----------|-------|----------|
| 1. Secrets | X/9 | ... |
| ... | | |
| Gesamt | X/90 | |

## FAIL Findings (MUSS gefixt werden)
1. [FAIL] ...

## WARN Findings (SOLLTE gefixt werden)
1. [WARN] ...

## Gesamtbewertung: [PASS/WARN/FAIL]
```

## Phase 6: Ergebnis speichern

Speichere den Report als `.planning/QUALITY-GATE-YYYY-MM-DD.md` (wenn `.planning/` existiert).

## WICHTIG

- **NICHT improvisieren.** Jeden Punkt der Checkliste einzeln pruefen.
- **NICHT raten.** Code lesen, Patterns suchen, Dateien oeffnen.
- **Agents nutzen.** Phase 3 und 4 PARALLEL als Background-Agents ausfuehren.
- **Dem User Fortschritt melden.** Nach Phase 2 (Scope), nach Phase 3+4 (Ergebnisse), nach Phase 5 (Report).
</process>
