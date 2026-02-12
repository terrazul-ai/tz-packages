# Terrazul Package Reference

Complete reference for creating Terrazul AI assistant packages.

## agents.toml Manifest Reference

The `agents.toml` manifest is the core configuration file for Terrazul packages.

### [package] Section

Defines core package information. `name` and `version` required for publishing.

```toml
[package]
name = "@owner/package-name"           # Required for publish
version = "1.0.0"                      # Required for publish (semver)
description = "Short description"      # Optional
homepage = "https://example.com"       # Optional
repository = "https://github.com/..."  # Optional
documentation = "https://docs...."     # Optional
license = "MIT"                        # Optional (SPDX identifier)
keywords = ["ai", "agent", "config"]   # Optional
authors = ["Name <email@example.com>"] # Optional
is_private = false                     # Optional (blocks publishing if true)
```

**Name Format**: Must match `/^@[\d_a-z-]+\/[\d_a-z-]+$/`
- Lowercase only
- Alphanumeric, hyphens, underscores allowed
- Must have scope (e.g., `@owner/`)

### [dependencies] Section

Declares package dependencies:

```toml
[dependencies]
"@terrazul/base" = "^2.0.0"     # Caret: compatible with 2.x.x
"@acme/utils" = "~1.5.0"        # Tilde: compatible with 1.5.x
"@org/exact" = "1.0.0"          # Exact version
```

### [compatibility] Section

Declares tool compatibility:

```toml
[compatibility]
claude = ">=0.2.0"     # Minimum version
codex = "*"            # Any version
gemini = "^1.0.0"      # Compatible range
cursor = "~2.5.0"      # Patch-compatible range
copilot = "*"
```

**Valid tools**: `claude`, `codex`, `gemini`, `cursor`, `copilot`

### [tasks] Section

Maps task identifiers to file paths:

```toml
[tasks]
"ctx.generate" = "tasks/ctx-generate.yaml"
"build" = "tasks/build.json"
```

**Rules**:
- Paths must be relative (no `..` traversal)
- Referenced files must exist
- Symlinks must resolve within package root

### [exports] Section

Defines tool-specific template exports:

```toml
[exports.claude]
template = "templates/CLAUDE.md.hbs"
skillsDir = "templates/claude/skills"
agentsDir = "templates/claude/agents"
commandsDir = "templates/claude/commands"
mcpServers = "templates/claude/mcp_servers.json.hbs"

[exports.codex]
template = "templates/AGENTS.md.hbs"
skillsDir = "templates/claude/skills"

[exports.gemini]
template = "templates/GEMINI.md.hbs"
skillsDir = "templates/claude/skills"
commandsDir = "templates/gemini/commands"
mcpServers = "templates/gemini/settings.json.hbs"
```

**Export Properties**:
- `template` - Main context template path
- `skillsDir` - Directory containing skills
- `agentsDir` - Directory containing agents (Claude only)
- `commandsDir` - Directory containing commands
- `mcpServers` - MCP server configuration file

### [profiles] Section

Defines installation profiles:

```toml
[profiles]
focus = ["@acme/alpha", "@acme/bravo"]
full = ["@acme/alpha", "@acme/bravo", "@acme/charlie"]
minimal = ["@acme/alpha"]
```

**Usage**:
```bash
tz add --profile focus @acme/alpha
tz run --profile focus
```

---

## Template System Reference

### Handlebars Basics

Templates use Handlebars syntax (`.hbs` extension):

```handlebars
# {{ project.name }}

{{#if vars.hasTests}}
## Testing
Run tests with: `npm test`
{{else}}
No tests configured.
{{/if}}

{{#each items}}
- {{ this.name }}: {{ this.description }}
{{/each}}
```

### Template Context

Templates receive this context when rendered:

```typescript
{
  project: {
    name: string;      // Project name
    root: string;      // Project root path
  };
  pkg: {
    name: string;      // Package name
    version: string;   // Package version
    // ... other package metadata
  };
  env: Record<string, string>;  // Environment variables
  now: Date;                     // Current timestamp
  files: { /* file helpers */ };
  vars: Record<string, any>;    // Variables from askUser/askAgent
}
```

### Whitespace Control

Use `~` for whitespace trimming:

```handlebars
{{~ var x = askUser('Question') ~}}  <!-- Trims surrounding whitespace -->
{{- expression -}}                    <!-- Same effect -->
```

---

## askUser Reference

Interactive prompts for gathering user input.

### Basic Syntax

```handlebars
{{~ var variableName = askUser('Your question here') ~}}
```

### With Options

```handlebars
{{~ var answer = askUser('Question text', {
  default: 'default value',
  placeholder: 'hint text'
}) ~}}
```

### Options

| Option | Type | Description |
|--------|------|-------------|
| `default` | string | Default value if user presses Enter |
| `placeholder` | string | Hint text shown when input is empty |

### Examples

**Simple question**:
```handlebars
{{~ var projectName = askUser('What is your project name?') ~}}
```

**With default**:
```handlebars
{{~ var framework = askUser('Which framework?', { default: 'React' }) ~}}
```

**With placeholder**:
```handlebars
{{~ var constraints = askUser('Any constraints?', {
  default: 'None',
  placeholder: 'Enter constraints or press Enter for none'
}) ~}}
```

**Using the value**:
```handlebars
# {{ vars.projectName }}

Framework: {{ vars.framework }}
```

---

## askAgent Reference

AI-powered content generation using codebase analysis.

### Basic Syntax

```handlebars
{{~ var result = askAgent('Your prompt here') ~}}
```

### String Formats

**Single quotes** - Single-line prompts:
```handlebars
{{~ var name = askAgent('What is the repository name?') ~}}
```

**Backticks** - Multi-line prompts:
```handlebars
{{~ var analysis = askAgent(`
Analyze the repository structure.
Return a brief summary.
`) ~}}
```

**Triple quotes** - Multi-line with auto-dedenting:
```handlebars
{{~ var data = askAgent("""
Analyze this repository and return:
{
  "name": "repo name",
  "description": "description"
}
""", { json: true }) ~}}
```

### Options

```typescript
{
  json?: boolean;           // Expect JSON response
  tool?: ToolType;          // Override tool: 'claude' | 'codex' | 'cursor' | 'copilot'
  schema?: SchemaReference; // Validate JSON against schema
  safeMode?: boolean;       // Disable if agent can modify files (default: true)
  timeoutMs?: number;       // Custom timeout in milliseconds
  systemPrompt?: string;    // Custom system prompt (Claude only)
}
```

### Options Details

**json: true** - Parse response as JSON:
```handlebars
{{~ var config = askAgent('Return config as JSON', { json: true }) ~}}
Name: {{ vars.config.name }}
```

**tool** - Specify AI tool:
```handlebars
{{~ var result = askAgent('Analyze code', { tool: 'claude' }) ~}}
```

**systemPrompt** - Custom system prompt:
```handlebars
{{~ var guide = askAgent('Write user guide', {
  systemPrompt: 'You are a helpful technical writer.'
}) ~}}
```

**Default system prompt**:
```
You are a context extraction agent. Your job is to understand, synthesize
and extract context from existing projects. Your responses should only
include what is asked, and should not include any dialog such as
"I'm now ready to..", "Looking at", etc.
```

### File-Based Prompts

Reference external prompt files:

```handlebars
{{~ var analysis = askAgent('./prompts/analyze-architecture.txt') ~}}
```

File paths are resolved relative to the package directory.

### JSON Response Best Practices

**CRITICAL**: Always use flat JSON structures where every value is a string:

```handlebars
{{~ var projectData = askAgent("""
Analyze this repository and return a flat JSON object.
All values must be strings. Use commas to separate list items.

{
  "name": "repository name",
  "description": "brief description",
  "languages": "TypeScript, Python, Go",
  "frameworks": "Next.js, FastAPI",
  "directories": "src: source, tests: tests, docs: documentation"
}
""", { json: true }) ~}}
```

**Why flat JSON**:
- More reliably parsed by AI models
- Simpler to access: `{{ vars.projectData.languages }}`
- Avoids nested property issues
- Better caching behavior

**Avoid nested structures**:
```json
// BAD - nested structure
{
  "techStack": {
    "languages": ["TypeScript", "Python"]
  }
}

// GOOD - flat structure
{
  "languages": "TypeScript, Python"
}
```

### Single Comprehensive Call Pattern

**CRITICAL**: Use ONE askAgent call with all fields instead of multiple calls:

```handlebars
{{~ var projectAnalysis = askAgent("""
Analyze this repository and return a flat JSON object:
{
  "name": "repository name",
  "description": "brief description",
  "languages": "primary languages",
  "frameworks": "frameworks used",
  "buildTools": "build tools",
  "testFramework": "test framework if present",
  "mainDirectories": "key directories with purposes"
}
Only include fields you can confidently determine.
""", { json: true }) ~}}

# {{ vars.projectAnalysis.name }}

{{ vars.projectAnalysis.description }}

## Tech Stack
- Languages: {{ vars.projectAnalysis.languages }}
- Frameworks: {{ vars.projectAnalysis.frameworks }}
- Build: {{ vars.projectAnalysis.buildTools }}
- Tests: {{ vars.projectAnalysis.testFramework }}

## Structure
{{ vars.projectAnalysis.mainDirectories }}
```

**Why single calls are better**:
- **Performance**: 3-5x faster (one API call vs multiple)
- **Cost**: Fewer API invocations
- **Quality**: AI sees all requirements together, more coherent output
- **Caching**: Simpler cache invalidation

### Chaining Variables

Use previous results in subsequent calls:

```handlebars
{{~ var projectInfo = askAgent('Describe this project briefly') ~}}
{{~ var recommendations = askAgent('Based on: {{ vars.projectInfo }}, suggest improvements') ~}}
```

---

## Snippet Caching

Terrazul caches snippet responses to avoid re-prompting.

### Cache Behavior

- **Content-based IDs**: Each snippet gets a stable ID from prompt + options
- **Cache file**: `agents-cache.toml` in project root
- **Automatic reuse**: Same prompts across renders use cached values
- **Version tracking**: Cache invalidates when package version changes

### Cache File Structure

```toml
version = 1

[packages."@user/package"]
version = "1.0.0"

[[packages."@user/package".snippets]]
id = "snippet_a1b2c3d4"
type = "askUser"
promptExcerpt = "Summarize this project..."
value = "\"A CLI tool for AI agent management\""
timestamp = "2025-01-21T10:30:00.000Z"

[[packages."@user/package".snippets]]
id = "snippet_e5f6g7h8"
type = "askAgent"
promptExcerpt = "Analyze repository structure..."
value = "\"# Structure\\n\\n- src/: Core...\""
timestamp = "2025-01-21T10:30:15.000Z"
tool = "claude"
```

### Cache Management

```bash
# Bypass cache, re-run all snippets
tz apply --no-cache

# Force overwrite existing output files
tz apply --force

# Both flags for complete refresh
tz apply --force --no-cache
```

---

## Skill File Reference

Skills add capabilities to AI tools.

### SKILL.md Format

```markdown
---
name: skill-name
description: Third-person description explaining what and when
version: "1.0.0"
allowed-tools:
  - Read
  - Grep
  - Glob
---

# Skill Title

[Overview - 2-3 sentences]

## When to Use

Activate this skill when:
- [Trigger 1]
- [Trigger 2]

## Instructions

[Step-by-step instructions]

## Examples

[Concrete examples]

## Reference Materials

- `reference.md` - Detailed documentation
- `examples.md` - More examples
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Lowercase, hyphens, max 64 chars |
| `description` | Yes | Third-person, max 1024 chars |
| `version` | No | Semver string |
| `allowed-tools` | No | Restrict available tools |

### Description Guidelines

**Format**: `[Verb]s [specific thing] [context] including [features]`

**Good verbs**: Applies, Processes, Generates, Provides, Enforces, Creates

**Examples**:
- "Applies brand guidelines to presentations including logo usage and typography"
- "Processes Excel files and generates reports with charts and insights"

---

## Agent File Reference

Agents define specialized Claude personas.

### Agent Format

```markdown
---
name: agent-name
description: What this agent specializes in
model: sonnet
color: blue
tools:
  - Read
  - Grep
  - Glob
  - Edit
examples:
  - "Review this code for security"
  - "Analyze the architecture"
---

You are a specialized agent for [purpose].

## Your Role

[Agent responsibilities]

## Guidelines

[Specific instructions]
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Agent identifier |
| `description` | Yes | Brief description |
| `model` | No | `opus`, `sonnet`, `haiku` |
| `color` | No | UI color for agent |
| `tools` | No | Available tools |
| `examples` | No | Example invocation phrases |

---

## Command File Reference

Commands are user-invokable shortcuts.

### Claude Command Format (Markdown)

```markdown
---
name: review
description: Run code review on specified files
arguments:
  - name: files
    description: Files to review
    required: true
---

Review the following files for code quality:
$ARGUMENTS

Focus on:
- Security issues
- Performance problems
- Code style
```

### Gemini Command Format (TOML)

```toml
name = "review"
description = "Run code review on specified files"

[[arguments]]
name = "files"
description = "Files to review"
required = true

[prompt]
text = """
Review the following files: {{args}}

Focus on security, performance, and style.
"""
```

---

## MCP Server Configuration

### Claude Format (JSON)

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

### Codex Format (TOML)

```toml
[mcp_servers.github]
command = "npx"
args = ["-y", "@anthropic/mcp-github"]

[mcp_servers.github.env]
GITHUB_TOKEN = "${GITHUB_TOKEN}"
```

### Gemini Format (JSON)

Same as Claude format.

---

## CLI Commands Reference

### Package Development

```bash
# Initialize new package
tz init

# Create package from template
tz create

# Validate package structure
tz validate

# Render templates locally
tz run
tz run --force           # Overwrite existing
tz run --no-cache        # Skip cache
tz run --profile focus   # Specific profile
```

### Package Management

```bash
# Add dependency
tz add @owner/package
tz add --profile focus @owner/package

# Install dependencies
tz install

# Update dependencies
tz update

# Remove package
tz uninstall @owner/package

# Apply all packages
tz apply
tz apply --force --no-cache
```

### Publishing

```bash
# Validate before publish
tz validate

# Publish to registry
tz publish
```

---

## Working with PDF Context

Assistants are often provided PDFs for context (documentation, specifications, brand guidelines, etc.). Large PDFs can exceed token limits when read directly by AI tools.

### Converting PDFs to Text

Use `pdftotext` (part of poppler-utils) to convert PDFs before including in packages:

```bash
# Basic conversion
pdftotext document.pdf document.txt

# Preserve layout (useful for tables, columns)
pdftotext -layout document.pdf document.txt

# Extract specific pages
pdftotext -f 1 -l 10 document.pdf first-10-pages.txt

# Raw text extraction (no formatting)
pdftotext -raw document.pdf document.txt
```

### Installation

```bash
# macOS
brew install poppler

# Ubuntu/Debian
sudo apt-get install poppler-utils

# Windows (via chocolatey)
choco install poppler
```

### Usage

Use the converted text however is appropriate for your use case:

- Include in context files
- Reference in templates
- Provide as input to skills
- Use for AI analysis

**For very large documents**, consider having the AI summarize key points:

```handlebars
{{~ var summary = askAgent("""
Read the document and extract:
{
  "keyRequirements": "main requirements, comma-separated",
  "constraints": "key constraints and limitations",
  "terminology": "important terms and definitions"
}
""", { json: true }) ~}}
```

### Best Practices

1. **Convert early**: Convert PDFs to text before use
2. **Keep originals**: Store original PDFs for reference but use text for AI context
3. **Chunk large docs**: Split very large documents into logical sections
4. **Summarize when needed**: Use `askAgent` to extract key information from lengthy text

---

## Directory Conventions

### Standard Locations

| Location | Purpose |
|----------|---------|
| `agents.toml` | Package manifest |
| `README.md` | Package documentation |
| `templates/` | All template files |
| `templates/CLAUDE.md[.hbs]` | Claude context |
| `templates/AGENTS.md[.hbs]` | Codex context |
| `templates/GEMINI.md[.hbs]` | Gemini context |
| `templates/claude/skills/` | Claude skills |
| `templates/claude/agents/` | Claude agents |
| `templates/claude/commands/` | Claude commands |
| `templates/claude/mcp_servers.json[.hbs]` | Claude MCP config |
| `templates/codex/config.toml[.hbs]` | Codex config |
| `templates/gemini/commands/` | Gemini commands |
| `templates/gemini/settings.json[.hbs]` | Gemini MCP config |
| `prompts/` | External prompt files for askAgent |

### Output Locations

After `tz apply`, files are written to:

| Source | Output |
|--------|--------|
| Context templates | `agent_modules/@owner/package/` |
| Skills | Symlinked to `.claude/skills/` |
| Agents | Symlinked to `.claude/agents/` |
| Commands | Symlinked to `.claude/commands/` |
| MCP config | Merged into `.claude/settings.local.json` |
