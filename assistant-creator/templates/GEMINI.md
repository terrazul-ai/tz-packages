# Assistant Creator

This package helps you create AI assistant packages with skill and MCP server integration for Gemini CLI.

## Available Skills

### Creating Packages

| Skill | Description |
|-------|-------------|
| `create-assistant` | Create complete Terrazul packages with manifests, templates, and dynamic content |

### Creating Components

| Skill | Description |
|-------|-------------|
| `create-skill` | Create skills for Gemini (or any platform) |
| `create-gemini-command` | Create Gemini slash commands (TOML format) |
| `create-command` | Create Claude slash commands (if cross-platform needed) |
| `create-agent` | Create Claude agents (Claude-only feature) |

### Discovery & Installation

| Skill | Description |
|-------|-------------|
| `search-skills` | Search skillregistry.io and install skills |
| `add-mcp` | Search mcp.so and configure MCP servers |

### Cross-Platform

| Skill | Description |
|-------|-------------|
| `convert-skill-to-gemini` | Convert Claude skills to Gemini format |

## Quick Start

### Creating a Terrazul Package

```
"Create an AI assistant package for our codebase"
```

This activates the `create-assistant` skill which guides you through creating a complete Terrazul package with `agents.toml`, context templates (including dynamic `askUser`/`askAgent` content), skills, and MCP configuration.

### Creating a Skill

```
"Create a skill for our coding standards"
```

This activates the `create-skill` skill which will:
1. Determine skill type (guidelines, process, tool integration)
2. Generate SKILL.md with proper frontmatter
3. Create supporting files if needed
4. Save to `.gemini/skills/`

### Creating a Gemini Command

```
"Create a command for reviewing code changes"
```

This activates the `create-gemini-command` skill which will:
1. Understand the command purpose
2. Generate a TOML command file
3. Support special syntax (`{{args}}`, `!{...}`, `@{...}`)
4. Save to `.gemini/commands/`

### Finding and Installing Skills

```
"Search for code review skills"
"Install the typescript-guidelines skill"
```

Skills from skillregistry.io are in Claude format. Use `convert-skill-to-gemini` if needed.

### Adding MCP Servers

```
"Add GitHub integration"
"Configure MCP for PostgreSQL"
```

## Gemini-Specific Features

### Command Format (TOML)

Gemini commands use TOML format:

```toml
description = "Review code for issues"
prompt = """
Review the code: {{args}}

Focus on quality and security.
"""
```

### Special Syntax

| Syntax | Purpose | Example |
|--------|---------|---------|
| `{{args}}` | User arguments | `Review {{args}}` |
| `!{cmd}` | Shell output | `!{git status}` |
| `@{path}` | File embed | `@{package.json}` |

### Namespaced Commands

Create directories for related commands:

```
.gemini/commands/
├── review.toml          # /review
└── git/
    ├── status.toml      # /git:status
    └── commit.toml      # /git:commit
```

## Platform Limitations

### Not Available in Gemini

- **Agents (subagents)**: Claude-only feature
- **Some MCP servers**: May have Claude-specific integrations

### Workarounds

- Skills can provide step-by-step processes instead of agent delegation
- Use web search for documentation instead of Context7 (if unavailable)

## Skill Compatibility

Skills from skillregistry.io are designed for Claude but often work in Gemini:

**Works directly**:
- Skills without `allowed-tools`
- Skills without tool references
- Pure guidelines/reference skills

**Needs conversion**:
- Skills with Claude tool names (`Read` → `read_file`)
- Skills with `.claude/` path references
- Skills with agent delegation

Use the `convert-skill-to-gemini` skill to adapt:
```
"Convert the code-review skill to Gemini format"
```

## MCP Configuration

### Settings File

`.gemini/settings.json`:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

### Environment Variables

Set tokens in your shell:

```bash
export GITHUB_TOKEN="ghp_..."
export DATABASE_URL="postgres://..."
```

## File Structure

```
.gemini/
├── settings.json           # MCP configuration
├── commands/
│   ├── review.toml
│   └── git/
│       ├── status.toml
│       └── commit.toml
└── skills/
    └── my-skill/
        ├── SKILL.md
        ├── reference.md
        └── examples.md
```

## Best Practices

### Creating Commands

1. **Use TOML Format**: Gemini commands are `.toml`, not `.md`
2. **Leverage Special Syntax**: Use `!{...}` for dynamic context
3. **Handle Missing Args**: Design commands to work with or without `{{args}}`
4. **Safe Shell Commands**: Avoid destructive commands in `!{...}`

### Creating Skills

1. **Platform-Agnostic When Possible**: Avoid tool-specific references
2. **Document Limitations**: Note if skill was converted from Claude
3. **Test in Gemini**: Verify skill works before sharing

### MCP Servers

1. **Use Environment Variables**: Never hardcode tokens
2. **Test Locally**: Verify servers work with Gemini
3. **Document Setup**: Note required tokens and permissions

### Working with PDF Context

Large PDFs can exceed token limits when read directly. Convert to text first:

```bash
# Install: brew install poppler (macOS) or apt-get install poppler-utils (Linux)
pdftotext document.pdf document.txt
pdftotext -layout document.pdf document.txt  # Preserve layout
```

Use the converted text however is appropriate for your use case.

## Troubleshooting

### Command Not Working

```bash
# Check TOML syntax
cat .gemini/commands/[name].toml | toml-cli validate

# Verify file location
ls -la .gemini/commands/
```

### Skill Not Appearing

```bash
# Check skill directory
ls -la .gemini/skills/[skill-name]/

# Verify SKILL.md format
head -10 .gemini/skills/[skill-name]/SKILL.md
```

### MCP Server Issues

```bash
# Test server directly
npx -y @package/name --help

# Check JSON syntax
cat .gemini/settings.json | jq .

# Verify environment variables
echo $GITHUB_TOKEN
```
