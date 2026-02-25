# Wheee Protocol — Security Checklist

Diese Checkliste deckt alle sicherheitsrelevanten Pruefpunkte ab, die bei jeder Anwendung beruecksichtigt werden muessen — insbesondere bei KI-assistierter Entwicklung, wo Security-Luecken systematisch uebersehen werden.

**Wann verwenden:**
- **Link-Phase (B.L.A.S.T. Phase 2):** Pruefe alle Punkte die fuer dein Projekt relevant sind
- **Stabilize-Phase (B.L.A.S.T. Phase 4):** Verifiziere vor dem Deployment
- **Jederzeit:** `wheee vulns` fuer Dependency-Scans, `wheee audit` fuer Compliance

---

## 1. Secrets & Credentials

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 1.1 | Keine hardcoded API Keys, Tokens oder Passwoerter im Code | Credential-Leak bei Public Repos |
| 1.2 | `.env`-Dateien in `.gitignore` — nie committed | Secrets landen in Git-History |
| 1.3 | `.env.example` ohne echte Werte vorhanden | Dokumentation der benoetigten Variablen |
| 1.4 | Secrets nicht in Logs, Error Messages oder URLs | Exfiltration ueber Monitoring/Referrer |
| 1.5 | Secret-Rotation implementiert (regelmaessiger Key-Wechsel) | Kompromittierte Keys bleiben ewig gueltig |
| 1.6 | API Keys mit minimalen Berechtigungen (Least Privilege) | Ueberprivilegierte Keys ermoeglichen Lateral Movement |
| 1.7 | Secrets ueber Secret Manager (Vault, AWS SM, etc.) statt Env-Vars in Production | Env-Vars sind einsehbar ueber `/proc` oder Crashes |
| 1.8 | Keine Secrets in Docker Image Layern | Multi-Stage-Build oder `.dockerignore` |
| 1.9 | CI/CD Pipeline exponiert keine Secrets in Logs | Build-Logs sind oft breit zugaenglich |

---

## 2. Injection Attacks

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 2.1 | SQL: Prepared Statements / parametrisierte Queries — kein String-Concat | SQL Injection |
| 2.2 | Shell: Kein User-Input in `exec()`, `system()`, `child_process` | Command Injection |
| 2.3 | HTML: Output-Escaping / Sanitization in Templates | XSS (Cross-Site Scripting) |
| 2.4 | NoSQL: Query-Operatoren validiert (kein `$gt`, `$ne` aus User-Input) | NoSQL Injection (MongoDB etc.) |
| 2.5 | XML: External Entity Processing deaktiviert | XXE (XML External Entity) |
| 2.6 | RegExp: Keine User-kontrollierten Patterns ohne Limits | ReDoS (Regular Expression Denial of Service) |

---

## 3. Authentication & Authorization

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 3.1 | Authentifizierung auf allen schuetzenswerten Endpoints | Unautorisierter Zugriff |
| 3.2 | MFA (Multi-Factor Authentication) fuer kritische Aktionen | Account-Uebernahme |
| 3.3 | Session-Timeout konfiguriert | Offene Sessions auf geteilten Geraeten |
| 3.4 | Session-ID Rotation nach Login | Session Fixation |
| 3.5 | IDOR-Schutz: Autorisierung pro Objekt-Zugriff, nicht nur pro Endpoint | User A sieht Daten von User B (`/api/users/123`) |
| 3.6 | RBAC (Role-Based Access Control) implementiert | Privilege Escalation |
| 3.7 | Mass Assignment verhindert: Whitelist fuer erlaubte Felder | User setzt `isAdmin: true` |
| 3.8 | Passwort-Hashing mit bcrypt/scrypt/argon2 — nicht MD5/SHA1 | Password-Cracking |
| 3.9 | Account Lockout nach fehlgeschlagenen Logins | Brute Force |
| 3.10 | Password-Reset: Token-basiert, zeitlich begrenzt, einmalig | Token-Reuse, Account-Uebernahme |

---

## 4. JWT & OAuth

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 4.1 | JWT: `alg: none` nicht akzeptiert | Signatur-Bypass |
| 4.2 | JWT: Starker Signing Key (RS256 bevorzugt ueber HS256) | Key-Brute-Force |
| 4.3 | JWT: Expiration (`exp`) gesetzt und validiert | Token gilt ewig |
| 4.4 | JWT: Audience (`aud`) und Issuer (`iss`) validiert | Token fuer anderen Service wird akzeptiert |
| 4.5 | JWT: Nicht in `localStorage` — HttpOnly Cookie bevorzugt | XSS stiehlt Token |
| 4.6 | JWT: Key Rotation implementiert | Kompromittierter Key bleibt ewig gueltig |
| 4.7 | OAuth: State-Parameter gegen CSRF | Cross-Site Request Forgery im Auth-Flow |
| 4.8 | OAuth: PKCE fuer Public Clients (SPAs, Mobile) | Authorization Code Interception |
| 4.9 | OAuth: Redirect-URI strikt validiert (kein Open Redirect) | Phishing, Token-Theft |
| 4.10 | OAuth: Kurze Token-Lifetimes + Refresh Token Rotation | Gestohlene Tokens bleiben lange gueltig |

---

## 5. API Security

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 5.1 | Alle Endpoints authentifiziert (kein offener Default) | Unautorisierter Zugriff |
| 5.2 | Rate Limiting konfiguriert | DoS, Brute Force, Scraping |
| 5.3 | Input-Validierung auf Server-Seite (nie nur Client) | Bypass durch direkten API-Aufruf |
| 5.4 | Response-Daten minimal (kein Oversharing) | Sensitive Data Exposure |
| 5.5 | Pagination mit Limits (kein unbegrenztes `?limit=999999`) | Memory Exhaustion |
| 5.6 | API-Versionierung implementiert | Breaking Changes in Production |
| 5.7 | GraphQL: Introspection in Production deaktiviert | Schema-Leak |
| 5.8 | GraphQL: Query Depth Limit gesetzt | DoS durch verschachtelte Queries |
| 5.9 | GraphQL: Query Complexity / Cost Analysis | Resource Exhaustion |
| 5.10 | WebSocket: Authentifizierung bei Connection | Unautorisierter Zugriff |
| 5.11 | WebSocket: Origin-Validierung | Cross-Origin-Hijacking |
| 5.12 | WebSocket: Message Rate Limiting | DoS |

---

## 6. HTTP Security Headers

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 6.1 | `Content-Security-Policy` gesetzt (kein `unsafe-inline/eval`) | XSS |
| 6.2 | `X-Frame-Options: DENY` oder `SAMEORIGIN` | Clickjacking |
| 6.3 | `Strict-Transport-Security` (HSTS) mit Preload | Downgrade-Angriffe |
| 6.4 | `X-Content-Type-Options: nosniff` | MIME Sniffing |
| 6.5 | `Referrer-Policy: strict-origin-when-cross-origin` (oder strenger) | Referrer-Leak von sensiblen URLs |
| 6.6 | `Permissions-Policy` (kamera, mikro, geolocation etc. deaktiviert) | Feature-Abuse |
| 6.7 | CORS: Spezifische Origins — kein Wildcard `*` | Cross-Origin Data Theft |
| 6.8 | CORS: `Access-Control-Allow-Credentials` nur mit expliziter Origin | Cookie-Theft |

---

## 7. Cookie Security

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 7.1 | `HttpOnly` Flag gesetzt | XSS kann Cookie stehlen |
| 7.2 | `Secure` Flag gesetzt | Cookie ueber HTTP sichtbar |
| 7.3 | `SameSite=Strict` oder `Lax` | CSRF |
| 7.4 | Cookie-Prefix `__Host-` oder `__Secure-` bei sensiblen Cookies | Cookie-Injection |
| 7.5 | Session-Cookies ablaufend (nicht persistent) | Langzeit-Session-Diebstahl |

---

## 8. Data Validation & File Handling

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 8.1 | Server-Side Validierung fuer ALLE Inputs (Typ, Laenge, Format) | Bypass durch direkten Request |
| 8.2 | File Upload: Typ-Pruefung (Magic Bytes, nicht nur Extension) | Malware-Upload |
| 8.3 | File Upload: Groessen-Limit | Storage Exhaustion |
| 8.4 | File Upload: Dateien ausserhalb des Web-Root speichern | Direct Access auf hochgeladene Malware |
| 8.5 | File Upload: Generierte Dateinamen (nicht User-kontrolliert) | Path Traversal |
| 8.6 | Path Traversal: Pfade kanonisiert, gegen Whitelist validiert | Zugriff auf `/etc/passwd` etc. |
| 8.7 | SSRF: Ausgehende Requests auf Whitelist beschraenkt | Interner Netzwerk-Scan |
| 8.8 | Deserialization: Keine untrusted Daten deserialisieren | Remote Code Execution |

---

## 9. CSRF (Cross-Site Request Forgery)

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 9.1 | CSRF-Tokens auf allen state-changing Endpoints (POST, PUT, DELETE) | Fremde Website loest Aktionen im Namen des Users aus |
| 9.2 | Double-Submit Cookie Pattern oder Synchronizer Token | CSRF |
| 9.3 | `SameSite` Cookie-Flag als Defense-in-Depth | CSRF |

---

## 10. Dependencies & Supply Chain

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 10.1 | `wheee vulns` regelmaessig ausfuehren | Bekannte CVEs in Dependencies |
| 10.2 | Lock-Files committed (`package-lock.json`, `Gemfile.lock`, etc.) | Reproducible Builds, kein Dependency-Drift |
| 10.3 | Dependencies gepinnt (exakte Versionen) | Unerwartete Breaking Changes |
| 10.4 | Keine unbekannten/unverifizierten Packages | Typosquatting, Malicious Packages |
| 10.5 | Subresource Integrity (SRI) fuer Third-Party Scripts/CSS | CDN-Kompromittierung |
| 10.6 | Software Bill of Materials (SBOM) erstellt | Transparenz ueber alle Abhaengigkeiten |
| 10.7 | Lizenz-Compliance geprueft | Rechtliche Risiken |

---

## 11. Database Security

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 11.1 | DB-User mit minimalen Rechten (Least Privilege) | SQL Injection wird maechtiger als noetig |
| 11.2 | Sensitive Daten verschluesselt at Rest | Data Breach bei Disk-Zugriff |
| 11.3 | Sensitive Daten verschluesselt in Transit (TLS) | Sniffing |
| 11.4 | Connection Pooling mit Timeout konfiguriert | Connection Exhaustion |
| 11.5 | Backups verschluesselt | Backup-Theft |
| 11.6 | Backup-Restore getestet | Backup nutzlos wenn nicht wiederherstellbar |
| 11.7 | PII (Personal Identifiable Information) identifiziert und geschuetzt | DSGVO/GDPR-Verstoss |

---

## 12. Environment & Deployment

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 12.1 | HTTPS erzwungen — kein HTTP-Fallback | Man-in-the-Middle |
| 12.2 | TLS 1.2+ — keine alten Protokolle (SSL3, TLS 1.0/1.1) | Known Vulnerabilities |
| 12.3 | Docker: Non-Root User im Container | Container Escape |
| 12.4 | Docker: Minimale Base Images (Alpine, Distroless) | Reduzierte Attack Surface |
| 12.5 | Docker: Image-Scanning in CI/CD | Vulnerable Base Images |
| 12.6 | Docker: Keine Secrets in Build-Args oder Layern | Layer-Extraction |
| 12.7 | CI/CD: Secrets nicht in Build-Logs | Log-Leak |
| 12.8 | Infrastructure-as-Code gescannt (Terraform, etc.) | Fehlkonfigurationen |
| 12.9 | DNS Rebinding: Hostname-Validierung | Interner Netzwerk-Zugriff |
| 12.10 | Production-Umgebung gehaertet (keine Dev-Tools, Debug-Endpoints) | Information Disclosure |

---

## 13. Logging & Error Handling

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 13.1 | Keine PII in Logs (E-Mail, IP, Name, etc. maskiert) | DSGVO-Verstoss, Data Breach |
| 13.2 | Keine Credentials/Tokens in Logs | Credential-Leak |
| 13.3 | Keine Stack Traces in Production-Responses | Information Disclosure |
| 13.4 | Generische Fehlermeldungen fuer User (keine internen Details) | Information Disclosure |
| 13.5 | Security Events geloggt (Login, Fehlversuche, Permission Denied) | Forensik bei Incidents |
| 13.6 | Log-Rotation und -Retention konfiguriert | Storage Exhaustion, Compliance |
| 13.7 | Logs tamper-proof gespeichert (append-only, zentral) | Log-Manipulation |

---

## 14. Business Logic

| # | Pruefpunkt | Risiko |
|---|-----------|--------|
| 14.1 | Idempotency: Doppelte Submits abgefangen | Doppelte Payments, doppelte Registrierungen |
| 14.2 | Race Conditions: Kritische Operationen serialisiert | Inventory-Overselling, Double-Spending |
| 14.3 | Preis-/Betrags-Berechnung serverseitig — nicht Client | Preis-Manipulation |
| 14.4 | Feature Flags umgehen keine Security-Checks | Auth-Bypass ueber Feature Flag |
| 14.5 | Admin-Funktionen nicht ueber URL erreichbar ohne Auth | Privilege Escalation |

---

## OWASP Top 10 Mapping

| OWASP | Kategorie | Abgedeckt durch |
|-------|-----------|----------------|
| A01: Broken Access Control | Auth, IDOR, RBAC | Abschnitt 3, 5, 14 |
| A02: Cryptographic Failures | Hashing, TLS, Encryption at Rest | Abschnitt 3.8, 11, 12 |
| A03: Injection | SQL, XSS, Command, NoSQL | Abschnitt 2 |
| A04: Insecure Design | Business Logic, Mass Assignment | Abschnitt 3.7, 14 |
| A05: Security Misconfiguration | Headers, CORS, Debug-Mode | Abschnitt 6, 7, 12 |
| A06: Vulnerable Components | Dependencies, Supply Chain | Abschnitt 10 |
| A07: Auth Failures | JWT, OAuth, Session, MFA | Abschnitt 3, 4 |
| A08: Data Integrity Failures | CI/CD, Deserialization | Abschnitt 8.8, 12.7 |
| A09: Logging Failures | PII in Logs, Missing Events | Abschnitt 13 |
| A10: SSRF | Server-Side Request Forgery | Abschnitt 8.7 |

---

## Verwendung im Wheee Protocol

### Link-Phase (B.L.A.S.T. Phase 2)
Gehe diese Checkliste durch und markiere alle Punkte die fuer dein Projekt relevant sind. Nicht jedes Projekt braucht alles — eine statische Seite braucht kein JWT-Handling. Aber die relevanten Punkte muessen BEWUSST als relevant oder nicht-relevant markiert werden.

### Stabilize-Phase (B.L.A.S.T. Phase 4)
Verifiziere alle als relevant markierten Punkte vor dem Deployment. Nutze:
- `wheee vulns` — Dependency-Scan
- `wheee audit` — Projekt-Compliance
- `wheee check` — Service-Health

### Automatisierte Checks
- **Secrets:** `wheee audit` prueft auf `.env` in Git und hardcoded Patterns
- **Dependencies:** `wheee vulns` scannt npm/pip/cargo/go auf CVEs
- **Headers:** Manuell oder mit Tools wie `securityheaders.com`

---

*Last updated: 2026-02-20 — Wheee Protocol v1.5.0*
