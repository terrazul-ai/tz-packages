# Full-Featured Package Template

A comprehensive Terrazul package with skills, agents, commands, and MCP integration.

## Directory Structure

```
my-package/
├── agents.toml
├── README.md
├── prompts/
│   └── analyze.txt
└── templates/
    ├── CLAUDE.md.hbs
    ├── AGENTS.md.hbs
    ├── claude/
    │   ├── mcp_servers.json
    │   ├── skills/
    │   │   └── my-skill/
    │   │       ├── SKILL.md
    │   │       └── reference.md
    │   ├── agents/
    │   │   └── my-agent.md
    │   └── commands/
    │       └── my-command.md
    └── codex/
        └── config.toml
```

## agents.toml

```toml
[package]
name = "@owner/my-package"
version = "1.0.0"
description = "Comprehensive package with skills, agents, and MCP integration"
repository = "https://github.com/owner/my-package"
license = "MIT"
keywords = ["comprehensive", "skills", "agents", "mcp"]
authors = ["Your Name <you@example.com>"]

[compatibility]
claude = ">=0.2.0"
codex = "*"

[exports.claude]
template = "templates/CLAUDE.md.hbs"
skillsDir = "templates/claude/skills"
agentsDir = "templates/claude/agents"
commandsDir = "templates/claude/commands"
mcpServers = "templates/claude/mcp_servers.json"

[exports.codex]
template = "templates/AGENTS.md.hbs"
skillsDir = "templates/claude/skills"
```

## templates/CLAUDE.md.hbs

```handlebars
{{~ var projectData = askAgent("""
Analyze this repository and return a flat JSON object:
{
  "name": "repository name",
  "description": "brief description",
  "type": "project type"
}
""", { json: true }) ~}}

# {{ vars.projectData.name }}

{{ vars.projectData.description }}

## Available Components

### Skills

| Skill | Description |
|-------|-------------|
| `my-skill` | Brief description of what this skill does |

### Agents

| Agent | Description |
|-------|-------------|
| `my-agent` | Brief description of what this agent does |

### Commands

| Command | Description |
|---------|-------------|
| `/my-command` | Brief description of what this command does |

## MCP Integrations

This package configures the following MCP servers:
- **GitHub** - PR and issue management (requires GITHUB_TOKEN)
- **Context7** - Library documentation lookup

## Quick Start

### Using the Skill

```
"Help me with [skill purpose]"
```

### Using the Agent

```
@my-agent [request]
```

### Using the Command

```
/my-command [arguments]
```

## Guidelines

- Follow existing code patterns
- Read code before making changes
- Use the specialized components when appropriate
```

## templates/claude/skills/my-skill/SKILL.md

```markdown
---
name: my-skill
description: Provides [specific capability]. Use when [trigger conditions].
---

# My Skill

This skill provides [detailed description of capability].

## When to Use

Activate this skill when:
- [Trigger condition 1]
- [Trigger condition 2]
- [Trigger condition 3]

## Instructions

### Step 1: [First Step]

[Instructions for first step]

### Step 2: [Second Step]

[Instructions for second step]

### Step 3: [Third Step]

[Instructions for third step]

## Examples

### Example 1: [Scenario]

**Request**: "[Example request]"

**Response**: [How to handle]

### Example 2: [Another Scenario]

**Request**: "[Example request]"

**Response**: [How to handle]

## Reference Materials

- `reference.md` - Detailed documentation
```

## templates/claude/skills/my-skill/reference.md

```markdown
# My Skill Reference

Detailed documentation for my-skill.

## Complete Specification

[Detailed specification]

## Advanced Usage

[Advanced patterns and techniques]

## Troubleshooting

### Common Issue 1

**Problem**: [Description]
**Solution**: [How to fix]

### Common Issue 2

**Problem**: [Description]
**Solution**: [How to fix]
```

## templates/claude/agents/my-agent.md

```markdown
---
name: my-agent
description: Specialized agent for [purpose]
model: sonnet
color: blue
tools:
  - Read
  - Grep
  - Glob
  - Edit
examples:
  - "[Example invocation 1]"
  - "[Example invocation 2]"
---

You are a specialized agent for [purpose].

## Your Role

[Detailed description of the agent's role and responsibilities]

## Guidelines

1. [Guideline 1]
2. [Guideline 2]
3. [Guideline 3]

## Process

When handling requests:

1. [Step 1]
2. [Step 2]
3. [Step 3]

## Constraints

- [Constraint 1]
- [Constraint 2]
```

## templates/claude/commands/my-command.md

```markdown
---
name: my-command
description: [What this command does]
arguments:
  - name: target
    description: [Argument description]
    required: true
---

[Command instructions]

$ARGUMENTS

[Additional context or instructions]
```

## templates/claude/mcp_servers.json

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

## templates/codex/config.toml

```toml
[mcp_servers.github]
command = "npx"
args = ["-y", "@anthropic/mcp-github"]

[mcp_servers.github.env]
GITHUB_TOKEN = "${GITHUB_TOKEN}"

[mcp_servers.context7]
command = "npx"
args = ["-y", "@context7/mcp-server"]
```

## prompts/analyze.txt

```
Analyze the provided content and generate a comprehensive response.

Structure your response as:

## Summary
Brief overview.

## Details
Detailed analysis.

## Recommendations
Suggested actions.
```

## README.md

```markdown
# @owner/my-package

Comprehensive package with skills, agents, and MCP integration.

## Features

- **my-skill** - [Description]
- **my-agent** - [Description]
- **/my-command** - [Description]
- **GitHub MCP** - PR and issue management
- **Context7 MCP** - Documentation lookup

## Installation

\`\`\`bash
tz add @owner/my-package
tz apply
\`\`\`

## Prerequisites

Set up required environment variables:

\`\`\`bash
export GITHUB_TOKEN=your_token_here
\`\`\`

## Usage

### Skills

Skills activate automatically based on context:

\`\`\`
"Help me with [skill purpose]"
\`\`\`

### Agents

Invoke agents directly:

\`\`\`
@my-agent [your request]
\`\`\`

### Commands

Run commands with slash prefix:

\`\`\`
/my-command [arguments]
\`\`\`

## License

MIT
```

## When to Use

Use this template when:
- Building a comprehensive assistant package
- Need multiple component types (skills, agents, commands)
- Integrating external services via MCP
- Creating a team-wide development toolkit
