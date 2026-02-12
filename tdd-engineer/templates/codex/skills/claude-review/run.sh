#!/usr/bin/env bash

# claude-review.sh
#
# Usage:
# ./run.sh 2
#
# Runs: claude -p "<prompt that tells claude to read issue #N + run git status/diff>"
#

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <issue-number>" >&2
  exit 1
fi

ISSUE_NUM="$1"

if ! [[ "$ISSUE_NUM" =~ ^[0-9]+$ ]]; then
  echo "Error: issue-number must be an integer (got: $ISSUE_NUM)" >&2
  exit 1
fi

# Find claude binary
if command -v claude &>/dev/null; then
  CLAUDE_BIN="claude"
else
  echo "Error: claude CLI not found in PATH. Install Claude Code: https://docs.anthropic.com/en/docs/claude-code" >&2
  exit 1
fi

PROMPT=$(
  cat <<EOF
Look at issue #$ISSUE_NUM and then do a git status and where necessary git diff.

Goal: find likely bugs, missing edge cases, type-safety issues, Next.js server/client boundary mistakes, security issues, and missing tests.

Be strict on correctness; avoid large refactors unless necessary.

Output format:

1) Blockers (must-fix before push)
2) Important (should-fix)
3) Nits (optional)
4) Missing tests (specific test cases)
5) Questions for the author (only if truly needed)
EOF
)

"$CLAUDE_BIN" -p "$PROMPT"
