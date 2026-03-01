# @terrazul/cli-qa-engineer

AI-powered QA Engineer for testing command-line interfaces using tmux terminal automation.

## Overview

This package provides skills for automated CLI testing using Claude and `tmux-cli`. It enables:

- **Functional testing** of CLI commands, arguments, and outputs
- **Interactive testing** of prompts, wizards, and multi-step flows
- **Automated reporting** with comprehensive test summaries

## Prerequisites

- **tmux** installed on your system
- **tmux-cli** installed via `uv tool install tmux-cli`
- **Claude Code** CLI

### Installing tmux

```bash
# macOS
brew install tmux

# Ubuntu/Debian
sudo apt install tmux

# Fedora
sudo dnf install tmux
```

### Installing tmux-cli

```bash
uv tool install tmux-cli
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

## CLI Tools

The package uses `tmux-cli` (run via the Bash tool) which provides:

| Command | Purpose |
|---------|---------|
| `tmux-cli launch "zsh"` | Launch an isolated test pane |
| `tmux-cli send "cmd" --pane=ID` | Run commands in a pane |
| `tmux-cli capture --pane=ID` | Capture pane output |
| `tmux-cli wait_idle --pane=ID` | Wait for command completion |
| `tmux-cli kill --pane=ID` | Clean up test panes |
| `tmux-cli interrupt --pane=ID` | Send Ctrl+C to a pane |
| `tmux-cli escape --pane=ID` | Send Escape to a pane |
| `tmux-cli status` | Show current tmux status |

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

1. **Pane Isolation**: Each test runs in a dedicated tmux pane launched via `tmux-cli launch "zsh"`
2. **Command Execution**: Commands sent via `tmux-cli send`
3. **Idle Detection**: `tmux-cli wait_idle` waits for commands to complete
4. **Output Capture**: Pane content captured via `tmux-cli capture` for assertions
5. **Pattern Matching**: Success/error patterns validated against output
6. **Cleanup**: Test panes killed via `tmux-cli kill` after tests
7. **Safety**: `tmux-cli` prevents you from killing your own pane

## Troubleshooting

### tmux not found

Ensure tmux is installed and in your PATH:
```bash
which tmux
```

### tmux-cli not found

Install via uv:
```bash
uv tool install tmux-cli
```

### Tests timing out

Increase the command timeout during configuration, or modify the generated `CLAUDE.md`.

## License

MIT
