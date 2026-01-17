# @terrazul/cli-qa-engineer

AI-powered QA Engineer for testing command-line interfaces using tmux terminal automation.

## Overview

This package provides skills for automated CLI testing using Claude and the `tmux-mcp` server. It enables:

- **Functional testing** of CLI commands, arguments, and outputs
- **Interactive testing** of prompts, wizards, and multi-step flows
- **Automated reporting** with comprehensive test summaries

## Prerequisites

- **tmux** installed on your system
- **Node.js** (for npx to run tmux-mcp)
- **Claude Code** CLI with MCP support

### Installing tmux

```bash
# macOS
brew install tmux

# Ubuntu/Debian
sudo apt install tmux

# Fedora
sudo dnf install tmux
```

## Installation

```bash
tz add @terrazul/cli-qa-engineer
tz apply
```

## Configuration

During setup, you'll be prompted for:

| Setting | Description | Default |
|---------|-------------|---------|
| CLI Command | The command to test | - |
| Working Directory | Where to run tests | `.` |
| Success Patterns | Output indicating success | `success,completed,done` |
| Error Patterns | Output indicating errors | `error,failed,Error:` |
| Report Directory | Where to save reports | `qa-reports` |
| Session Prefix | Tmux session naming | `cli-qa` |
| Command Timeout | Max wait time (seconds) | `30` |

## Skills

### `/test-cli <command>`

Test a specific CLI command with functional tests.

```bash
# In Claude Code
/test-cli --help
/test-cli init --name myproject
/test-cli build --verbose
```

**What it tests:**
- Command execution success/failure
- Output patterns matching
- Help and version flags
- Error handling

### `/test-interactive <scenario>`

Test interactive CLI prompts and wizards.

```bash
# In Claude Code
/test-interactive init wizard
/test-interactive configuration setup
/test-interactive delete confirmation
```

**What it tests:**
- Prompt detection and response
- Multi-step flow completion
- Selection menus and inputs
- Cancellation handling

### `/cli-qa-report`

Generate a comprehensive QA test report.

```bash
# In Claude Code
/cli-qa-report
/cli-qa-report functional
/cli-qa-report all
```

**What it generates:**
- Markdown report with all test results
- Pass/fail summary statistics
- Issues and recommendations
- JSON summary for automation

## MCP Tools

The package uses `tmux-mcp` which provides:

| Tool | Purpose |
|------|---------|
| `create-session` | Create isolated test sessions |
| `kill-session` | Clean up test sessions |
| `execute-command` | Run CLI commands |
| `capture-pane` | Capture command output |
| `list-sessions` | View active sessions |
| `split-pane` | Parallel test execution |

## Example Usage

### Testing a Node.js CLI

```bash
# Start Claude Code in your CLI project
claude

# Run functional tests
/test-cli --version
/test-cli --help
/test-cli create myapp

# Test interactive init
/test-interactive init

# Generate report
/cli-qa-report
```

### Testing a Python CLI

```bash
# Configure for Python CLI
# CLI Command: python -m mycli

/test-cli --help
/test-cli process input.txt
/cli-qa-report
```

## Report Output

Reports are saved to the configured report directory:

```
qa-reports/
├── cli-qa-report-2025-01-16.md    # Full markdown report
└── cli-qa-summary-2025-01-16.json # JSON summary
```

### Sample Report Structure

```markdown
# CLI QA Test Report

## Executive Summary
- Total Tests: 15
- Passed: 13 (87%)
- Failed: 2 (13%)

## Test Results
...

## Issues Found
### Critical
- None

### Major
- Missing error message for invalid input

## Recommendations
1. Add validation for --output flag
2. Improve error messages
```

## How It Works

1. **Session Isolation**: Each test runs in a dedicated tmux session
2. **Command Execution**: Commands run via tmux execute-command
3. **Output Capture**: Pane content captured for assertions
4. **Pattern Matching**: Success/error patterns validated
5. **Cleanup**: Sessions destroyed after tests

## Troubleshooting

### tmux not found

Ensure tmux is installed and in your PATH:
```bash
which tmux
```

### MCP server not loading

Check that npx can run tmux-mcp:
```bash
npx -y tmux-mcp --help
```

### Tests timing out

Increase the command timeout during configuration, or modify the generated `CLAUDE.md`.

## License

MIT
