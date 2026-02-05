# Terrazul Package Examples

Real-world examples of Terrazul packages for different use cases.

---

## Example 1: Documentation-Focused Package

A package that analyzes the codebase and provides context to AI tools.

### Directory Structure

```
@acme/docs-assistant/
├── agents.toml
├── README.md
└── templates/
    ├── CLAUDE.md.hbs
    ├── AGENTS.md.hbs
    └── claude/
        └── skills/
            └── codebase-overview/
                └── SKILL.md
```

### agents.toml

```toml
[package]
name = "@acme/docs-assistant"
version = "1.0.0"
description = "Provides codebase documentation and context to AI assistants"
license = "MIT"
keywords = ["documentation", "context", "codebase"]

[compatibility]
claude = ">=0.2.0"
codex = "*"

[exports.claude]
template = "templates/CLAUDE.md.hbs"
skillsDir = "templates/claude/skills"

[exports.codex]
template = "templates/AGENTS.md.hbs"
skillsDir = "templates/claude/skills"
```

### templates/CLAUDE.md.hbs

```handlebars
{{~ var projectPitch = askUser('Describe this project in 1-2 sentences.') ~}}
{{~ var primaryUser = askUser('Who is the primary user of this assistant?', {
  default: 'developers'
}) ~}}

{{~ var projectAnalysis = askAgent("""
Analyze this repository and return a flat JSON object:
{
  "name": "repository name",
  "description": "one-line description",
  "languages": "primary languages used, comma-separated",
  "frameworks": "frameworks and libraries, comma-separated",
  "mainDirs": "key directories with brief purposes",
  "entryPoints": "main entry point files",
  "configFiles": "configuration files present"
}
Only include fields you can confidently determine.
""", { json: true }) ~}}

# {{ vars.projectAnalysis.name }}

{{ vars.projectPitch }}

## Overview

{{ vars.projectAnalysis.description }}

**Primary User**: {{ vars.primaryUser }}

## Tech Stack

- **Languages**: {{ vars.projectAnalysis.languages }}
- **Frameworks**: {{ vars.projectAnalysis.frameworks }}

## Project Structure

{{ vars.projectAnalysis.mainDirs }}

## Entry Points

{{ vars.projectAnalysis.entryPoints }}

## Configuration

{{ vars.projectAnalysis.configFiles }}

## Available Skills

| Skill | Description |
|-------|-------------|
| `codebase-overview` | Provides high-level understanding of codebase structure |

## Guidelines

- Read existing code before suggesting modifications
- Follow existing patterns and conventions
- Keep changes minimal and focused
```

### templates/claude/skills/codebase-overview/SKILL.md

```markdown
---
name: codebase-overview
description: Provides high-level understanding of codebase structure, architecture patterns, and key components. Use when onboarding to a new project or needing context about how code is organized.
allowed-tools:
  - Read
  - Grep
  - Glob
---

# Codebase Overview Skill

This skill helps understand the structure and organization of a codebase.

## When to Use

Activate this skill when:
- Onboarding to a new project
- Needing to understand project architecture
- Looking for where specific functionality lives
- Understanding dependencies and relationships

## Instructions

### 1. Identify Project Type

Determine the project type by examining:
- Package manager files (package.json, Cargo.toml, go.mod, etc.)
- Build configuration (webpack, vite, tsconfig, etc.)
- Framework markers (next.config.js, angular.json, etc.)

### 2. Map Directory Structure

Identify key directories:
- Source code location (src/, lib/, app/)
- Test directories (tests/, __tests__/, spec/)
- Configuration (config/, .config/)
- Documentation (docs/, README files)

### 3. Find Entry Points

Locate main entry points:
- Main/index files
- CLI entry points
- Server bootstrap files
- Export barrels

### 4. Understand Architecture

Look for patterns:
- Layer separation (controllers, services, repositories)
- Module organization
- Shared utilities
- Type definitions

## Example Output

When asked "Give me an overview of this codebase":

```
# Project Overview: acme-api

## Type
Node.js REST API using Express and TypeScript

## Structure
- `src/` - Source code
  - `controllers/` - HTTP request handlers
  - `services/` - Business logic
  - `models/` - Data models and types
  - `middleware/` - Express middleware
  - `utils/` - Shared utilities
- `tests/` - Jest test files
- `config/` - Environment configuration

## Entry Points
- `src/index.ts` - Server bootstrap
- `src/app.ts` - Express app setup

## Key Files
- `package.json` - Dependencies and scripts
- `tsconfig.json` - TypeScript configuration
- `.env.example` - Environment variables template
```
```

**Why this works**:
- Uses single comprehensive `askAgent` call with flat JSON
- Combines user input (`askUser`) with AI analysis (`askAgent`)
- Includes a supporting skill for ongoing use
- Clean, readable output format

---

## Example 2: Skills-Focused Package

A package that adds specific capabilities to AI tools.

### Directory Structure

```
@acme/code-review/
├── agents.toml
├── README.md
└── templates/
    ├── CLAUDE.md
    └── claude/
        └── skills/
            ├── security-review/
            │   ├── SKILL.md
            │   ├── reference.md
            │   └── examples.md
            └── performance-review/
                ├── SKILL.md
                └── reference.md
```

### agents.toml

```toml
[package]
name = "@acme/code-review"
version = "1.0.0"
description = "Code review skills for security and performance analysis"
license = "MIT"
keywords = ["code-review", "security", "performance"]

[compatibility]
claude = ">=0.2.0"
codex = "*"

[exports.claude]
template = "templates/CLAUDE.md"
skillsDir = "templates/claude/skills"

[exports.codex]
template = "templates/CLAUDE.md"
skillsDir = "templates/claude/skills"
```

### templates/CLAUDE.md

```markdown
# Code Review Assistant

This package provides specialized code review skills for security and performance analysis.

## Available Skills

| Skill | Description |
|-------|-------------|
| `security-review` | Reviews code for security vulnerabilities (OWASP Top 10) |
| `performance-review` | Identifies performance issues and optimization opportunities |

## Quick Start

### Security Review

```
"Review src/auth/ for security issues"
"Check this file for SQL injection vulnerabilities"
```

### Performance Review

```
"Analyze this function for performance problems"
"Review the database queries for N+1 issues"
```

## Usage Guidelines

1. **Be specific**: Mention the files or areas to review
2. **Provide context**: Explain the risk profile (public API vs internal tool)
3. **Prioritize findings**: Focus on critical issues first
```

### templates/claude/skills/security-review/SKILL.md

```markdown
---
name: security-review
description: Reviews code for security vulnerabilities including OWASP Top 10 issues, authentication flaws, injection attacks, and sensitive data exposure. Use when reviewing PRs, auditing code, or checking for security issues.
---

# Security Review Skill

This skill performs security-focused code review to identify vulnerabilities.

## When to Use

Activate this skill when:
- Reviewing pull requests for security issues
- Auditing code for vulnerabilities
- Checking authentication/authorization logic
- Reviewing code that handles user input
- Examining code that processes sensitive data

## Review Process

### 1. Input Validation

Check all user inputs for:
- SQL injection (parameterized queries vs string concatenation)
- XSS (output encoding, Content-Security-Policy)
- Command injection (shell escaping, subprocess handling)
- Path traversal (path normalization, allowlists)
- XML/JSON injection (proper parsing)

### 2. Authentication & Authorization

Review:
- Password handling (hashing, salting, strength requirements)
- Session management (secure cookies, timeout, regeneration)
- Token handling (JWT validation, expiration, storage)
- Access control (role checks, resource ownership)

### 3. Data Protection

Examine:
- Sensitive data in logs (PII, credentials, tokens)
- Encryption at rest and in transit
- Secrets management (environment variables vs hardcoded)
- Data exposure in errors/responses

### 4. Dependencies

Check:
- Known vulnerabilities in dependencies
- Outdated packages with security patches
- Untrusted or unmaintained packages

## Severity Levels

| Level | Description | Examples |
|-------|-------------|----------|
| **Critical** | Immediate exploitation risk | RCE, auth bypass, SQL injection |
| **High** | Significant risk with effort | Stored XSS, privilege escalation |
| **Medium** | Limited impact or requires conditions | CSRF, information disclosure |
| **Low** | Minimal impact, best practice | Missing headers, verbose errors |

## Example Review

**Code**:
```javascript
app.get('/user', (req, res) => {
  const query = `SELECT * FROM users WHERE id = ${req.query.id}`;
  db.query(query, (err, result) => res.json(result));
});
```

**Finding**:
```
## CRITICAL: SQL Injection in /user endpoint

**Location**: src/routes/user.js:15
**Issue**: User input directly concatenated into SQL query
**Impact**: Attacker can read/modify/delete database contents
**Exploit**: GET /user?id=1 OR 1=1--

**Fix**:
```javascript
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [req.query.id], (err, result) => res.json(result));
```
```

## Reference Materials

- `reference.md` - Complete OWASP checklist and vulnerability patterns
- `examples.md` - More vulnerability examples with fixes
```

**Why this works**:
- No dynamic content needed (static CLAUDE.md)
- Focused, specialized skills with clear purposes
- Detailed instructions with examples
- Actionable review process

---

## Example 3: Full-Featured Package with MCP

A comprehensive package with multiple features and MCP integration.

### Directory Structure

```
@acme/dev-toolkit/
├── agents.toml
├── README.md
├── prompts/
│   └── analyze-pr.txt
└── templates/
    ├── CLAUDE.md.hbs
    ├── AGENTS.md.hbs
    ├── claude/
    │   ├── mcp_servers.json.hbs
    │   ├── skills/
    │   │   └── pr-review/
    │   │       └── SKILL.md
    │   ├── agents/
    │   │   └── reviewer.md
    │   └── commands/
    │       └── review.md
    └── codex/
        └── config.toml.hbs
```

### agents.toml

```toml
[package]
name = "@acme/dev-toolkit"
version = "2.0.0"
description = "Complete development toolkit with GitHub integration, code review, and PR analysis"
repository = "https://github.com/acme/dev-toolkit"
license = "MIT"
keywords = ["github", "code-review", "pr", "development"]
authors = ["Acme Team <team@acme.com>"]

[compatibility]
claude = ">=0.2.0"
codex = "*"

[exports.claude]
template = "templates/CLAUDE.md.hbs"
skillsDir = "templates/claude/skills"
agentsDir = "templates/claude/agents"
commandsDir = "templates/claude/commands"
mcpServers = "templates/claude/mcp_servers.json.hbs"

[exports.codex]
template = "templates/AGENTS.md.hbs"
skillsDir = "templates/claude/skills"

[profiles]
minimal = ["@acme/dev-toolkit"]
with-github = ["@acme/dev-toolkit"]
```

### templates/CLAUDE.md.hbs

```handlebars
{{~ var teamContext = askUser('Describe your team and development workflow briefly.', {
  default: 'Software development team using GitHub for version control'
}) ~}}

{{~ var projectData = askAgent("""
Analyze this repository and return a flat JSON object:
{
  "name": "repository name",
  "type": "project type (e.g., web app, API, library)",
  "languages": "primary languages",
  "testCommand": "command to run tests if present",
  "buildCommand": "command to build if present",
  "hasCI": "yes or no - whether CI/CD is configured"
}
""", { json: true }) ~}}

# {{ vars.projectData.name }} Development Toolkit

{{ vars.teamContext }}

## Project Info

- **Type**: {{ vars.projectData.type }}
- **Languages**: {{ vars.projectData.languages }}
- **Tests**: {{ vars.projectData.testCommand }}
- **Build**: {{ vars.projectData.buildCommand }}
- **CI/CD**: {{ vars.projectData.hasCI }}

## Available Components

### Skills

| Skill | Description |
|-------|-------------|
| `pr-review` | Comprehensive pull request review |

### Agents

| Agent | Description |
|-------|-------------|
| `reviewer` | Specialized code review agent |

### Commands

| Command | Description |
|---------|-------------|
| `/review` | Quick review of specified files |

## Quick Start

### Review a PR

```
"Review PR #123"
"Analyze the changes in the latest PR"
```

### Use the Reviewer Agent

```
@reviewer Review the authentication changes
```

### Run the Review Command

```
/review src/auth/
```

## MCP Integrations

This package configures:
- **GitHub MCP** - PR and issue management (requires GITHUB_TOKEN)
- **Context7 MCP** - Library documentation lookup

## Guidelines

- Run tests before approving PRs
- Check for security issues in authentication code
- Ensure documentation is updated for API changes
```

### templates/claude/mcp_servers.json.hbs

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/mcp-server"]
    }
  }
}
```

### templates/claude/agents/reviewer.md

```markdown
---
name: reviewer
description: Specialized code reviewer focusing on quality, security, and best practices
model: sonnet
color: purple
tools:
  - Read
  - Grep
  - Glob
  - mcp__github__*
examples:
  - "Review the latest PR"
  - "Check PR #42 for security issues"
  - "Analyze the changes in feature/auth"
---

You are a senior code reviewer specializing in code quality, security, and best practices.

## Your Role

- Review code changes thoroughly
- Identify bugs, security issues, and performance problems
- Suggest improvements while respecting existing patterns
- Provide actionable, constructive feedback

## Review Focus

1. **Correctness**: Does the code do what it claims?
2. **Security**: Are there vulnerabilities?
3. **Performance**: Are there obvious inefficiencies?
4. **Maintainability**: Is the code readable and well-structured?
5. **Testing**: Are changes adequately tested?

## Guidelines

- Be constructive, not critical
- Explain the "why" behind suggestions
- Prioritize issues by severity
- Acknowledge good patterns and improvements
- Use the GitHub MCP to fetch PR details when available
```

### templates/claude/commands/review.md

```markdown
---
name: review
description: Quick code review of specified files or directories
arguments:
  - name: target
    description: Files or directories to review
    required: true
---

Review the following code for quality and potential issues:

$ARGUMENTS

Focus on:
1. Bugs and logic errors
2. Security vulnerabilities
3. Performance issues
4. Code style and readability
5. Missing error handling

Provide findings in order of severity (critical → low).
```

### prompts/analyze-pr.txt

```
Analyze the provided pull request and generate a comprehensive review.

Structure your review as:

## Summary
Brief overview of what this PR does.

## Changes Reviewed
List of files and the nature of changes.

## Findings

### Critical Issues
Issues that must be fixed before merging.

### Suggestions
Improvements that would enhance the code.

### Positive Notes
Good patterns or improvements to acknowledge.

## Recommendation
APPROVE, REQUEST_CHANGES, or COMMENT with rationale.
```

**Why this works**:
- Comprehensive package with multiple component types
- MCP integration for external services
- External prompt file for complex analysis
- Agents, skills, and commands working together
- Clear documentation and usage examples

---

## Pattern Summary

### When to Use Each Pattern

| Pattern | Use When |
|---------|----------|
| **Documentation-focused** | Providing codebase context and guidelines |
| **Skills-focused** | Adding specific capabilities |
| **Full-featured** | Comprehensive tooling with integrations |

### Key Decisions

| Decision | Recommendation |
|----------|----------------|
| Static vs dynamic content | Use `.hbs` only when analysis/input needed |
| Single vs multiple askAgent | Always prefer single comprehensive call |
| Flat vs nested JSON | Always use flat JSON |
| Skills vs agents | Skills for capabilities, agents for personas |

### Checklist for Any Package

- [ ] `agents.toml` with valid name and version
- [ ] README.md with installation and usage
- [ ] Context template(s) for target platforms
- [ ] Skills/agents with clear descriptions
- [ ] MCP config if external services needed
- [ ] Tested with `tz validate` and `tz apply --force`
