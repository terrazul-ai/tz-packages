# Skill Structure Reference

Complete reference for Claude Skill file format, anatomy, writing patterns, and validation rules.

## Skill Anatomy & Directory Structure

A skill is a directory containing at minimum a `SKILL.md` file:

```
my-skill/
+-- SKILL.md              # Required: metadata + instructions (<500 lines)
+-- reference.md           # Optional: detailed specs, API refs, rule catalogs
+-- examples.md            # Optional: usage examples with input/output pairs
+-- scripts/               # Optional: helper scripts, linters, automation
+--   build.sh
+--   validate.py
+-- references/            # Optional: source docs, specs, PDFs-as-text
+--   api-spec.txt
+--   design-doc.md
+-- assets/                # Optional: images, templates, static files
+--   logo.png
+--   template.html
```

### When to Add Supporting Files

| File/Dir | Add When |
|----------|----------|
| `reference.md` | Instructions exceed ~200 lines or detailed specs are needed |
| `examples.md` | Multiple complex examples that would clutter the main file |
| `scripts/` | Automation, validation, or helper utilities support the skill |
| `references/` | External docs, specs, or PDFs (converted to text) provide essential context |
| `assets/` | Templates, images, or static files are referenced by instructions |

### Progressive Disclosure

Layer information so the model gets what it needs without drowning in detail:

1. **Metadata** (frontmatter): name, description, version, allowed-tools. The description is the primary trigger mechanism.
2. **Body** (<500 lines): overview, core instructions, inline examples. Everything the model needs to act.
3. **Bundled resources**: reference.md for deep specs, examples.md for extended examples, scripts/ for automation, references/ for source material, assets/ for static files.

## YAML Frontmatter

### Required Fields

#### name (string)

- **Format**: Lowercase letters, numbers, hyphens only
- **Pattern**: `/^[a-z0-9-]+$/`
- **Length**: Maximum 64 characters
- **Purpose**: Unique identifier for skill discovery

**Valid**: `brand-guidelines`, `excel-report-generator`, `api-documentation`
**Invalid**: `Brand Guidelines` (spaces/caps), `brand_guidelines` (underscore)

#### description (string)

- **Length**: Maximum 1024 characters
- **Point of view**: Third person only
- **Content**: WHAT the skill does + WHEN to activate (pushy description)

**Pushy Description Formula:**
```
[Verb]s [specific thing] [context] including [key features]. Activates when [trigger conditions].
```

**Good verbs**: Applies, Processes, Generates, Provides, Enforces, Creates, Analyzes, Validates, Transforms, Orchestrates

**Examples of pushy descriptions:**

```yaml
# Capability Uplift - API docs
description: Generates comprehensive API documentation from OpenAPI 3.0 and Swagger 2.0 specifications including endpoint descriptions, request/response examples, authentication guides, and code samples. Activates when the user provides an API spec file, requests endpoint documentation, or needs integration guides.

# Capability Uplift - data processing
description: Processes Excel sales data files and generates formatted monthly reports with charts, KPIs, trend analysis, and actionable insights. Activates when the user provides spreadsheet data, asks for report generation, or needs automated data analysis.

# Encoded Preference - brand guidelines
description: Applies Acme Corp brand guidelines to all presentations and documents including logo usage, color palette, typography, and approved messaging. Activates when creating branded materials, reviewing documents for compliance, or answering questions about visual identity standards.

# Encoded Preference - code review
description: Enforces team code review standards for TypeScript projects including naming conventions, error handling patterns, test coverage requirements, and PR description format. Activates when reviewing pull requests, checking code quality, or answering questions about coding standards.
```

**Anti-patterns:**
- "Use this skill to apply brand guidelines" (second person, no trigger clause)
- "I help with documentation" (first person)
- "Helps with Excel files" (too vague, no specifics, no trigger clause)
- "Provides brand guidelines" (missing trigger clause - add "Activates when...")

### Optional Fields

#### version (string)

Track skill iterations with semantic versioning: `"1.0.0"`, `"2.1.3"`

#### allowed-tools (array)

Restrict which tools the model can use within this skill:

```yaml
# Read-only (guidelines, reference)
allowed-tools:
  - Read
  - Grep
  - Glob

# Research-capable
allowed-tools:
  - Read
  - Grep
  - Glob
  - mcp__context7__*
  - WebSearch

# Full write access (omit field entirely to inherit all tools)
```

Use `allowed-tools` when the skill should be read-only or needs specific tools only. Omit when the skill needs flexibility.

## Writing Patterns

### Imperative Form

Write instructions as direct commands, not suggestions:

- "Use 4-space indentation" not "You should use 4-space indentation"
- "Return JSON with snake_case keys" not "It would be good to return JSON with snake_case keys"
- "Validate input before processing" not "Consider validating input before processing"

### Explain "Why" Behind Rules

Bare rules get ignored or misapplied. Attach rationale:

- "Use 4-space indentation because our formatter enforces it and mixed indentation breaks CI"
- "Limit functions to 50 lines because longer functions correlate with higher defect density in our codebase"
- "Always include error codes in API responses because the mobile client uses them for localized error messages"

### Generalize from Instances

Extract patterns rather than listing every case:

**Instead of:**
```markdown
- For GET /users, validate the `limit` query param is between 1-100
- For GET /orders, validate the `limit` query param is between 1-100
- For GET /products, validate the `limit` query param is between 1-100
```

**Write:**
```markdown
For all paginated list endpoints, validate the `limit` query parameter:
- Accept values between 1-100
- Default to 20 when omitted
- Return 400 with error code `INVALID_LIMIT` for out-of-range values
```

### Show Patterns, Not Just Instances

A single example teaches one case. A pattern teaches a category:

**Instead of:**
```markdown
## Example
When the user asks "Review this PR", check the diff for...
```

**Write:**
```markdown
## Code Review Pattern
For any code review request:
1. Read the diff to understand scope of changes
2. Check against the standards in reference.md
3. Categorize findings as blocking, suggestion, or nitpick
4. Present findings grouped by category, blocking issues first
```

### Output Format Specification

When a skill produces structured output, specify the format explicitly:

```markdown
## Output Format

Return a Markdown report with:
- H1 title matching the input filename
- H2 "Summary" with 2-3 sentence overview
- H2 "Findings" with bulleted list, each prefixed with severity emoji
- H2 "Recommendations" with numbered action items
```

## Skill Body Structure

### Recommended Sections

1. **Overview** (required, 2-3 sentences): What the skill provides and its value
2. **When to Use** (recommended): Bulleted trigger conditions, 3-5 items
3. **Instructions/Guidelines** (required): Core content organized with headers
4. **Examples** (recommended): Concrete input/output pairs
5. **Reference Materials** (optional): Links to supporting files

### Organization by Skill Type

**Guidelines/Standards**: Category > Subcategory > Rules with rationale
**Process/Workflow**: Numbered steps > Sub-steps > Validation criteria
**Tool Integration**: Parse > Transform > Generate > Format
**Reference/Knowledge**: Principles > Patterns > Decision frameworks

## Cross-Platform Skill Notes

### Claude Code
- Tool names: `Read`, `Write`, `Edit`, `Grep`, `Glob`, `Bash`, `Agent`
- Skill location: `.claude/skills/[name]/`
- Package location: `templates/claude/skills/[name]/`
- Supports agent delegation and all tool types

### Codex
- Tool names differ from Claude (platform-specific)
- Skills shared from Claude via package configuration
- No subagent support
- Skills location shared from `templates/claude/skills/`

### Gemini
- Tool names: `read_file`, `write_file`, `edit_file`, `run_shell`
- Skill location: `.gemini/skills/[name]/`
- No agent delegation support
- Uses different path conventions (`.gemini/` vs `.claude/`)

### Cross-Platform Best Practices

- Write instructions generically when possible (avoid hardcoding tool names)
- Use the `convert-skill-to-gemini` skill to adapt Claude skills
- Test skills on each target platform after creation
- Note platform-specific limitations in the skill's reference.md

## Validation Checklist

### Structure
- [ ] Valid YAML frontmatter with triple dashes (`---`)
- [ ] Name is lowercase with hyphens, max 64 chars, matches `/^[a-z0-9-]+$/`
- [ ] Directory name matches the `name` field in frontmatter
- [ ] Body under ~500 lines; detailed content in supporting files

### Description Quality
- [ ] Third person point of view ("Provides", "Generates", "Applies")
- [ ] Under 1024 characters
- [ ] Explains WHAT the skill does with specifics
- [ ] Includes "Activates when..." trigger clause (pushy style)
- [ ] Specific enough to avoid false activation, broad enough to catch intended use cases

### Instruction Quality
- [ ] Uses imperative form ("Use X" not "You should use X")
- [ ] Explains "why" behind non-obvious rules
- [ ] Generalizes patterns rather than listing every instance
- [ ] Concrete examples with realistic data (no placeholders like "foo", "bar")
- [ ] Clear output format specification when the skill produces structured output

### Testing
- [ ] Tested with 2-3 representative scenarios
- [ ] Description triggers activation at the right time
- [ ] Instructions produce desired output quality
- [ ] Edge cases and error conditions handled

### File Locations

**Local projects:**
```
.claude/skills/
+-- my-skill/
    +-- SKILL.md
    +-- reference.md (optional)
    +-- examples.md (optional)
    +-- scripts/ (optional)
    +-- references/ (optional)
    +-- assets/ (optional)
```

**Agent packages:**
```
your-package/
+-- templates/
    +-- claude/
        +-- skills/
            +-- my-skill/
                +-- SKILL.md
                +-- reference.md (optional)
                +-- examples.md (optional)
```

## Skill Type Patterns

### Guidelines/Standards

**Purpose**: Encode team conventions, brand standards, compliance rules
**Tools**: Typically read-only (`Read`, `Grep`, `Glob`)
**Structure**: Categories > Subcategories > Rules with rationale and examples

### Process/Workflow

**Purpose**: Define step-by-step procedures for data processing, analysis, generation
**Tools**: Read/write access as needed
**Structure**: Numbered steps > Validation > Output format > Error handling

### Tool Integration

**Purpose**: Interface with external tools, APIs, specifications
**Tools**: Context-dependent
**Structure**: Parse input > Transform > Generate output > Format result

### Reference/Knowledge

**Purpose**: Provide domain knowledge, architecture patterns, decision frameworks
**Tools**: Read-only plus research tools
**Structure**: Principles > Patterns > Decision frameworks > Anti-patterns

## Common Pitfalls

### Vague Descriptions
- "Helps with documentation" tells the model nothing about when to activate
- Fix: "Generates API documentation from OpenAPI specs including endpoints, auth, and code samples. Activates when the user provides a spec file or asks for API docs."

### Missing Trigger Clause
- "Provides brand guidelines for presentations" has WHAT but not WHEN
- Fix: Add "Activates when creating branded materials, reviewing for compliance, or answering visual identity questions."

### Wall of Text
- Long paragraphs without structure make instructions hard to follow
- Fix: Use headers, lists, code blocks, and tables for organization

### Overfitting to One Example
- Instructions that only work for one specific case
- Fix: Extract the general pattern and reference it

### Placeholder Content
- "foo", "bar", "example.com", "[TODO]" in examples
- Fix: Use realistic, domain-appropriate data

## Further Resources

- `examples.md` - Complete skill examples with pattern analysis
- `templates/` - Pre-built templates for common skill types
