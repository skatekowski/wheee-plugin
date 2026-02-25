# Args Directory

Runtime configuration files that control Wheee behavior without editing
skills or commands. Changing args changes behavior.

## Available Configuration

### preferences.yaml (create to customize)

```yaml
# Default execution mode
mode: guided  # guided | autonomous

# Model routing defaults (agents override these)
models:
  research: haiku
  architecture: opus
  implementation: sonnet
  review: sonnet

# Quality gate level override
# auto = determined by change size (default)
# 0-3 = force specific level
quality_gate_level: auto

# Planning document format
planning:
  date_format: "YYYY-MM-DD"
  timezone: "Europe/Berlin"
```

### team.yaml (create for Agent Team customization)

```yaml
# Agent Team composition for autonomous mode
team:
  # Which agents to spawn (all by default)
  agents:
    - researcher
    - architect
    - developer
    - reviewer
    - tester

  # Maximum parallel agents
  max_parallel: 3

  # Auto quality-gate after each phase
  auto_quality_gate: true
```

## How It Works

Commands and agents read args files before execution. If an args file
doesn't exist, defaults are used. Create only the files you need to customize.
