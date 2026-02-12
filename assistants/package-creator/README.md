# @terrazul/package-creator

A Terrazul package that helps create well-structured agents, skills, and packages for Claude Code and other AI tools.

## Running

```bash
tz run @terrazul/package-creator
```

## Features

This package provides skills and templates for creating Terrazul packages:

- **create-agent** - Scaffold new Claude agents with proper YAML frontmatter
- **create-skill** - Create Claude skills with clear instructions and examples
- **help** - Quick reference for package structure and workflows

## Available Skills

### create-agent

Creates well-formed Claude agent definitions with:
- YAML frontmatter (name, description, model, color, tools)
- System prompt defining role and expertise
- Core responsibilities and success criteria

**Templates included:**
| Template | Use Case |
|----------|----------|
| `basic-agent.md` | Generic agent structure |
| `code-agent.md` | Implementation with write access |
| `research-agent.md` | Read-only with research tools |
| `review-agent.md` | Code review and quality |

**Example usage:**
```
Create a code review agent for TypeScript projects
```

### create-skill

Creates well-formed Claude skill definitions with:
- YAML frontmatter (name, description)
- Clear trigger conditions
- Step-by-step instructions

**Templates included:**
| Template | Use Case |
|----------|----------|
| `basic-skill.md` | Generic skill structure |
| `guidelines-skill.md` | Standards and brand guidelines |
| `process-skill.md` | Multi-step workflows |
| `tool-integration-skill.md` | External tool/API integration |

**Example usage:**
```
Create a skill for our API documentation standards
```

## Package Structure

When creating a new Terrazul package, this package will use the standard structure:

```
my-package/
├── agents.toml              # REQUIRED: Package manifest
├── README.md                # RECOMMENDED: Documentation
└── templates/
    ├── CLAUDE.md.hbs        # Context file for Claude
    └── claude/
        ├── agents/          # Agent definitions
        ├── commands/        # Slash commands
        └── skills/          # Reusable skills
```

## Quick Start

### Create a new package

Creating a new package is as simple as 

```bash
$ mkdir my-package && cd my-package
$ tz run @terrazul/package-creator
```

The agent will ask all the necessary questions to create a valid Terrazul package

### Add agents to your package

Ask Claude to create an agent:
```
Use the create-agent skill to create a debugging agent for Go services
```

### Add skills to your package

Ask Claude to create a skill:
```
Use the create-skill skill to create a deployment workflow
```

## agents.toml Reference

Minimal manifest for a new package:

```toml
[package]
name = "@yourname/my-package"
version = "1.0.0"
description = "Your package description"
license = "MIT"

[exports.claude]
template = "templates/CLAUDE.md.hbs"
skillsDir = "templates/claude/skills"
subagentsDir = "templates/claude/agents"
commandsDir = "templates/claude/commands"
```

## Best Practices

**Agents:**
- Keep agents focused on a single responsibility
- Match model to task complexity (haiku for simple, opus for complex)
- Only include tools the agent actually needs
- Use clear color assignments for identification

**Skills:**
- Write descriptions in third person ("Provides X", not "Use this to X")
- Include concrete examples, not placeholder text
- Use progressive disclosure: SKILL.md for workflow, reference.md for details

## License

MIT
