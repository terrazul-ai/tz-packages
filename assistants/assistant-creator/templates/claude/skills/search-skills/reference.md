# Skill Search and Installation Reference

Complete reference for searching skillregistry.io and installing skills.

## skillregistry.io Overview

skillregistry.io is a community-driven registry of Claude Code skills. It provides:
- Searchable skill catalog
- Skill documentation and examples
- Author information
- Installation instructions

## Search Methods

### WebSearch with Site Filter

The primary search method uses WebSearch with the `site:` operator:

```
site:skillregistry.io [query]
```

**Benefits**:
- Searches only skillregistry.io content
- Returns relevant skill pages
- Includes skill descriptions in results

### Direct Skill URLs

If you know the skill name:
```
https://skillregistry.io/skills/[skill-name]
```

Use WebFetch to retrieve skill details directly.

### Browsing by Category

Categories on skillregistry.io:
- `/skills?category=development`
- `/skills?category=testing`
- `/skills?category=documentation`
- `/skills?category=devops`
- `/skills?category=security`

## Search Query Patterns

### By Programming Language

```
site:skillregistry.io [language]
```

Examples:
- `site:skillregistry.io typescript`
- `site:skillregistry.io python`
- `site:skillregistry.io rust`
- `site:skillregistry.io go`

### By Framework

```
site:skillregistry.io [framework]
```

Examples:
- `site:skillregistry.io react`
- `site:skillregistry.io nextjs`
- `site:skillregistry.io django`
- `site:skillregistry.io fastapi`

### By Task Type

```
site:skillregistry.io "[task description]"
```

Examples:
- `site:skillregistry.io "code review"`
- `site:skillregistry.io "test generation"`
- `site:skillregistry.io "api documentation"`
- `site:skillregistry.io "security audit"`

### By Skill Type

```
site:skillregistry.io [skill type]
```

Examples:
- `site:skillregistry.io guidelines`
- `site:skillregistry.io workflow`
- `site:skillregistry.io template`
- `site:skillregistry.io checker`

## Skill Page Structure

A typical skill page on skillregistry.io contains:

### Metadata
- **Name**: Skill identifier (lowercase, hyphenated)
- **Description**: What the skill does
- **Author**: Creator/maintainer
- **Version**: Current version
- **License**: Usage license

### Documentation
- **Overview**: Detailed description
- **Installation**: How to install
- **Usage**: How to use the skill
- **Examples**: Sample invocations

### Files
- **SKILL.md**: Main skill file
- **reference.md**: Optional detailed docs
- **examples.md**: Optional usage examples
- **templates/**: Optional template files

## Installation Methods

### Method 1: Local Project Installation

Best for single-project use.

**Directory Structure**:
```
project/
└── .claude/
    └── skills/
        └── [skill-name]/
            ├── SKILL.md
            ├── reference.md (optional)
            └── examples.md (optional)
```

**Steps**:
1. Create directory: `mkdir -p .claude/skills/[skill-name]`
2. Download SKILL.md from skillregistry.io
3. Copy additional files if needed
4. Verify: `ls .claude/skills/[skill-name]`

**Using curl**:
```bash
mkdir -p .claude/skills/[skill-name]
curl -o .claude/skills/[skill-name]/SKILL.md [skill-url]
```

### Method 2: Package Installation

Best for reusable skills across projects.

**Directory Structure**:
```
your-package/
└── templates/
    └── claude/
        └── skills/
            └── [skill-name]/
                ├── SKILL.md
                ├── reference.md (optional)
                └── examples.md (optional)
```

**Steps**:
1. Create directory in package templates
2. Copy skill files from registry
3. Update package manifest if needed
4. Run `tz apply` to install

### Method 3: Manual Creation

If skill content is available but not as a downloadable file:

1. Create skill directory
2. Create SKILL.md with proper frontmatter:
   ```markdown
   ---
   name: [skill-name]
   description: [description from registry]
   ---

   [skill content]
   ```
3. Add additional files as needed

## Verifying Installation

### Check Directory Exists

```bash
ls -la .claude/skills/[skill-name]/
```

### Check SKILL.md Format

Verify the file has:
- Valid YAML frontmatter (triple dashes)
- `name` field matching directory name
- `description` field
- Clear instructions in body

### Test the Skill

Try invoking the skill with a simple request that matches its description.

## Skill File Requirements

### SKILL.md (Required)

```markdown
---
name: skill-name
description: Brief description (third person, max 1024 chars)
---

# Skill Title

[Instructions for Claude]
```

### reference.md (Optional)

Detailed documentation, specifications, and technical reference.

### examples.md (Optional)

Usage examples with input/output pairs.

### templates/ (Optional)

Template files used by the skill.

## Troubleshooting

### Skill Not Found

- Verify skill name spelling
- Try broader search terms
- Check if skill was renamed or removed

### Installation Failed

- Check directory permissions
- Verify file was downloaded correctly
- Check YAML frontmatter syntax

### Skill Not Appearing

- Restart Claude Code
- Run `tz apply --force` if using packages
- Check skill directory structure

### Skill Not Working

- Verify SKILL.md format
- Check that name matches directory
- Review skill documentation for requirements

## Best Practices

### Before Installing

1. Read full skill documentation
2. Check author reputation
3. Review required tools/permissions
4. Test in non-critical project first

### When Installing

1. Use exact skill name from registry
2. Include all required files
3. Preserve directory structure
4. Verify installation worked

### After Installing

1. Test with example invocation
2. Configure if needed
3. Document skill usage in project
4. Consider contributing improvements

## Security Considerations

### Review Skill Content

Before installing, check:
- What tools does it use?
- Does it write files?
- Does it execute commands?
- Does it access sensitive data?

### Trusted Sources

Prefer skills that:
- Have many downloads/stars
- Are from verified authors
- Have clear documentation
- Are actively maintained

### Sandboxing

For untrusted skills:
- Test in isolated environment
- Review all file writes
- Monitor command execution
- Check for data exfiltration
