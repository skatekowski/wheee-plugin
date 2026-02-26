#!/usr/bin/env bash
# Hook: Guardrail (PreToolUse Hook)
# Purpose: Block dangerous/destructive commands before they execute.
# Trigger: PreToolUse on Bash
# Exit 0 = allow, Exit 2 = block
#
# Prevents: force pushes, hard resets, destructive rm, DROP TABLE,
#           unsafe chmod, piped script execution, find -delete, etc.
#
# IMPORTANT: This hook is fail-open by design.
# Any unexpected error must exit 0 (allow), never accidentally block.

set -euo pipefail
trap 'exit 0' ERR  # Fail-open: unexpected errors allow the command

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

# ── Dangerous pattern detection (regex-based) ────────────────────────

# 1. rm with recursive+force flags in any order (rm -rf, rm -fr, rm -rfi, etc.)
if echo "$CMD_LOWER" | grep -qE "rm[[:space:]]+-[a-z]*r[a-z]*f|rm[[:space:]]+-[a-z]*f[a-z]*r"; then
  echo "GUARDRAIL BLOCKED: 'rm' with recursive+force flags detected."
  echo "If you need to do this, ask the user for explicit confirmation first."
  exit 2
fi

# 2. find with -delete (equivalent to rm -rf)
if echo "$CMD_LOWER" | grep -qE "find[[:space:]]+.*-delete"; then
  echo "GUARDRAIL BLOCKED: 'find -delete' is equivalent to recursive deletion."
  echo "If you need to do this, ask the user for explicit confirmation first."
  exit 2
fi

# 3. git force push (--force or -f after push)
if echo "$CMD_LOWER" | grep -qE "git[[:space:]]+push[[:space:]]+.*--force|git[[:space:]]+push[[:space:]]+-[a-z]*f"; then
  echo "GUARDRAIL BLOCKED: Force push detected."
  echo "If you need to do this, ask the user for explicit confirmation first."
  exit 2
fi

# 4. git reset --hard
if echo "$CMD_LOWER" | grep -qE "git[[:space:]]+reset[[:space:]]+.*--hard"; then
  echo "GUARDRAIL BLOCKED: 'git reset --hard' detected."
  echo "If you need to do this, ask the user for explicit confirmation first."
  exit 2
fi

# 5. SQL destructive operations
if echo "$CMD_LOWER" | grep -qE "drop[[:space:]]+(table|database)|truncate[[:space:]]+table"; then
  echo "GUARDRAIL BLOCKED: Destructive SQL operation detected."
  echo "If you need to do this, ask the user for explicit confirmation first."
  exit 2
fi

# 6. Unsafe chmod (world-writable or no permissions)
if echo "$CMD_LOWER" | grep -qE "chmod[[:space:]]+(777|000|666)[[:space:]]"; then
  echo "GUARDRAIL BLOCKED: Unsafe chmod detected (777/000/666)."
  echo "If you need to do this, ask the user for explicit confirmation first."
  exit 2
fi

# 7. Piped script execution from untrusted sources
if echo "$CMD_LOWER" | grep -qE "curl[[:space:]]+.*\|[[:space:]]*(ba)?sh|wget[[:space:]]+.*\|[[:space:]]*(ba)?sh"; then
  echo "GUARDRAIL BLOCKED: Piping remote content to shell detected."
  echo "If you need to do this, ask the user for explicit confirmation first."
  exit 2
fi

# ── Protected files — cannot be deleted ──────────────────────────────
# Uses CMD_LOWER for both file and operation matching (consistent casing)
PROTECTED=(
  ".env"
  ".env.local"
  ".env.production"
  ".env.development"
  ".env.staging"
  "credentials.json"
  "token.json"
  "id_rsa"
  "id_ed25519"
  "claude.md"
  ".planning/roadmap.md"
  ".planning/state.md"
)

for file in "${PROTECTED[@]}"; do
  if echo "$CMD_LOWER" | grep -qF "$file"; then
    if echo "$CMD_LOWER" | grep -qE "(rm |del |unlink |mv |>|truncate )"; then
      echo "GUARDRAIL BLOCKED: Cannot delete/overwrite protected file '$file'."
      exit 2
    fi
  fi
done

exit 0
