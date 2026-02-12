# Codex Pre-Push Review

Use this skill when instructed by the user, typically when finished with implementing an issue.

## Purpose

Run OpenAI Codex locally to review changes related to a GitHub issue. Codex will inspect the issue, run git status / git diff as needed, and return a structured review.

## When to use

When instructed by the user

## How it works

- Takes a GitHub issue number as input
- Executes the `run.sh` script in this skill's directory
- Writes raw JSON output to a temporary file
- Prints only the filtered review text (agent message output)

## Usage

Run the review script with an issue number:

```bash
bash .claude/skills/codex-review/run.sh <issue-number>
```

## Expected output

1. Blockers (must-fix before push)
2. Important (should-fix)
3. Nits (optional)
4. Missing tests
5. Questions for the author (if needed)

Do not modify the script behavior. Address blockers before continuing.
