---
name: help
description: Shows all available skills, platform support, common workflows, and troubleshooting for the @terrazul/assistant-creator package. Activates when the user asks for help, wants to know what's available, or needs guidance on using the package.
---

# @terrazul/assistant-creator - Package Help

Welcome to the **@terrazul/assistant-creator** package! This package helps you create AI assistant packages with skill and MCP server integration for Claude, Codex, and Gemini.

## Quick Overview

This package includes:
- **Skills for creating components** - Agents, skills, and complete Terrazul packages
- **Discovery tools** - Search and install from skillregistry.io and mcp.so
- **Cross-platform support** - Claude, Codex, and Gemini
- **Conversion utilities** - Port skills between platforms
- **Setup tools** - Interactive credential setup for MCP servers

## Available Skills

### 1. **create-assistant**
**Purpose**: Create complete Terrazul AI assistant packages

**When to use**:
- Building reusable AI assistant configurations
- Creating packages with agents.toml, templates, and dynamic content
- Setting up packages for Claude, Codex, or Gemini

**Example**: "Create an AI assistant package for our codebase"

---

### 2. **create-agent**
**Purpose**: Create Claude Code agent definitions

**When to use**:
- Creating specialized coding assistants
- Building domain-specific helpers
- Defining custom agent personas

**Templates available**:
- `basic-agent.md` - Simple agent template
- `code-agent.md` - Code generation agent
- `research-agent.md` - Research and analysis agent
- `review-agent.md` - Code review agent

**Example**: "Create a security-focused code review agent"

---

### 3. **create-skill**
**Purpose**: Create skills for any platform

**When to use**:
- Adding reusable capabilities
- Creating guidelines or standards
- Building tool integrations

**Templates available**:
- `basic-skill.md` - Simple skill template
- `guidelines-skill.md` - Standards and guidelines
- `process-skill.md` - Workflow skills
- `tool-integration-skill.md` - External tool integration

**Example**: "Create a skill for our TypeScript coding standards"

---

### 4. **search-skills**
**Purpose**: Search skillregistry.io and install skills

**When to use**:
- Finding pre-built skills
- Installing community skills
- Browsing skill categories

**Example**: "Search for code review skills on skillregistry.io"

---

### 5. **add-mcp**
**Purpose**: Search mcp.so and configure MCP servers

**When to use**:
- Adding external integrations (GitHub, databases, APIs)
- Configuring new tools
- Setting up development environment

**Example**: "Add GitHub integration to my project"

---

### 6. **convert-skill-to-gemini**
**Purpose**: Convert Claude skills to Gemini format

**When to use**:
- Porting skills from skillregistry.io to Gemini
- Making skills cross-platform compatible
- Adapting Claude-specific skills

**Example**: "Convert the code-review skill to Gemini format"

---

### 7. **help**
**Purpose**: Show this help overview

**When to use**:
- Getting oriented with the package
- Finding available skills
- Learning common workflows

**Example**: "What skills are available?" or "Help me get started"

---

### 8. **setup-mcp**
**Purpose**: Interactive wizard to set up MCP server credentials

**When to use**:
- After adding MCP servers that require API keys
- Setting up environment variables for authentication
- Configuring credentials in your shell profile

**Example**: "Set up my MCP credentials" or "Configure GitHub token"

---

## Platform Support Matrix

| Feature | Claude | Codex | Gemini |
|---------|--------|-------|--------|
| Agents | YES | NO | NO |
| Skills | YES | YES | YES |
| MCP Servers | JSON | TOML | JSON |

---

## Common Workflows

### Creating a Complete Agent Package

1. "Create an AI assistant package" (uses create-assistant)
2. "Create a code review agent" (uses create-agent)
3. "Create a skill for review guidelines" (uses create-skill)
4. "Add GitHub integration" (uses add-mcp)
5. "Set up my MCP credentials" (uses setup-mcp)

### Setting Up Cross-Platform Skills

1. "Search for typescript skills" (uses search-skills)
2. "Install the typescript-guidelines skill"
3. "Convert it to Gemini format" (uses convert-skill-to-gemini)

### Adding External Integrations

1. "Search for database MCP servers" (uses add-mcp)
2. "Configure PostgreSQL server"
3. "Set up credentials" (uses setup-mcp)

---

## File Locations

### Claude
```
.claude/
├── settings.local.json    # MCP config
├── agents/               # Agent definitions
└── skills/               # Skill directories
```

### Gemini
```
.gemini/
├── settings.json         # MCP config
└── skills/               # Skill directories
```

### Codex
```
~/.codex/
└── config.toml           # MCP config (TOML format)
```

---

## Tips

1. **Start with templates**: Each skill has templates for common patterns
2. **Test incrementally**: Try skills after creation
3. **Use search skills**: Don't reinvent the wheel
4. **Check platform compatibility**: Some features are Claude-only
5. **Run setup-mcp after adding integrations**: Ensure credentials are configured

---

## Troubleshooting

### Skills not appearing
```bash
tz apply --force
ls -la .claude/skills/
```

### MCP server not working
```bash
# Test server
npx -y @package/name --help
# Check config
cat .claude/settings.local.json | jq .
# Set up missing credentials
# Use the setup-mcp skill
```

### Credentials not set
Run the `setup-mcp` skill to interactively configure all required environment variables for your MCP servers.

---

Need more help? Ask about specific features!
