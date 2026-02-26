# Wheee Protocol

**From Vibe Coding to Vibe Engineering.**

Vibe Coding builds fast. It also breaks fast — scope creep, no quality gates, architecture that collapses at scale. Wheee gives AI-assisted development the structure it needs without killing the speed.

This is a Claude Code plugin that turns "just build it" into a repeatable, quality-gated engineering process. You still move fast. But now you know *where* you're going before you start, *what* you're allowed to touch, and *when* it's actually done.

## The Problem

AI can write code faster than ever. But faster code isn't better code:

- Features get built without understanding blast radius
- Nobody asks "what does done look like?" before starting
- Quick fixes bypass review and break unrelated features
- Planning documents exist once, then drift from reality
- There's no quality gate between "it works on my machine" and "it's shipped"

## What Wheee Does

**Think first. Then build. Then verify.** Every time. Enforced by tooling, not willpower.

### B.L.A.S.T. — The 5-Phase Cycle

Every piece of work follows the same structured cycle:

| Phase | What Happens |
|-------|-------------|
| **Blueprint** | Discovery questions define scope, constraints, and success criteria. *What are we building? For whom? What does done look like?* |
| **Link** | Dependency mapping and connectivity checks. The FIP (Functionality Isolation Protocol) maps your blast radius *before* you touch code. |
| **Architect** | System design, technical planning, execution plan with tasks and acceptance criteria. |
| **Stabilize** | Implementation + verification. Tests, linting, smoke tests on protected areas. |
| **Trigger** | Quality gate, planning doc sync, deployment. Nothing ships without passing. |

### The Blueprint Phase Is the Secret Weapon

Before a single line of code is written, Wheee asks the questions that matter:

```
/wheee:new-project
```

- What problem does this project solve?
- Who is the target user?
- What is the core feature set (MVP)?
- What technology stack and constraints exist?
- What are the success criteria?

For existing projects, `/wheee:discuss-phase` gathers context through adaptive questioning — drilling into exactly what a phase needs to achieve, what the inputs are, what the risks are, and what "done" means.

This is where scope gets defined. Where features get shaped before they get built. Where a vague "add authentication" becomes a concrete plan with boundaries.

## Two Execution Modes

The plan is always the same. Only execution differs.

### Guided Mode — You Drive

You approve each step. See what's happening. Learn the codebase.

```
/wheee:init                    # Set up planning structure
/wheee:new-project             # Blueprint: discovery questions
/wheee:plan-phase 1            # Create execution plan
/wheee:execute-phase 1         # Build step by step
/wheee:quality-gate            # Verify before shipping
```

Good for: new projects, sensitive changes, learning a codebase, onboarding.

### Autonomous Mode — Agent Teams Execute

After planning, an Agent Team of 6 specialists handles the phase independently.

```
/wheee:init                    # Same planning
/wheee:new-project             # Same discovery
/wheee:plan-phase 1            # Same plan
/wheee:orchestrate 1           # Agent Team takes over
```

The team self-coordinates:
- **Researcher** gathers context and maps dependencies
- **Architect** designs the solution (plan mode, can't write code)
- **Developer** implements in an isolated worktree
- **Reviewer** runs quality gates and security scans
- **Tester** validates acceptance criteria
- **Orchestrator** coordinates and reports results

Good for: well-understood domains, parallelizable work, scaling output.

## Safety — Enforced by Hooks, Not Rules

AI can be convinced to ignore a rule in a prompt. It cannot bypass a hook that returns exit code 2.

- **Code-Gate**: Physically blocks direct file edits in Wheee-managed projects. All code changes must go through the protocol — no "quick fixes" that bypass review.
- **FIP (Functionality Isolation Protocol)**: Maps every dependency before you change anything. Know your blast radius *before* you create it.
- **Quality Gate**: Automated checks against 12 code quality sections and 14 security sections. Four levels (0-3) based on change size.
- **Planning Compliance**: Blocks completion until ROADMAP.md and STATE.md reflect reality. No more planning docs that drift.
- **Guardrail**: Blocks destructive commands (force-push, rm -rf, DROP TABLE).

## Install

```bash
claude plugin install wheee
```

## Quick Start

```
/wheee:init              # Initialize planning structure
/wheee:new-project       # Discovery: answer the Blueprint questions
/wheee:assess            # Get S/M/L mode recommendation
/wheee:plan-phase 1      # Create execution plan
/wheee:execute-phase 1   # Execute (guided) — or /wheee:orchestrate 1 (autonomous)
/wheee:progress          # Check status, get next action
```

## Commands (45 total)

| Category | Commands | Purpose |
|----------|----------|---------|
| **Discovery** | `new-project`, `discuss-phase`, `research-phase`, `assess` | Define scope, gather context, recommend mode |
| **Planning** | `init`, `plan-phase`, `new-milestone`, `add-phase`, `insert-phase` | Structure the work |
| **Execution** | `execute-phase`, `orchestrate`, `quick` | Build — guided or autonomous |
| **Quality** | `quality-gate`, `vulns`, `fip`, `audit` | Verify before shipping |
| **Management** | `progress`, `pause-work`, `resume-work`, `cleanup` | Track and maintain |
| **Tooling** | `check`, `heal`, `perf`, `preview`, `prototype`, `design` | Dev utilities |

Run `/wheee:help` for the full reference.

## Agents

Six specialist agents with persistent memory across sessions:

| Agent | Role | Model | Can Write Code? |
|-------|------|-------|----------------|
| Orchestrator | Coordinates Agent Teams | inherit | No |
| Researcher | Discovery and dependency analysis | haiku | No |
| Architect | System design and FIP analysis | opus | No (plan mode) |
| Developer | Implementation | sonnet | Yes (isolated worktree) |
| Reviewer | Quality + security review | sonnet | No |
| Tester | Test writing and verification | sonnet | Yes |

Read-only agents (researcher, architect, reviewer) cannot modify code. The developer works in a git worktree — isolated from your main branch. Model routing keeps costs down: haiku for research, opus for architecture, sonnet for everything else.

## Project Structure

```
your-project/
├── .planning/                 # Created by /wheee:init
│   ├── ROADMAP.md             # Phase roadmap with checkboxes
│   ├── STATE.md               # Current phase, status, next action
│   ├── PROJECT.md             # Blueprint: what, who, why
│   ├── REQUIREMENTS.md        # Scope and success criteria
│   └── phases/
│       └── 01-feature-name/
│           ├── CONTEXT.md     # Discovery answers
│           ├── RESEARCH.md    # Research findings
│           ├── PLAN.md        # Execution plan with tasks
│           └── SUMMARY.md     # Phase completion report
└── ... your code ...
```

## Who This Is For

- **Solo developers** who want structure without overhead
- **Teams** where AI agents handle implementation but humans set direction
- **Projects** that outgrew "just vibe it" but don't need enterprise process
- **Anyone** who's had an AI break something because nobody asked "what else uses this code?"

## License

MIT
