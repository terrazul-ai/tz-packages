# Skill Conversion Reference

Complete reference for converting Claude skills to Gemini format.

## Format Comparison

### Skill File Structure

Both Claude and Gemini use the same basic structure:

```markdown
---
[YAML frontmatter]
---

[Markdown instructions]
```

The main differences are in:
1. Frontmatter field names/values
2. Tool names
3. Path references

## Frontmatter Fields

### name

**Same in both platforms**:
```yaml
name: skill-name
```

- Lowercase with hyphens
- Max 64 characters
- Must match directory name

### description

**Same in both platforms**:
```yaml
description: Brief description of what this skill does
```

- Third person ("Provides", "Generates")
- Max 1024 characters
- Explains WHAT and WHEN

### version

**Same in both platforms**:
```yaml
version: "1.0.0"
```

Optional, semantic versioning recommended.

### allowed-tools

**Different tool names**:

Claude:
```yaml
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
```

Gemini:
```yaml
allowed-tools:
  - read_file
  - write_file
  - edit_file
  - search_files
  - list_files
  - run_shell_command
```

## Complete Tool Mapping

### File Operations

| Claude | Gemini | Description |
|--------|--------|-------------|
| Read | read_file | Read file contents |
| Write | write_file | Create/overwrite file |
| Edit | edit_file | Modify existing file |
| Glob | list_files | Find files by pattern |
| Grep | search_files | Search file contents |

### Execution

| Claude | Gemini | Description |
|--------|--------|-------------|
| Bash | run_shell_command | Execute shell commands |

### Web/Search

| Claude | Gemini | Description |
|--------|--------|-------------|
| WebSearch | web_search | Search the web |
| WebFetch | web_fetch | Fetch URL content |

### Interactive

| Claude | Gemini | Description |
|--------|--------|-------------|
| AskUserQuestion | prompt_user | Ask user for input |
| TodoWrite | (none) | Task management |

### IDE/LSP

| Claude | Gemini | Description |
|--------|--------|-------------|
| mcp__ide__getDiagnostics | get_diagnostics | Get code diagnostics |
| mcp__lsp-api__* | (varies) | LSP operations |

### Context/Research

| Claude | Gemini | Description |
|--------|--------|-------------|
| mcp__context7__* | (none) | Library docs |
| mcp__exa__* | (none) | Code search |

## Path References

### In Frontmatter

No path references in frontmatter, so no changes needed.

### In Instructions

**Claude paths**:
```markdown
Save to `.claude/skills/[name]/`
Check `.claude/settings.json`
```

**Gemini paths**:
```markdown
Save to `.gemini/skills/[name]/`
Check `.gemini/settings.json`
```

## Feature Compatibility Matrix

| Feature | Claude | Gemini | Notes |
|---------|--------|--------|-------|
| SKILL.md format | Yes | Yes | Same structure |
| reference.md | Yes | Yes | Compatible |
| examples.md | Yes | Yes | Update tool refs |
| templates/ | Yes | Yes | Compatible |
| allowed-tools | Yes | Yes | Different names |
| Agents (subagents) | Yes | No | Not portable |
| MCP servers | Yes | Yes | Different config |
| Commands | Yes | Yes | Different format |

## Conversion Checklist

### Pre-Conversion

- [ ] Read source SKILL.md completely
- [ ] Identify all tool references
- [ ] Check for agent delegation
- [ ] Note any MCP server dependencies
- [ ] List Claude-specific features used

### During Conversion

- [ ] Transform tool names in frontmatter
- [ ] Update tool references in instructions
- [ ] Change path references (.claude → .gemini)
- [ ] Remove agent delegation (or note as manual)
- [ ] Update platform-specific instructions

### Post-Conversion

- [ ] Validate YAML frontmatter
- [ ] Test skill in Gemini CLI
- [ ] Verify tool permissions work
- [ ] Check all file paths resolve
- [ ] Document any limitations

## Handling Non-Portable Features

### Agent Delegation

**Claude (has agents)**:
```markdown
## Complex Analysis

For complex analysis, delegate to the research-agent.
```

**Gemini (no agents)**:
```markdown
## Complex Analysis

For complex analysis, perform the following steps manually:
1. [Step 1]
2. [Step 2]
3. [Step 3]

Note: This skill originally delegated to a specialized agent. In Gemini, follow the steps above instead.
```

### MCP Servers

**Claude**:
```markdown
Use mcp__context7__query-docs for library documentation.
```

**Gemini** (if equivalent exists):
```markdown
Use the docs_search tool for library documentation.
```

**Gemini** (if no equivalent):
```markdown
For library documentation, use web_search or refer to official docs.

Note: Claude's Context7 integration is not available in Gemini.
```

### TodoWrite

**Claude**:
```markdown
Track progress using TodoWrite.
```

**Gemini**:
```markdown
Track progress by listing completed steps as you go.

Note: Gemini doesn't have built-in task tracking. Report progress inline.
```

## Directory Structure

### Claude Skill

```
.claude/skills/my-skill/
├── SKILL.md
├── reference.md
├── examples.md
└── templates/
    └── template.md
```

### Gemini Skill

```
.gemini/skills/my-skill/
├── SKILL.md
├── reference.md
├── examples.md
└── templates/
    └── template.md
```

### Package Structure (Both)

```
my-package/
└── templates/
    ├── claude/
    │   └── skills/
    │       └── my-skill/
    └── gemini/
        └── skills/
            └── my-skill/
```

## Sharing Skills Across Platforms

### Option 1: Duplicate with Adjustments

Create separate directories:
- `templates/claude/skills/my-skill/`
- `templates/gemini/skills/my-skill/`

Maintain both, keeping in sync.

### Option 2: Shared via agents.toml

If skill is tool-agnostic (no tool references):

```toml
[exports.claude]
skillsDir = "templates/claude/skills"

[exports.gemini]
skillsDir = "templates/claude/skills"  # Share same skills
```

Works when:
- No `allowed-tools` field
- No tool references in instructions
- No platform-specific paths

### Option 3: Symlinks

Create symlinks for compatible skills:

```bash
cd templates/gemini/skills
ln -s ../../claude/skills/platform-agnostic-skill .
```

## Validation

### Frontmatter Validation

Check YAML is valid:
```bash
head -20 SKILL.md | yq .
```

### Tool Name Validation

Verify tool names are Gemini-compatible:

```yaml
# Valid Gemini tools
allowed-tools:
  - read_file
  - write_file
  - edit_file
  - search_files
  - list_files
  - run_shell_command
  - web_search
  - web_fetch
```

### Test Invocation

After conversion, test with:
1. Simple request matching skill description
2. Request requiring tools
3. Edge case requests
