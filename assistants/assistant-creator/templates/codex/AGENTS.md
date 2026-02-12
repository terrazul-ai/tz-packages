# Assistant Creator

This package helps you create AI assistant packages with skill and MCP server integration for Codex.

## Available Skills

Skills are shared from Claude via the package configuration. All skills work with Codex.

### Creating Packages

| Skill | Description |
|-------|-------------|
| `create-assistant` | Create complete Terrazul packages with manifests, templates, and dynamic content |

### Creating Components

| Skill | Description |
|-------|-------------|
| `create-skill` | Create skills for any platform |
| `create-agent` | Create Claude agents (Claude-only, but documents patterns) |
| `create-command` | Create Claude commands (for reference) |
| `create-gemini-command` | Create Gemini commands (for reference) |

### Discovery & Installation

| Skill | Description |
|-------|-------------|
| `search-skills` | Search skillregistry.io and install skills |
| `add-mcp` | Search mcp.so and configure MCP servers |

### Cross-Platform

| Skill | Description |
|-------|-------------|
| `convert-skill-to-gemini` | Convert skills between formats |

## Quick Start

### Creating a Terrazul Package

```
"Create an AI assistant package for our codebase"
```

This activates the `create-assistant` skill which guides you through creating a complete Terrazul package with:
- `agents.toml` manifest
- Context templates (with optional `askUser`/`askAgent` dynamic content)
- Skills, agents, and commands
- MCP server configuration

### Creating a Skill

```
"Create a skill for our coding standards"
```

Skills are platform-agnostic in their basic form. The skill will be created in a format that works with Codex.

### Finding Skills

```
"Search for code review skills"
```

Skills from skillregistry.io work with Codex. They're stored in `templates/claude/skills/` but shared via package configuration.

### Adding MCP Servers

```
"Add GitHub integration for Codex"
```

Codex uses TOML format for MCP configuration in `~/.codex/config.toml`.

## Codex-Specific Notes

### Skills

Skills work the same as Claude. They're stored in the shared location and symlinked by the CLI.

### Prompts (Deprecated)

Codex prompts (`~/.codex/prompts/*.md`) are deprecated in favor of skills. This package focuses on skills instead.

### MCP Configuration

Codex uses TOML format:

```toml
[mcp_servers.github]
command = "npx"
args = ["-y", "@anthropic/mcp-github"]

[mcp_servers.github.env]
GITHUB_TOKEN = "${GITHUB_TOKEN}"
```

### Agents

Codex does not support subagents. Skills and MCP servers provide the primary extensibility.

## Tool Names

Codex may use different tool names than Claude. When creating skills:

- Write instructions generically when possible
- Avoid hardcoding specific tool names
- Test skills in Codex after creation

## File Structure

```
~/.codex/
├── config.toml             # MCP and settings
└── prompts/                # Deprecated, use skills

project/
└── agent_modules/
    └── @terrazul/
        └── assistant-creator/
            └── claude/
                └── skills/    # Shared skills
```

## Terrazul Package Structure

When creating packages with `create-assistant`:

```
my-package/
├── agents.toml              # REQUIRED: Package manifest
├── README.md                # Documentation
└── templates/
    ├── CLAUDE.md.hbs        # Dynamic content with askUser/askAgent
    ├── AGENTS.md.hbs        # Codex context
    └── claude/
        └── skills/          # Skills (shared across platforms)
```

### Dynamic Content (askUser/askAgent)

Templates can use Handlebars (`.hbs`) for dynamic content:

```handlebars
{{~ var projectData = askAgent("""
Return flat JSON: { "name": "repo name", "type": "project type" }
""", { json: true }) ~}}

# {{ vars.projectData.name }}
Type: {{ vars.projectData.type }}
```

Best practices:
- Use ONE `askAgent` call with flat JSON (all values as strings)
- Use `askUser` for gathering user context
- Keep prompts stable for better caching
- Convert large PDFs to text with `pdftotext` before including as context

### Working with PDF Context

Large PDFs can exceed token limits. Convert them to text first:

```bash
# Install: brew install poppler (macOS) or apt-get install poppler-utils (Linux)
pdftotext document.pdf document.txt
```

Use the converted text however is appropriate for your use case.

## Best Practices

1. **Use Skills Over Prompts**: Skills are the modern approach
2. **Platform-Agnostic Instructions**: Avoid tool-specific references
3. **Test in Codex**: Verify skills work after creation
4. **TOML for MCP**: Remember Codex uses TOML, not JSON

## Troubleshooting

### Skill Not Working

```bash
# Check skill files
ls -la agent_modules/@terrazul/assistant-creator/claude/skills/

# Verify SKILL.md format
cat agent_modules/@terrazul/assistant-creator/claude/skills/[skill]/SKILL.md | head -10
```

### MCP Server Issues

```bash
# Validate TOML syntax
cat ~/.codex/config.toml | toml-cli validate

# Test server
npx -y @package/name --help
```
