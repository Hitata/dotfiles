#!/usr/bin/env bash
# Compact notification for Claude Code via ntfy
# Receives JSON on stdin with .message field

set -euo pipefail

INPUT=$(cat)
MSG=$(echo "$INPUT" | jq -r '.message // "done"')
PROJECT=$(basename "${CLAUDE_PROJECT_DIR:-${PWD}}")
TITLE="Claude Code | ${PROJECT}"

# Truncate message to 200 chars for compact display
if [ ${#MSG} -gt 200 ]; then
  MSG="${MSG:0:197}..."
fi

curl -s \
  -H "Title: ${TITLE}" \
  -H "Tags: robot" \
  -d "${MSG}" \
  ntfy.sh/secondmind-lai-le105skfckto >/dev/null 2>&1 || true
