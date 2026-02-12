# Claude Agent Structure Reference

Complete reference for Claude agent file format and components.

## File Format

Agent files are Markdown (`.md`) with YAML frontmatter followed by system prompt content.

```markdown
---
[YAML frontmatter]
---

[Markdown system prompt]
```

## YAML Frontmatter

### Required Fields

#### name (string, required)

- **Format**: Lowercase letters, numbers, hyphens only
- **Purpose**: Unique identifier for the agent
- **Examples**:
  - `architect`
  - `code-reviewer`
  - `test-driven-developer`
  - `debugging-specialist`

#### description (string, required)

- **Format**: Brief 1-2 sentence description
- **Length**: Maximum 200 characters recommended
- **Purpose**: Explains what the agent does and when to use it
- **Examples**:
  - "Assists with design decisions, architectural planning, and technical specifications"
  - "Performs thorough code reviews for best practices, security, and quality"
  - "Enforces TDD workflow for all feature development and bug fixes"

#### model (string, required)

- **Options**: `opus`, `sonnet`, `haiku`
- **Purpose**: Determines agent capability and cost
- **Guidelines**:
  - `opus` - Most capable, highest cost
    - Complex reasoning and deep analysis
    - Architectural decisions
    - Multi-step problem solving
    - Research-intensive tasks
  - `sonnet` - Balanced capability and cost (most common choice)
    - Code review
    - General development
    - Documentation writing
    - Standard implementation tasks
  - `haiku` - Fast responses, lowest cost
    - Simple formatting tasks
    - Quick lookups
    - High-volume simple operations
    - Basic validation

#### color (string, required)

- **Options**: `cyan`, `purple`, `green`, `blue`, `red`, `yellow`
- **Purpose**: Visual identification in UI
- **Suggested mapping**:
  - `cyan` - Architecture, design, planning agents
  - `purple` - Code review, quality assurance agents
  - `green` - Testing, verification, validation agents
  - `blue` - Documentation, writing, communication agents
  - `red` - Debugging, troubleshooting, error investigation agents
  - `yellow` - Research, exploration, discovery agents

### Optional Fields

#### tools (array of strings, optional but recommended)

- **Purpose**: List of tools agent can use
- **Format**: Array of tool names
- **Default**: If omitted, agent inherits all tools from main thread

**Common tool categories**:

**File Operations**:
- `Read` - Read files from filesystem
- `Write` - Create new files
- `Edit` - Modify existing files
- `Glob` - Find files by pattern
- `Grep` - Search file contents

**Execution**:
- `Bash` - Execute shell commands (use with caution)
- `mcp__ide__executeCode` - Run code in Jupyter kernel

**Research & Documentation**:
- `mcp__context7__resolve-library-id` - Find library documentation
- `mcp__context7__get-library-docs` - Fetch library docs
- `mcp__exa__get_code_context_exa` - Search code examples
- `mcp__exa__web_search_exa` - Search the web
- `WebSearch` - Built-in web search
- `WebFetch` - Fetch web content

**IDE Integration**:
- `mcp__ide__getDiagnostics` - Get language diagnostics
- `mcp__lsp-api__definition` - Go to definition
- `mcp__lsp-api__references` - Find references
- `mcp__lsp-api__hover` - Get hover information
- `mcp__lsp-api__diagnostics` - Get diagnostics

**GitHub Integration**:
- `mcp__github__*` - GitHub operations (use wildcard for all)

**Interactive**:
- `AskUserQuestion` - Ask user for clarification
- `TodoWrite` - Manage task lists

**Tool Selection Guidelines**:
1. Start minimal - add only what's needed
2. Use wildcards for related tools: `mcp__context7__*`
3. Read-only agents: Just Read, Grep, Glob
4. Research agents: Add context7, exa, WebSearch
5. Implementation agents: Add Write, Edit, possibly Bash

## System Prompt Structure

The markdown body after frontmatter is the agent's system prompt. Effective structure includes:

### 1. Role Introduction (Required)

```markdown
# Role: [Agent Name]

[2-3 sentence description of agent's role, expertise, and approach]
```

**Purpose**: Establishes agent identity and primary function

**Example**:
```markdown
# Role: Code Reviewer

You are an experienced code reviewer who ensures code quality, security, and maintainability through thorough reviews. You focus on identifying real issues while providing constructive, actionable feedback.
```

### 2. Core Responsibilities (Recommended)

```markdown
## Core Responsibilities

1. **[Responsibility 1]** - [Detailed description]
2. **[Responsibility 2]** - [Detailed description]
3. **[Responsibility 3]** - [Detailed description]
```

**Purpose**: Defines specific capabilities and duties

**Guidelines**:
- Use 3-5 responsibilities
- Make each one specific and actionable
- Focus on WHAT the agent does, not HOW

**Example**:
```markdown
## Core Responsibilities

1. **Review code changes** - Analyze diffs and pull requests for quality issues
2. **Check best practices** - Ensure code follows language and project conventions
3. **Identify security issues** - Spot common vulnerabilities and security risks
4. **Suggest improvements** - Provide actionable, specific feedback
5. **Verify tests** - Ensure adequate test coverage for changes
```

### 3. Methodology/Process (Optional but recommended)

```markdown
## [Process Name]

### Step 1: [Name]
[Instructions]

### Step 2: [Name]
[Instructions]
```

**Purpose**: Guides agent through step-by-step workflow

**When to include**: Complex tasks with multiple phases

**Example**:
```markdown
## Review Process

### 1. Understand Context
Read PR description, related issues, and design decisions

### 2. Check Code Quality
- Readability and naming
- Structure and complexity
- Code duplication

### 3. Security Review
- SQL injection risks
- XSS vulnerabilities
- Secret exposure
```

### 4. Guidelines/Best Practices (Optional)

```markdown
## [Guidelines Name]

- **[Principle 1]**: [Description]
- **[Principle 2]**: [Description]
```

**Purpose**: Establishes operational principles

**Example**:
```markdown
## Review Guidelines

- **Be Constructive**: Focus on improvement, not criticism
- **Be Specific**: Point to exact lines and suggest alternatives
- **Prioritize**: Critical issues first, then nice-to-haves
- **Context Matters**: Consider project constraints and deadlines
```

### 5. Success Criteria (Recommended)

```markdown
## Success Criteria

A successful [outcome] should:
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]
```

**Purpose**: Defines measurable outcomes

**Guidelines**: Use checkboxes for clarity

## Agent Type Patterns

### Read-Only Research Agent

**Characteristics**:
- Model: `sonnet` or `haiku`
- Tools: Read, Grep, Glob, mcp__context7__*, mcp__exa__*
- Color: `yellow`
- Focus: Information gathering and analysis

**Use cases**:
- Library research
- Documentation analysis
- Pattern discovery
- Technology comparison

**Example frontmatter**:
```yaml
---
name: research-agent
description: Investigates libraries, patterns, and best practices through documentation and code analysis
model: sonnet
color: yellow
tools:
  - Read
  - Grep
  - Glob
  - mcp__context7__*
  - mcp__exa__*
  - WebSearch
---
```

### Code Writing Agent

**Characteristics**:
- Model: `sonnet` or `opus`
- Tools: Read, Write, Edit, Grep, Glob, mcp__ide__*
- Color: `blue`
- Focus: Implementation and modification

**Use cases**:
- Feature implementation
- Refactoring
- Code generation
- Bug fixes

**Example frontmatter**:
```yaml
---
name: implementation-agent
description: Implements features and refactors code following project conventions and best practices
model: sonnet
color: blue
tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
  - mcp__ide__*
  - mcp__lsp-api__*
---
```

### Code Review Agent

**Characteristics**:
- Model: `sonnet`
- Tools: Read, Grep, Glob, mcp__ide__getDiagnostics, mcp__github__*
- Color: `purple`
- Focus: Quality assurance

**Use cases**:
- Pull request review
- Security analysis
- Best practices enforcement
- Test coverage verification

**Example frontmatter**:
```yaml
---
name: code-reviewer
description: Reviews code for quality, security, and best practices with constructive feedback
model: sonnet
color: purple
tools:
  - Read
  - Grep
  - Glob
  - mcp__ide__getDiagnostics
  - mcp__github__*
---
```

### Architect/Planning Agent

**Characteristics**:
- Model: `opus`
- Tools: Read, Grep, Glob, mcp__context7__*, mcp__exa__*, AskUserQuestion
- Color: `cyan`
- Focus: Design and planning

**Use cases**:
- System architecture
- Technical specifications
- Design decisions
- Technology selection

**Example frontmatter**:
```yaml
---
name: architect
description: Designs system architecture and creates technical specifications for complex features
model: opus
color: cyan
tools:
  - Read
  - Grep
  - Glob
  - mcp__context7__*
  - mcp__exa__*
  - AskUserQuestion
  - TodoWrite
---
```

### Debugging Agent

**Characteristics**:
- Model: `sonnet` or `opus`
- Tools: Read, Write, Edit, Grep, Bash, mcp__ide__*, mcp__lsp-api__*
- Color: `red`
- Focus: Problem investigation and resolution

**Use cases**:
- Bug investigation
- Error analysis
- Performance debugging
- Root cause analysis

**Example frontmatter**:
```yaml
---
name: debugger
description: Investigates bugs systematically, identifies root causes, and implements targeted fixes
model: opus
color: red
tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
  - mcp__ide__*
  - mcp__lsp-api__*
---
```

## Best Practices

### Agent Design

1. **Single Responsibility**: One clear purpose per agent
2. **Focused Expertise**: Deep knowledge in specific area beats broad generalization
3. **Appropriate Model**: Match capability needs to cost
4. **Minimal Tools**: Only include tools agent actually uses
5. **Clear Instructions**: System prompt should be actionable, not vague

### System Prompt Writing

1. **Be Specific**: Concrete guidance over abstract principles
2. **Include Examples**: Show patterns and anti-patterns
3. **Define Success**: Make outcomes measurable
4. **Consider Context**: Reference project conventions when relevant
5. **Keep Focused**: Under 3000 words recommended

### Testing Agents

1. **Try Example Scenarios**: Test with realistic requests
2. **Verify Tool Usage**: Ensure agent uses appropriate tools
3. **Check Output Quality**: Review generated code/docs/analysis
4. **Iterate**: Refine based on actual usage
5. **Monitor Performance**: Track success rate and user satisfaction

## Common Pitfalls

### ❌ Avoid

- **Too General**: "You are a helpful coding assistant"
- **Too Many Tools**: Listing every available tool
- **Vague Responsibilities**: "Help with whatever is needed"
- **Wrong Model**: Using opus for simple formatting tasks
- **Missing Examples**: No concrete guidance on usage
- **Overly Long**: 5000+ word system prompts

### ✅ Prefer

- **Specific Role**: "You are a React component code reviewer specializing in hooks"
- **Focused Tools**: Only Read, Grep, Glob for analysis agents
- **Clear Duties**: "Review React hooks for dependency arrays, effect cleanup, and performance"
- **Right Model**: sonnet for most development tasks
- **Concrete Examples**: Show specific scenarios in system prompt
- **Concise**: 500-2000 words with clear structure

## File Organization

### Single Agent

```
.claude/agents/code-reviewer.md
```

### Agent Package

```
your-package/
├── agents.toml
└── templates/
    └── claude/
        └── agents/
            ├── architect.md
            ├── code-reviewer.md
            └── debugger.md
```

### With Examples

Consider including example invocations in the agent's system prompt:

```markdown
## Example Usage

Users might invoke this agent with:
- "Review this PR for security issues"
- "Check if this code follows our style guide"
- "Analyze test coverage for these changes"
```

## Validation Checklist

Before considering an agent complete:

- [ ] Valid YAML frontmatter (triple dashes, proper syntax)
- [ ] Name is lowercase with hyphens
- [ ] Description is concise and clear
- [ ] Model matches task complexity
- [ ] Tools are necessary and sufficient
- [ ] Color follows convention
- [ ] Role introduction is clear
- [ ] Core responsibilities are specific (3-5 items)
- [ ] Success criteria are defined
- [ ] System prompt is under 3000 words
- [ ] Tested with example scenarios
- [ ] File saved in correct location

## Further Resources

- `examples.md` - See complete agent examples with analysis
- `templates/` - Pre-built templates for common agent types
- Claude Code documentation - Official agent best practices
