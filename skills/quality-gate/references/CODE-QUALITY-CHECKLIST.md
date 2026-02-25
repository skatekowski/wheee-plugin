# Wheee Protocol — Code Quality Checklist

Diese Checkliste deckt alle qualitaetsrelevanten Pruefpunkte ab — von Clean Code ueber Architektur bis Testing. Besonders wichtig bei KI-assistierter Entwicklung, wo technische Schulden systematisch entstehen.

**Wann verwenden:**
- **Architect-Phase (B.L.A.S.T. Phase 3):** Pruefe Architektur- und Design-Punkte
- **Stabilize-Phase (B.L.A.S.T. Phase 4):** Verifiziere Code-Qualitaet vor Deployment
- **Jederzeit:** `wheee audit` fuer Compliance, Code Reviews

---

## 1. Clean Code Fundamentals

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 1.1 | Funktionen machen genau EINE Sache (Single Responsibility) | Unwartbare, schwer testbare Funktionen |
| 1.2 | Funktionen unter 50 Zeilen, Klassen unter 200 Zeilen | Kognitive Ueberlastung, Bugs verstecken sich |
| 1.3 | Cyclomatic Complexity unter 10 pro Funktion | Untestbar, fehleranfaellig |
| 1.4 | Maximal 3 Parameter pro Funktion (sonst: Parameter-Objekt) | Schwer zu lesen, schwer zu testen |
| 1.5 | Kein tief verschachteltes Nesting (max 3 Ebenen) | Kognitive Komplexitaet, schwer zu debuggen |
| 1.6 | Keine Magic Numbers/Strings — benannte Konstanten verwenden | Unverstaendlicher Code, Aenderungen an mehreren Stellen |
| 1.7 | Keine auskommentierten Code-Bloecke | Dead Code, Verwirrung, Git ist die History |
| 1.8 | Konsistente Formatierung (Linter/Formatter konfiguriert) | Inkonsistenter Code, unnoetige Merge-Konflikte |
| 1.9 | Kein `any` oder `ts-ignore` in TypeScript | Typ-Safety umgangen, Bugs zur Laufzeit |
| 1.10 | Keine `console.log` Debugging-Statements in Production | Information Disclosure, Performance |

---

## 2. Naming Conventions

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 2.1 | Variablen beschreiben WAS sie enthalten, nicht WIE (`userAge` statt `n`) | Unlesbar, schwer wartbar |
| 2.2 | Funktionen beschreiben WAS sie tun (`calculateTotal` statt `calc`) | Intention unklar |
| 2.3 | Booleans als Fragen formuliert (`isActive`, `hasPermission`, `canEdit`) | Logik wird unlesbar |
| 2.4 | Konsistentes Naming-Schema im gesamten Projekt (camelCase/snake_case) | Inkonsistenz verwirrt |
| 2.5 | Keine Abkuerzungen ausser Standard-Abkuerzungen (`id`, `url`, `api`) | Nur der Autor versteht den Code |
| 2.6 | Klassen/Typen als Nomen, Funktionen als Verben | Verwechslung von Daten und Aktionen |
| 2.7 | Event-Handler mit `on`/`handle`-Prefix (`onClick`, `handleSubmit`) | Unklare Intention |
| 2.8 | Keine generischen Namen (`data`, `temp`, `result`, `item`) in breitem Scope | Unverstaendlich im Kontext |

---

## 3. DRY (Don't Repeat Yourself)

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 3.1 | Keine duplizierten Code-Bloecke (gleiche Logik an mehreren Stellen) | Aenderung vergessen = Bug |
| 3.2 | Shared Logic in wiederverwendbare Funktionen/Hooks/Utils extrahiert | Inkonsistentes Verhalten |
| 3.3 | Konstanten zentral definiert (Config, Enums, Magic Values) | Aenderungen an 20 Stellen |
| 3.4 | Types/Interfaces wiederverwendet statt copy-pasted | Typ-Drift zwischen Modulen |
| 3.5 | API-Aufrufe zentralisiert (Service Layer), nicht inline | Endpunkt-Aenderung erfordert globale Suche |
| 3.6 | CSS/Styles: Design-Tokens statt hardcoded Werte | Inkonsistentes Design |
| 3.7 | Error-Handling-Pattern konsistent und zentralisiert | Verschiedene Fehlermeldungen fuer gleiche Fehler |
| 3.8 | Validation-Logik wiederverwendet (Schemas, Validators) | Inkonsistente Validierung Frontend vs Backend |

---

## 4. SOLID Principles

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 4.1 | **S**ingle Responsibility: Jede Klasse/Modul hat genau eine Aufgabe | Unuebersichtlich, schwer zu aendern |
| 4.2 | **O**pen/Closed: Erweiterbar ohne bestehenden Code zu aendern | Riskante Aenderungen bei jeder Erweiterung |
| 4.3 | **L**iskov Substitution: Subtypen ersetzen Basistypen ohne Side Effects | Unerwartetes Verhalten bei Polymorphie |
| 4.4 | **I**nterface Segregation: Kleine, spezifische Interfaces statt Mega-Interfaces | Unnoetige Abhaengigkeiten |
| 4.5 | **D**ependency Inversion: Abhaengigkeiten auf Abstraktionen, nicht Implementierungen | Tight Coupling, schwer testbar |
| 4.6 | Dependency Injection statt hardcoded Instanziierung | Untestbar, unflexibel |

---

## 5. KISS & YAGNI

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 5.1 | Einfachste Loesung die funktioniert — kein Over-Engineering | Unnoetige Komplexitaet |
| 5.2 | Keine Features "fuer spaeter" implementiert | Tote Codepfade, Wartungsaufwand |
| 5.3 | Keine Abstraktionen ohne mindestens 2 konkrete Anwendungsfaelle | Premature Abstraction |
| 5.4 | Keine Framework-Features benutzen die nicht benoetigt werden | Unnoetige Abhaengigkeit und Komplexitaet |
| 5.5 | Konfiguration so einfach wie moeglich (YAML > Custom DSL) | Lernkurve, Maintenance-Overhead |
| 5.6 | Lieber explizit als clever — lesbarer Code schlaegt kompakten Code | Bugs durch Missverstaendnisse |

---

## 6. Code Smells

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 6.1 | Keine God Classes (Klassen die alles koennen) | SRP-Verletzung, untestbar |
| 6.2 | Keine Feature Envy (Funktion greift mehr auf fremde Daten zu als auf eigene) | Falsche Zuordnung von Verantwortlichkeiten |
| 6.3 | Keine Primitive Obsession (Strings/Numbers statt Value Objects) | Validation-Luecken, semantische Fehler |
| 6.4 | Keine Switch-Kaskaden ueber gleiche Bedingung an mehreren Stellen | Polymorphie oder Map-Pattern verwenden |
| 6.5 | Keine Shotgun Surgery (eine Aenderung erfordert Edits in 10+ Dateien) | Fragiles Design |
| 6.6 | Keine Data Clumps (gleiche Parametergruppen ueberall) | In Objekt/Type zusammenfassen |
| 6.7 | Kein Dead Code (unused imports, unreachable branches, unused variables) | Verwirrung, groessere Bundle |
| 6.8 | Keine temporaeren Hacks die permanent werden (`// TODO: fix later`) | Technische Schulden |

---

## 7. Error Handling

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 7.1 | Alle externen Aufrufe (API, DB, File) mit Error-Handling | Unbehandelte Exceptions crashen die App |
| 7.2 | Spezifische Fehlertypen statt generischem `catch(e)` | Fehlerfalle fuer alle Fehler gleich |
| 7.3 | Aussagekraeftige Fehlermeldungen fuer Debugging | "Error occurred" hilft niemandem |
| 7.4 | User-facing Errors generisch, keine internen Details | Information Disclosure |
| 7.5 | Graceful Degradation: App funktioniert bei Teilausfaellen weiter | Komplettausfall wegen einem Service |
| 7.6 | Keine leeren Catch-Bloecke (`catch(e) {}`) | Fehler werden verschluckt |
| 7.7 | Retry-Logic fuer transiente Fehler (mit Backoff) | Unnoetige Fehler bei kurzen Netzwerkproblemen |
| 7.8 | Validation am Eingang (Fail Fast), nicht tief in der Logik | Fehler treten weit vom Ursprung auf |

---

## 8. Testing

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 8.1 | Unit Tests fuer Business-Logik (keine triviale Getter/Setter-Tests) | Bugs in kritischer Logik |
| 8.2 | Integration Tests fuer externe Schnittstellen (API, DB) | Integrationsprobleme in Production |
| 8.3 | E2E Tests fuer kritische User-Flows | Feature kaputt ohne es zu merken |
| 8.4 | Tests testen Verhalten, nicht Implementierung | Fragile Tests bei Refactoring |
| 8.5 | Edge Cases getestet (leere Listen, null, Grenzwerte, Unicode) | Bugs bei unerwarteten Inputs |
| 8.6 | Error-Pfade getestet (nicht nur Happy Path) | Fehlerfaelle nie verifiziert |
| 8.7 | Tests sind unabhaengig voneinander (keine Reihenfolge-Abhaengigkeit) | Flaky Tests |
| 8.8 | Test Coverage fuer kritische Pfade > 80% | Blinde Flecken |
| 8.9 | Mocks/Stubs fuer externe Dependencies | Tests schlagen durch externe Faktoren fehl |
| 8.10 | CI/CD Pipeline fuehrt alle Tests automatisch aus | Broken Code wird deployed |

---

## 9. Architecture & Design

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 9.1 | Klare Schichtentrennung (UI, Business Logic, Data Access) | Spaghetti-Code, untestbar |
| 9.2 | Modulare Struktur: Feature-basiert statt Typ-basiert | Cross-Feature-Abhaengigkeiten |
| 9.3 | Unidirektionaler Datenfluss (kein zirkulaerer Import) | Schwer zu debuggen, Import-Loops |
| 9.4 | State Management zentralisiert und vorhersagbar | Inkonsistenter State, Race Conditions |
| 9.5 | Loose Coupling zwischen Modulen (ueber Interfaces/Events) | Aenderung in A bricht B |
| 9.6 | High Cohesion innerhalb von Modulen | Zusammengehoeriges verteilt ueber Codebase |
| 9.7 | Klare Abhaengigkeitsrichtung (Features → Core, nie umgekehrt) | Zirkulaere Abhaengigkeiten |
| 9.8 | Backend-Logik auf dem Backend, nicht im Frontend repliziert | Inkonsistenz, Sicherheitsrisiken |

---

## 10. Performance

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 10.1 | Keine N+1 Queries (Datenbankabfragen in Schleifen) | Massive DB-Last, langsame Seiten |
| 10.2 | Pagination/Lazy Loading fuer grosse Datenmengen | Memory Exhaustion, langsame UI |
| 10.3 | Caching fuer haeufig abgefragte, selten geaenderte Daten | Unnoetige Last auf DB/API |
| 10.4 | Keine blockierenden Operationen im Main Thread | Frozen UI, schlechte UX |
| 10.5 | Images optimiert (WebP, lazy loading, responsive) | Langsame Ladezeiten |
| 10.6 | Bundle-Groesse kontrolliert (Code Splitting, Tree Shaking) | Lange initiale Ladezeit |
| 10.7 | Keine Memory Leaks (Event Listeners, Subscriptions aufraumen) | App wird langsamer ueber Zeit |
| 10.8 | Debounce/Throttle fuer frequent Events (Scroll, Resize, Input) | Performance-Probleme, API-Spam |
| 10.9 | Keine unnoetige Re-Renders (React: Memoization, useMemo, useCallback) | Langsame UI |

---

## 11. Documentation

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 11.1 | README mit Setup, Usage und Architektur-Ueberblick | Neuer Entwickler braucht Stunden um zu starten |
| 11.2 | Inline-Kommentare nur fuer WARUM, nicht WAS (Code soll selbsterklaerend sein) | Veraltete Kommentare luegen |
| 11.3 | API-Dokumentation mit Beispielen und Edge Cases | API falsch benutzt |
| 11.4 | Architektur-Entscheidungen dokumentiert (ADRs oder Process Journal) | Niemand weiss warum etwas so gebaut wurde |
| 11.5 | Komplexe Business-Logik mit Kontext dokumentiert | Logik wird beim Refactoring kaputt gemacht |
| 11.6 | Setup-Anleitung getestet (funktioniert auf frischem System) | "Works on my machine" |
| 11.7 | Changelog gepflegt | Unklare Versionshistorie |

---

## 12. KI-spezifische Code-Qualitaet

Diese Punkte sind besonders relevant bei KI-assistierter Entwicklung (Vibe Coding, Copilot, ChatGPT, Claude):

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 12.1 | Code-Duplikation nach KI-Generierung pruefen (gleiche Logik in verschiedenen Sessions erzeugt) | +30% technische Schulden gegenueber manuell |
| 12.2 | Architekturelle Konsistenz pruefen (KI hat begrenzten Context-Window) | Verschiedene Patterns in verschiedenen Dateien |
| 12.3 | Halluzinierte APIs/Libraries pruefen (Funktionen die nicht existieren) | Runtime-Errors in Production |
| 12.4 | Unused Imports und Dead Code nach KI-Session aufraeumen | Aufgeblaehte Bundles, Verwirrung |
| 12.5 | Over-Engineering durch KI reduzieren (unnoetige Abstraktionen) | +39% kognitive Komplexitaet |
| 12.6 | Naming-Konsistenz nach KI-Generierung pruefen | Verschiedene Konventionen vermischt |
| 12.7 | Error-Handling vollstaendig? (KI fokussiert auf Happy Path) | Unbehandelte Fehlerfaelle |
| 12.8 | Tests vorhanden? (KI generiert selten proaktiv Tests) | Ungetesteter Code in Production |
| 12.9 | Hardcoded Credentials pruefen (KI kopiert Beispielwerte) | Sicherheitsluecken |
| 12.10 | Global Refactoring nach groesseren KI-Sessions | Technische Schulden akkumulieren unbemerkt |
| 12.11 | Business-Logik serverseitig verifizieren (KI baut oft nur Frontend) | Sicherheits- und Konsistenzprobleme |
| 12.12 | Pruefen ob KI veraltete APIs/Patterns verwendet (Training-Cutoff) | Deprecated Code, Sicherheitsluecken |

---

## Clean Code Prinzipien Quick-Check

| Prinzip | Frage | Verletzt wenn... |
|---------|-------|-------------------|
| **DRY** | Gibt es diesen Code schon woanders? | Gleiche Logik an 2+ Stellen |
| **SOLID** | Hat jedes Modul genau eine Aufgabe? | Eine Klasse tut 5 verschiedene Dinge |
| **KISS** | Ist das die einfachste Loesung? | Es gibt eine Loesung mit halb so viel Code |
| **YAGNI** | Brauchen wir das JETZT? | Feature fuer hypothetischen Future Use Case |
| **FIP** | Aendere ich nur was ich aendern soll? | Unbeabsichtigte Nebenwirkungen |
| **Boy Scout** | Ist der Code jetzt sauberer als vorher? | Neue technische Schulden hinzugefuegt |

---

## Verwendung im Wheee Protocol

### Architect-Phase (B.L.A.S.T. Phase 3)
Gehe die Architektur- und Design-Punkte durch (Abschnitt 4, 5, 9) bevor du Code schreibst. Stelle sicher, dass die Struktur stimmt bevor du implementierst.

### Stabilize-Phase (B.L.A.S.T. Phase 4)
Verifiziere Code-Qualitaet vor dem Deployment:
- `wheee audit` — Projekt-Compliance (Golden Rule, DRY, SOP-First)
- Abschnitt 1-3: Clean Code, Naming, DRY
- Abschnitt 6-8: Code Smells, Error Handling, Tests
- Abschnitt 12: KI-spezifische Checks nach AI-Sessions

### Nach KI-Sessions
Besonders nach laengeren KI-assistierten Coding-Sessions:
- Abschnitt 12 komplett durchgehen
- Globales Refactoring wo noetig
- Dead Code und Unused Imports aufraeumen
- Architekturelle Konsistenz pruefen

### Automatisierte Checks
- **Linter:** ESLint, Biome, Pylint — fangen 1.1, 1.8, 1.9, 1.10, 6.7 automatisch
- **Formatter:** Prettier, Black — loest 1.8 automatisch
- **Tests:** `npm test` / `pytest` — deckt Abschnitt 8 ab
- **Complexity:** Sonarqube, CodeClimate — misst 1.3, Cyclomatic Complexity

---

*Last updated: 2026-02-20 — Wheee Protocol v1.5.0*
