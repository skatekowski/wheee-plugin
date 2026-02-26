# Wheee Protocol Plugin — Architecture

> Give this document to any AI or human. They'll understand the full system,
> why every decision was made, and how to extend it.

---

## What This Is

The Wheee Protocol is a Claude Code plugin that structures software development
into planned, phased, quality-gated workflows. It provides:

- **45 workflow commands** — A complete development process vocabulary
- **6 specialist agents** — Persistent-memory roles for autonomous execution
- **4 core skills** — Quality gates, security scanning, dependency analysis, codebase mapping
- **3 safety hooks** — Code-Gate, guardrail, planning compliance
- **2 execution modes** — Guided (user supervises) or Autonomous (Agent Teams)

The plugin installs via `claude plugin install wheee` and works with any project.

---

## Why It Exists

### The Problem

Software projects fail not because of bad code, but because of bad process:
- Changes without understanding blast radius
- No quality gates before merge
- Planning documents that drift from reality
- "Quick fixes" that bypass review

### What Wheee Does

**Plan → Execute → Verify.** Every time. No exceptions.

The protocol enforces this through tooling, not willpower:
- Code-Gate hooks physically block direct file edits in managed projects
- Planning compliance hooks block review completion until docs are updated
- Quality gate skills run automated checks against security and code quality checklists
- FIP (Functionality Isolation Protocol) maps blast radius before changes

---

## The Two Modes

### Guided Mode

The user drives. Claude assists. Every step requires approval.

```
User: /wheee:init
User: /wheee:plan-phase 1
  → Claude creates PLAN.md, user reviews
User: /wheee:execute-phase 1
  → Claude implements, user approves each file change
User: /wheee:progress
  → Status check, next action suggested
```

This is the default. It's safer. It's slower. It's right for:
- New projects (understanding the codebase)
- Sensitive changes (auth, payments, data migrations)
- Learning (user wants to understand what's happening)

### Autonomous Mode (Agent Teams)

The user plans. Agent Teams execute. Results are reviewed at the end.

```
User: /wheee:init
User: /wheee:plan-phase 1
  → Same planning phase, same PLAN.md
User: /wheee:orchestrate 1
  → Orchestrator spawns Agent Team:
    - Researcher gathers context
    - Architect designs solution
    - Developer implements in worktree
    - Reviewer checks quality + security
    - Tester validates acceptance criteria
  → Orchestrator reports results
User: Reviews output, approves or requests changes
```

This is faster. It's right for:
- Well-understood domains
- Phases with clear acceptance criteria
- Parallelizable work (frontend + backend simultaneously)

**Key insight:** The plan is the same in both modes. Only execution differs.

---

## File Structure

```
wheee-plugin/
├── .claude-plugin/
│   └── plugin.json                  # Plugin manifest (name, version, metadata)
│
├── commands/                        # 45 Wheee Protocol commands
│   ├── init.md                      # Initialize project planning
│   ├── plan-phase.md                # Create phase execution plan
│   ├── execute-phase.md             # Guided phase execution
│   ├── orchestrate.md               # Autonomous Agent Team execution
│   ├── progress.md                  # Status + next action
│   ├── quality-gate.md              # Run quality checks
│   ├── vulns.md                     # Security vulnerability scan
│   ├── fip.md                       # Functionality Isolation Protocol
│   ├── audit.md                     # Project doctor — compliance check
│   └── ... (36 more commands)       # Full protocol vocabulary
│
├── agents/                          # 6 specialist agent definitions
│   ├── orchestrator.md              # Team Lead — coordinates Agent Teams
│   ├── researcher.md                # Read-only discovery and analysis
│   ├── architect.md                 # System design, plan mode
│   ├── developer.md                 # Code implementation, worktree isolation
│   ├── reviewer.md                  # Quality + security review
│   └── tester.md                    # Testing and verification
│
├── skills/                          # Core analysis skills
│   ├── quality-gate/
│   │   ├── SKILL.md                 # Comprehensive quality + security audit
│   │   └── references/
│   │       ├── CODE-QUALITY-CHECKLIST.md
│   │       └── SECURITY-CHECKLIST.md
│   ├── security-scan/
│   │   ├── SKILL.md                 # OWASP-based vulnerability scanning
│   │   └── references/
│   │       └── SECURITY-CHECKLIST.md
│   ├── fip/
│   │   └── SKILL.md                 # Dependency graph + blast radius
│   └── codebase-map/
│       └── SKILL.md                 # Project structure analysis
│
├── hooks/                           # Safety enforcement
│   ├── hooks.json                   # Hook configuration
│   ├── code-gate.sh                 # PreToolUse: Block edits in Wheee projects
│   ├── guardrail.sh                 # PreToolUse: Block destructive commands
│   └── planning-compliance.sh       # PostToolUse: Enforce doc updates
│
├── templates/                       # Planning document scaffolds
│   └── planning/
│       ├── ROADMAP.md               # Phase roadmap template
│       ├── STATE.md                 # Current state template
│       └── phase/                   # Per-phase template structure
│
├── context/                         # Project-specific domain knowledge
│   └── README.md                    # How to add project context
│
├── args/                            # Runtime configuration
│   └── README.md                    # Available settings
│
├── memory/                          # Persistent cross-session learnings
│   ├── MEMORY.md                    # Always loaded (< 200 lines)
│   └── logs/                        # Daily session logs
│
├── data/                            # Runtime data storage
├── docs/                            # Extended documentation
├── tests/                           # Plugin tests
├── .tmp/                            # Disposable scratch space
│
├── CLAUDE.md                        # KERNEL — System instructions
├── ARCHITECTURE.md                  # THIS FILE
└── README.md                        # Public quickstart
```

---

## Key Design Decisions

### 1. Plan Is Always The Same — Only Execution Differs

PLAN.md is the single source of truth for what a phase does. Guided mode and
autonomous mode read the same plan. This means:

- Switching modes mid-project is safe
- Plans can be reviewed before choosing execution mode
- Quality gates apply equally to both modes

### 2. Agent Teams, Not Subagents, for Autonomous Mode

Subagents report back to the main thread — they're not truly autonomous.
Agent Teams have their own context windows and communicate directly:

| Feature | Subagents | Agent Teams |
|---------|-----------|-------------|
| Context | Shared with parent | Independent per agent |
| Communication | Return to parent | Direct inter-agent messaging |
| Task management | Parent assigns | Self-claim from shared list |
| Autonomy | Supervised | Truly independent |

The orchestrator spawns teammates, shares the task list, and monitors progress.
Teammates claim tasks, execute, and report completion independently.

### 3. Code-Gate Is a Hook, Not a Rule

CLAUDE.md rules can be reasoned around. A hook that returns exit code 2 is
significantly harder to bypass — it physically blocks Write/Edit/MultilineEdit
operations in Wheee-managed projects (directories with `.planning/`).
There are no override mechanisms or environment variables. This ensures:

- All code changes go through the protocol (execute-phase, orchestrate, quick)
- No "quick fixes" bypass quality gates
- Review findings become follow-up tasks, not inline patches

### 4. Six Agents With Clear Separation

| Agent | Model | Can Write? | Isolation | Memory | Purpose |
|-------|-------|-----------|-----------|--------|---------|
| Orchestrator | inherit | No | — | user | Coordinate teams, track progress |
| Researcher | haiku | No | — | user | Discovery, context building |
| Architect | opus | No | plan mode | user | System design, FIP analysis |
| Developer | sonnet | Yes | worktree | project | Implementation |
| Reviewer | sonnet | No | — | user | Quality + security review |
| Tester | sonnet | Yes | — | project | Test writing + verification |

Key principles:
- **Read-only agents cannot modify code** (researcher, architect, reviewer)
- **Developer works in a worktree** — isolated from main branch
- **Model routing for cost** — haiku for research, opus for architecture, sonnet for execution
- **Memory scoping** — user-level for cross-project learnings, project-level for project-specific

### 5. Skills Are Checklists, Not Pipelines

Unlike the AI OS (which has script-based pipelines), Wheee skills are
checklist-driven analysis tools. They don't produce outputs — they produce
reports. The quality-gate skill checks 12 code quality sections + 14 security
sections and reports pass/fail. The agent decides what to do with the report.

### 6. Commands Are the Wheee Protocol

The 45 commands ARE the protocol. They define:
- Initialization: `init`, `new-project`, `new-milestone`
- Planning: `plan-phase`, `discuss-phase`, `research-phase`
- Execution: `execute-phase`, `orchestrate`, `quick`
- Quality: `quality-gate`, `vulns`, `fip`, `audit`
- Management: `progress`, `pause-work`, `resume-work`, `cleanup`
- Tooling: `check`, `heal`, `perf`, `preview`, `prototype`

Each command is a markdown file with instructions. Claude matches them by
description when users type natural language.

### 7. Hooks for Safety, Not Automation

Three hooks, three concerns:
- **Code-Gate** (PreToolUse) — Enforces the protocol. No direct edits.
- **Guardrail** (PreToolUse) — Prevents destruction. No force-push, no rm -rf.
- **Planning Compliance** (PostToolUse) — Enforces documentation. No undocumented changes.

All hooks fail-open (exit 0 on errors). They never break the workflow.
They only block intentional protocol violations.

---

## How It Works (End to End)

### Project Initialization

```
1. User installs plugin: claude plugin install wheee
2. User starts a project: /wheee:init
3. Wheee creates .planning/ directory:
   ├── ROADMAP.md         # Phase roadmap with checkboxes
   ├── STATE.md           # Current phase, status, next action
   └── phases/            # Phase-specific plans and context
4. Code-Gate hook activates (detects .planning/)
5. All file edits now require going through the protocol
```

### Guided Execution

```
1. /wheee:plan-phase 1
2. Claude reads context, creates PLAN.md with tasks + acceptance criteria
3. User reviews and approves the plan
4. /wheee:execute-phase 1
5. Claude executes task by task, asking for approval at each step
6. /wheee:quality-gate runs at the end
7. Planning docs updated (enforced by hook)
8. Phase marked complete in ROADMAP.md
```

### Autonomous Execution

```
1. /wheee:plan-phase 1
2. Same PLAN.md, same review, same approval
3. /wheee:orchestrate 1
4. Orchestrator reads PLAN.md, decomposes into tasks
5. Spawns Agent Team: researcher + architect + developer + reviewer + tester
6. Shared task list: each agent claims tasks independently
7. Developer works in isolated worktree
8. Reviewer runs quality-gate on results
9. Tester validates acceptance criteria
10. Orchestrator collects results, reports to user
11. Planning docs updated
```

---

## How to Extend

### Add Project Context

Drop markdown files in `context/`:
- `context/tech-stack.md` — Framework versions, conventions
- `context/api-contracts.md` — External API documentation
- `context/constraints.md` — Business rules, compliance requirements

Agents reference these automatically when relevant.

### Add Custom Skills

Create a new directory in `skills/`:
```
skills/my-skill/
├── SKILL.md           # Process definition (YAML frontmatter + instructions)
└── references/        # Supporting documents
```

Skills are auto-discovered by description matching in the SKILL.md frontmatter.

### Configure Runtime Behavior

Edit files in `args/`:
- `args/preferences.yaml` — Default mode (guided/autonomous), model routing
- `args/team.yaml` — Agent Team composition and constraints

### Add Hooks

Add new hook scripts and update `hooks/hooks.json`.
