# Wheee Protocol

Structured development workflow plugin for Claude Code. Plan once, execute guided or let agent teams run autonomously.

## Install

```bash
claude plugin install wheee
```

## Quick Start

### 1. Initialize a project

```
/wheee:init
```

Creates a `.planning/` directory with ROADMAP.md and STATE.md.

### 2. Plan a phase

```
/wheee:plan-phase 1
```

Creates a detailed PLAN.md with tasks, acceptance criteria, and FIP scope.

### 3. Execute

**Guided** (you supervise each step):
```
/wheee:execute-phase 1
```

**Autonomous** (Agent Team handles it):
```
/wheee:orchestrate 1
```

### 4. Check progress

```
/wheee:progress
```

## How It Works

```
/wheee:init → /wheee:plan-phase → /wheee:execute-phase OR /wheee:orchestrate → /wheee:progress
```

**Guided Mode:** You approve each step. Safer. Good for new projects and sensitive changes.

**Autonomous Mode:** After planning, an Agent Team (researcher, architect, developer, reviewer, tester) executes the phase independently. Faster. Good for well-understood work.

The plan is the same in both modes. Only execution differs.

## Commands (45 total)

| Category | Commands |
|----------|----------|
| **Init** | `init`, `new-project`, `new-milestone` |
| **Plan** | `plan-phase`, `discuss-phase`, `research-phase`, `assess` |
| **Execute** | `execute-phase`, `orchestrate`, `dispatch`, `quick` |
| **Quality** | `quality-gate`, `vulns`, `fip`, `audit` |
| **Manage** | `progress`, `add-phase`, `insert-phase`, `remove-phase`, `cleanup` |
| **Tools** | `check`, `heal`, `perf`, `preview`, `prototype`, `design` |
| **Context** | `pause-work`, `resume-work`, `context`, `map-codebase` |

Run `/wheee:help` for the full command reference.

## Agents

Six specialist agents with persistent memory:

| Agent | Role | Model | Writes Code? |
|-------|------|-------|-------------|
| Orchestrator | Coordinates Agent Teams | inherit | No |
| Researcher | Discovery and analysis | haiku | No |
| Architect | System design | opus | No (plan mode) |
| Developer | Implementation | sonnet | Yes (worktree) |
| Reviewer | Quality + security review | sonnet | No |
| Tester | Testing and verification | sonnet | Yes |

## Safety

- **Code-Gate:** Blocks direct file edits in Wheee-managed projects. Code changes must go through the protocol.
- **Guardrail:** Blocks destructive commands (force-push, rm -rf, DROP TABLE).
- **Planning Compliance:** Blocks review completion until ROADMAP.md and STATE.md are updated.

## Project Structure

```
your-project/
├── .planning/           # Created by /wheee:init
│   ├── ROADMAP.md       # Phase roadmap with checkboxes
│   ├── STATE.md         # Current phase, status, next action
│   └── phases/          # Phase-specific plans and research
│       └── 01-name/
│           ├── PLAN.md
│           └── RESEARCH.md
└── ... your code ...
```

## Configuration

Add project context in `context/` and runtime settings in `args/`. See the README files in each directory.

## License

MIT
