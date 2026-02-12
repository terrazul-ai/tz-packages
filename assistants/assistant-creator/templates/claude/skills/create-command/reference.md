# Claude Command Structure Reference

Complete reference for Claude Code command file format and components.

## File Format

Command files are Markdown with optional YAML frontmatter followed by the command prompt.

```markdown
---
[YAML frontmatter - optional]
---

[Command prompt/instructions]
```

## Directory Structure

Commands are single files stored in:

```
.claude/commands/
├── review.md              # /review command
├── deploy.md              # /deploy command
├── generate-tests.md      # /generate-tests command
└── my-workflow/
    └── step1.md           # /my-workflow:step1 (namespaced)
```

## YAML Frontmatter

All fields are optional. If no frontmatter is needed, you can omit it entirely.

### description (string, optional)

- **Format**: Brief description of command purpose
- **Length**: Maximum 200 characters recommended
- **Purpose**: Shown in command list and help output
- **Examples**:
  - `"Review code for security vulnerabilities"`
  - `"Generate unit tests for the specified file"`
  - `"Deploy to staging environment"`

### allowed-modes (array, optional)

- **Format**: Array of mode names
- **Options**: `plan`, `code`
- **Default**: All modes if omitted
- **Purpose**: Restrict command availability by mode
- **Examples**:
  ```yaml
  allowed-modes:
    - plan
  ```
  ```yaml
  allowed-modes:
    - code
  ```

## Command Prompt Content

The markdown body after frontmatter is the command's prompt. This is sent to Claude when the command is invoked.

### $ARGUMENTS Placeholder

Use `$ARGUMENTS` anywhere in your prompt to include user-provided input:

```markdown
Review the following code for security issues: $ARGUMENTS

Focus on:
- SQL injection
- XSS vulnerabilities
- Authentication bypasses
```

When user runs `/review src/auth.ts`, Claude receives:
```
Review the following code for security issues: src/auth.ts

Focus on:
- SQL injection
- XSS vulnerabilities
- Authentication bypasses
```

### Multiple Uses

You can use `$ARGUMENTS` multiple times:

```markdown
Generate a $ARGUMENTS component.

Name it: $ARGUMENTS
Location: src/components/$ARGUMENTS.tsx
```

### Optional Arguments

Commands work with or without arguments. Design prompts to handle both:

```markdown
Review the code $ARGUMENTS for best practices.

If no specific file is provided, review recent changes.
```

## Naming Conventions

### File Names

- Lowercase letters, numbers, hyphens
- Extension: `.md`
- Examples: `review.md`, `deploy-staging.md`, `generate-api-docs.md`

### Namespaced Commands

Use directories for related commands:

```
.claude/commands/
└── git/
    ├── commit.md      # /git:commit
    ├── pr.md          # /git:pr
    └── review.md      # /git:review
```

## Command Patterns

### Simple Action Command

No arguments, performs a specific action:

```markdown
---
description: Run all tests and report results
---

Run the test suite using the project's test framework.

1. Identify the test runner (jest, pytest, go test, etc.)
2. Execute all tests
3. Summarize results: passed, failed, skipped
4. For failures, show the error message and file location
```

### Argument-Based Command

Takes user input to customize behavior:

```markdown
---
description: Explain code in detail
---

Explain the following code or concept in detail: $ARGUMENTS

Provide:
1. Overview of what it does
2. Key components and their roles
3. How data flows through it
4. Any notable patterns or techniques used
```

### Mode-Restricted Command

Only available in specific modes:

```markdown
---
description: Create implementation plan for a feature
allowed-modes:
  - plan
---

Create a detailed implementation plan for: $ARGUMENTS

Include:
1. Requirements analysis
2. Technical approach
3. File changes needed
4. Testing strategy
5. Rollout considerations
```

### Multi-Step Workflow Command

Guides through a process:

```markdown
---
description: Complete code review workflow
---

Perform a comprehensive code review of $ARGUMENTS:

## Step 1: Read and Understand
Read the code and understand its purpose.

## Step 2: Check Code Quality
- Naming conventions
- Code organization
- Complexity
- Duplication

## Step 3: Security Review
- Input validation
- Authentication/authorization
- Data exposure

## Step 4: Performance Check
- N+1 queries
- Unnecessary iterations
- Memory usage

## Step 5: Summary
Provide a summary with:
- Overall assessment (approve/request changes)
- Critical issues (must fix)
- Suggestions (nice to have)
```

## Best Practices

### Keep Commands Focused

**Good**: One clear purpose
```markdown
Review code for security vulnerabilities: $ARGUMENTS
```

**Bad**: Too many unrelated tasks
```markdown
Review code, then deploy, then send email, then update docs: $ARGUMENTS
```

### Write Clear Instructions

**Good**: Specific and actionable
```markdown
Generate a React component with:
- TypeScript types
- Unit tests
- Storybook story

Component name: $ARGUMENTS
```

**Bad**: Vague and unclear
```markdown
Make a component: $ARGUMENTS
```

### Handle Missing Arguments

Design commands to work gracefully without arguments:

```markdown
Analyze test coverage $ARGUMENTS.

If no file specified, analyze the entire project.
Provide a summary of:
- Overall coverage percentage
- Uncovered files
- Suggestions for improvement
```

### Use Descriptive Names

- `review-security.md` - Clear purpose
- `deploy-prod.md` - Clear target
- `generate-api-docs.md` - Clear output

Avoid:
- `r.md` - Too cryptic
- `do-stuff.md` - Too vague

## Common Pitfalls

### Missing $ARGUMENTS

If your command needs user input but doesn't use `$ARGUMENTS`, the input is lost.

**Wrong**:
```markdown
Review the code for security issues.
```

**Right**:
```markdown
Review the code for security issues: $ARGUMENTS
```

### Overly Complex Commands

Break complex workflows into multiple commands or use skills instead.

**Instead of**:
```markdown
Do everything for deploying: build, test, lint, deploy, notify...
```

**Consider**:
- `/deploy-prepare` - Build and test
- `/deploy-staging` - Deploy to staging
- `/deploy-prod` - Deploy to production

### Conflicting with Built-ins

Check that your command name doesn't conflict with built-in commands:
- `/help`
- `/clear`
- `/status`
- `/config`

## File Locations

### For Local Projects

```
project/
└── .claude/
    └── commands/
        └── your-command.md
```

### For Packages

```
your-package/
└── templates/
    └── claude/
        └── commands/
            └── your-command.md
```

When the package is applied, commands are symlinked to `.claude/commands/`.

## Validation Checklist

Before finalizing a command:

- [ ] File has `.md` extension
- [ ] Filename uses lowercase and hyphens only
- [ ] YAML frontmatter is valid (if present)
- [ ] Description is clear and under 200 chars
- [ ] `$ARGUMENTS` used where user input is needed
- [ ] Command prompt is focused on one task
- [ ] Instructions are clear and actionable
- [ ] Command works with and without arguments
- [ ] No conflict with built-in commands
- [ ] Tested with realistic scenarios
