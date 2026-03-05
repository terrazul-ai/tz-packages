# Skill Examples

Real-world skill examples showing different patterns and use cases. Each example demonstrates pushy descriptions, imperative writing style, and concrete instructions.

## Example 1: Brand Guidelines Skill (Encoded Preference)

```markdown
---
name: acme-brand-guidelines
description: Applies Acme Corp brand guidelines to all presentations and documents including logo usage, color palette, typography, and approved messaging. Activates when creating branded materials, reviewing documents for compliance, or answering questions about visual identity standards.
version: "1.0.0"
allowed-tools:
  - Read
  - Grep
  - Glob
---

# Acme Corp Brand Guidelines

Provides Acme Corp's official brand guidelines for creating consistent,
professional materials across all communications.

## When to Use

Activate this skill when:
- Creating presentations or documents for Acme Corp
- Reviewing materials for brand compliance
- Questions about logo usage, colors, or typography
- Needing approved messaging for marketing materials
- Ensuring consistent visual identity across projects

## Logo Usage

### Primary Logo
- Use full-color logo on white or light backgrounds
- Minimum size: 100px width (digital), 1 inch (print)
- Clear space: Maintain distance equal to height of "A" in Acme
- Download approved assets from brand portal

### Secondary Logo
- Use monochrome logo on colored backgrounds
- Available in white and black versions only
- Never rotate, distort, stretch, or add visual effects
- Maintain same clear space requirements as primary

### Logo Don'ts
- Changing logo colors
- Rotating or skewing
- Placing on busy backgrounds without adequate contrast
- Using outdated logo versions
- Adding drop shadows or effects

## Color Palette

### Primary Colors
- **Acme Blue**: #0066CC (Pantone 300C)
  - Use for primary CTAs, headers, key elements
  - 70% of colored elements should use Acme Blue
- **White**: #FFFFFF
  - Primary background color
  - Use for contrast and breathing room

### Secondary Colors
- **Charcoal**: #333333 (body text, headers)
- **Light Gray**: #F5F5F5 (background sections, dividers)
- **Medium Gray**: #999999 (secondary text, captions)

### Accent Colors
- **Success**: #28A745 (positive actions, confirmations)
- **Warning**: #FFC107 (cautions, important notices)
- **Error**: #DC3545 (errors, critical alerts)

### Color Usage Rules
- Maintain 4.5:1 contrast ratio minimum for accessibility
- Use accent colors sparingly (max 10% of design)
- Never use colors outside approved palette
- Test colorblind accessibility

## Typography

### Headings
- **Font**: Montserrat Bold
- **Sizes**:
  - H1: 32pt (presentations), 24pt (documents)
  - H2: 24pt (presentations), 18pt (documents)
  - H3: 18pt (presentations), 14pt (documents)
- **Color**: Acme Blue (#0066CC) or Charcoal (#333333)
- **Line height**: 1.2x

### Body Text
- **Font**: Open Sans Regular
- **Size**: 14pt (presentations), 11pt (documents)
- **Color**: Charcoal (#333333)
- **Line height**: 1.5x
- **Paragraph spacing**: 1.5x line height

## Messaging and Voice

### Voice Characteristics
- **Professional yet approachable** - Expert but not stuffy
- **Action-oriented** - Focus on outcomes and results
- **Customer-centric** - Benefits over features
- **Clear and concise** - Avoid jargon and complexity

### Messaging Don'ts
- Using competitor names
- Making unsubstantiated claims
- Negative messaging or fear-based appeals
- Technical jargon without explanation

## Examples

### Correct Usage
- Full-color Acme logo on white slide with Montserrat Bold heading in Acme Blue
- Body text in Open Sans Regular, Charcoal color, 1.5x line height
- CTA button in Acme Blue (#0066CC) with white text

### Incorrect Usage
- Logo stretched to fit space (distorted proportions)
- Using Arial instead of Open Sans for body text
- Random colors not from brand palette (#FF5500)

## Reference Materials

For complete specifications and templates:
- `reference.md` - Detailed brand standards with measurements
- `examples.md` - Visual examples of correct brand application
- `templates/` - Approved PowerPoint, Google Slides, and Word templates
```

**Why this works**:
- Pushy description with "Activates when..." clause that lists three trigger conditions
- Imperative writing style throughout ("Use full-color logo" not "You should use the full-color logo")
- Specific measurements and values (not vague guidance)
- Do's and don'ts with concrete examples
- Read-only tool restrictions appropriate for a guidelines skill

---

## Example 2: Excel Report Generator (Capability Uplift)

```markdown
---
name: excel-sales-reports
description: Processes Excel sales data files and generates formatted monthly reports with charts, KPIs, trend analysis, and actionable insights. Activates when the user provides spreadsheet data, requests report generation, or needs automated data analysis from tabular files.
version: "2.1.0"
---

# Excel Sales Report Generator

Processes Excel spreadsheets containing sales data and generates
professional formatted reports with visualizations, key metrics, and insights.

## When to Use

Activate when the user:
- Provides an Excel file with sales, financial, or inventory data
- Requests formatted reports with analysis and charts
- Needs data visualization or trend identification
- Asks for period-over-period comparisons
- Wants automated insights from data

## Processing Workflow

### 1. Load and Validate Data

**Load Excel file**:
- Accept `.xlsx` or `.xls` formats
- Read first worksheet by default (or specified sheet)
- Parse headers from first row

**Validate structure**:
- Check required columns exist
- Verify data types (dates, numbers, text)
- Identify data quality issues:
  - Missing values
  - Duplicate rows
  - Invalid dates
  - Negative values where inappropriate
- Report validation errors clearly with row numbers

### 2. Analyze Data

**Automatic calculations**:
- Total revenue/sales/units
- Average values per category
- Min/max values and ranges
- Growth rates (month-over-month, year-over-year)
- Percentage distributions

**Trend identification**:
- Upward/downward trends over time
- Seasonal patterns
- Anomalies and outliers
- Peak and trough periods

### 3. Generate Report

**Report structure**:
1. **Executive Summary**: Key findings in 2-3 sentences
2. **Key Metrics**: Top-level KPIs in visual cards
3. **Trend Analysis**: Charts showing patterns over time
4. **Category Breakdown**: Performance by segments
5. **Detailed Tables**: Supporting data with totals
6. **Insights**: Notable findings and explanations
7. **Recommendations**: Actionable next steps

## Data Format Expectations

### Sales Data
**Required columns**: Date, Product, Quantity, Revenue
**Optional columns**: Region, Salesperson, Category, Cost

## Output Format

Generate report in Markdown with:
- Clear hierarchical headers (# ## ###)
- Text descriptions of charts
- Formatted tables with alignment
- Bulleted insights
- Numbered recommendations

## Example

**Input**: `sales_q4_2024.xlsx`

Columns: [Date, Product, Quantity, Revenue, Region]

**Output**:

# Q4 2024 Sales Report

## Executive Summary
Total revenue of $2.45M represents 18% growth over Q3 2024. Widget A
continues to lead with 42% of revenue while Widget C shows exceptional
35% quarter-over-quarter growth.

## Key Metrics
- **Total Revenue**: $2,450,000 (+18% vs Q3 2024)
- **Total Units Sold**: 125,000 (+12% vs Q3 2024)
- **Top Product**: Widget A ($1,029,000, 42% of revenue)
- **Top Region**: West ($892,500, 36% of revenue)

## Error Handling

**If validation fails**:
- List specific problems with row/column references
- Suggest corrections or data cleanup steps
- Offer to proceed with partial analysis if possible
- Never guess or fabricate missing data

## Reference Materials

- `reference.md` - Complete data format specifications and chart guidelines
- `examples.md` - Sample reports for different data types and industries
```

**Why this works**:
- Pushy description ends with "Activates when..." listing three trigger conditions
- Imperative instructions ("Accept `.xlsx` or `.xls` formats" not "You should accept...")
- Step-by-step workflow with clear progression
- Complete input/output example with realistic data
- Error handling with specific guidance

---

## Example 3: OpenAPI Documentation Generator (Capability Uplift)

```markdown
---
name: openapi-documentation
description: Generates comprehensive API documentation from OpenAPI 3.0 and Swagger 2.0 specifications including endpoint descriptions, request/response examples, authentication guides, and code samples. Activates when the user provides an API spec file, requests endpoint documentation, or needs API integration guides.
version: "1.0.0"
---

# OpenAPI Documentation Generator

Generates developer-friendly API documentation from OpenAPI 3.0 and
Swagger 2.0 specification files.

## When to Use

Activate when the user:
- Provides an OpenAPI/Swagger spec file (`.yaml` or `.json`)
- Requests API documentation generation
- Needs endpoint reference documentation
- Wants authentication or integration guides
- Asks for code examples or SDKs

## Documentation Generation Process

### 1. Parse Specification

**Load and validate**:
- Support OpenAPI 3.0.x and Swagger 2.0 formats
- Validate against official JSON schema
- Parse YAML or JSON format
- Extract metadata (title, version, description, servers, contact)

**Report validation errors** with specific schema violations, suggested fixes,
and links to OpenAPI specification docs.

### 2. Generate API Overview

Include in overview:
- API title and version number
- Base URL(s) for different environments
- High-level description of API purpose
- Contact information and support links

### 3. Document Authentication

For each security scheme, document:
- Type (apiKey, http basic/bearer, oauth2, openIdConnect)
- Location (header, query parameter, cookie)
- Parameter name
- Example usage with curl

### 4. Document Endpoints

For each endpoint, include:
- HTTP method and path
- Summary and description
- Path, query, and header parameters with types and constraints
- Request body schema with required/optional fields
- Response schemas for each status code
- curl example with realistic data

### 5. Document Schemas

For each schema, include:
- Name and description
- All properties with types, descriptions, and constraints
- Required fields clearly marked
- Enum values listed

## Output Format

Generate Markdown documentation with this structure:

```
# [API Name] v[Version]
## Base URL
## Authentication
## Endpoints
### [HTTP METHOD] /[path]
## Schemas
### [Schema Name]
## Error Responses
```

## Error Handling

**If spec parsing fails**:
- Report specific validation errors with line numbers
- Identify schema violations clearly
- Suggest common fixes (missing fields, invalid refs, incorrect version format)
- Offer to generate docs for valid portions only

## Reference Materials

- `reference.md` - Complete OpenAPI/Swagger format guide and schema reference
- `examples.md` - Sample generated docs for various API types
```

**Why this works**:
- Pushy description with "Activates when..." clause covering three scenarios
- Imperative instructions throughout ("Support OpenAPI 3.0.x", "Include in overview")
- Generalizes the pattern (endpoint documentation structure) rather than listing every endpoint type
- Clear output format specification with template structure
- Error handling with actionable fixes

---

## Example 4: Microservices Architecture Patterns (Encoded Preference)

```markdown
---
name: microservices-architecture
description: Provides guidance on microservices architecture patterns including service decomposition strategies, communication approaches, data management techniques, and deployment best practices for distributed systems. Activates when discussing system architecture, evaluating microservices vs monolith tradeoffs, or designing inter-service communication.
version: "1.0.0"
allowed-tools:
  - Read
  - Grep
  - Glob
  - mcp__context7__*
  - mcp__exa__*
---

# Microservices Architecture Patterns

Provides expert guidance on microservices architecture design,
implementation patterns, and best practices for building distributed systems.

## When to Use

Activate when discussing:
- System architecture design decisions
- Microservices vs monolith tradeoffs
- Service decomposition strategies
- Inter-service communication patterns
- Data management in distributed systems
- Deployment and scaling approaches

## Core Principles

### 1. Single Responsibility per Service
Each service owns one business capability with clear boundaries. Align services
with business functions, not technical layers, because organizational alignment
reduces coordination overhead.

### 2. Decentralized Data Management
Database per service, no shared databases. Each service owns its data schema
and exposes it only through its API. Accept eventual consistency because it
enables independent scaling and failure isolation.

### 3. Smart Endpoints, Dumb Pipes
Keep business logic in services, use simple communication protocols (HTTP/REST,
gRPC, messaging). Avoid complex middleware because ESBs and orchestration layers
become bottlenecks and single points of failure.

## Service Decomposition

### By Business Capability
Align services with business functions:
- Customer Management, Product Catalog, Order Management, Payment, Shipping

### By Subdomain (DDD)
Use bounded contexts from Domain-Driven Design:
- Core domains (competitive advantage), Supporting domains (necessary but not differentiating)

### Guidelines
- Services can be deployed independently
- Clear ownership and team responsibility
- Minimal coupling between services
- Avoid nano-services (too fine-grained) and distributed monoliths (must deploy together)

## Communication Patterns

### Synchronous (REST/gRPC)
Use for immediate response needs. Implement circuit breakers, timeouts, and
retry with exponential backoff to prevent cascading failures.

### Asynchronous (Event-Driven)
Use for event notifications, long-running operations, and loose coupling.
Make message handlers idempotent, use dead letter queues, and monitor queue depths.

## Decision Framework

### Use Microservices When
- Multiple teams need independent delivery
- Different parts have different scaling needs
- Technology diversity is valuable
- Continuous deployment is a priority

### Keep the Monolith When
- Team is small (< 10 people)
- System is simple
- Operational maturity is low
- Speed and flexibility matter more than scalability

## Reference Materials

- `reference.md` - Complete pattern catalog with implementation details
- `examples.md` - Real-world case studies and migration stories
```

**Why this works**:
- Pushy description with "Activates when..." listing three architectural discussion triggers
- Explains "why" behind principles (e.g., why database-per-service enables independent scaling)
- Imperative form throughout ("Align services with business functions", "Implement circuit breakers")
- Decision framework helps the model choose the right recommendation
- Read-only with research tools (appropriate for knowledge/reference)

---

## Pattern Analysis

### Common Elements Across All Skills

1. **Pushy descriptions** - Every description ends with "Activates when..." listing 2-3 trigger scenarios
2. **Third-person descriptions** - "Applies", "Processes", "Generates", "Provides"
3. **Imperative instructions** - Direct commands ("Use", "Include", "Validate") not suggestions ("You should", "Consider")
4. **"Why" behind rules** - Non-obvious rules include rationale so the model applies them correctly
5. **Concrete examples** - Realistic data and scenarios, no placeholder text
6. **Generalized patterns** - Instructions describe categories of behavior, not just individual cases
7. **Error/edge case handling** - Specific guidance for when things go wrong
8. **Reference materials** - Links to deeper documentation in supporting files

### Skill Type Comparison

| Type | Category | Focus | Tools | Example |
|------|----------|-------|-------|---------|
| **Guidelines** | Encoded Preference | Standards enforcement | Read-only | Brand guidelines |
| **Process** | Capability Uplift | Workflow execution | Read/write | Data processing |
| **Tool Integration** | Capability Uplift | External tool usage | Context-dependent | API docs |
| **Reference** | Encoded Preference | Knowledge provision | Read + research | Architecture |

### Pushy Description Formula Analysis

**Pattern:**
```
[Verb]s [specific thing] [context] including [key features]. Activates when [trigger conditions].
```

**Real examples deconstructed:**

| Component | Brand Guidelines | Excel Reports | API Docs | Architecture |
|-----------|-----------------|---------------|----------|--------------|
| Verb | Applies | Processes | Generates | Provides |
| Specific thing | brand guidelines | Excel sales data | API documentation | guidance on architecture patterns |
| Context | to all presentations and documents | files | from OpenAPI 3.0 specs | for distributed systems |
| Key features | logo, color, typography, messaging | charts, KPIs, trend analysis | endpoints, examples, auth, code | decomposition, communication, data |
| Trigger clause | creating, reviewing, answering | provides data, requests reports, needs analysis | provides spec, requests docs, needs guides | discussing architecture, evaluating tradeoffs, designing communication |

### Writing Style Checklist

- [ ] Description includes "Activates when..." clause
- [ ] Instructions use imperative form
- [ ] Non-obvious rules include "because..." rationale
- [ ] Patterns generalized from specific instances
- [ ] Examples use realistic data, not placeholders
- [ ] Output format specified when structured output is expected

---

## Quick Reference: Choose Your Pattern

**Need to encode team conventions?**
-> Use Brand Guidelines pattern (rules + rationale + do's/don'ts)

**Need data processing capability?**
-> Use Excel Reports pattern (workflow + validation + output format)

**Need tool integration capability?**
-> Use OpenAPI Docs pattern (parse + generate + error handling)

**Need architecture/knowledge reference?**
-> Use Microservices pattern (principles + patterns + decisions)

**Need something unique?**
-> Follow structure principles from reference.md
