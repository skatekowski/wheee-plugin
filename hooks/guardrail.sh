#!/usr/bin/env bash
# Hook: Guardrail (PreToolUse Hook)
# Purpose: Block dangerous/destructive commands before they execute.
# Trigger: PreToolUse on Bash
# Exit 0 = allow, Exit 2 = block
#
# Prevents: force pushes, hard resets, destructive rm, DROP TABLE, etc.

set -euo pipefail

INPUT=$(cat)

if [[ -z "$INPUT" ]]; then
  exit 0
fi

# Extract the command
COMMAND=$(echo "$INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
print(data.get('tool_input', {}).get('command', ''))
" 2>/dev/null || echo "")

if [[ -z "$COMMAND" ]]; then
  exit 0
fi

CMD_LOWER=$(echo "$COMMAND" | tr '[:upper:]' '[:lower:]')

# Blocked patterns — always denied
BLOCKED=(
  "rm -rf /"
  "rm -rf ~"
  "rm -rf ."
  "git push --force"
  "git push -f"
  "git reset --hard"
  "drop table"
  "drop database"
  "truncate table"
)

for pattern in "${BLOCKED[@]}"; do
  if echo "$CMD_LOWER" | grep -qF "$pattern"; then
    echo "GUARDRAIL BLOCKED: Command contains dangerous pattern '$pattern'."
    echo "If you need to do this, ask the user for explicit confirmation first."
    exit 2
  fi
done

# Protected files — cannot be deleted
PROTECTED=(
  ".env"
  "credentials.json"
  "token.json"
  "CLAUDE.md"
  ".planning/ROADMAP.md"
  ".planning/STATE.md"
)

for file in "${PROTECTED[@]}"; do
  if echo "$COMMAND" | grep -qF "$file"; then
    if echo "$CMD_LOWER" | grep -qE "(rm |del |unlink )"; then
      echo "GUARDRAIL BLOCKED: Cannot delete protected file '$file'."
      exit 2
    fi
  fi
done

exit 0
