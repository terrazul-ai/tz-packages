---
name: create-gemini-command
description: Creates Gemini CLI slash commands in TOML format. Use when user wants to create a new Gemini command, add custom slash functionality for Gemini, or needs help structuring command definitions in TOML format.
---

# Create Gemini Command Skill

This skill guides you through creating Gemini CLI slash commands that users can invoke with `/command-name`. Commands are TOML files stored in `.gemini/commands/`.

## When to Use

Activate this skill when the user wants to:
- Create a new Gemini CLI slash command
- Add custom `/something` functionality for Gemini
- Structure a command definition in TOML format
- Understand Gemini command syntax (different from Claude)
- Convert a workflow into a reusable Gemini command

## Command Creation Workflow

### 1. Understand Command Purpose

Ask the user (or infer from context):
- What should the command do when invoked?
- Does it need user-provided arguments?
- Should it include shell output or file contents?
- Is it for a specific workflow or general use?

### 2. Determine Command Configuration

**Naming**:
- Use lowercase with hyphens: `my-command`
- File extension: `.toml`
- Namespacing via directories: `git/commit.toml` → `/git:commit`

**Special Syntax**:
- `{{args}}` - User-provided arguments
- `!{command}` - Shell command output (executed at runtime)
- `@{filepath}` - File content embedding

### 3. Generate Command File

Create a TOML file with this structure:

```toml
description = "Brief description shown in command list"
prompt = """
Your prompt instructions here.

User arguments: {{args}}
"""
```

### 4. Validation Checklist

Before saving, verify:
- [ ] File is valid TOML syntax
- [ ] `description` field is present and concise
- [ ] `prompt` field contains the command instructions
- [ ] `{{args}}` used if user input is needed
- [ ] Shell commands `!{...}` are safe and necessary
- [ ] File paths `@{...}` are correct
- [ ] Filename matches intended command name

## Command File Naming

Save command files as:
- `.gemini/commands/[name].toml` (for local project)
- `templates/gemini/commands/[name].toml` (for packages)

**Examples**:
- `review.toml` → `/review`
- `git/commit.toml` → `/git:commit`
- `deploy/staging.toml` → `/deploy:staging`

## Special Syntax Reference

### User Arguments: `{{args}}`

Captures everything after the command name:

```toml
prompt = "Explain this code: {{args}}"
```

Usage: `/explain src/auth.ts` → "Explain this code: src/auth.ts"

### Shell Output: `!{command}`

Embeds output of a shell command:

```toml
prompt = """
Current git status:
!{git status}

Review these changes.
"""
```

The shell command runs when the command is invoked.

### File Embedding: `@{filepath}`

Embeds file contents:

```toml
prompt = """
Review this configuration:
@{config/settings.json}

Check for security issues.
"""
```

Paths are relative to project root.

## Quick Start Templates

For common command types, use these templates:
- `templates/basic-command.toml` - Generic command structure

Access templates with: "Use the basic Gemini command template"

## Reference Materials

For detailed information, consult:
- `reference.md` - Complete Gemini command documentation
- `examples.md` - Real-world Gemini command examples

## Tips for Effective Commands

1. **Keep Focused**: One command, one purpose
2. **Clear Instructions**: Tell Gemini exactly what to do
3. **Use Arguments**: Make commands flexible with `{{args}}`
4. **Dynamic Context**: Use `!{...}` for runtime information
5. **Document Well**: Description helps users find commands
6. **Test First**: Try the command after creating it

## Common Patterns

**Code Review Command**:
```toml
description = "Review code for issues"
prompt = """
Review the following code: {{args}}

Check for security, performance, and best practices.
"""
```

**Git Status Command**:
```toml
description = "Review current git changes"
prompt = """
Git status:
!{git status}

Git diff:
!{git diff}

Summarize the current changes.
"""
```

**Config Review Command**:
```toml
description = "Review project configuration"
prompt = """
Review this configuration:
@{package.json}

Check for outdated dependencies and security issues.
"""
```

## Example Invocations

Here are examples of how users might request Gemini commands:

- "Create a Gemini command to review PRs"
- "I need a /git:status command for Gemini"
- "Make a Gemini command for deploying to staging"
- "Build a /explain command for Gemini"
- "Create a command to check project health"

## Platform Note

This skill creates commands for **Gemini CLI** only. Commands use TOML format with:
- `description` and `prompt` fields
- `{{args}}` for user input
- `!{...}` for shell commands
- `@{...}` for file embedding

For Claude commands (which use Markdown format), use the `create-command` skill instead.

## Key Differences from Claude Commands

| Feature | Claude | Gemini |
|---------|--------|--------|
| Format | Markdown (.md) | TOML (.toml) |
| Arguments | `$ARGUMENTS` | `{{args}}` |
| Shell output | Not built-in | `!{command}` |
| File embed | Not built-in | `@{filepath}` |
| Modes | `allowed-modes` | Not supported |
| Frontmatter | YAML | N/A (native TOML) |
