#!/usr/bin/env bash
# Hook: Planning Compliance (PostToolUse Hook)
# Purpose: After dispatch-review, verify ROADMAP.md and STATE.md are updated.
#          Review is NOT complete until planning docs reflect the changes.
# Trigger: PostToolUse on Bash (after dispatch-review scripts)
# Exit 0 = pass, Exit 2 = block (remind to update docs)
#
# This hook checks if planning documents were recently modified
# after a dispatch-review completes. If not, it blocks completion.

set -euo pipefail
trap 'exit 0' ERR  # Fail-open: unexpected errors allow the command

# Read hook input from stdin
INPUT=$(cat)

if [[ -z "$INPUT" ]]; then
  exit 0
fi

# Check if this was a dispatch-review related command
IS_REVIEW=$(echo "$INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
tool_input = data.get('tool_input', {})
command = tool_input.get('command', '')
# Check if this looks like a dispatch-review completion
if 'dispatch-review' in command or 'task_complete' in command:
    print('yes')
else:
    print('no')
" 2>/dev/null || echo "no")

if [[ "$IS_REVIEW" != "yes" ]]; then
  exit 0  # Not a review command, skip
fi

# Find the Wheee project root
PROJECT_ROOT=""
CHECK_DIR="$(pwd)"
while [[ "$CHECK_DIR" != "/" ]]; do
  if [[ -d "$CHECK_DIR/.planning" ]]; then
    PROJECT_ROOT="$CHECK_DIR"
    break
  fi
  CHECK_DIR=$(dirname "$CHECK_DIR")
done

if [[ -z "$PROJECT_ROOT" ]]; then
  exit 0  # No Wheee project found
fi

ROADMAP="$PROJECT_ROOT/.planning/ROADMAP.md"
STATE="$PROJECT_ROOT/.planning/STATE.md"

# Check if both files exist
if [[ ! -f "$ROADMAP" ]] || [[ ! -f "$STATE" ]]; then
  echo "PLANNING COMPLIANCE: Missing planning documents."
  echo "  ROADMAP.md exists: $([ -f "$ROADMAP" ] && echo 'yes' || echo 'NO')"
  echo "  STATE.md exists: $([ -f "$STATE" ] && echo 'yes' || echo 'NO')"
  exit 2
fi

# Check if files were modified in the last 5 minutes (300 seconds)
NOW=$(date +%s)
ROADMAP_MOD=$(stat -f %m "$ROADMAP" 2>/dev/null || stat -c %Y "$ROADMAP" 2>/dev/null || echo 0)
STATE_MOD=$(stat -f %m "$STATE" 2>/dev/null || stat -c %Y "$STATE" 2>/dev/null || echo 0)

ROADMAP_AGE=$((NOW - ROADMAP_MOD))
STATE_AGE=$((NOW - STATE_MOD))

ISSUES=""

if [[ $ROADMAP_AGE -gt 300 ]]; then
  ISSUES="${ISSUES}\n  - ROADMAP.md not updated (last modified ${ROADMAP_AGE}s ago)"
fi

if [[ $STATE_AGE -gt 300 ]]; then
  ISSUES="${ISSUES}\n  - STATE.md not updated (last modified ${STATE_AGE}s ago)"
fi

if [[ -n "$ISSUES" ]]; then
  echo "PLANNING COMPLIANCE: Review is NOT complete."
  echo ""
  echo "After dispatch-review, you MUST update:"
  printf "%b" "$ISSUES"
  echo ""
  echo "Required updates:"
  echo "  1. ROADMAP.md — Update checkboxes for completed tasks"
  echo "  2. STATE.md — Set current phase, status, and next action"
  exit 2
fi

exit 0
