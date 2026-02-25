---
name: wheee:audit
description: Project Doctor – Wheee-Compliance pruefen (wheee audit)
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
---

<objective>
Pruefe Wheee Protocol Compliance im aktuellen Projekt.
Dieser Befehl prueft die Wheee-Struktur, Planungsdokumente und Prozess-Einhaltung.
</objective>

<context>
Der Audit prueft OB das Protokoll eingehalten wird — nicht die Code-Qualitaet.
Fuer Code-Qualitaet und Security: `wheee quality-gate`
Fuer Dependency-Vulnerabilities: `wheee vulns`
</context>

<process>
## 1. Projekt-Root finden

Suche nach `.planning/` Ordner im aktuellen Verzeichnis oder im naechsten Parent.
Wenn kein `.planning/` vorhanden: "Kein Wheee-Projekt gefunden. Nutze `wheee init` um zu starten."

## 2. Planungsdokumente pruefen

Pruefe ob diese Dateien existieren UND Inhalt haben (nicht leer):

| Datei | Pflicht | Pruefung |
|-------|---------|----------|
| `.planning/PROJECT.md` | Ja | Existiert + nicht leer |
| `.planning/REQUIREMENTS.md` | Ja (ab Modus M) | Existiert + nicht leer |
| `.planning/ROADMAP.md` | Ja | Existiert + Checkboxen vorhanden |
| `.planning/STATE.md` | Ja | Existiert + "Current Phase" vorhanden |
| `.planning/dispatches/DISPATCH-LOG.md` | Ja (wenn Dispatches liefen) | Existiert + Eintraege vorhanden |

Fuer jedes Dokument: PASS oder FAIL + Grund.

## 3. Phasen-Dokumentation pruefen

Fuer JEDE abgeschlossene Phase (Checkbox in ROADMAP.md checked):
- `.planning/phases/<NN>-<name>/PLAN.md` — existiert?
- `.planning/phases/<NN>-<name>/SUMMARY.md` — existiert?

Pruefe: Anzahl abgeschlossener Phasen vs. Anzahl vorhandener PLAN.md/SUMMARY.md Paare.
Fehlende Phasen-Doku = FAIL.

## 4. STATE.md Aktualitaet pruefen

Lies STATE.md und pruefe:
- Stimmt "Current Phase" mit dem letzten nicht-abgeschlossenen Phase in ROADMAP.md ueberein?
- Stimmt "Status" mit der Realitaet (letzte abgeschlossene Aufgabe)?
- Gibt es offene Bugs/Findings die nicht dokumentiert sind?
- Stimmt "Next Action" mit dem was tatsaechlich als naechstes kommt?

Bei Abweichung: WARN + was konkret veraltet ist.

## 5. ROADMAP.md Sync pruefen

- Sind alle abgeschlossenen Arbeiten als Checkboxen gecheckt?
- Gibt es gecheckte Items die nicht in STATE.md oder einer SUMMARY.md erwaehnt werden?
- Gibt es Phasen die uebersprungen oder zusammengelegt wurden ohne Dokumentation?

## 6. Dispatch-Compliance pruefen

- Liegt der Projekt-Code in einem `.planning/`-Ordner? (Code-Gate Regel)
- Gibt es Task-Specs in `workspace/input/tasks/` die nicht in `_done/` archiviert sind, aber bereits reviewed/completed?
- Stimmt die Anzahl der Dispatch-Log-Eintraege mit den archivierten Specs ueberein?

## 7. Report ausgeben

```
# Wheee Audit Report — [Projektname]
Datum: YYYY-MM-DD
Modus: S/M/L

| Kategorie | Score | Status |
|-----------|-------|--------|
| Planungsdokumente | X/5 | PASS/FAIL |
| Phasen-Doku | X/X | PASS/FAIL |
| STATE.md Aktualitaet | - | PASS/WARN/FAIL |
| ROADMAP.md Sync | - | PASS/WARN/FAIL |
| Dispatch-Compliance | X/X | PASS/WARN/FAIL |

## Findings
1. [FAIL/WARN] ...

## Empfohlene Aktionen
1. ...

Gesamtbewertung: [PASS/WARN/FAIL]
```

## WICHTIG
- Jeden Punkt TATSAECHLICH pruefen. Dateien lesen, nicht raten.
- Bei WARN: Konkret sagen WAS veraltet/falsch ist.
- Bei FAIL: Konkret sagen WAS fehlt und WIE es gefixt wird.

## Selbst-Validierung (PFLICHT vor Abgabe)

Beantworte diese Fragen ehrlich. Bei NEIN → zurueckgehen und beheben.

- [ ] Habe ich JEDE Kategorie tatsaechlich geprueft (Dateien geoeffnet, nicht geraten)?
- [ ] Habe ich STATE.md gegen ROADMAP.md abgeglichen (nicht nur gelesen)?
- [ ] Habe ich mindestens 3 konkrete Datei-Zeilen als Beleg fuer FAIL/WARN zitiert?
- [ ] Habe ich bei einer Kategorie "PASS" geschrieben ohne die zugehoerigen Dateien gelesen zu haben? (Falls ja: zurueck und lesen)
</process>
