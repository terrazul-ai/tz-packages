#!/usr/bin/env bash

# codex-review.sh
#
# Usage:
# ./run.sh 2
#
# Runs: codex exec "<prompt that tells codex to read issue #N + run git status/diff>"
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

# Find codex binary - check PATH first, then common locations
if command -v codex &>/dev/null; then
  CODEX_BIN="codex"
else
  echo "Error: codex CLI not found in PATH. Install with: npm install -g @openai/codex" >&2
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

# Run codex in non-interactive mode, save raw output, and print filtered results.
RAW_OUT="$(mktemp -t codex-prepush-review.XXXXXX)"

"$CODEX_BIN" exec --json "$PROMPT" | awk -v f="$RAW_OUT" '{
  print > f
  c++
  printf "\rlines: %d", c > "/dev/stderr"
} END { print "" > "/dev/stderr" }'

cat "$RAW_OUT" | jq -r 'select(.type=="item.completed" and .item.type=="agent_message") | .item.text'
