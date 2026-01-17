# @terrazul/general-coder

A comprehensive AI coding assistant package for Terrazul CLI that provides deep codebase understanding, pragmatic TDD workflow enforcement, and intelligent debugging support.

## Features

### 🔍 **Deep Codebase Analysis**
- Automatically detects tech stack and dependencies using exa and context7 MCP servers
- Analyzes project structure, build systems, and testing frameworks
- Generates context-aware documentation tailored to your project

### 🧪 **Pragmatic TDD Workflow**
- Enforces test-driven development for features and bug fixes
- Flexible approach for trivial changes
- Automated test running and failure analysis
- Pre-commit hooks to ensure tests pass

### 🐛 **Intelligent Debugging**
- Automatic error diagnosis from stack traces and logs
- Test failure deep-dive analysis
- Performance profiling and optimization suggestions
- Integration with IDE diagnostics

### 🤖 **Specialized Agents**
- **Test-Driven Developer**: Enforces TDD workflow and writes comprehensive tests
- **Code Reviewer**: Reviews code for all languages with best practices
- **Debugger**: Diagnoses errors and analyzes test failures
- **Architect**: Helps with design decisions and architectural planning

### ⚡ **Developer Experience**
- Custom slash commands for common workflows
- Lifecycle hooks for automation
- Multiple profiles (focus, full, review)
- Context7 integration for up-to-date library documentation
- Exa integration for web research and examples

## Installation

```bash
# Install the package
tz run @terrazul/general-coder
```

## Requirements

### MCP Servers

This package requires the following MCP servers:

1. **context7** (required) - For library documentation
   ```bash
   # Installation instructions for context7
   # Add to your Claude MCP configuration
   ```

2. **exa** (required) - For web search and research
   ```bash
   # Installation instructions for exa
   # Add to your Claude MCP configuration
   ```

3. **github** (optional) - For GitHub integration
   - Requires GitHub Personal Access Token
   - Will prompt during setup if you want to enable

### Claude Code

Requires Claude Code version 0.2.0 or higher.

## Usage

### First-Time Setup

When you do `tz run`, the package will:

1. Ask you questions about your project (name, GitHub URL, test coverage preferences)
2. Analyze your codebase to detect:
   - Programming languages and frameworks
   - Build and run commands
   - Testing setup
   - Debugging tools
3. Generate a customized `CLAUDE.md` with project-specific context
4. Configure MCP servers
5. Install specialized agents and custom commands

### Available Agents

#### Test-Driven Developer (`test-driven-developer`)
Focuses on TDD workflow enforcement:
- Writes tests before implementation
- Ensures comprehensive test coverage
- Runs tests automatically
- Helps fix failing tests

#### Code Reviewer (`code-reviewer`)
Performs thorough code reviews:
- Reviews for best practices
- Checks for security vulnerabilities
- Suggests improvements
- Language-agnostic

#### Debugger (`debugger`)
Helps troubleshoot issues:
- Analyzes error messages and stack traces
- Deep-dives into test failures
- Suggests fixes with context
- Integrates with IDE diagnostics

#### Architect (`architect`)
Assists with design decisions:
- Reviews architectural choices
- Suggests patterns and approaches
- Helps plan implementations
- Read-only (no code changes)

### Custom Commands

#### `/analyze-codebase`
Performs a deep analysis of your codebase structure, dependencies, and patterns.

```bash
/analyze-codebase
```

#### `/run-tests`
Runs your project's test suite and analyzes any failures.

```bash
/run-tests
```

#### `/debug [error|file]`
Helps debug errors or specific files with issues.

```bash
/debug "TypeError: Cannot read property 'foo'"
/debug src/components/Button.tsx
```

#### `/review [file|PR]`
Reviews code changes or files for best practices.

```bash
/review src/utils/helper.ts
/review https://github.com/owner/repo/pull/123
```

### Profiles

The package supports multiple usage profiles:

#### **focus** (Minimal)
Only essential agents for focused development work.

```bash
tz run --profile focus
```

#### **full** (Complete)
All agents and features enabled.

```bash
tz run --profile full
```

#### **review** (Audit)
Only code review and security audit agents.

```bash
tz run --profile review
```

## Configuration

### Settings

The package creates Claude Code settings with sensible defaults:
- Auto-save enabled
- Format on save
- Integrated terminal support
- MCP server configurations

### Hooks

#### Pre-commit Hook
Automatically runs tests before allowing commits.

#### Post-edit Hook
Runs linter/formatter after file edits.

#### Error Detection Hook
Automatically invokes the debugger agent when errors are detected.

## How It Works

### Dynamic Content Generation

The package uses `askAgent` to dynamically analyze your codebase:

1. **Tech Stack Detection**: Analyzes package.json, go.mod, requirements.txt, etc.
2. **Build System Analysis**: Detects npm scripts, Makefile, justfile, etc.
3. **Testing Framework**: Identifies Jest, pytest, go test, etc.
4. **Documentation Generation**: Creates project-specific guidelines

### Caching

Responses from `askAgent` are cached in `agents-cache.toml` to avoid:
- Re-prompting users for the same information
- Re-analyzing the codebase unnecessarily
- Slow re-renders

To force a fresh analysis:

```bash
tz apply --force --no-cache
```

## Best Practices

### TDD Workflow

1. Start with `/run-tests` to understand current test state
2. Use the **test-driven-developer** agent when adding features
3. Write tests first, then implement
4. Use `/run-tests` after changes
5. The pre-commit hook ensures tests pass before committing

### Code Review

1. Use the **code-reviewer** agent for local reviews
2. Use `/review` command for specific files or PRs
3. Review feedback is actionable and specific

### Debugging

1. Copy error messages and use `/debug`
2. The **debugger** agent analyzes context automatically
3. Test failures get deep analysis with suggested fixes

### Architecture

1. Consult **architect** agent for design decisions
2. Agent is read-only, focuses on planning
3. Use before starting major features

## Troubleshooting

### MCP Servers Not Working

Ensure MCP servers are properly configured:

```bash
# Check Claude MCP configuration
cat ~/.claude/mcp_servers.json

# Restart Claude Code after adding servers
```

### Agents Not Available

If agents aren't showing up:

```bash
# Re-apply the package
tz apply --force

# Check symlinks
ls -la .claude/agents
```

### Cache Issues

If stale cache is causing problems:

```bash
# Clear cache and re-render
rm agents-cache.toml
tz apply --no-cache
```

## Contributing

This package is part of the Terrazul ecosystem. Contributions are welcome!

## License

MIT License - see LICENSE file for details

## Support

- [GitHub Issues](https://github.com/terrazul/packages/issues)
- [Documentation](https://terrazul.dev/docs)
- [Community Discord](https://discord.gg/terrazul)
