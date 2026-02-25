# Context Directory

Project-specific domain knowledge. Drop markdown files here to give agents
context about your project's domain, constraints, and conventions.

## Suggested Files

- `tech-stack.md` — Framework versions, language conventions, build tools
- `api-contracts.md` — External API documentation, endpoint specs
- `constraints.md` — Business rules, compliance requirements, limitations
- `architecture.md` — System architecture, data flow, infrastructure
- `conventions.md` — Code style, naming patterns, project-specific rules

## How It Works

Agents reference context files automatically when relevant to their task.
The researcher agent reads context during discovery. The architect references
it during design. The developer follows conventions during implementation.

## Rules

- Keep files focused: one topic per file
- Use markdown with clear headings
- Include version numbers and dates for external dependencies
- Skill-specific references go in `skills/<name>/references/`, not here
