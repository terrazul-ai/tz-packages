# @terrazul/assistant-creator - Package Help

Welcome to the **@terrazul/assistant-creator** package! This package helps you create AI assistant packages with skill and MCP server integration for Claude, Codex, and Gemini.

---

## Quick Overview

This package includes:
- **Skills for creating components** - Agents, skills, and commands
- **Discovery tools** - Search and install from skillregistry.io and mcp.so
- **Cross-platform support** - Claude, Codex, and Gemini
- **Conversion utilities** - Port skills between platforms

---

## Available Skills

### 1. **create-agent**
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

### 2. **create-skill**
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

### 3. **create-command**
**Purpose**: Create Claude slash commands (Markdown format)

**When to use**:
- Adding custom `/command` shortcuts
- Automating repetitive tasks
- Creating project-specific workflows

**Format**: Markdown with YAML frontmatter, uses `$ARGUMENTS`

**Example**: "Create a /review command for code review"

---

### 4. **create-gemini-command**
**Purpose**: Create Gemini CLI slash commands (TOML format)

**When to use**:
- Building Gemini-specific commands
- Using Gemini's special syntax (`{{args}}`, `!{...}`, `@{...}`)

**Format**: TOML with `description` and `prompt` fields

**Example**: "Create a Gemini command for reviewing git changes"

---

### 5. **search-skills**
**Purpose**: Search skillregistry.io and install skills

**When to use**:
- Finding pre-built skills
- Installing community skills
- Browsing skill categories

**Example**: "Search for code review skills on skillregistry.io"

---

### 6. **add-mcp**
**Purpose**: Search mcp.so and configure MCP servers

**When to use**:
- Adding external integrations (GitHub, databases, APIs)
- Configuring new tools
- Setting up development environment

**Example**: "Add GitHub integration to my project"

---

### 7. **convert-skill-to-gemini**
**Purpose**: Convert Claude skills to Gemini format

**When to use**:
- Porting skills from skillregistry.io to Gemini
- Making skills cross-platform compatible
- Adapting Claude-specific skills

**Example**: "Convert the code-review skill to Gemini format"

---

## Platform Support Matrix

| Feature | Claude | Codex | Gemini |
|---------|--------|-------|--------|
| Agents | YES | NO | NO |
| Skills | YES | YES | YES |
| Commands | Markdown | N/A | TOML |
| MCP Servers | JSON | TOML | JSON |

---

## Common Workflows

### Creating a Complete Agent Package

1. "Create a code review agent" (uses create-agent)
2. "Create a skill for review guidelines" (uses create-skill)
3. "Create a /review command" (uses create-command)
4. "Add GitHub integration" (uses add-mcp)

### Setting Up Cross-Platform Skills

1. "Search for typescript skills" (uses search-skills)
2. "Install the typescript-guidelines skill"
3. "Convert it to Gemini format" (uses convert-skill-to-gemini)

### Adding External Integrations

1. "Search for database MCP servers" (uses add-mcp)
2. "Configure PostgreSQL server"
3. Follow environment variable setup

---

## File Locations

### Claude
```
.claude/
├── settings.local.json    # MCP config
├── agents/               # Agent definitions
├── commands/             # Slash commands
└── skills/               # Skill directories
```

### Gemini
```
.gemini/
├── settings.json         # MCP config
├── commands/             # TOML commands
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
```

### Command not found
```bash
ls .claude/commands/
head -10 .claude/commands/[name].md
```

---

Need more help? Check the README or ask me directly about specific features!
