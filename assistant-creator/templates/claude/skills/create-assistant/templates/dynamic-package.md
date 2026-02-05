# Dynamic Package Template

A Terrazul package with dynamic content using `askUser` and `askAgent`.

## Directory Structure

```
my-package/
├── agents.toml
├── README.md
└── templates/
    ├── CLAUDE.md.hbs
    └── AGENTS.md.hbs
```

## agents.toml

```toml
[package]
name = "@owner/my-package"
version = "1.0.0"
description = "Dynamic package that analyzes the codebase and gathers user context"
license = "MIT"
keywords = ["dynamic", "context", "analysis"]

[compatibility]
claude = ">=0.2.0"
codex = "*"

[exports.claude]
template = "templates/CLAUDE.md.hbs"

[exports.codex]
template = "templates/AGENTS.md.hbs"
```

## templates/CLAUDE.md.hbs

```handlebars
{{~ var projectDescription = askUser('Describe this project in 1-2 sentences.') ~}}
{{~ var primaryUser = askUser('Who is the primary user of this assistant?', {
  default: 'developers'
}) ~}}
{{~ var specialInstructions = askUser('Any special instructions or constraints?', {
  default: 'None',
  placeholder: 'Enter constraints or press Enter for none'
}) ~}}

{{~ var projectAnalysis = askAgent("""
Analyze this repository and return a flat JSON object where all values are strings:
{
  "name": "repository name",
  "type": "project type (web app, API, library, CLI, etc.)",
  "languages": "primary languages, comma-separated",
  "frameworks": "frameworks and libraries, comma-separated",
  "mainDirs": "key directories with brief purposes",
  "testCommand": "command to run tests, or 'none' if not found",
  "buildCommand": "command to build, or 'none' if not found"
}
Only include fields you can confidently determine from the codebase.
""", { json: true }) ~}}

# {{ vars.projectAnalysis.name }}

{{ vars.projectDescription }}

## Project Overview

- **Type**: {{ vars.projectAnalysis.type }}
- **Languages**: {{ vars.projectAnalysis.languages }}
- **Frameworks**: {{ vars.projectAnalysis.frameworks }}
- **Primary User**: {{ vars.primaryUser }}

## Project Structure

{{ vars.projectAnalysis.mainDirs }}

## Development Commands

- **Tests**: `{{ vars.projectAnalysis.testCommand }}`
- **Build**: `{{ vars.projectAnalysis.buildCommand }}`

{{#if (eq vars.specialInstructions "None")}}
## Guidelines

- Follow existing code patterns and conventions
- Read code before making changes
- Keep modifications minimal and focused
{{else}}
## Special Instructions

{{ vars.specialInstructions }}
{{/if}}
```

## templates/AGENTS.md.hbs

```handlebars
{{~ var projectAnalysis = askAgent("""
Analyze this repository and return a flat JSON object:
{
  "name": "repository name",
  "description": "one-line description",
  "type": "project type"
}
""", { json: true }) ~}}

# {{ vars.projectAnalysis.name }}

{{ vars.projectAnalysis.description }}

**Type**: {{ vars.projectAnalysis.type }}

## Codex Guidelines

- Use generic tool references (not Claude-specific names)
- Follow existing patterns in the codebase
- Keep changes minimal and focused
```

## README.md

```markdown
# @owner/my-package

Dynamic package that analyzes your codebase and gathers context.

## Installation

\`\`\`bash
tz add @owner/my-package
tz apply
\`\`\`

During installation, you'll be asked:
1. To describe your project
2. Who the primary user is
3. Any special instructions

The package will also analyze your codebase to understand:
- Project type and languages
- Directory structure
- Development commands

## Re-running Analysis

To regenerate with fresh analysis:

\`\`\`bash
tz apply --force --no-cache
\`\`\`

## License

MIT
```

## When to Use

Use this template when:
- Content should adapt to the specific codebase
- User input adds valuable context
- Supporting multiple platforms (Claude + Codex)
- Project-specific customization is valuable
