#!/usr/bin/env bash
# Hook: Code-Gate (PreToolUse Hook)
# Purpose: Block direct Write/Edit in Wheee-managed projects.
#          Code changes must go through agent teams or guided execution.
# Trigger: PreToolUse on Write, Edit, MultilineEdit
# Exit 0 = allow, Exit 2 = block
#
# When a project has a .planning/ directory, it's Wheee-managed.
# Direct file edits in those projects are blocked — only agent teams
# or guided execution should modify project files.
#
# No overrides. No env vars. No bypass files.
# Use /wheee:quick for legitimate small fixes.
#
# IMPORTANT: This hook is fail-open by design.
# Any unexpected error must exit 0 (allow), never accidentally block.

set -euo pipefail
trap 'exit 0' ERR  # Fail-open: unexpected errors allow the command

# Read hook input from stdin
INPUT=$(cat)

if [[ -z "$INPUT" ]]; then
  exit 0
fi

# Extract the file path from tool input
FILE_PATH=$(echo "$INPUT" | python3 -c "
import json, sys
data = json.load(sys.stdin)
tool_input = data.get('tool_input', {})
# Write tool uses 'file_path', Edit uses 'file_path' too
print(tool_input.get('file_path', ''))
" 2>/dev/null || echo "")

if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

# Resolve to absolute path and normalize (remove ../ traversal)
if [[ "$FILE_PATH" != /* ]]; then
  FILE_PATH="$(pwd)/$FILE_PATH"
fi
FILE_PATH="$(realpath -m "$FILE_PATH" 2>/dev/null || python3 -c "import os,sys; print(os.path.normpath(sys.argv[1]))" "$FILE_PATH" 2>/dev/null || echo "$FILE_PATH")"

# Walk up from the file to find if it's in a Wheee-managed project
CHECK_DIR=$(dirname "$FILE_PATH")
IS_WHEEE_PROJECT=false

while [[ "$CHECK_DIR" != "/" ]]; do
  if [[ -d "$CHECK_DIR/.planning" ]]; then
    IS_WHEEE_PROJECT=true
    PROJECT_ROOT="$CHECK_DIR"
    break
  fi
  CHECK_DIR=$(dirname "$CHECK_DIR")
done

if [[ "$IS_WHEEE_PROJECT" == "false" ]]; then
  exit 0  # Not a Wheee project, allow freely
fi

# Allow edits to planning documents themselves
case "$FILE_PATH" in
  "$PROJECT_ROOT/.planning/"*)
    exit 0
    ;;
  "$PROJECT_ROOT/CLAUDE.md")
    exit 0
    ;;
esac

# Block: Direct edit in a Wheee-managed project
echo "CODE-GATE BLOCKED: Direct file edit in Wheee-managed project."
echo ""
echo "  File: $FILE_PATH"
echo "  Project: $PROJECT_ROOT"
echo ""
echo "Wheee projects require code changes to go through:"
echo "  - /wheee:orchestrate — agent team execution"
echo "  - /wheee:execute-phase — guided phase execution"
echo ""
echo "If this is intentional, use /wheee:quick for small fixes."
exit 2
