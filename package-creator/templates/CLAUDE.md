# Package Creator

This project is a Terrazul package which helps in the creation of Terrazul packages. Currently only Claude packages are supported.

## Directory Structure

A Terrazul package consits of a directory with the following structure:

```
my-package/
├── agents.toml              # REQUIRED: Package manifest
├── README.md                # RECOMMENDED: Package documentation
├── .gitignore               # Optional: Standard ignores
├── prompts/                 # Optional: External prompt files for askAgent
│   ├── analyze.txt
│   └── generate.txt
└── templates/               # Templates directory
    ├── CLAUDE.md.hbs        # Context file for Claude
    ├── AGENTS.md.hbs        # Context file for Codex
    ├── cursor.rules.mdc.hbs # Context file for Cursor
    ├── COPILOT.md.hbs       # Context file for GitHub Copilot
    ├── claude/              # Claude-specific operational files
    │   ├── settings.json.hbs
    │   ├── settings.local.json.hbs
    │   ├── user.settings.json.hbs
    │   ├── mcp_servers.json.hbs
    │   └── agents/          # Agent definitions
    │       ├── reviewer.md.hbs
    │       ├── planner.md.hbs
    │       └── utils/
    │           └── helper.md.hbs
    └── codex/               # Codex-specific configuration
        ├── config.toml.hbs
        └── agents.toml.hbs  # Codex MCP servers
```

### Required vs Optional

| Component | Status | Purpose |
|-----------|--------|---------|
| `agents.toml` | **REQUIRED** | Package manifest (name/version required for publishing) |
| `README.md` | **RECOMMENDED** | Package documentation |
| `templates/` | **RECOMMENDED** | Contains all template files |
| Context templates (`.md.hbs`) | **OPTIONAL** | Main documentation files for AI tools |
| Operational templates | **OPTIONAL** | Settings, MCP config, agents |
| `prompts/` | **OPTIONAL** | External prompt files for `askAgent` |
| `.gitignore` | **OPTIONAL** | Standard gitignore |

---

## `agents.toml` Manifest Reference

The `agents.toml` manifest is the core configuration file for Terrazul CLI packages, similar to `package.json` in npm. It uses TOML format and defines package metadata, dependencies, tool compatibility, task specifications, template exports, and installation profiles.

All sections are **optional** except `[package].name` and `[package].version` when publishing to the registry.

---

## Complete Schema

### `[package]` - Package Metadata

Defines core package information. Optional during development, but `name` and `version` are **required for publishing**.

```toml
[package]
name = "@owner/package-name"           # Required for publish. Format: @scope/name
version = "1.0.0"                      # Required for publish. Semantic version
description = "Short description"      # Optional. Brief package description
homepage = "https://example.com"       # Optional. Package homepage URL
repository = "https://github.com/..."  # Optional. Source repository URL
documentation = "https://docs...."     # Optional. Documentation URL
license = "MIT"                        # Optional. SPDX license identifier
keywords = ["ai", "agent", "config"]   # Optional. Array of strings for discoverability
authors = ["Name <email@example.com>"] # Optional. Array of author strings
is_private = false                     # Optional. If true, prevents publishing. Default: false
```

**Validation Rules:**
- `name` must match pattern: `/^@[\d_a-z-]+\/[\d_a-z-]+$/` (lowercase, alphanumeric, hyphens, underscores)
- `version` must be valid semver
- All URLs should be valid HTTP(S) URLs
- `keywords` and `authors` must be string arrays

**Usage:**
- `tz publish` - Uploads package metadata to registry
- `tz validate` - Checks package structure
- `tz init` / `tz create` - Scaffolds new packages

---

### `[compatibility]` - Tool Compatibility

Declares which AI tools the package supports and their version requirements.

```toml
[compatibility]
claude = ">=0.2.0"     # Requires Claude Code v0.2.0 or higher
codex = "*"            # Compatible with any Codex version
cursor = "^1.0.0"      # Requires Cursor v1.x.x
copilot = "~2.5.0"     # Requires GitHub Copilot v2.5.x
```

**Valid Tool Names:**
- `claude` - Claude Code
- `codex` - Codex
- `cursor` - Cursor
- `copilot` - GitHub Copilot

**Validation Rules:**
- Keys must be one of the valid tool names (others trigger warnings, not errors)
- Values must be valid semver ranges or `*` (wildcard)
- Used for informational purposes (not enforced by CLI)

**Usage:**
- `tz create` wizard - Scaffolds tool-specific configs
- Package info/search results (future feature)
- Integrations - Filters compatible packages

---

### `[tasks]` - Task Specifications

Maps task identifiers to relative file paths containing task definitions (YAML/JSON format).

```toml
[tasks]
"ctx.generate" = "tasks/ctx-generate.yaml"
"build" = "tasks/build.json"
"analyze" = "tasks/analyze.yaml"
```

**Validation Rules:**
- Values **must be relative paths** (no absolute paths or `..` traversal)
- Referenced files **must exist** and resolve within package root
- Symlinks must resolve within package root
- Missing files trigger validation errors

**Security:**
- Path traversal protection: all paths normalized and validated
- Symlink target validation: must resolve within package root
- No execution of task content (declarative only)

**Usage:**
- `tz validate` - Validates task file paths exist

---

### `[exports]` - Template Exports

Defines tool-specific templates that should be rendered when the package is applied.

```toml
[exports.claude]
template = "templates/CLAUDE.md.hbs"

[exports.codex]
template = "templates/AGENTS.md.hbs"

[exports.cursor]
template = "templates/cursor.rules.mdc.hbs"

[exports.copilot]
template = "templates/COPILOT.md.hbs"
```

**Type Definition:**
```typescript
exports?: Partial<Record<string, ExportEntry>>;

interface ExportEntry {
  template?: string;  // Relative path to Handlebars template
  [key: string]: unknown; // Forward-compatible: unknown keys preserved
}
```

**Valid Tool Keys:**
- `claude`, `codex`, `cursor`, `copilot`
- Unknown tool keys trigger warnings (ignored, not errors)

**Validation Rules:**
- `template` paths must be relative (no absolute or `..`)
- Referenced templates must exist within package root
- Symlinks must resolve within package root
- Unknown properties (e.g., `extra = true`) trigger warnings (not errors)

**Template Context:**

Templates are Handlebars (`.hbs`) files with the following context:

```typescript
{
  project: { name, root },  // Project metadata
  pkg: { name, version, ... }, // Package metadata from agents.toml
  env: Record<string, string>, // Environment variables
  now: Date,                   // Current timestamp
  files: { ... }               // File helpers
}
```

**Template Features:**
- **Handlebars syntax** - Standard Handlebars expressions and helpers
- **`askUser` snippets** - Interactive prompts during rendering
- **`askAgent` snippets** - AI-powered content generation (uses Claude)

**Rendering Behavior:**
- Output written to `agent_modules/<scope>/<package>/`
- `tz run` / `tz apply` renders templates
- Skip rendering if output files exist (use `--force` to override)
- CLAUDE.md/AGENTS.md files @-mentioned in project context files
- Operational files (agents/, commands/, hooks/, skills/) symlinked to `.claude/`

**Usage:**
- `tz run` - Renders templates for specified packages
- `tz apply` - Renders templates for all installed packages
- `tz validate` - Validates template paths exist

---

### `[profiles]` - Installation Profiles

Defines mutually exclusive groups of packages for selective rendering.

```toml
[profiles]
focus = ["@acme/alpha", "@acme/bravo"]
full = ["@acme/alpha", "@acme/bravo", "@acme/charlie"]
minimal = ["@acme/alpha"]
```

**Type Definition:**
```typescript
profiles?: Record<string, string[]>; // Key: profile name, Value: package names
```

**Validation Rules:**
- Profile names must be strings (alphanumeric, hyphens, underscores recommended)
- Package names must be valid (`@owner/package-name`)
- Duplicates within a profile are automatically deduplicated
- Profiles are sorted alphabetically for deterministic output

**Usage:**

**Install with profile:**
```bash
tz add --profile focus @acme/alpha
# Adds package to manifest AND appends to [profiles.focus] array
```

**Run with profile:**
```bash
tz run --profile focus
# Only renders packages listed in focus profile
```

**Uninstall:**
```bash
tz uninstall @acme/alpha
# Removes package from ALL profiles it appears in
```

**Behavior:**
- Profiles are **mutually exclusive** at runtime (only one active per `tz run`)
- All packages in a profile must be installed in `agent_modules/`
- Missing packages in a profile trigger errors during `tz run --profile`

**Example Workflow:**
```bash
# Create profile with focused packages
tz add --profile focus @acme/alpha
tz add --profile focus @acme/bravo

# agents.toml now contains:
# [profiles]
# focus = ["@acme/alpha", "@acme/bravo"]

# Run only focus profile packages
tz run --profile focus

# Uninstall removes from profile
tz uninstall @acme/alpha
# [profiles]
# focus = ["@acme/bravo"]
```

---

## Complete Example

```toml
[package]
name = "@mattheu/research-agent"
version = "1.2.3"
description = "AI agent for code research and analysis"
homepage = "https://github.com/mattheu/research-agent"
repository = "https://github.com/mattheu/research-agent.git"
documentation = "https://docs.example.com/research-agent"
license = "MIT"
keywords = ["research", "code-analysis", "ai-agent"]
authors = ["Matthew <matt@example.com>"]
is_private = false

[dependencies]
"@terrazul/base" = "^2.0.0"
"@acme/utils" = "~1.5.0"

[compatibility]
claude = ">=0.2.0"
codex = "*"

[tasks]
"ctx.generate" = "tasks/ctx-generate.yaml"
"analyze" = "tasks/analyze.json"

[exports.claude]
template = "templates/CLAUDE.md.hbs"

[exports.codex]
template = "templates/AGENTS.md.hbs"

[profiles]
focus = ["@mattheu/research-agent"]
full = ["@mattheu/research-agent", "@terrazul/base"]
```

---

## Command Usage Matrix

| Command | `[package]` | `[dependencies]` | `[compatibility]` | `[tasks]` | `[exports]` | `[profiles]` |
|---------|-------------|------------------|-------------------|-----------|-------------|--------------|
| `tz init` | ✅ Creates | ✅ Creates empty | ✅ Creates if tools detected | ❌ | ❌ | ❌ |
| `tz add` | ✅ Reads name/version | ✅ Adds entry | ❌ | ❌ | ❌ | ✅ With `--profile` |
| `tz install` | ❌ | ✅ Resolves & installs | ❌ | ❌ | ❌ | ❌ |
| `tz update` | ❌ | ✅ Updates versions | ❌ | ❌ | ❌ | ❌ |
| `tz uninstall` | ❌ | ✅ Removes entry | ❌ | ❌ | ❌ | ✅ Removes from all |
| `tz run` | ❌ | ❌ | ❌ | ❌ | ✅ Renders templates | ✅ With `--profile` |
| `tz apply` | ❌ | ❌ | ❌ | ❌ | ✅ Renders templates | ✅ With `--profile` |
| `tz publish` | ✅ **Required** (name, version) | ❌ | ❌ | ❌ | ❌ | ❌ |
| `tz validate` | ✅ Validates | ✅ Validates ranges | ✅ Warns on unknown | ✅ Validates paths | ✅ Validates paths | ❌ |
| `tz create` | ✅ Scaffolds | ✅ Creates empty | ✅ With wizard | ❌ | ✅ Optional | ❌ |
| `tz extract` | ✅ Generates | ✅ Optional | ✅ Detects | ❌ | ❌ | ❌ |

---

## Validation Rules Summary

### ✅ Structural Validation (via Zod schema)
- `[package]` fields have correct types (strings, arrays, boolean)
- `[dependencies]`, `[compatibility]`, `[tasks]`, `[exports]` are key-value records
- `[profiles]` values are string arrays

### ⚠️ Content Validation (via `validateManifest`)
- **Package name format**: Must match `/^@[\d_a-z-]+\/[\d_a-z-]+$/`
- **Semver validity**: `version` and dependency ranges must be valid semver
- **File existence**: `[tasks]` and `[exports]` paths must reference existing files
- **Path safety**: No absolute paths, no `..` traversal, symlinks resolve within root
- **Tool keys**: Unknown tools in `[exports]` trigger warnings (not errors)
- **Export properties**: Unknown properties in `[exports.*]` trigger warnings

### ❌ Publishing Requirements
- `[package].name` and `[package].version` are **required**
- `is_private = true` blocks publishing
- All referenced files must exist and be readable

---

## Best Practices

1. **Always specify `name` and `version`** if you plan to publish
2. **Use semantic versioning** for all versions and ranges
3. **Keep `keywords` relevant** for discoverability
4. **Document dependencies** with version ranges that allow updates (e.g., `^2.0.0` vs `2.0.0`)
5. **Test templates** before publishing with `tz run --force` (forces re-rendering)
6. **Use profiles** for different development contexts (e.g., `focus`, `full`, `minimal`)
7. **Validate before publishing** with `tz validate` to catch issues early
8. **Keep task paths relative** for portability across environments
9. **Add `is_private = true`** for internal packages not meant for public registry
10. **Use meaningful profile names** that describe their purpose (e.g., `focus`, `debug`, `production`)

---

## Related Files

- **`agents-lock.toml`** - Lockfile with resolved versions and integrity hashes (generated by CLI)
- **`agent_modules/`** - Installed package storage directory (like `node_modules`)
- **`.terrazul/`** - Local CLI state, cache, and metadata
- **`.claude/`** - Integration directory for Claude Code (symlinks and MCP config)

---

## Summary

The `agents.toml` manifest is the heart of Terrazul CLI's package system. It supports:

- **6 top-level sections**: `[package]`, `[dependencies]`, `[compatibility]`, `[tasks]`, `[exports]`, `[profiles]`
- **10 package metadata fields**: name, version, description, homepage, repository, documentation, license, keywords, authors, is_private
- **4 supported tools**: claude, codex, cursor, copilot
- **Type-safe validation**: Zod schemas enforce structure, `validateManifest` enforces semantics
- **Deterministic output**: Sorted keys, deduplicated arrays, alphabetical ordering
- **Security-first**: Path validation, symlink safety, no executable code

All sections are **optional** except `[package].name` and `[package].version` when publishing. The CLI gracefully handles missing sections with sensible defaults.



# Dynamic Package Templates with `askUser` and `askAgent`

Terrazul packages can generate **dynamic, context-aware content** using two powerful Handlebars helpers embedded in template files (`.hbs`):

## Overview

Both `askUser` and `askAgent` are **snippet functions** that execute during template rendering (when you run `tz apply` or `tz run`). They allow packages to:

- Gather user input interactively
- Analyze the codebase using AI
- Generate customized documentation based on the project
- Create truly adaptive configurations

---

## `askUser` - Interactive User Input

Prompts the user for information during template rendering.

### Syntax

```handlebars
{{~ var myVar = askUser('Your question here') ~}}
{{~ askUser('Another question', { default: 'value', placeholder: 'hint' }) ~}}
```

### Options

- `default` (string) - Default value if user presses Enter
- `placeholder` (string) - Placeholder text shown when input is empty

### Examples

```handlebars
{{~ var projectPitch = askUser('Summarize this project for Claude (1-2 sentences).') ~}}
{{~ var mainPersona = askUser('Who is Claude primarily assisting? (e.g., maintainers, support engineers)') ~}}
{{~ var guardrails = askUser('List any constraints or guardrails.', {
  default: 'None',
  placeholder: 'Enter constraints or press Enter for none'
}) ~}}

# Project Overview

{{ vars.projectPitch }}

**Primary User:** {{ vars.mainPersona }}
```

---

## `askAgent` - AI-Powered Code Analysis

Invokes an AI tool (Claude, Codex, Cursor, Copilot) to analyze the codebase and generate content.

### Syntax

```handlebars
{{~ var analysis = askAgent('Analyze the codebase structure') ~}}
{{~ var result = askAgent('prompts/research.txt') ~}}
{{~ var data = askAgent("""
Multi-line prompt
with more context
""") ~}}
```

### String Formats

1. **Single quotes** (`'text'`) - Single-line prompts or file paths
2. **Backticks** (`` `text` ``) - Multi-line text prompts
3. **Triple quotes** (`"""text"""`) - Multi-line with automatic dedenting

### Prompt Types

**Text prompts**: Inline instructions
```handlebars
{{~ var summary = askAgent('Summarize the repository structure') ~}}
```

**File prompts**: Reference external prompt files
```handlebars
{{~ var analysis = askAgent('./prompts/analyze-architecture.txt') ~}}
```

File paths are resolved relative to the package directory.

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

### Schema Validation

Define TypeScript interfaces for type-safe JSON responses:

```handlebars
{{~ var config = askAgent('Generate config', {
  json: true,
  schema: { file: './types/config.ts', exportName: 'ConfigSchema' }
}) ~}}
```

The schema file should export a TypeScript type or interface that will be used to validate the JSON response.

### System Prompt Control

**Default behavior** (when no `systemPrompt` specified):
```
You are a context extraction agent. Your job is to understand, synthesize
and extract context from existing projects. Your responses should only
include what is asked, and should not include any dialog such as
"I'm now ready to..", "Looking at", etc.
```

**Custom system prompt**:
```handlebars
{{~ var guide = askAgent('Write user guide', {
  systemPrompt: 'You are a helpful technical writer.'
}) ~}}
```

**Disable system prompt** (use Claude's default):
```handlebars
{{~ var creative = askAgent('Generate ideas', {
  systemPrompt: ''
}) ~}}
```

### Examples

**Simple analysis**:
```handlebars
{{~ var repoName = askAgent('What is the name of the repository?') ~}}
```

**Multi-line research prompt**:
```handlebars
{{~ var kickoffBrief = askAgent("""
You are to write a summary of this repo structure and services.

Include:
- Main directories and their purposes
- Key technologies used
- Service architecture

Return the summary in markdown format.
""") ~}}
```

**JSON with schema validation**:
```handlebars
{{~ var repoFiles = askAgent("""
Produce a concise bullet list where each bullet has the format:
`- path: short description`

Summarize the purpose of key files and directories.
Only describe items you are confident about.
""", { json: true }) ~}}
```

**Using previous snippet results**:
```handlebars
{{~ var first = askAgent('Provide initial value') ~}}
{{~ var refined = askAgent('Use {{ vars.first }} to craft final output') ~}}
```

---

## Variables and References

### Variable Assignment

Store snippet results for reuse:

```handlebars
{{~ var projectName = askUser('Project name?') ~}}
{{~ var description = askAgent('Describe {{ vars.projectName }}') ~}}

# {{ vars.projectName }}

{{ vars.description }}
```

### Accessing Snippet Values

- `vars.<name>` - Access variable values
- `snippets.<id>` - Access snippet results by auto-generated ID

The whitespace control syntax (`~`) is optional but recommended to prevent extra blank lines in output.

---

## Snippet Caching System

To avoid re-prompting users or re-running expensive AI queries, Terrazul implements **persistent snippet caching**.

### How It Works

1. **Content-based IDs**: Each snippet gets a stable ID based on its prompt and options (not variable name)
2. **Cache file**: Responses stored in `agents-cache.toml` at project root
3. **Automatic reuse**: Identical prompts across renders use cached responses
4. **Version tracking**: Cache includes package version for invalidation

### Cache Structure

```toml
version = 1

[packages."@user/package"]
version = "1.0.0"

[[packages."@user/package".snippets]]
id = "snippet_a1b2c3d4"
type = "askUser"
promptExcerpt = "Summarize this project for Claude (1-2 sentences)."
value = "\"A CLI tool for AI agent management\""
timestamp = "2025-01-21T10:30:00.000Z"

[[packages."@user/package".snippets]]
id = "snippet_e5f6g7h8"
type = "askAgent"
promptExcerpt = "Analyze repository structure..."
value = "\"# Repository Structure\\n\\n- src/: Core implementation...\""
timestamp = "2025-01-21T10:30:15.000Z"
tool = "claude"
```

### Cache Behavior

- **Hit**: Snippet with same prompt/options found → reuse value, skip execution
- **Miss**: No match → execute snippet and cache result
- **File change detection**: For file-based prompts, content hash included in ID
- **Manual override**: Use `--no-cache` flag to force re-execution
- **Package version**: Cache is per-package-version; upgrading invalidates cache

### Cache Management

```bash
# Re-render with fresh AI responses (bypasses cache)
tz apply --no-cache

# Re-render forcing overwrite of existing files
tz apply --force

# Both flags together for complete refresh
tz apply --force --no-cache
```

Cache is automatically pruned when packages are uninstalled.

---

## Real-World Example

Here's how `@mattheu/ctx-default` uses both helpers to generate a dynamic `CLAUDE.md`:

```handlebars
{{~ var projectPitch = askUser('Summarize this project for Claude (1-2 sentences).') ~}}
{{~ var mainPersona = askUser('Who is Claude primarily assisting?') ~}}
{{~ var coreWorkflows = askUser('Describe the most important workflows.') ~}}
{{~ var guardrails = askUser('List any constraints or guardrails.') ~}}

{{~ var repoFiles = askAgent("""
You are an expert technical writer documenting a software repository.
Produce a concise bullet list where each bullet has the format `- path: short description`.
Summarize the purpose of key files and directories that exist in this repository.
Only describe items you are confident about from the available context.
If you lack context about the repo contents, output `- Unable to determine repository structure.`
""", { json: true }) ~}}

{{~ var kickoffBrief = askAgent("""
You are to write a two-sentence summary.

Project pitch:
{{ vars.projectPitch }}

Audience:
{{ vars.mainPersona }}

Workflows:
{{ vars.coreWorkflows }}

Combine these into a concise introduction.
""") ~}}

# Project Context

{{ vars.kickoffBrief }}

## Repository Structure

{{ vars.repoFiles }}

## Workflows

{{ vars.coreWorkflows }}

## Guardrails

{{ vars.guardrails }}
```

---

## Best Practices

### Design Guidelines

1. **Use triple-quotes for multi-line prompts** - Automatic dedenting keeps templates clean
2. **Reference file prompts for complex queries** - Easier to maintain and test
3. **Enable JSON mode for structured data** - Better for parsing and validation
4. **Store important results in variables** - Chain snippets by referencing previous results
5. **Leverage the cache** - Design prompts to be stable across renders
6. **Use systemPrompt for specialized behavior** - Customize AI personality per snippet
7. **Provide defaults for askUser** - Better UX when users want to skip optional questions
8. **Use askAgent with care** - Each call to askAgent is expensive and may take a while to complete. Make sure that calls to it are warranted and provide value to the configuration.
9. **Use flat JSON schemas** - Always request flat `{ "string": "string" }` structures (see below)

### Prefer Single Comprehensive askAgent Calls with Flat JSON

**IMPORTANT**: When gathering multiple pieces of information, use **one** `askAgent` call with JSON output and a comprehensive prompt rather than multiple sequential calls. Always use a **flat JSON structure** where every value is a string.

**Why this matters**:
- **Performance**: One API call instead of multiple sequential requests (renders 3-5x faster)
- **Cost**: Fewer Claude API invocations (lower API usage)
- **Quality**: The model sees all requirements together, producing more coherent and contextually consistent output
- **Maintainability**: One prompt to update instead of several scattered calls
- **Debugging**: Single point of failure to troubleshoot
- **Caching**: Simpler cache invalidation with fewer cache keys
- **Reliability**: Flat JSON is more reliably parsed by AI models

✅ **Recommended - Single comprehensive call with flat JSON:**

```handlebars
{{~ var projectAnalysis = askAgent("""
Analyze this repository and return a flat JSON object where every value is a string.
Use comma-separated values for lists.

{
  "name": "repository name",
  "description": "brief description",
  "languages": "TypeScript, Python",
  "frameworks": "Next.js, FastAPI",
  "buildTools": "vite, esbuild",
  "mainDirectories": "src, tests, docs",
  "entryPoints": "src/index.ts, src/main.py",
  "keyPatterns": "architectural patterns observed"
}

Only include information you can confidently determine from the codebase.
Omit any fields where you lack sufficient evidence.
""", { json: true }) ~}}

## Tech Stack
Languages: {{ vars.projectAnalysis.languages }}
Frameworks: {{ vars.projectAnalysis.frameworks }}

## Structure
{{ vars.projectAnalysis.keyPatterns }}
```

❌ **Avoid - Multiple sequential calls:**

```handlebars
{{~ var repoName = askAgent('What is the repository name?') ~}}
{{~ var description = askAgent('Provide a brief description.') ~}}
{{~ var languages = askAgent('List the primary languages.', { json: true }) ~}}
{{~ var frameworks = askAgent('List the key frameworks.', { json: true }) ~}}
{{~ var structure = askAgent('Describe the project structure.') ~}}
```

❌ **Avoid - Nested JSON structures:**

```json
{
  "techStack": {
    "languages": ["TypeScript", "Python"]
  }
}
```

**Exception**: Only use multiple `askAgent` calls when later calls genuinely depend on the results of earlier ones. This is rare—most information gathering can be structured as a single comprehensive flat JSON response.

**Flat Schema Tips**:
- Use comma-separated strings instead of arrays (e.g., `"TypeScript, Python"`)
- Use flat keys instead of nested objects (e.g., `devServerUrl` instead of `devServer.url`)
- Provide clear instructions that all values must be strings
- Include an example showing the expected flat JSON structure

### Performance Considerations

- **askAgent calls are expensive** - Each invokes the AI tool, which can take seconds or minutes
- **Cache dramatically improves speed** - Second render skips all cached snippets
- **File-based prompts auto-invalidate** - Cache refreshes when prompt file changes
- **Parallel execution not supported** - Snippets run sequentially to support variable chaining

### User Experience

- **Show clear, concise questions** - Users should understand what information you need
- **Use placeholders for optional fields** - Make it clear when users can skip
- **Provide context in prompts** - Help the AI understand what you're asking for
- **Test with --dry-run** - Preview output before writing files

## Advanced Use Cases

### Prefer single askAgent call 


```handlebars
{{~ var structure = askAgent('List all TypeScript files in src/') ~}}
{{~ var complexity = askAgent('Analyze complexity of: {{ vars.structure }}') ~}}
{{~ var recommendations = askAgent('Suggest refactoring for: {{ vars.complexity }}') ~}}

# Code Analysis

## Structure
{{ vars.structure }}

## Complexity Report
{{ vars.complexity }}

## Recommendations
{{ vars.recommendations }}
```

### Conditional Logic with Snippet Results

```handlebars
{{~ var hasTests = askAgent('Does this project have tests?', { json: true }) ~}}

{{#if vars.hasTests}}
## Testing
Run tests with: `npm test`
{{else}}
## Testing
No tests found. Consider adding test coverage.
{{/if}}
```

### Tool-Specific Prompts

```handlebars
{{~ var claudeAnalysis = askAgent('Provide detailed analysis', { tool: 'claude' }) ~}}
{{~ var quickSummary = askAgent('One-line summary', { tool: 'codex' }) ~}}
```

### External Prompt Files

Create a `prompts/` directory in your package:

```
my-package/
├── agents.toml
├── templates/
│   └── CLAUDE.md.hbs
└── prompts/
		├── analyze-architecture.txt
		└── generate-examples.txt
```

Reference them in templates:

```handlebars
{{~ var architecture = askAgent('./prompts/analyze-architecture.txt') ~}}
{{~ var examples = askAgent('./prompts/generate-examples.txt') ~}}
```

---

## Troubleshooting

### Cache Not Working

- Verify `agents-cache.toml` exists in project root
- Check cache format is valid TOML
- Use `--no-cache` to force regeneration
- Ensure package version hasn't changed

### Snippets Not Executing

- Check template syntax is valid Handlebars
- Verify quotes are balanced
- Look for error messages in CLI output
- Try `--verbose` flag for detailed logs

### Slow Performance

- Review number of askAgent calls (each is expensive). Try to keep this to a minimum.
- Use cache effectively (design stable prompts)
- Consider file-based prompts for complex queries
- Profile with `--verbose` to see execution times

### AI Tool Not Responding

- Verify tool is configured in `~/.terrazul/config.json`
- Check tool command is in PATH
- Test tool manually: `claude --version`
- Review timeout settings in snippet options
