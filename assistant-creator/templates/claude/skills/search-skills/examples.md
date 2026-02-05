# Skill Search Examples

Example search sessions demonstrating how to find and install skills.

## Example 1: Finding Code Review Skills

**User Request**: "Find code review skills"

**Search**:
```
site:skillregistry.io code review
```

**Results** (formatted):

| Skill | Description | Author |
|-------|-------------|--------|
| code-review-standards | Provides comprehensive code review guidelines for quality, security, and maintainability | @devtools |
| react-code-review | Specialized code review checklist for React applications | @reactdev |
| security-review | Security-focused code review with OWASP checklist | @securityteam |

**User Selection**: "I want the security-review skill"

**Fetch Details**:
```
WebFetch: https://skillregistry.io/skills/security-review
```

**Installation**:
```bash
mkdir -p .claude/skills/security-review
# Download SKILL.md with the content
```

**Post-Installation**:
> The security-review skill is now installed. It provides:
> - OWASP-based security checklist
> - Common vulnerability patterns
> - Remediation suggestions
>
> Try it with: "Review src/auth.ts for security issues"

---

## Example 2: TypeScript Development Skills

**User Request**: "What TypeScript skills are available?"

**Search**:
```
site:skillregistry.io typescript
```

**Results**:

| Skill | Description | Author |
|-------|-------------|--------|
| typescript-guidelines | TypeScript coding standards and best practices | @tsdev |
| type-generation | Generates TypeScript types from various sources | @typegen |
| ts-migration | Guides JavaScript to TypeScript migration | @migrator |
| strict-typescript | Enforces strict TypeScript configuration | @strictdev |

**User**: "Tell me more about typescript-guidelines"

**Details**:
- Covers naming conventions, type patterns, and strict mode
- Includes examples of good and bad practices
- Works with any TypeScript project
- Updated for TypeScript 5.x

**User**: "Install it to my package"

**Package Installation**:
```bash
mkdir -p templates/claude/skills/typescript-guidelines
# Create SKILL.md with content
# Create reference.md with detailed guidelines
```

---

## Example 3: Documentation Skills

**User Request**: "I need help generating API documentation"

**Search**:
```
site:skillregistry.io "api documentation"
```

**Results**:

| Skill | Description | Author |
|-------|-------------|--------|
| openapi-docs | Generates documentation from OpenAPI/Swagger specs | @apidocs |
| markdown-api-docs | Creates markdown API documentation | @docwriter |
| graphql-docs | Documents GraphQL schemas and queries | @graphqlteam |

**User**: "Install openapi-docs locally"

**Local Installation**:
```
.claude/skills/openapi-docs/
├── SKILL.md
├── reference.md
└── templates/
    └── api-template.md
```

**Verification**:
```bash
ls -la .claude/skills/openapi-docs/
# Shows: SKILL.md, reference.md, templates/
```

---

## Example 4: Testing Skills

**User Request**: "Search for testing and test generation skills"

**Search**:
```
site:skillregistry.io testing "test generation"
```

**Results**:

| Skill | Description | Author |
|-------|-------------|--------|
| jest-test-gen | Generates Jest unit tests from code | @testmaster |
| pytest-patterns | Python testing patterns and fixtures | @pythonista |
| e2e-playwright | End-to-end testing with Playwright | @e2edev |
| test-coverage | Analyzes and improves test coverage | @qualityteam |

**Comparison**:

| Feature | jest-test-gen | pytest-patterns |
|---------|--------------|-----------------|
| Language | JavaScript/TS | Python |
| Framework | Jest | pytest |
| Auto-generate | Yes | Templates |
| Coverage | Basic | Advanced |

**User**: "Install jest-test-gen"

---

## Example 5: Browsing by Category

**User Request**: "Show me DevOps skills"

**Category Search**:
```
site:skillregistry.io category:devops
```

Or browse URL:
```
https://skillregistry.io/skills?category=devops
```

**Results**:

| Skill | Description | Author |
|-------|-------------|--------|
| docker-best-practices | Dockerfile optimization and security | @containerdev |
| ci-cd-workflows | GitHub Actions and CI/CD patterns | @cicdmaster |
| kubernetes-helper | K8s resource management and debugging | @k8sdev |
| terraform-guidelines | Infrastructure as Code best practices | @iacteam |

---

## Example 6: Installing to a Package

**User Request**: "Add the code-review-standards skill to my package"

**Package Location**: `my-package/`

**Steps**:

1. **Search and Fetch**:
   ```
   site:skillregistry.io code-review-standards
   WebFetch: https://skillregistry.io/skills/code-review-standards
   ```

2. **Create Directory**:
   ```bash
   mkdir -p my-package/templates/claude/skills/code-review-standards
   ```

3. **Create Skill Files**:
   - `SKILL.md` - Main skill with frontmatter
   - `reference.md` - Detailed review checklist
   - `examples.md` - Review examples

4. **Update Package** (if needed):
   ```toml
   # agents.toml
   [exports.claude]
   skillsDir = "templates/claude/skills"
   ```

5. **Apply Package**:
   ```bash
   tz apply --force
   ```

6. **Verify**:
   ```bash
   ls -la .claude/skills/code-review-standards/
   ```

---

## Example 7: Skill Not Found

**User Request**: "Find a skill for quantum computing"

**Search**:
```
site:skillregistry.io quantum computing
```

**Results**: No matching skills found.

**Response**:
> I couldn't find quantum computing skills on skillregistry.io.
>
> You could:
> 1. **Create your own**: Use the `create-skill` skill to make one
> 2. **Try related searches**: `site:skillregistry.io physics` or `site:skillregistry.io scientific computing`
> 3. **Request on GitHub**: Submit a skill request to the registry
> 4. **Check later**: New skills are added regularly

---

## Search Query Reference

### Exact Phrase

```
site:skillregistry.io "code review"
```

### Multiple Terms

```
site:skillregistry.io react typescript best practices
```

### Exclude Terms

```
site:skillregistry.io testing -python
```

### By Author

```
site:skillregistry.io author:devtools
```

### Recent Skills

```
site:skillregistry.io new skills 2025
```

---

## Common Issues

### Issue: Too Many Results

**Solution**: Add more specific terms
```
site:skillregistry.io "react hooks" testing
```

### Issue: No Results

**Solution**: Try broader terms
```
# Instead of:
site:skillregistry.io "react useEffect cleanup"

# Try:
site:skillregistry.io react hooks
```

### Issue: Skill Page Not Loading

**Solution**: Try direct skill URL
```
WebFetch: https://skillregistry.io/skills/[skill-name]
```

### Issue: Installation Verification

**Solution**: Check file structure
```bash
ls -laR .claude/skills/[skill-name]/
cat .claude/skills/[skill-name]/SKILL.md | head -10
```
