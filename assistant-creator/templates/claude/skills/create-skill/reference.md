# Claude Skill Structure Reference

Complete reference for Claude Skill file format and components.

## File Format

Skill files are Markdown with YAML frontmatter followed by instructions.

```markdown
---
[YAML frontmatter]
---

[Markdown instructions for Claude]
```

## Directory Structure

A skill consists of a directory containing:

```
my-skill/
├── SKILL.md              # Required: Main skill file
├── reference.md          # Optional: Detailed documentation
├── examples.md           # Optional: Usage examples
├── templates/            # Optional: Template files
│   └── template.txt
└── scripts/              # Optional: Helper scripts
    └── helper.py
```

## YAML Frontmatter

### Required Fields

#### name (string, required)

- **Format**: Lowercase letters, numbers, hyphens only
- **Length**: Maximum 64 characters
- **Purpose**: Unique identifier for skill discovery
- **Pattern**: `/^[a-z0-9-]+$/`
- **Examples**:
  - `brand-guidelines`
  - `excel-report-generator`
  - `api-documentation`
  - `code-review-checklist`

**Validation**:
- ✅ `brand-guidelines`
- ✅ `data-processor-2024`
- ❌ `Brand Guidelines` (has spaces and capitals)
- ❌ `brand_guidelines` (has underscore)

#### description (string, required)

- **Format**: Brief description
- **Length**: Maximum 1024 characters
- **Purpose**: Tells Claude WHAT the skill does and WHEN to use it
- **Point of view**: MUST use third person (not "you" or "I")
- **Content**: Explain capability + activation triggers
- **Examples**:
  - ✅ "Applies Acme Corp brand guidelines to all presentations and documents including logo usage, color palette, typography, and approved messaging"
  - ✅ "Processes Excel files and generates formatted reports with charts, summaries, and automated insights from financial or sales data"
  - ✅ "Generates comprehensive API documentation from OpenAPI/Swagger specifications including endpoint descriptions, request/response examples, and authentication guides"
  - ❌ "Use this skill to apply brand guidelines" (wrong POV - second person)
  - ❌ "I help with documentation" (wrong POV - first person)
  - ❌ "Helps with Excel files" (too vague, no specifics)

**Description Formula**:
```
[Verb]s [specific thing] [context/scope] including [key features/aspects]
```

**Good verbs**: Applies, Processes, Generates, Provides, Enforces, Creates, Analyzes

### Optional Fields

#### version (string, optional)

- **Purpose**: Track skill iterations
- **Format**: Semantic versioning recommended
- **Example**: `"1.0.0"`, `"2.1.3"`
- **Use case**: Track breaking changes, feature additions

#### allowed-tools (array, optional)

- **Purpose**: Restrict which tools Claude can use within this skill
- **Format**: Array of tool names
- **Use case**: Limit skill to read-only operations or specific tools
- **Example**:
  ```yaml
  allowed-tools:
    - Read
    - Grep
    - Glob
  ```

**When to use**:
- Skill should be read-only (guidelines, reference)
- Skill needs specific tools only
- Security/safety constraints

**When NOT to use**:
- Skill needs flexibility in tool choice
- All standard tools are acceptable
- Omit field to inherit all tools

## Skill Instructions Structure

The markdown body provides instructions to Claude. Effective structure includes:

### 1. Skill Overview (Required)

```markdown
# [Skill Name]

[2-3 sentence description of what this skill provides and its purpose]
```

**Purpose**: Establishes what capability the skill adds

**Guidelines**:
- Keep concise (2-3 sentences)
- Focus on value proposition
- Complement the frontmatter description

**Example**:
```markdown
# Brand Guidelines Skill

This skill provides Acme Corp's official brand guidelines for creating consistent,
professional materials. It ensures all documents, presentations, and communications
follow our established visual identity and messaging standards.
```

### 2. When to Use Section (Recommended)

```markdown
## When to Use

Activate this skill when:
- [Trigger condition 1]
- [Trigger condition 2]
- [Trigger condition 3]
```

**Purpose**: Helps Claude decide when to activate the skill

**Guidelines**:
- Be specific about trigger scenarios
- Use bulleted list for clarity
- Include 3-5 common use cases
- Phrase as user requests or situations

**Example**:
```markdown
## When to Use

Activate this skill when:
- Creating presentations or documents for Acme Corp
- Reviewing materials for brand compliance
- Questions about logo usage, colors, or typography
- Needing approved messaging for marketing materials
- Ensuring consistent visual identity across projects
```

### 3. Instructions/Guidelines (Required)

```markdown
## [Section Title]

[Specific, actionable instructions]
```

**Purpose**: Core guidance for Claude to follow

**Guidelines**:
- Be specific and concrete
- Use hierarchical headers (##, ###)
- Include lists for step-by-step processes
- Add examples where helpful
- Avoid vague statements

**Organization patterns**:

**For Guidelines Skills**:
```markdown
## [Category 1]
### [Subcategory]
- [Rule 1]
- [Rule 2]

### [Subcategory]
- [Rule 1]
- [Rule 2]

## [Category 2]
[More guidelines]
```

**For Process Skills**:
```markdown
## Processing Workflow

### 1. [Step Name]
[What to do]

### 2. [Step Name]
[What to do]

### 3. [Step Name]
[What to do]
```

**For Tool Integration Skills**:
```markdown
## [Tool] Integration

### 1. Parse [Input]
[Instructions]

### 2. Generate [Output Component]
[Instructions]

### 3. Format [Result]
[Instructions]
```

### 4. Examples Section (Optional but recommended)

```markdown
## Examples

[Concrete usage scenarios]
```

**Purpose**: Show skill in action

**Guidelines**:
- Use real scenarios, not placeholders
- Show both correct and incorrect usage
- Include input/output examples
- Use visual separators (✅ ❌)

**Example**:
```markdown
## Examples

### Correct Logo Usage
✅ Full-color logo on white presentation slide with proper clear space
✅ Monochrome white logo on brand blue background (#0066CC)
✅ Minimum size respected: 100px width for digital assets

### Incorrect Logo Usage
❌ Logo stretched or distorted to fit space
❌ Logo rotated at angles
❌ Logo on busy photographic background without adequate contrast
❌ Logo colors changed to non-brand colors
```

### 5. Reference Materials Section (Optional)

```markdown
## Reference Materials

[Links to additional resources]
```

**Purpose**: Point to detailed documentation

**Example**:
```markdown
## Reference Materials

For complete details:
- `reference.md` - Full brand guidelines with technical specifications
- `examples.md` - Visual examples and use case studies
- `templates/` - Approved presentation and document templates
```

## Skill Type Patterns

### Guidelines/Standards Skill

**Characteristics**:
- Provides rules, standards, or guidelines
- Often includes do's and don'ts
- May reference templates or examples
- Typically read-only (no file modifications)

**Use cases**:
- Brand guidelines and visual identity
- Coding standards and style guides
- Compliance rules and regulations
- Company policies and procedures
- Documentation standards

**Typical structure**:
```markdown
---
name: company-standards
description: Applies [Company] standards for [aspect] including [specifics]
version: "1.0.0"
allowed-tools:
  - Read
  - Grep
  - Glob
---

# [Standards Name]

[Overview]

## When to Use
[Trigger conditions]

## [Category 1]
### [Subcategory]
[Rules and standards]

## [Category 2]
### [Subcategory]
[Rules and standards]

## Examples
### Correct Usage
✅ [Example]

### Incorrect Usage
❌ [Example]

## Reference Materials
[Links]
```

### Process/Workflow Skill

**Characteristics**:
- Defines step-by-step procedures
- May process files or data
- Often includes input/output specifications
- May need write access to files

**Use cases**:
- Data transformation and analysis
- File format conversion
- Report generation from data
- Automated analysis workflows
- Content processing pipelines

**Typical structure**:
```markdown
---
name: data-processor
description: Processes [input type] and generates [output type] with [features]
version: "1.0.0"
---

# [Process Name]

[Overview of what it processes and produces]

## When to Use
[Trigger conditions]

## Processing Workflow

### 1. Load and Validate
[Instructions]

### 2. Process Data
[Instructions]

### 3. Generate Output
[Instructions]

## Input Format
[Specifications]

## Output Format
[Specifications]

## Example
**Input**: [Sample]
**Output**: [Sample]

## Error Handling
[What to do when things go wrong]
```

### Tool Integration Skill

**Characteristics**:
- Interfaces with external tools or APIs
- Provides usage patterns and examples
- Often includes error handling guidance
- May include helper scripts or templates

**Use cases**:
- API documentation generation
- External service integration
- Code generation from specifications
- Tool automation and workflows
- Configuration management

**Typical structure**:
```markdown
---
name: tool-integration
description: Generates [output] from [input spec] including [features]
version: "1.0.0"
---

# [Tool] Integration

[Overview of integration]

## When to Use
[Trigger conditions]

## [Process Name]

### 1. Parse [Input]
[Instructions]

### 2. Generate [Component]
[Instructions]

### 3. Format [Output]
[Instructions]

## Input Specification
[Format details]

## Output Format
[Structure and examples]

## Example
**Input**: [Sample spec/file]
**Output**: [Generated result]

## Error Handling
[Common issues and solutions]

## Reference Materials
[Links to tool docs, specs]
```

### Reference/Knowledge Skill

**Characteristics**:
- Provides domain knowledge or context
- Often extensive reference materials
- May include glossaries or specifications
- Informational (typically read-only)

**Use cases**:
- Technical specifications and standards
- Company policies and procedures
- Domain expertise and best practices
- Architecture patterns and principles
- Historical context and decisions

**Typical structure**:
```markdown
---
name: domain-knowledge
description: Provides guidance on [domain] including [key aspects]
version: "1.0.0"
allowed-tools:
  - Read
  - Grep
  - Glob
  - mcp__context7__*
---

# [Domain] Knowledge

[Overview of domain and scope]

## When to Use
[Trigger conditions]

## Core Principles
[Fundamental concepts]

## [Topic 1]
### [Subtopic]
[Detailed information]

## [Topic 2]
### [Subtopic]
[Detailed information]

## Common Patterns
[Typical scenarios and solutions]

## Decision Framework
[How to choose between options]

## Reference Materials
[Additional resources]
```

## Best Practices

### Skill Design Principles

1. **Single Purpose**: One clear capability per skill
2. **Clear Triggers**: Make it obvious when to use the skill
3. **Third Person Description**: Always "Provides X", never "Use this to X"
4. **Progressive Disclosure**: SKILL.md for workflow, reference.md for details
5. **Concrete Examples**: Show real scenarios, not placeholders
6. **Focused Scope**: Don't try to do everything

### Instruction Writing Guidelines

1. **Be Specific**: Concrete steps over abstract principles
2. **Use Lists**: Break down complex information into bullets
3. **Include Examples**: Show correct and incorrect usage
4. **Keep Focused**: Core instructions in SKILL.md, details in reference.md
5. **Test Instructions**: Verify Claude can follow them successfully
6. **Avoid Jargon**: Use clear language, define technical terms

### File Organization Strategy

1. **Start Minimal**: Begin with SKILL.md only
2. **Add as Needed**:
   - reference.md when instructions exceed ~200 lines
   - examples.md when multiple complex examples are helpful
   - templates/ when users need starting point files
   - scripts/ when automation or utilities are required
3. **Keep Maintainable**: Don't duplicate content across files
4. **Clear Separation**: Workflow in SKILL.md, specs in reference.md

## Common Pitfalls

### ❌ Avoid These Mistakes

**Vague Descriptions**:
- ❌ "Helps with documentation"
- ❌ "Useful for brand stuff"
- ✅ "Generates API documentation from OpenAPI 3.0 specifications with examples"

**Wrong Point of View**:
- ❌ "Use this skill to process Excel files"
- ❌ "I help you with brand guidelines"
- ✅ "Processes Excel files and generates formatted reports"

**Too Generic**:
- ❌ Skill that does everything related to a topic
- ✅ Focused skill for specific capability

**Missing Triggers**:
- ❌ No clear indication when to activate
- ✅ Explicit "When to Use" section with scenarios

**No Examples**:
- ❌ Only theory and abstract principles
- ✅ Concrete examples showing usage

**Wall of Text**:
- ❌ Long paragraphs without structure
- ✅ Headers, lists, code blocks for organization

**Placeholder Content**:
- ❌ "foo", "bar", "example.com", "[TODO]"
- ✅ Real, meaningful examples

### ✅ Follow These Patterns

**Specific Descriptions**:
```yaml
description: Generates comprehensive API documentation from OpenAPI 3.0 specifications including endpoint descriptions, request/response examples, and authentication guides
```

**Third Person POV**:
```yaml
description: Provides guidance for microservices architecture including service decomposition, communication patterns, and data management strategies
```

**Focused Purpose**:
```yaml
name: excel-sales-reports
description: Processes Excel sales data and generates monthly reports with charts, KPIs, and trend analysis
```

**Clear Triggers**:
```markdown
## When to Use

Activate this skill when:
- User provides an Excel file with sales data
- Requesting monthly sales reports
- Needing sales trend analysis with visualizations
```

**Concrete Examples**:
```markdown
## Example

**Input**: `sales_january_2025.xlsx` with columns [Date, Product, Quantity, Revenue, Region]

**Output**:
# January 2025 Sales Report

## Summary
- Total Revenue: $150,000 (+12% vs Dec 2024)
- Top Product: Widget A ($60,000)
- Top Region: West ($55,000)
[... detailed report ...]
```

**Structured Content**:
```markdown
## Logo Usage

### Primary Logo
- Use on white backgrounds
- Minimum size: 100px width
- Clear space: Equal to "A" height

### Secondary Logo
- Use on colored backgrounds
- Monochrome only (black or white)
```

## Validation Checklist

Before considering a skill complete, verify:

- [ ] **Valid YAML frontmatter** (triple dashes, proper syntax)
- [ ] **Name format** (lowercase with hyphens, max 64 chars)
- [ ] **Description quality** (clear, concise, max 1024 chars)
- [ ] **Third person POV** (uses "Provides", "Generates", "Applies", etc.)
- [ ] **WHAT and WHEN** (description explains both capability and triggers)
- [ ] **Clear instructions** (specific and actionable, not vague)
- [ ] **Concrete examples** (real scenarios, not placeholders)
- [ ] **Proper organization** (headers, lists, code blocks)
- [ ] **File location** (saved in correct directory structure)
- [ ] **Tested** (verified with example invocations)
- [ ] **Reference materials** (organized if skill is complex)

## Directory Naming and Location

### For Local Projects

```
.claude/skills/
└── my-skill/
    ├── SKILL.md
    ├── reference.md (optional)
    └── examples.md (optional)
```

### For Agent Packages

```
your-package/
└── templates/
    └── claude/
        └── skills/
            └── my-skill/
                ├── SKILL.md
                ├── reference.md (optional)
                └── examples.md (optional)
```

**Directory name**: Must match the `name` field in frontmatter

## Tool Restrictions (allowed-tools)

### Read-Only Skills

For guidelines, reference, and knowledge skills:

```yaml
allowed-tools:
  - Read
  - Grep
  - Glob
```

### Research Skills

For skills that need web or documentation research:

```yaml
allowed-tools:
  - Read
  - Grep
  - Glob
  - mcp__context7__*
  - mcp__exa__*
  - WebSearch
```

### Processing Skills

For skills that modify files:

```yaml
# Omit allowed-tools to inherit all tools
# Or specify exactly what's needed:
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
```

### When to Restrict Tools

**Use `allowed-tools` when**:
- Skill should be read-only for safety
- Skill only needs specific tools
- Following principle of least privilege
- Documenting intended tool usage

**Omit `allowed-tools` when**:
- Skill needs flexibility
- All standard tools are acceptable
- Restriction would limit usefulness

## Further Resources

- `examples.md` - See complete skill examples with detailed analysis
- `templates/` - Pre-built templates for common skill types
- Claude Code documentation - Official skill authoring best practices
