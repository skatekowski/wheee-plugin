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

## Three Execution Modes

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

### Design Mode — UX Before Code

Start with the user experience, not the architecture. Mode D lets you explore UI/UX concepts, wireframes, and interaction flows before any technical planning begins.

```
/wheee:design                  # Start a UX/UI design round
/wheee:convert                 # Turn design findings into S/M/L phases
```

Design Mode produces UX artifacts — screens, flows, component inventories. When the design is solid, `/wheee:convert` transforms those findings into concrete technical phases with tasks and acceptance criteria. The design drives the engineering, not the other way around.

#### The Design Critic

In autonomous mode, the **Critic agent** evaluates every design output against strict criteria — visual hierarchy, consistency, accessibility, spacing, typography, contrast ratios. It uses browser tools (Playwright, Chrome Extension, Preview Server) to take screenshots and inspect actual rendered CSS.

The Critic scores each criterion 0-10 and gives a verdict: **PASS**, **ITERATE**, or **RETHINK**. No design moves to implementation without passing.

Custom criteria? Drop a `.planning/DESIGN-CRITERIA.md` and the Critic uses your rules instead of the defaults.

The Critic also runs during Guided and Autonomous Mode whenever a phase involves UI work — after the Developer builds a frontend component, the Critic inspects the rendered result before the Reviewer signs off.

Good for: new products, UX-heavy features, redesigns, anything where "what should it look like?" comes before "how should it work?".

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
| **Design** | `design`, `convert`, `prototype`, `preview` | UX/UI first, then convert to engineering |
| **Quality** | `quality-gate`, `vulns`, `fip`, `audit` | Verify before shipping |
| **Management** | `progress`, `pause-work`, `resume-work`, `cleanup` | Track and maintain |
| **Tooling** | `check`, `heal`, `perf`, `preview`, `prototype`, `design` | Dev utilities |

Run `/wheee:help` for the full reference.

## Agents

Seven specialist agents with persistent memory across sessions:

| Agent | Role | Model | Can Write Code? |
|-------|------|-------|----------------|
| Orchestrator | Coordinates Agent Teams | inherit | No |
| Researcher | Discovery and dependency analysis | haiku | No |
| Architect | System design and FIP analysis | opus | No (plan mode) |
| Developer | Implementation | sonnet | Yes (isolated worktree) |
| Reviewer | Quality + security review | sonnet | No |
| Tester | Test writing and verification | sonnet | Yes |
| Critic | Design evaluation via browser inspection | opus | No |

Read-only agents (researcher, architect, reviewer, critic) cannot modify code. The developer works in a git worktree — isolated from your main branch. The critic uses browser tools to visually inspect rendered designs. Model routing keeps costs down: haiku for research, opus for architecture and design critique, sonnet for everything else.

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

## Standing On The Shoulders Of

Wheee didn't come from nowhere. It builds on ideas from people who figured out pieces of this puzzle first:

- **[GSD (Get Shit Done)](https://github.com/gsd-build/get-shit-done)** — The context engineering and atomic planning methodology that Wheee adapts and extends. Wave-based parallelization, fresh context per task, structured planning documents. GSD showed that AI-assisted development needs deliberate context management to maintain quality at scale.

- **[Boris Cherny's workflow](https://x.com/AskBorislav/status/2007179832300581177)** — Boris built Claude Code at Anthropic. His approach to parallel Claude sessions, plan-mode-first development, verification via browser tools, and shared CLAUDE.md conventions directly influenced how Wheee structures its execution modes and agent coordination.

## License

MIT
