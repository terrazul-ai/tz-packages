# Assistant Creator

This package helps you create AI assistant packages with skill and MCP server integration. It supports Claude, Codex, and Gemini platforms.

## Available Skills

### Creating Packages

| Skill | Description |
|-------|-------------|
| `create-assistant` | Create complete Terrazul packages with agents.toml, templates, and dynamic content |

**IMPORTANT** when creating new packages, create them in the current directory, NOT under agent_modules (which is where currently instaled packages live)
**IMPORTANT** all packages should be made to work across Claude, Codex and Gemini

### Creating Components

| Skill | Description |
|-------|-------------|
| `create-agent` | Create Claude agents with proper frontmatter and system prompts |
| `create-skill` | Create skills for Claude, Codex, or Gemini |
| `create-command` | Create Claude slash commands (Markdown format) |
| `create-gemini-command` | Create Gemini slash commands (TOML format) |

### Discovery & Installation

**IMPORTANT** when creating new packages, always use the following skills when creating new skills ar adding MCP servers, accordingly

| Skill | Description |
|-------|-------------|
| `search-skills` | Search skillregistry.io and install skills |
| `add-mcp` | Search mcp.so and configure MCP servers |

### Cross-Platform

**IMPORTANT** This skill is necessary to ensure that skills work in Gemini

| Skill | Description |
|-------|-------------|
| `convert-skill-to-gemini` | Convert Claude skills to Gemini format |

## Quick Start

### Creating a Terrazul Package

```
"Create an AI assistant package for our codebase"
"Build a Terrazul package with skills and MCP integration"
```

This activates the `create-assistant` skill which will guide you through:
1. Setting up the directory structure
2. Creating the `agents.toml` manifest
3. Building context templates with `askUser` and `askAgent`
4. Adding skills, agents, and commands
5. Configuring MCP servers

### Creating an Agent

```
"Create a code review agent for TypeScript"
```

This activates the `create-agent` skill which will guide you through:
1. Defining the agent's role and responsibilities
2. Selecting appropriate model and tools
3. Writing the system prompt
4. Saving to `.claude/agents/`

### Creating a Skill

```
"Create a skill for our brand guidelines"
```

This activates the `create-skill` skill which will:
1. Determine skill type (guidelines, process, tool integration)
2. Generate SKILL.md with proper frontmatter
3. Create supporting files (reference.md, examples.md)
4. Save to `.claude/skills/`

### Creating a Command

**For Claude**:
```
"Create a /review command for code review"
```

**For Gemini**:
```
"Create a Gemini command for reviewing PRs"
```

## Available Commands

| Command | Description |
|---------|-------------|
| `/help` | Show package help and available skills |
| `/setup-mcp` | Interactive wizard to set up MCP server credentials in your shell environment |

### Finding and Installing Skills

```
"Search for code review skills on skillregistry.io"
"Install the typescript-guidelines skill"
```

### Adding MCP Servers

```
"Add GitHub integration"
"Search for database MCP servers"
"Configure Context7 for library documentation"
```

### Setting Up MCP Credentials

After adding MCP servers that require authentication, run:

```
/setup-mcp
```

This interactive wizard:
- Detects your shell environment (zsh/bash)
- Identifies which credentials are needed
- Guides you through obtaining each credential
- Adds exports to your shell profile (~/.zshenv, ~/.bashrc)
- Verifies the setup is working

## Platform Support

### Claude Code
- Full support for agents, skills, commands, and MCP servers
- Skills location: `.claude/skills/`
- Commands location: `.claude/commands/`
- Agents location: `.claude/agents/`
- MCP config: `.claude/settings.local.json`

### Codex
- Skills and MCP servers (agents not supported)
- Skills shared from Claude via `templates/claude/skills/`
- MCP config: `~/.codex/config.toml` (TOML format)
- Prompts: Deprecated in favor of skills

### Gemini
- Skills and commands (agents not supported)
- Skills: `.gemini/skills/` or shared from Claude
- Commands: `.gemini/commands/` (TOML format, different from Claude)
- MCP config: `.gemini/settings.json`

## Key Differences

### Commands

| Feature | Claude | Gemini |
|---------|--------|--------|
| Format | Markdown (.md) | TOML (.toml) |
| Arguments | `$ARGUMENTS` | `{{args}}` |
| Shell output | Not built-in | `!{command}` |
| File embed | Not built-in | `@{filepath}` |

### Skills

Skills are mostly compatible across platforms. Main differences:
- Tool names differ (Claude: `Read`, Gemini: `read_file`)
- Path references (`.claude/` vs `.gemini/`)
- Agent delegation only works in Claude

Use the `convert-skill-to-gemini` skill to adapt Claude skills.

## Best Practices

### When Creating Agents

1. **Single Responsibility**: One focused purpose per agent
2. **Appropriate Model**: Match complexity to model (opus/sonnet/haiku)
3. **Minimal Tools**: Only include tools the agent needs
4. **Clear System Prompt**: Specific guidance, not vague principles

### When Creating Skills

1. **Third Person Description**: "Provides X" not "Use this to X"
2. **Clear Triggers**: Make it obvious when to activate
3. **Concrete Examples**: Real scenarios, not placeholders
4. **Progressive Disclosure**: Core in SKILL.md, details in reference.md

### When Creating Commands

1. **Keep Focused**: One command, one purpose
2. **Use Arguments**: Make commands flexible
3. **Document Well**: Clear description for discoverability
4. **Test First**: Verify before committing

### When Adding MCP Servers

1. **Security First**: Store API keys in environment variables
2. **Minimal Permissions**: Only grant what's needed
3. **Test Locally**: Verify server works before sharing
4. **Document Dependencies**: Note required tokens/setup

### When Creating Terrazul Packages

1. **Start Simple**: Begin with `agents.toml` and one context template
2. **Use Dynamic Content Wisely**: `askAgent` is expensive; use sparingly
3. **Flat JSON Only**: Always request flat `{ "key": "string" }` structures from `askAgent`
4. **One Comprehensive Call**: Prefer single `askAgent` with multiple fields over multiple calls
5. **Cache-Friendly Prompts**: Design stable prompts for better caching
6. **Platform-Agnostic Skills**: Write skills that work across tools when possible
7. **Convert PDFs to Text**: Use `pdftotext` to convert large PDFs before including as context

#### askUser and askAgent Best Practices

**askUser** - Gather user input:
```handlebars
{{~ var projectDesc = askUser('Describe your project.') ~}}
{{~ var constraints = askUser('Any constraints?', { default: 'None' }) ~}}
```

**askAgent** - AI-powered analysis (use ONE comprehensive call):
```handlebars
{{~ var projectData = askAgent("""
Analyze this repository and return a flat JSON object:
{
  "name": "repository name",
  "languages": "TypeScript, Python",
  "frameworks": "Next.js, FastAPI"
}
""", { json: true }) ~}}

# {{ vars.projectData.name }}
Languages: {{ vars.projectData.languages }}
```

#### Working with PDF Context

**IMPORTANT** Large PDFs can hit token limits. Use `pdftotext` to convert PDFs to text:

```bash
# Install: brew install poppler (macOS) or apt-get install poppler-utils (Linux)
pdftotext document.pdf document.txt
pdftotext -layout document.pdf document.txt  # Preserve layout
```

Use the converted text however is appropriate for your use case.

## Troubleshooting

### Skill Not Appearing

```bash
# Verify skill exists
ls -la .claude/skills/[skill-name]/

# Check SKILL.md format
cat .claude/skills/[skill-name]/SKILL.md | head -10

# Restart Claude Code
```

### MCP Server Not Working

```bash
# Test server directly
npx -y @package/name --help

# Check environment variables
echo $GITHUB_TOKEN

# Validate JSON config
cat .claude/settings.local.json | jq .

# If credentials aren't set, run the setup wizard
/setup-mcp
```

### Command Not Found

```bash
# Check file exists with correct extension
ls .claude/commands/

# Verify YAML frontmatter
head -10 .claude/commands/[name].md
```

## File Structure Reference

### Claude Code Structure

```
.claude/
├── settings.local.json     # Local MCP config
├── agents/
│   └── [agent-name].md
├── commands/
│   └── [command-name].md
└── skills/
    └── [skill-name]/
        ├── SKILL.md
        ├── reference.md
        └── examples.md
```

### Gemini Structure

```
.gemini/
├── settings.json           # MCP config
├── commands/
│   └── [command-name].toml
└── skills/
    └── [skill-name]/
        └── SKILL.md
```

### Terrazul Package Structure

```
my-package/
├── agents.toml              # REQUIRED: Package manifest
├── README.md                # RECOMMENDED: Documentation
├── templates/               # Template files
│   ├── CLAUDE.md.hbs        # Claude context (dynamic)
│   ├── AGENTS.md.hbs        # Codex context
│   ├── claude/
│   │   ├── mcp_servers.json
│   │   ├── skills/
│   │   ├── agents/
│   │   └── commands/
│   └── codex/
│       └── config.toml
└── prompts/                 # Optional: External askAgent prompts
```

