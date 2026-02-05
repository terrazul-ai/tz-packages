---
name: create-command
description: Creates Claude Code slash commands with proper Markdown format and YAML frontmatter. Use when user wants to create a new command, add custom slash functionality, or needs help structuring command definitions for Claude.
---

# Create Command Skill

This skill guides you through creating Claude Code slash commands that users can invoke with `/command-name`. Commands are Markdown files with YAML frontmatter stored in `.claude/commands/`.

## When to Use

Activate this skill when the user wants to:
- Create a new Claude Code slash command
- Add custom `/something` functionality
- Structure a command definition file
- Understand command components (frontmatter, prompt, arguments)
- Convert a workflow into a reusable command

## Command Creation Workflow

### 1. Understand Command Purpose

Ask the user (or infer from context):
- What should the command do when invoked?
- Does it need user-provided arguments?
- Is it for a specific workflow or general use?
- Should it be allowed in all modes or restricted?

### 2. Determine Command Configuration

**Naming**:
- Use lowercase with hyphens: `my-command`
- Keep names short and descriptive
- Avoid conflicts with built-in commands

**Arguments**:
- Use `$ARGUMENTS` placeholder for user input
- Arguments are passed after the command name: `/my-command these are the arguments`
- Arguments are optional - command works with or without them

**Allowed Modes** (optional):
- `plan` - Only available in plan mode
- `code` - Only available in code mode
- Omit to allow in all modes

### 3. Generate Command File

Create a markdown file with this structure:

```markdown
---
description: Brief description shown in command list
allowed-modes:
  - plan
  - code
---

[Your prompt/instructions here]

Use $ARGUMENTS for user input.
```

### 4. Validation Checklist

Before saving, verify:
- [ ] YAML frontmatter is valid (use triple dashes `---`)
- [ ] Description is concise and actionable (< 200 chars)
- [ ] Filename matches intended command name (e.g., `review.md` for `/review`)
- [ ] `$ARGUMENTS` used if user input is needed
- [ ] Instructions are clear and focused
- [ ] Allowed modes are appropriate (or omitted for all modes)

## Command File Naming

Save command files as:
- `.claude/commands/[name].md` (for local project)
- `templates/claude/commands/[name].md` (for packages)

The filename (without `.md`) becomes the command name.

**Examples**:
- `review.md` → `/review`
- `deploy-staging.md` → `/deploy-staging`
- `generate-tests.md` → `/generate-tests`

## Quick Start Templates

For common command types, use these templates as starting points:
- `templates/basic-command.md` - Generic command structure

Access templates with: "Use the basic command template"

## Reference Materials

For detailed information, consult:
- `reference.md` - Complete command structure documentation
- `examples.md` - Real-world command examples

## Tips for Effective Commands

1. **Keep Focused**: One command, one purpose
2. **Clear Instructions**: Tell Claude exactly what to do
3. **Use Arguments**: Make commands flexible with `$ARGUMENTS`
4. **Document Well**: Description helps users find commands
5. **Test First**: Try the command after creating it
6. **Iterate**: Refine based on actual usage

## Common Patterns

**Code Review Command**:
- Purpose: Review code for specific concerns
- Arguments: File path or PR number
- Example: `/review $ARGUMENTS for security issues`

**Generate Command**:
- Purpose: Create boilerplate or templates
- Arguments: Type or name of thing to generate
- Example: `/generate a React component named $ARGUMENTS`

**Deploy Command**:
- Purpose: Trigger deployment workflows
- Arguments: Environment or version
- Example: `/deploy to $ARGUMENTS environment`

**Explain Command**:
- Purpose: Get explanations of code/concepts
- Arguments: Topic or file to explain
- Example: `/explain $ARGUMENTS in detail`

## Example Invocations

Here are examples of how users might request different commands:

- "Create a command to review PRs"
- "I need a /generate-tests command"
- "Make a command for deploying to staging"
- "Build a /explain command for code explanations"
- "Create a command to lint and fix code"

For each request, determine the appropriate structure based on the patterns above.

## Platform Note

This skill creates commands for **Claude Code** only. Commands use Markdown format with:
- YAML frontmatter for metadata
- `$ARGUMENTS` for user input

For Gemini commands (which use TOML format), use the `create-gemini-command` skill instead.
