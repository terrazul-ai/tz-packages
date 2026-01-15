# Claude Skill Examples

Real-world skill examples showing different patterns and use cases.

## Example 1: Brand Guidelines Skill (Standards/Rules Pattern)

```markdown
---
name: acme-brand-guidelines
description: Applies Acme Corp brand guidelines to all presentations and documents including logo usage, color palette, typography, and approved messaging
version: "1.0.0"
allowed-tools:
  - Read
  - Grep
  - Glob
---

# Acme Corp Brand Guidelines

This skill provides Acme Corp's official brand guidelines for creating consistent,
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
❌ Changing logo colors
❌ Rotating or skewing
❌ Placing on busy backgrounds without adequate contrast
❌ Using outdated logo versions
❌ Adding drop shadows or effects

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

### Lists and Bullets
- Use standard bullet points (•)
- Indent: 0.25 inches
- Spacing: 0.5 line height between items

## Messaging and Voice

### Official Tagline
"Innovation that moves you forward"

### Voice Characteristics
- **Professional yet approachable** - Expert but not stuffy
- **Action-oriented** - Focus on outcomes and results
- **Customer-centric** - Benefits over features
- **Clear and concise** - Avoid jargon and complexity

### Tone Guidelines
- **Confident**: We know our expertise
- **Helpful**: We're here to solve problems
- **Optimistic**: Focus on possibilities
- **Authentic**: Genuine, not corporate-speak

### Messaging Don'ts
❌ Using competitor names
❌ Making unsubstantiated claims
❌ Negative messaging or fear-based appeals
❌ Technical jargon without explanation
❌ Passive voice constructions

## Document Templates

### Presentation Structure
1. Title slide (logo, title, subtitle, date)
2. Agenda (if applicable)
3. Content slides (consistent headers, max 6 bullets per slide)
4. Summary/Next Steps
5. Thank you slide (logo, contact info)

### Document Structure
1. Cover page (logo, title, author, date)
2. Table of contents (for documents >5 pages)
3. Executive summary (1-2 pages max)
4. Body content (clear sections with headers)
5. Conclusion/Recommendations
6. Appendices (if needed)

## Examples

### Correct Usage
✅ Full-color Acme logo on white slide with Montserrat Bold heading in Acme Blue
✅ Body text in Open Sans Regular, Charcoal color, 1.5x line height
✅ CTA button in Acme Blue (#0066CC) with white text
✅ Tagline "Innovation that moves you forward" on title slide
✅ Professional, action-oriented messaging: "Accelerate your transformation"

### Incorrect Usage
❌ Logo stretched to fit space (distorted proportions)
❌ Using Arial instead of Open Sans for body text
❌ Random colors not from brand palette (#FF5500)
❌ Modified tagline: "Innovation that will move your business"
❌ Jargon-heavy copy: "Leverage synergies to optimize outcomes"

## Reference Materials

For complete specifications and templates:
- `reference.md` - Detailed brand standards with measurements
- `examples.md` - Visual examples of correct brand application
- `templates/` - Approved PowerPoint, Google Slides, and Word templates
- Brand portal: [internal link to asset library]
```

**Why this works**:
- Clear third-person description explaining what and when
- Comprehensive guidelines organized by category
- Specific measurements and specifications (not vague)
- Do's and don'ts with visual indicators (✅ ❌)
- Real examples showing correct and incorrect usage
- Read-only tool restrictions (appropriate for guidelines)

---

## Example 2: Excel Report Generator (Data Processing Pattern)

```markdown
---
name: excel-sales-reports
description: Processes Excel sales data files and generates formatted monthly reports with charts, KPIs, trend analysis, and actionable insights
version: "2.1.0"
---

# Excel Sales Report Generator

This skill processes Excel spreadsheets containing sales data and generates
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

**Comparative analysis**:
- Period-over-period changes
- Performance by category (product, region, etc.)
- Top and bottom performers
- Market share calculations

### 3. Generate Visualizations

**Chart types and usage**:
- **Line charts**: Trends over time (revenue by month)
- **Bar charts**: Category comparisons (sales by region)
- **Pie charts**: Composition (product mix, market share)
- **Tables**: Detailed breakdowns with totals

**Visualization guidelines**:
- Clear, descriptive titles
- Labeled axes with units
- Consistent color scheme
- Data labels on key points
- Legend when showing multiple series
- Source data referenced

### 4. Create Report

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

### Financial Data
**Required columns**: Account, Period, Amount, Category
**Optional columns**: Department, Project, Budget

### Inventory Data
**Required columns**: SKU, Product, Quantity, Location
**Optional columns**: Last Updated, Reorder Point, Supplier

## Output Format

Generate report in Markdown with:
- Clear hierarchical headers (# ## ###)
- Text descriptions of charts (since images can't be embedded)
- Formatted tables with alignment
- Bulleted insights
- Numbered recommendations
- Code fences for data excerpts

## Example

**Input**: `sales_q4_2024.xlsx`

Columns: [Date, Product, Quantity, Revenue, Region]

**Output**:

```markdown
# Q4 2024 Sales Report

## Executive Summary

Total revenue of $2.45M represents 18% growth over Q3 2024 and 22% growth
year-over-year. Widget A continues to lead with 42% of revenue, while Widget C
shows exceptional 35% quarter-over-quarter growth, particularly in the West region.

## Key Metrics

- **Total Revenue**: $2,450,000 (+18% vs Q3 2024)
- **Total Units Sold**: 125,000 (+12% vs Q3 2024)
- **Average Order Value**: $19.60 (+5% vs Q3 2024)
- **Top Product**: Widget A ($1,029,000, 42% of revenue)
- **Top Region**: West ($892,500, 36% of revenue)

## Revenue Trend

[Line chart description: Revenue by month showing steady growth]
- October: $750,000
- November: $820,000 (+9%)
- December: $880,000 (+7%)

December exceeded forecast by 12%, driven by holiday promotions.

## Product Performance

| Product | Revenue | Units | % of Total | vs Q3 2024 |
|---------|---------|-------|------------|------------|
| Widget A | $1,029,000 | 52,500 | 42% | +5% |
| Widget B | $588,000 | 31,500 | 24% | -3% |
| Widget C | $441,000 | 21,000 | 18% | +35% |
| Widget D | $392,000 | 20,000 | 16% | +8% |

## Regional Breakdown

[Bar chart description: Revenue by region showing West leading]
- **West**: $892,500 (36%, +25% vs Q3)
- **East**: $735,000 (30%, +15% vs Q3)
- **Central**: $490,000 (20%, +10% vs Q3)
- **South**: $332,500 (14%, +12% vs Q3)

## Key Insights

- **Widget C momentum**: 35% Q/Q growth concentrated in West region suggests
  successful regional marketing campaign; consider expanding to other regions

- **Widget B decline**: -3% Q/Q requires investigation; check pricing
  competitiveness and inventory availability

- **December outperformance**: Holiday promotions drove 12% above forecast;
  evaluate for permanent pricing strategy

- **West region strength**: Leading all regions with 25% growth; West sales
  team expansion recommended

## Recommendations

1. **Increase Widget C inventory** for Q1 2025 to support growth trajectory
2. **Investigate Widget B pricing** and competitive positioning
3. **Expand successful holiday promotions** to other high-traffic periods
4. **Add 2 sales representatives** in West region to capitalize on momentum
5. **Cross-regional learning** - share West marketing strategies with other regions

---

*Report generated from sales_q4_2024.xlsx on 2025-01-21*
```

## Error Handling

**If validation fails**:
- List specific problems with row/column references
- Suggest corrections or data cleanup steps
- Offer to proceed with partial analysis if possible
- Never guess or fabricate missing data
- Provide example of correct format

**Example error message**:
```
Data validation failed:
- Missing values in 'Revenue' column: rows 15, 23, 47
- Invalid dates in 'Date' column: rows 8 ("13/45/2024"), 92 ("N/A")
- Negative quantities in 'Quantity' column: rows 31, 33

Please correct these issues and try again, or I can proceed with analysis
excluding the 6 affected rows (4.8% of dataset).
```

## Reference Materials

- `reference.md` - Complete data format specifications and chart guidelines
- `examples.md` - Sample reports for different data types and industries
```

**Why this works**:
- Third-person description with specific capabilities
- Step-by-step workflow clearly defined
- Input/output format specifications
- Complete example showing actual data → report transformation
- Error handling with specific guidance
- Appropriate for data processing tasks

---

## Example 3: OpenAPI Documentation Generator (Tool Integration Pattern)

```markdown
---
name: openapi-documentation
description: Generates comprehensive API documentation from OpenAPI 3.0 and Swagger 2.0 specifications including endpoint descriptions, request/response examples, authentication guides, and code samples
version: "1.0.0"
---

# OpenAPI Documentation Generator

This skill generates developer-friendly API documentation from OpenAPI 3.0 and
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

**Validation errors**:
- Report specific schema violations
- Suggest fixes for common issues
- Provide links to OpenAPI specification docs

### 2. Generate API Overview

**Include in overview**:
- API title and version number
- Base URL(s) for different environments (production, staging)
- High-level description of API purpose
- Contact information and support links
- License information
- Terms of service link

**Example**:
```markdown
# Swagger Petstore API v1.0.0

Sample Pet Store Server based on OpenAPI 3.0 specification.

**Base URLs**:
- Production: `https://petstore3.swagger.io/api/v3`
- Staging: `https://staging.petstore3.swagger.io/api/v3`

**Contact**: apiteam@swagger.io
**License**: Apache 2.0
**Version**: 1.0.0
```

### 3. Document Authentication

**For each security scheme**:
- Type (apiKey, http basic/bearer, oauth2, openIdConnect)
- Location (header, query parameter, cookie)
- Parameter name or scheme name
- Flow type (for OAuth2)
- Scopes (for OAuth2)
- Example usage with curl

**Example**:
```markdown
## Authentication

This API uses API Key authentication via the `X-API-Key` header.

**Header**: `X-API-Key`
**Type**: apiKey

**Example**:
```bash
curl -H "X-API-Key: your_api_key_here" \
     https://api.example.com/v1/users
```
```

### 4. Document Endpoints

**For each endpoint, include**:

#### Basic Information
- HTTP method and path
- One-line summary
- Detailed description (if available)
- Tags/categories for grouping

#### Parameters

**Path Parameters**:
- Name, type, required status
- Description and constraints
- Example values

**Query Parameters**:
- Name, type, required status, default value
- Description and constraints
- Enum values (if applicable)
- Min/max values, pattern validation

**Request Headers**:
- Name, required status
- Description
- Example values

**Request Body**:
- Content type (application/json, multipart/form-data, etc.)
- Schema with nested structure
- Required vs optional fields
- Field descriptions and constraints
- Complete example request

#### Responses

**For each status code**:
- Status code and standard description
- Response content type
- Response schema with field descriptions
- Example response body

**Common status codes**:
- 200/201: Success responses
- 400: Bad request (validation errors)
- 401: Unauthorized (missing/invalid auth)
- 403: Forbidden (insufficient permissions)
- 404: Not found
- 500: Internal server error

#### Code Examples

**Include curl examples**:
- With all required parameters
- Using realistic data (not placeholders)
- Showing authentication
- For both successful and error scenarios

### 5. Document Schemas/Models

**For each schema**:
- Schema name and description
- All properties with types and descriptions
- Required fields clearly marked
- Nested schemas expanded or linked
- Enum values listed
- Validation constraints (min/max length, pattern, format)

**Example**:
```markdown
### User Schema

Represents a user account in the system.

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | integer | Yes | Unique user identifier |
| username | string | Yes | Unique username (3-20 chars, alphanumeric) |
| email | string | Yes | Valid email address |
| firstName | string | No | User's first name |
| lastName | string | No | User's last name |
| status | string | Yes | Account status (enum: active, inactive, suspended) |
| createdAt | string (date-time) | Yes | Account creation timestamp (ISO 8601) |
```

## Output Format

Generate Markdown documentation with this structure:

```markdown
# [API Name] v[Version]

[API description]

## Base URL

```
[Production URL]
```

## Authentication

[Auth documentation with examples]

## Endpoints

### [HTTP METHOD] /[path]

[Endpoint documentation]

**Parameters**:
[Parameter tables]

**Request Body**:
[Schema and example]

**Responses**:

**200 OK**:
[Response schema and example]

**Example**:
```bash
[curl example]
```

---

### [Next endpoint...]

## Schemas

### [Schema Name]

[Schema documentation]

---

## Error Responses

[Common error format documentation]
```

## Example

**Input**: `petstore.yaml` (OpenAPI 3.0)

**Output**:

```markdown
# Swagger Petstore v1.0.0

Sample Pet Store Server based on OpenAPI 3.0 specification.

## Base URL

```
https://petstore3.swagger.io/api/v3
```

## Authentication

This API uses API Key authentication.

**Header**: `api_key`
**Type**: apiKey

```bash
curl -H "api_key: your_api_key" \
     https://petstore3.swagger.io/api/v3/pet/1
```

## Endpoints

### GET /pet/{petId}

Find pet by ID. Returns a single pet.

**Path Parameters**:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| petId | integer (int64) | Yes | ID of pet to return |

**Responses**:

**200 OK** - Successful operation

Response Schema:
```json
{
  "id": 1,
  "name": "Fluffy",
  "category": {
    "id": 1,
    "name": "Dogs"
  },
  "photoUrls": ["https://example.com/photo1.jpg"],
  "tags": [
    {
      "id": 1,
      "name": "friendly"
    }
  ],
  "status": "available"
}
```

**400 Bad Request** - Invalid ID supplied
**404 Not Found** - Pet not found

**Example**:
```bash
curl -X GET "https://petstore3.swagger.io/api/v3/pet/1" \
     -H "accept: application/json" \
     -H "api_key: your_api_key"
```

---

### POST /pet

Add a new pet to the store

**Request Body** (application/json):

```json
{
  "name": "Fluffy",
  "category": {
    "id": 1,
    "name": "Dogs"
  },
  "photoUrls": ["https://example.com/photo1.jpg"],
  "tags": [
    {
      "id": 1,
      "name": "friendly"
    }
  ],
  "status": "available"
}
```

**Responses**:

**201 Created** - Pet created successfully

[... continues with more endpoints ...]

## Schemas

### Pet

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | integer (int64) | No | Unique identifier (auto-generated) |
| name | string | Yes | Pet name |
| category | Category | No | Pet category |
| photoUrls | array of strings | Yes | Photo URLs |
| tags | array of Tag | No | Pet tags |
| status | string | Yes | Pet status (enum: available, pending, sold) |

### Category

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | integer (int64) | No | Category ID |
| name | string | Yes | Category name |

[... continues with more schemas ...]
```

## Error Handling

**If spec parsing fails**:
- Report specific validation errors with line numbers (if YAML)
- Identify schema violations clearly
- Suggest common fixes:
  - Missing required fields
  - Invalid ref syntax
  - Incorrect version format
  - Unsupported features
- Offer to generate docs for valid portions only
- Link to OpenAPI specification documentation

**Example error**:
```
OpenAPI specification validation failed:

Line 45: Missing required field 'description' in 'info' object
Line 102: Invalid $ref syntax - should be '#/components/schemas/Pet'
Line 156: Unsupported security scheme type 'custom' (use: apiKey, http, oauth2, openIdConnect)

Fix these issues and try again, or see https://spec.openapis.org/oas/v3.0.0
```

## Reference Materials

- `reference.md` - Complete OpenAPI/Swagger format guide and schema reference
- `examples.md` - Sample generated docs for various API types (REST, GraphQL hybrid)
- OpenAPI Specification: https://spec.openapis.org/
- Swagger documentation: https://swagger.io/docs/
```

**Why this works**:
- Third-person description with specific input/output formats
- Detailed technical process for generation
- Comprehensive endpoint documentation structure
- Complete real-world example showing spec → docs
- Error handling with specific troubleshooting
- Perfect for tool integration scenarios

---

## Example 4: Microservices Architecture Patterns (Knowledge/Reference Pattern)

```markdown
---
name: microservices-architecture
description: Provides guidance on microservices architecture patterns including service decomposition strategies, communication approaches, data management techniques, and deployment best practices for distributed systems
version: "1.0.0"
allowed-tools:
  - Read
  - Grep
  - Glob
  - mcp__context7__*
  - mcp__exa__*
---

# Microservices Architecture Patterns

This skill provides expert guidance on microservices architecture design,
implementation patterns, and best practices for building distributed systems.

## When to Use

Activate when discussing:
- System architecture design decisions
- Microservices vs monolith tradeoffs
- Service decomposition strategies
- Inter-service communication patterns
- Data management in distributed systems
- Deployment and scaling approaches
- Resilience and fault tolerance

## Core Principles

### 1. Single Responsibility per Service

**Principle**: Each service owns one business capability with clear boundaries.

**Characteristics**:
- Focused on specific business function
- Clear bounded context (Domain-Driven Design)
- Independent deployment lifecycle
- Dedicated team ownership possible

**Example**:
- ✅ Order Service - manages orders only
- ✅ Payment Service - processes payments only
- ❌ Order-Payment Service - violates single responsibility

### 2. Decentralized Data Management

**Principle**: Database per service, no shared databases.

**Characteristics**:
- Each service owns its data schema
- Data accessed only through service API
- Eventual consistency acceptable
- Event-driven data synchronization

**Benefits**:
- Independent scaling
- Technology diversity (polyglot persistence)
- Failure isolation
- Team autonomy

### 3. Smart Endpoints, Dumb Pipes

**Principle**: Business logic in services, simple communication protocols.

**Characteristics**:
- Services contain business intelligence
- Communication via HTTP/REST, gRPC, or messaging
- Avoid complex middleware (ESB, orchestration layers)
- Point-to-point or pub/sub messaging

## Service Decomposition Strategies

### By Business Capability

**Approach**: Align services with business functions.

**Example - E-commerce**:
- Customer Management - customer profiles, preferences
- Product Catalog - product info, search, categories
- Order Management - cart, checkout, order lifecycle
- Inventory - stock levels, warehouse management
- Payment - payment processing, refunds
- Shipping - fulfillment, tracking, delivery
- Notifications - email, SMS, push notifications

**Advantages**:
- Aligns with business organization
- Clear ownership by business domains
- Easier to explain to non-technical stakeholders

### By Subdomain (Domain-Driven Design)

**Approach**: Use DDD bounded contexts.

**Example - Healthcare**:
- Patient Management (core domain)
- Appointment Scheduling (supporting domain)
- Billing and Insurance (supporting domain)
- Electronic Health Records (core domain)
- Lab Results (supporting domain)

**Advantages**:
- Reflects domain complexity
- Clear conceptual boundaries
- Supports ubiquitous language

### Decomposition Guidelines

**Do**:
- ✅ Services can be deployed independently
- ✅ Clear ownership and team responsibility
- ✅ Minimal coupling between services
- ✅ High cohesion within service
- ✅ Services handle 1-3 closely related capabilities

**Don't**:
- ❌ Nano-services (too fine-grained)
- ❌ Shared databases between services
- ❌ Synchronous call chains (A→B→C→D)
- ❌ Distributed monolith (must deploy together)

## Communication Patterns

### Synchronous (Request-Response)

**Technologies**: REST/HTTP, gRPC

**When to use**:
- Immediate response needed
- Client-driven workflows
- CRUD operations
- Low-latency requirements

**Best practices**:
- Use API gateway for external clients
- Implement circuit breakers (Hystrix, Resilience4j)
- Set appropriate timeouts (connection, request)
- Implement retry logic with exponential backoff
- Version APIs carefully (URL versioning recommended)
- Use correlation IDs for request tracing

**Example**:
```
Client → API Gateway → Order Service → Inventory Service
                                    → Payment Service
```

### Asynchronous (Event-Driven)

**Technologies**: RabbitMQ, Apache Kafka, AWS SQS/SNS

**When to use**:
- Event notifications
- Long-running operations
- High throughput requirements
- Loose coupling desired
- Eventual consistency acceptable

**Best practices**:
- Idempotent message handlers (handle duplicates)
- Dead letter queues for failed messages
- Event schema versioning
- Message ordering considerations
- At-least-once delivery semantics
- Monitoring and alerting on queue depths

**Example**:
```
Order Created Event → [Kafka Topic]
                    → Inventory Service (reserve stock)
                    → Notification Service (email customer)
                    → Analytics Service (update metrics)
```

## Data Management Patterns

### Database Per Service

**Pattern**: Each service owns its database.

**Implementation**:
```
Order Service → Orders DB (PostgreSQL)
Product Service → Products DB (MongoDB)
User Service → Users DB (MySQL)
Search Service → Search Index (Elasticsearch)
```

**Challenges**:
- Distributed transactions
- Data consistency
- Complex queries spanning services
- Data duplication

**Solutions**:
- Saga pattern for transactions
- CQRS for complex queries
- Event sourcing for audit trails
- API composition for cross-service queries

### Saga Pattern

**Purpose**: Maintain data consistency across services without distributed transactions.

**Choreography approach** (event-driven):
```
1. Order Service: Create order → Publish OrderCreated
2. Inventory Service: Reserve items → Publish InventoryReserved
3. Payment Service: Process payment → Publish PaymentProcessed
4. Shipping Service: Create shipment → Publish ShipmentCreated

If any step fails, publish compensating events:
- InventoryReservationFailed → Release order
- PaymentFailed → Release inventory, cancel order
```

**Orchestration approach** (coordinator):
```
Saga Orchestrator:
1. Call Inventory.Reserve()
2. Call Payment.Process()
3. Call Shipping.Create()
4. If any fail, execute compensating transactions in reverse
```

**When to use**:
- Order fulfillment workflows
- Multi-step business processes
- Cross-service transactions

### CQRS (Command Query Responsibility Segregation)

**Pattern**: Separate read and write models.

**Implementation**:
```
Commands (writes) → Write Model → Event Store → Events
Events → Read Model Updater → Denormalized Read Models
Queries (reads) → Read Model (optimized for queries)
```

**When to use**:
- Complex domain logic
- Different read/write scaling needs
- Event sourcing implementation
- Multiple read representations needed

**Advantages**:
- Optimized read and write paths
- Independent scaling
- Event history maintained
- Multiple read models possible

## Deployment Patterns

### Containerization (Docker/Kubernetes)

**Approach**: Service per container with orchestration.

**Architecture**:
```
Kubernetes Cluster
├── Order Service (3 pods)
├── Payment Service (2 pods)
├── Inventory Service (5 pods)
├── API Gateway (2 pods)
└── Service Mesh (Istio/Linkerd)
```

**Benefits**:
- Consistent deployment environment
- Auto-scaling and self-healing
- Rolling updates with zero downtime
- Resource isolation and limits
- Service discovery built-in

**Considerations**:
- Kubernetes complexity
- Monitoring and observability needs
- Secrets management
- Network policies

### Serverless Functions

**Approach**: Function per service operation.

**Architecture**:
```
API Gateway → Lambda Functions
            → CreateOrder function
            → ProcessPayment function
            → UpdateInventory function
```

**When to use**:
- Event-driven processing
- Variable traffic patterns
- Cost optimization (pay-per-use)
- Stateless operations
- Rapid scaling needs

**Limitations**:
- Cold start latency
- Execution time limits
- State management complexity
- Vendor lock-in

## Resilience Patterns

### Circuit Breaker

**Purpose**: Prevent cascading failures.

**States**:
- Closed: Normal operation, requests flow
- Open: Failures exceeded threshold, fail fast
- Half-Open: Test if downstream recovered

**Implementation** (Resilience4j):
```java
@CircuitBreaker(name = "inventoryService", fallbackMethod = "fallbackInventory")
public Inventory checkInventory(String productId) {
    return inventoryClient.getInventory(productId);
}

public Inventory fallbackInventory(String productId, Exception ex) {
    return Inventory.unavailable();
}
```

### Retry with Backoff

**Pattern**: Retry failed operations with increasing delays.

**Implementation**:
```
Attempt 1: Immediate
Attempt 2: Wait 1 second
Attempt 3: Wait 2 seconds
Attempt 4: Wait 4 seconds
Max attempts: 4
```

### Bulkhead

**Purpose**: Isolate resources to limit failure impact.

**Pattern**: Separate thread pools per dependency.

```
Order Service thread pool (50 threads)
├── Inventory calls (20 threads max)
├── Payment calls (20 threads max)
└── Notification calls (10 threads max)
```

## Common Anti-Patterns

### ❌ Distributed Monolith

**Problem**: Microservices that are tightly coupled despite being separated.

**Symptoms**:
- Must deploy multiple services together
- Services share databases
- Synchronous call chains (A→B→C→D→E)
- Coordinated releases required

**Solution**:
- Enforce service boundaries
- Use async messaging for coupling reduction
- Implement database per service
- Enable independent deployments

### ❌ God Service

**Problem**: One service doing too much.

**Symptoms**:
- Large codebase and team
- Multiple unrelated responsibilities
- Difficult to understand and modify
- Frequent changes for unrelated reasons

**Solution**:
- Decompose into focused services
- Apply single responsibility principle
- Split by business capability or subdomain

### ❌ Chatty Services

**Problem**: Excessive inter-service communication.

**Symptoms**:
- High network overhead
- Poor performance
- Complex debugging
- Tight coupling

**Solution**:
- Aggregate related functionality
- Use API composition or gateway
- Implement caching
- Denormalize data where appropriate

## Decision Framework

### Use Microservices When

✅ **Team can scale independently** - Multiple teams, independent delivery
✅ **Different scaling needs** - Parts of system have different load patterns
✅ **Technology diversity valuable** - Need different tech stacks
✅ **Continuous deployment priority** - Frequent, independent releases
✅ **System is large and complex** - Benefits outweigh coordination costs

### Stick with Monolith When

✅ **Team is small** (< 10 people) - Coordination overhead not justified
✅ **System is simple** - Complexity not warranted
✅ **Low deployment frequency** - Not doing CD/CI
✅ **Operational maturity lacking** - Team not ready for distributed systems
✅ **Startup/early stage** - Flexibility and speed more important

## Reference Materials

For detailed patterns and implementations:
- `reference.md` - Complete pattern catalog with implementation details
- `examples.md` - Real-world case studies and migration stories
- Martin Fowler's Microservices Guide: https://martinfowler.com/microservices/
- Cloud Native Patterns: https://www.cnpatterns.org/
```

**Why this works**:
- Third-person description with comprehensive scope
- Organized knowledge with clear principles
- Multiple patterns with when-to-use guidance
- Real examples showing implementations
- Decision framework for practical application
- Anti-patterns showing what to avoid
- Read-only with research tool access (appropriate for knowledge)

---

## Pattern Analysis

### Common Elements Across All Skills

1. **Clear activation triggers** - "When to Use" section with specific scenarios
2. **Third-person descriptions** - "Provides", "Processes", "Generates", "Applies"
3. **Specific instructions** - Concrete steps, not vague guidance
4. **Real examples** - Actual use cases, not placeholders
5. **Error/edge case handling** - What to do when things don't work
6. **Reference materials** - Links to deeper documentation
7. **Visual organization** - Headers, lists, tables, code blocks

### Skill Type Comparison

| Type | Focus | Structure | Tools | Example |
|------|-------|-----------|-------|---------|
| **Guidelines** | Standards enforcement | Rules + examples | Read-only | Brand guidelines |
| **Process** | Workflow execution | Steps + I/O specs | Read/write | Data processing |
| **Tool Integration** | External tool usage | Parse + generate | Context-dependent | API docs |
| **Reference** | Knowledge provision | Principles + patterns | Read + research | Architecture |

### Description Formula Analysis

**Effective pattern**:
```
[Verb]s [specific thing] [context] including [key features]
```

**Real examples**:
- "Applies Acme Corp brand guidelines to all presentations and documents including logo usage, color palette, typography, and approved messaging"
- "Processes Excel sales data files and generates formatted monthly reports with charts, KPIs, trend analysis, and actionable insights"
- "Generates comprehensive API documentation from OpenAPI 3.0 specifications including endpoint descriptions, request/response examples, and authentication guides"
- "Provides guidance on microservices architecture patterns including service decomposition, communication approaches, data management, and deployment practices"

**Pattern elements**:
1. Action verb (third person): Applies, Processes, Generates, Provides
2. Specific scope: What it works with
3. Context: Where/when it applies
4. Key features: What it includes/covers

---

## Using These Examples

### As Templates

1. Choose skill type matching your need
2. Copy frontmatter and structure
3. Replace domain-specific content
4. Adjust sections as needed
5. Test with realistic scenarios

### As Inspiration

Mix patterns for hybrid skills:
- Guidelines structure + Process workflow
- Tool integration + Reference knowledge
- Multiple skill types in one (carefully!)

### As Learning

Study what makes them effective:
- How are descriptions written?
- How are instructions organized?
- What makes examples concrete?
- How is third-person POV maintained?
- When are tools restricted?

---

## Quick Reference: Choose Your Pattern

**Need guidelines/standards skill?**
→ Use Brand Guidelines pattern (rules + do's/don'ts + examples)

**Need data processing skill?**
→ Use Excel Reports pattern (workflow + validation + output format)

**Need tool integration skill?**
→ Use OpenAPI Docs pattern (parse + generate + error handling)

**Need knowledge/reference skill?**
→ Use Microservices pattern (principles + patterns + decisions)

**Need hybrid skill?**
→ Combine patterns while maintaining clear focus

**Need something unique?**
→ Follow structure principles from reference.md
