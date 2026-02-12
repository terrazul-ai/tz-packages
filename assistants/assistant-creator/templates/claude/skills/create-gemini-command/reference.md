# Gemini Command Structure Reference

Complete reference for Gemini CLI command file format and components.

## File Format

Command files are TOML with two required fields:

```toml
description = "Brief description of the command"
prompt = """
Your prompt instructions here.
"""
```

## Directory Structure

Commands are stored in:

```
.gemini/commands/
├── review.toml              # /review command
├── deploy.toml              # /deploy command
├── generate-tests.toml      # /generate-tests command
└── git/
    ├── commit.toml          # /git:commit (namespaced)
    ├── pr.toml              # /git:pr
    └── status.toml          # /git:status
```

## Required Fields

### description (string, required)

- **Format**: Brief description of command purpose
- **Length**: Keep under 200 characters
- **Purpose**: Shown in command list
- **Example**:
  ```toml
  description = "Review code for security vulnerabilities"
  ```

### prompt (string, required)

- **Format**: Multi-line string with command instructions
- **Purpose**: The prompt sent to Gemini when command runs
- **Syntax**: Use triple quotes for multi-line
- **Example**:
  ```toml
  prompt = """
  Review the following code for security issues.

  Focus on:
  - Input validation
  - SQL injection
  - XSS vulnerabilities
  """
  ```

## Special Syntax

### User Arguments: `{{args}}`

Captures everything the user types after the command name.

```toml
prompt = """
Explain this code in detail: {{args}}

Include:
- What it does
- How it works
- Potential improvements
"""
```

**Usage**: `/explain src/auth.ts` passes `src/auth.ts` as `{{args}}`

**Multiple uses**: Can appear multiple times in prompt:
```toml
prompt = """
File to review: {{args}}
Generate tests for: {{args}}
"""
```

**Optional**: Commands work without arguments - `{{args}}` will be empty.

### Shell Output: `!{command}`

Embeds the output of a shell command at runtime.

```toml
prompt = """
Current branch:
!{git branch --show-current}

Recent commits:
!{git log --oneline -5}

Review the recent changes.
"""
```

**Security**: Commands execute in the project directory. Be careful with:
- User-controlled paths
- Destructive commands
- Commands that expose secrets

**Multiple commands**: Can have multiple shell expansions:
```toml
prompt = """
Tests: !{npm test 2>&1 | tail -20}
Lint: !{npm run lint 2>&1 | tail -20}

Fix any issues found.
"""
```

### File Embedding: `@{filepath}`

Embeds the contents of a file into the prompt.

```toml
prompt = """
Review this configuration:
@{package.json}

Check for:
- Security vulnerabilities
- Outdated patterns
- Missing fields
"""
```

**Paths**: Relative to project root.

**Multiple files**:
```toml
prompt = """
Main config:
@{config/main.json}

Environment config:
@{config/env.json}

Compare and find inconsistencies.
"""
```

**Missing files**: If file doesn't exist, behavior depends on Gemini CLI version (may error or show placeholder).

## Naming Conventions

### File Names

- Lowercase letters, numbers, hyphens
- Extension: `.toml`
- Examples: `review.toml`, `deploy-staging.toml`, `generate-docs.toml`

### Namespaced Commands

Use directories to group related commands:

```
.gemini/commands/
├── git/
│   ├── commit.toml    # /git:commit
│   ├── pr.toml        # /git:pr
│   └── review.toml    # /git:review
├── db/
│   ├── migrate.toml   # /db:migrate
│   └── seed.toml      # /db:seed
└── review.toml        # /review (no namespace)
```

**Pattern**: `directory/file.toml` → `/directory:file`

## Command Patterns

### Simple Action Command

No arguments, performs a specific action:

```toml
description = "Run all tests and summarize results"
prompt = """
Test output:
!{npm test 2>&1}

Summarize the test results:
1. Total tests run
2. Passed/failed count
3. Any failing test details
4. Recommendations for fixing failures
"""
```

### Argument-Based Command

Takes user input:

```toml
description = "Explain code or concepts in detail"
prompt = """
Explain the following in detail: {{args}}

If this is code:
- What it does
- Key components
- Data flow
- Potential issues

If this is a concept:
- Definition
- How it applies here
- Examples from codebase
"""
```

### Dynamic Context Command

Uses shell commands for runtime info:

```toml
description = "Review current changes before commit"
prompt = """
Staged changes:
!{git diff --cached}

Unstaged changes:
!{git diff}

Files changed:
!{git status --short}

Review these changes:
1. Code quality issues
2. Missing tests
3. Documentation needs
4. Suggested commit message
"""
```

### File Review Command

Embeds file contents:

```toml
description = "Review package dependencies"
prompt = """
Package configuration:
@{package.json}

Lock file (first 100 lines):
!{head -100 package-lock.json}

Analyze:
1. Outdated dependencies
2. Security vulnerabilities
3. Unnecessary packages
4. Version conflicts
"""
```

### Combined Syntax Command

Uses all special syntax:

```toml
description = "Comprehensive code review"
prompt = """
Reviewing: {{args}}

File contents:
@{{{args}}}

Git blame (recent changes):
!{git blame -L 1,50 {{args}} 2>/dev/null | head -20}

Related tests:
!{find . -name "*test*" -path "*/{{args}}*" 2>/dev/null}

Provide a thorough review covering:
1. Code quality
2. Security concerns
3. Performance issues
4. Test coverage
"""
```

**Note**: Dynamic `@{{{args}}}` embeds the file specified by user.

## Best Practices

### Keep Commands Focused

**Good**:
```toml
description = "Check for security vulnerabilities"
prompt = "Analyze {{args}} for security issues..."
```

**Bad**:
```toml
description = "Do everything"
prompt = "Review code, deploy, test, document..."
```

### Handle Missing Arguments

```toml
prompt = """
Target: {{args}}

If no target specified, analyze the entire project.
Otherwise, focus on the specified file or directory.
"""
```

### Safe Shell Commands

**Good** (read-only, bounded):
```toml
!{git status}
!{npm test 2>&1 | tail -50}
!{cat package.json}
```

**Risky** (use with caution):
```toml
!{rm -rf ...}           # Destructive
!{curl ... | sh}        # Arbitrary execution
!{cat ~/.ssh/id_rsa}    # Sensitive data
```

### Validate File Paths

If embedding user-specified files:
```toml
prompt = """
Reviewing: {{args}}

@{{{args}}}

Note: If file not found, report the error.
"""
```

## Common Pitfalls

### Invalid TOML Syntax

**Wrong** (unescaped quotes):
```toml
prompt = "Review "this" code"
```

**Right**:
```toml
prompt = 'Review "this" code'
# or
prompt = """Review "this" code"""
```

### Missing Required Fields

**Wrong**:
```toml
prompt = "Do something"
```

**Right**:
```toml
description = "Brief description"
prompt = "Do something"
```

### Shell Command Errors

Handle potential failures:
```toml
prompt = """
Git log (or error if not a repo):
!{git log --oneline -5 2>&1}

Handle gracefully if this isn't a git repository.
"""
```

### Large File Embeds

Avoid embedding huge files:
```toml
# Instead of embedding entire file:
# @{huge-log-file.log}

# Use shell to get relevant portion:
!{tail -100 huge-log-file.log}
```

## File Locations

### For Local Projects

```
project/
└── .gemini/
    └── commands/
        └── your-command.toml
```

### For Packages

```
your-package/
└── templates/
    └── gemini/
        └── commands/
            └── your-command.toml
```

## Validation Checklist

Before finalizing:

- [ ] Valid TOML syntax (use a TOML validator)
- [ ] `description` field present and under 200 chars
- [ ] `prompt` field present with clear instructions
- [ ] `{{args}}` used where user input needed
- [ ] Shell commands `!{...}` are safe and necessary
- [ ] File paths `@{...}` are correct and files exist
- [ ] Filename uses lowercase and hyphens
- [ ] No namespace conflicts
- [ ] Tested with realistic scenarios
