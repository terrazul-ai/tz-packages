---
name: create-skill
description: Create well-formed Claude Skills with proper YAML frontmatter and clear instructions. Use when user wants to create a new skill, add capabilities to Claude, or needs help structuring a skill definition.
---

# Create Skill Skill

This skill guides you through creating a well-structured Claude Skill with proper frontmatter and effective instructions.

## When to Use This Skill

Activate this skill when the user wants to:
- Create a new Claude Skill
- Add a specific capability to Claude
- Structure a skill definition file
- Understand skill components (frontmatter, instructions, reference files)

## Skill Creation Workflow

### 1. Understand Skill Purpose

Ask the user (or infer from context):
- What capability should this skill provide?
- When should Claude activate this skill?
- Does it need reference materials or examples?
- Will it process files or provide guidelines?

### 2. Determine Skill Type

**Skill Types**:
- **Guidelines/Standards** - Brand guidelines, coding standards, compliance rules
- **Process/Workflow** - Data processing, file conversion, analysis workflows
- **Tool Integration** - API usage, external tool interaction, documentation generation
- **Reference/Knowledge** - Domain knowledge, company policies, technical specifications

**Structure Needs**:
- **Simple**: Just SKILL.md with instructions
- **Medium**: SKILL.md + reference.md for detailed docs
- **Complex**: SKILL.md + reference.md + examples.md + templates/
- **Advanced**: All above + scripts/ for helper utilities

### 3. Generate Skill File

Create a directory with at minimum a SKILL.md file:

```markdown
---
name: skill-name
description: Brief description of what this skill does and when to use it
---

# Skill Title

[2-3 sentence overview of what this skill provides]

## When to Use

[Clear trigger conditions for when Claude should use this skill]

## Instructions

[Step-by-step instructions for Claude to follow]

## Examples

[Optional: Show example usage scenarios]
```

### 4. Write Effective Description

**Requirements**:
- Use third person point of view
- Explain WHAT the skill does
- Explain WHEN to use it
- Maximum 1024 characters
- Be specific, not vague

**Good examples**:
- ✅ "Applies Acme Corp brand guidelines to all presentations and documents including logo usage, color palette, typography, and approved messaging"
- ✅ "Processes Excel files and generates formatted reports with charts, summaries, and automated insights"

**Bad examples**:
- ❌ "Use this skill to apply brand guidelines" (wrong POV)
- ❌ "I help with documentation" (wrong POV)
- ❌ "Helps with Excel files" (too vague)

### 5. Structure Instructions

**Core sections**:

1. **Overview** - What this skill provides (2-3 sentences)
2. **When to Use** - Clear activation triggers
3. **Instructions** - Specific, actionable steps
4. **Examples** - Concrete usage scenarios
5. **Reference Materials** - Links to detailed docs (if applicable)

**Instruction writing tips**:
- Be specific and concrete
- Use lists and headers for clarity
- Include examples where helpful
- Avoid vague statements
- Show correct and incorrect usage

### 6. Validation Checklist

Before saving, verify:
- [ ] YAML frontmatter is valid (triple dashes `---`)
- [ ] Name is lowercase with hyphens (max 64 chars)
- [ ] Description is clear and actionable (< 1024 chars)
- [ ] Description uses third person ("Provides", "Generates", "Applies")
- [ ] Description explains WHAT and WHEN
- [ ] Instructions are clear and specific
- [ ] Examples are concrete (not vague or placeholder)
- [ ] File saved in correct location

## Skill File Naming

Save skill directories as:
- `.claude/skills/[name]/` (for local project)
- Or in your agent package's `templates/claude/skills/` directory

Directory name should match the `name` field in frontmatter.

## Quick Start Templates

For common skill types, consider using these templates as starting points:
- `templates/basic-skill.md` - Generic structure
- `templates/guidelines-skill.md` - Standards/brand guidelines pattern
- `templates/process-skill.md` - Data processing workflow pattern
- `templates/tool-integration-skill.md` - External tool/API integration pattern

Access templates with: "Use the guidelines skill template"

## Reference Materials

For detailed information, consult:
- `reference.md` - Complete skill structure documentation
- `examples.md` - Real-world skill examples with pattern analysis

## Tips for Effective Skills

1. **Clear Triggers**: Description should make it obvious when to use the skill
2. **Third Person**: Always write "Provides X" not "Use this to X"
3. **Specific Instructions**: Give Claude concrete steps, not vague guidance
4. **Progressive Disclosure**: Use reference.md for details, SKILL.md for workflow
5. **Examples Matter**: Show real scenarios, not placeholder text
6. **Test with Scenarios**: Try skill with realistic requests after creation

## Skill vs Agent Differences

| Aspect | Skills | Agents |
|--------|--------|--------|
| **Purpose** | Add capabilities to Claude | Define Claude personas |
| **Frontmatter** | Simple (name, description, version) | Complex (model, color, tools, examples) |
| **Content** | Instructions for Claude to follow | System prompts defining behavior |
| **POV** | Third person ("Provides X") | Can be first/second person |
| **Activation** | Model-invoked based on description | Explicit invocation or auto-delegation |
| **Examples** | Usage scenarios in instructions | Invocation phrases in frontmatter |

**When to use Skills**:
- Adding domain knowledge or guidelines
- Providing process instructions
- Integrating with external tools
- Reference materials and standards

**When to use Agents**:
- Defining specialized personas (code reviewer, architect)
- Creating focused sub-agents with dedicated context
- Needing specific tool access restrictions
- Role-based task delegation

## Common Patterns

### Brand Guidelines Skill
- **Type**: Guidelines/Standards
- **Structure**: SKILL.md + reference.md + examples.md
- **Content**: Logo rules, color palette, typography, messaging

### Data Processing Skill
- **Type**: Process/Workflow
- **Structure**: SKILL.md + reference.md + examples.md
- **Content**: Input validation, processing steps, output format

### API Documentation Skill
- **Type**: Tool Integration
- **Structure**: SKILL.md + reference.md + examples.md + templates/
- **Content**: Spec parsing, doc generation, output format

### Architecture Patterns Skill
- **Type**: Reference/Knowledge
- **Structure**: SKILL.md + reference.md
- **Content**: Pattern catalog, decision frameworks, best practices

## Example Invocations

Here are examples of how users might request different skills:

- "Create a skill for our brand guidelines"
- "I need a skill that processes CSV files"
- "Make a skill for API documentation generation"
- "Build a skill for code review checklists"
- "Create a skill with company policies"

For each request, determine the appropriate type and structure based on the patterns above.
