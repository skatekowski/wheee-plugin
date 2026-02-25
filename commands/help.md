---
name: wheee:help
description: Befehle und Usage anzeigen
allowed-tools:
  - Read
---

<objective>
Show all available Wheee commands and their usage.
</objective>

<process>
1. Read `docs/Wheee-COMMANDS.md` from the wheee-protocol installation.
2. Display the command reference to the user.
3. If the file is not found, display the built-in command list:

## Workflow Commands (/wheee:...)
| Command | Description |
|---------|-------------|
| `/wheee:new-project` | Initialize new project (Discovery & Research) |
| `/wheee:new-milestone` | Start new milestone cycle |
| `/wheee:discuss-phase [N]` | Gather phase context via adaptive questions |
| `/wheee:research-phase [N]` | Conduct research for phase |
| `/wheee:plan-phase [N]` | Create execution plan (PLAN.md) |
| `/wheee:add-phase` | Add new phase at end of roadmap |
| `/wheee:insert-phase` | Insert urgent phase between existing |
| `/wheee:remove-phase [N]` | Remove phase and renumber |
| `/wheee:execute-phase [N]` | Execute phase (wave-based) |
| `/wheee:quick` | Quick task with GSD guarantees |
| `/wheee:verify-work` | UAT validation |
| `/wheee:progress` | Check progress, next action |
| `/wheee:check-todos` | Show open todos |
| `/wheee:add-todo` | Capture todo |
| `/wheee:audit-milestone` | Milestone audit |
| `/wheee:plan-milestone-gaps` | Plan phases for gaps from audit |
| `/wheee:complete-milestone` | Archive milestone |
| `/wheee:pause-work` | Context handoff |
| `/wheee:resume-work` | Resume with context |
| `/wheee:debug` | Systematic debugging |
| `/wheee:map-codebase` | Analyze codebase |
| `/wheee:list-phase-assumptions` | Show assumptions for phase |
| `/wheee:settings` | Configure workflow/profile |
| `/wheee:set-profile` | Switch model profile |
| `/wheee:help` | This help |

## CLI Commands (/wheee:... → wheee ...)
| Command | Terminal | Description |
|---------|----------|-------------|
| `/wheee:init` | `wheee init` | Initialize Wheee in project |
| `/wheee:version` | `wheee version` | Show version |
| `/wheee:audit` | `wheee audit` | Wheee compliance check |
| `/wheee:assess` | `wheee assess` | Recommend mode S/M/L |
| `/wheee:fip [target]` | `wheee fip` | Find dependencies |
| `/wheee:log [type]` | `wheee log` | Process journal entry |
| `/wheee:heal` | `wheee heal` | Self-healing build |
| `/wheee:context` | `wheee context` | Context health check |
| `/wheee:cleanup` | `wheee cleanup` | Archive completed phases |
| `/wheee:sync` | `wheee sync` | Living SOP sync |
| `/wheee:check` | `wheee check` | Health checks (APIs, services) |
| `/wheee:vulns` | `wheee vulns` | Vulnerability scan |
| `/wheee:perf` | `wheee perf` | Performance check |
| `/wheee:orchestrate` | `wheee orchestrate` | Multi-agent orchestration |
| `/wheee:agents` | `wheee agents` | Show agent status |
| `/wheee:design` | `wheee design` | UX/UI design round (Mode D) |
| `/wheee:prototype` | `wheee prototype` | Generate prototype from design |
| `/wheee:preview` | `wheee preview` | Preview server for prototypes |
| `/wheee:convert` | `wheee convert` | Convert Mode D to S/M/L project |
</process>
