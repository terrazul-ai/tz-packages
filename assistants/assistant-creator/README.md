# @terrazul/assistant-creator

Create AI assistant packages with skill and MCP server integration for Claude, Codex, and Gemini.

## Features

- **Create agents** for Claude Code with proper frontmatter and system prompts
- **Create skills** for any platform with templates and best practices
- **Create commands** for Claude (Markdown) and Gemini (TOML)
- **Search and install skills** from skillregistry.io
- **Search and configure MCP servers** from mcp.so
- **Convert skills** between Claude and Gemini formats

## Installation

```bash
tz add @terrazul/assistant-creator
tz apply
```

## Quick Start

### Create a Terrazul Package

```
"Create an AI assistant package for our codebase"
"Build a Terrazul package with dynamic content"
```

### Create an Agent (Claude)

```
"Create a code review agent for TypeScript"
```

### Create a Skill (All Platforms)

```
"Create a skill for our brand guidelines"
```

### Create a Command

**Claude**:
```
"Create a /review command"
```

**Gemini**:
```
"Create a Gemini command for code review"
```

### Search and Install Skills

```
"Search for testing skills on skillregistry.io"
"Install the code-review-standards skill"
```

### Add MCP Server

```
"Add GitHub integration"
"Configure Context7 for library documentation"
```

## Available Skills

| Skill | Description |
|-------|-------------|
| `create-assistant` | Create complete Terrazul packages with manifests and templates |
| `create-agent` | Create Claude agents with proper structure |
| `create-skill` | Create skills for any platform |
| `create-command` | Create Claude slash commands (Markdown) |
| `create-gemini-command` | Create Gemini slash commands (TOML) |
| `search-skills` | Search and install from skillregistry.io |
| `add-mcp` | Search and configure MCP servers |
| `convert-skill-to-gemini` | Convert Claude skills to Gemini format |

## Platform Support

| Feature | Claude | Codex | Gemini |
|---------|--------|-------|--------|
| Agents | YES | NO | NO |
| Skills | YES | YES | YES |
| Commands | Markdown | N/A | TOML |
| MCP Servers | JSON | TOML | JSON |

## Documentation

After installation, context files are available:
- **Claude**: `agent_modules/@terrazul/assistant-creator/CLAUDE.md`
- **Gemini**: `agent_modules/@terrazul/assistant-creator/GEMINI.md`
- **Codex**: `agent_modules/@terrazul/assistant-creator/codex/AGENTS.md`

## License

MIT
