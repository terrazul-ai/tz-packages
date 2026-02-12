# Skill Conversion Examples

Before and after examples showing Claude to Gemini skill conversion.

## Example 1: Code Review Skill

### Before (Claude)

**File**: `.claude/skills/code-review/SKILL.md`

```markdown
---
name: code-review
description: Provides comprehensive code review guidelines for quality, security, and maintainability. Use when reviewing code changes or PRs.
version: "1.0.0"
allowed-tools:
  - Read
  - Grep
  - Glob
---

# Code Review Skill

This skill provides guidelines for conducting thorough code reviews.

## When to Use

Activate this skill when:
- Reviewing pull requests
- Checking code quality
- Auditing for security issues

## Review Process

### 1. Read the Code

Use the Read tool to examine files:
- Read the main files being changed
- Check related files for context

### 2. Search for Patterns

Use Grep to find:
- Similar code elsewhere
- TODO comments
- Debug statements

### 3. Report Findings

Organize findings by:
- Critical (must fix)
- Important (should fix)
- Minor (nice to have)
```

### After (Gemini)

**File**: `.gemini/skills/code-review/SKILL.md`

```markdown
---
name: code-review
description: Provides comprehensive code review guidelines for quality, security, and maintainability. Use when reviewing code changes or PRs.
version: "1.0.0"
allowed-tools:
  - read_file
  - search_files
  - list_files
---

# Code Review Skill

This skill provides guidelines for conducting thorough code reviews.

## When to Use

Activate this skill when:
- Reviewing pull requests
- Checking code quality
- Auditing for security issues

## Review Process

### 1. Read the Code

Use read_file to examine files:
- Read the main files being changed
- Check related files for context

### 2. Search for Patterns

Use search_files to find:
- Similar code elsewhere
- TODO comments
- Debug statements

### 3. Report Findings

Organize findings by:
- Critical (must fix)
- Important (should fix)
- Minor (nice to have)
```

### Changes Made

1. **Tool names in frontmatter**:
   - `Read` → `read_file`
   - `Grep` → `search_files`
   - `Glob` → `list_files`

2. **Tool references in body**:
   - "Use the Read tool" → "Use read_file"
   - "Use Grep to find" → "Use search_files to find"

---

## Example 2: Documentation Skill (with Agent Reference)

### Before (Claude)

**File**: `.claude/skills/api-docs/SKILL.md`

```markdown
---
name: api-docs
description: Generates API documentation from code and OpenAPI specs. Use when creating or updating API documentation.
allowed-tools:
  - Read
  - Write
  - Glob
---

# API Documentation Skill

Generate comprehensive API documentation.

## When to Use

Activate this skill when:
- Creating new API docs
- Updating existing documentation
- Generating OpenAPI specs

## Documentation Process

### 1. Analyze API

Read the API files using Read tool.
Use Glob to find all route files.

### 2. Generate Documentation

For complex APIs, delegate to the documentation-agent for detailed analysis.

Write the documentation to `docs/api/` using the Write tool.

### 3. Validate

Check documentation against `.claude/settings.json` for project conventions.
```

### After (Gemini)

**File**: `.gemini/skills/api-docs/SKILL.md`

```markdown
---
name: api-docs
description: Generates API documentation from code and OpenAPI specs. Use when creating or updating API documentation.
allowed-tools:
  - read_file
  - write_file
  - list_files
---

# API Documentation Skill

Generate comprehensive API documentation.

## When to Use

Activate this skill when:
- Creating new API docs
- Updating existing documentation
- Generating OpenAPI specs

## Documentation Process

### 1. Analyze API

Read the API files using read_file.
Use list_files to find all route files.

### 2. Generate Documentation

For complex APIs, follow these detailed analysis steps:
1. List all endpoint files
2. Read each file and extract routes
3. Document parameters, responses, and errors
4. Add usage examples

> Note: Claude's version delegated to a specialized agent. In Gemini, follow the steps above.

Write the documentation to `docs/api/` using write_file.

### 3. Validate

Check documentation against `.gemini/settings.json` for project conventions.
```

### Changes Made

1. **Tool names updated** (frontmatter and body)
2. **Agent delegation removed** and replaced with manual steps
3. **Path reference updated**: `.claude/settings.json` → `.gemini/settings.json`
4. **Note added** explaining the agent limitation

---

## Example 3: Research Skill (with MCP Servers)

### Before (Claude)

**File**: `.claude/skills/library-research/SKILL.md`

```markdown
---
name: library-research
description: Researches libraries and provides recommendations. Use when evaluating packages or dependencies.
allowed-tools:
  - Read
  - Grep
  - mcp__context7__resolve-library-id
  - mcp__context7__query-docs
  - WebSearch
---

# Library Research Skill

Research and evaluate libraries for your project.

## When to Use

Activate this skill when:
- Choosing between libraries
- Evaluating dependencies
- Checking for alternatives

## Research Process

### 1. Check Current Usage

Use Read and Grep to understand current dependencies.

### 2. Research Libraries

Use mcp__context7__resolve-library-id to find documentation.
Then use mcp__context7__query-docs to get specific information.

### 3. Compare Options

Search the web with WebSearch for reviews and comparisons.
```

### After (Gemini)

**File**: `.gemini/skills/library-research/SKILL.md`

```markdown
---
name: library-research
description: Researches libraries and provides recommendations. Use when evaluating packages or dependencies.
allowed-tools:
  - read_file
  - search_files
  - web_search
  - web_fetch
---

# Library Research Skill

Research and evaluate libraries for your project.

## When to Use

Activate this skill when:
- Choosing between libraries
- Evaluating dependencies
- Checking for alternatives

## Research Process

### 1. Check Current Usage

Use read_file and search_files to understand current dependencies.

### 2. Research Libraries

Search for library documentation using web_search.
Fetch specific documentation pages using web_fetch.

> Note: Claude's version used Context7 for library documentation. In Gemini, use web search and the library's official documentation.

### 3. Compare Options

Search the web with web_search for reviews and comparisons.
```

### Changes Made

1. **Tool names updated**
2. **MCP tools removed** (context7 not available in Gemini)
3. **Alternative workflow provided** using web_search and web_fetch
4. **Note added** explaining the Context7 limitation

---

## Example 4: Platform-Agnostic Skill (Minimal Changes)

### Before (Claude)

**File**: `.claude/skills/code-standards/SKILL.md`

```markdown
---
name: code-standards
description: Provides coding standards and best practices for the project. Use when writing new code or reviewing existing code.
---

# Code Standards Skill

This skill defines the coding standards for this project.

## When to Use

Activate this skill when:
- Writing new code
- Reviewing code changes
- Onboarding new developers

## Standards

### Naming Conventions

- Variables: camelCase
- Classes: PascalCase
- Constants: UPPER_SNAKE_CASE
- Files: kebab-case

### Code Organization

- One class per file
- Group imports by type
- Keep functions under 50 lines

### Documentation

- Document all public APIs
- Use JSDoc format
- Include examples for complex functions
```

### After (Gemini)

**File**: `.gemini/skills/code-standards/SKILL.md`

```markdown
---
name: code-standards
description: Provides coding standards and best practices for the project. Use when writing new code or reviewing existing code.
---

# Code Standards Skill

This skill defines the coding standards for this project.

## When to Use

Activate this skill when:
- Writing new code
- Reviewing code changes
- Onboarding new developers

## Standards

### Naming Conventions

- Variables: camelCase
- Classes: PascalCase
- Constants: UPPER_SNAKE_CASE
- Files: kebab-case

### Code Organization

- One class per file
- Group imports by type
- Keep functions under 50 lines

### Documentation

- Document all public APIs
- Use JSDoc format
- Include examples for complex functions
```

### Changes Made

**None!** This skill is platform-agnostic:
- No `allowed-tools` field
- No tool references in body
- No platform-specific paths
- No agent or MCP references

This skill can be shared across platforms without modification.

---

## Conversion Summary Table

| Element | Claude | Gemini | Action |
|---------|--------|--------|--------|
| `name` | Same | Same | Keep |
| `description` | Same | Same | Keep |
| `version` | Same | Same | Keep |
| `allowed-tools` | Claude names | Gemini names | Convert |
| Tool references | Claude names | Gemini names | Convert |
| `.claude/` paths | `.claude/` | `.gemini/` | Convert |
| Agent delegation | Supported | Not supported | Remove/Replace |
| MCP context7 | Supported | Not supported | Use web_search |
| MCP exa | Supported | Not supported | Use web_search |
| Instructions | Markdown | Markdown | Keep |
| Examples | Markdown | Markdown | Keep (update tools) |
| Templates | Any format | Any format | Keep |
