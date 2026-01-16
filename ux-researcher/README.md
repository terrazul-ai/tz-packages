# @leourbina/ux-researcher

AI-powered UX evaluation using Puppeteer for browser automation, Nielsen's heuristics, WCAG accessibility, and user flow testing.

## Features

- **Nielsen's 10 Usability Heuristics** - Systematic evaluation against established UX principles
- **WCAG 2.1 Accessibility** - Comprehensive accessibility auditing (Level A, AA, AAA)
- **User Flow Testing** - Analyze signup, checkout, onboarding, and custom flows
- **Browser Automation** - Puppeteer MCP integration for real interaction
- **Consistent Reporting** - Standardized report format across all evaluations

## Prerequisites

This package uses the Puppeteer MCP server for browser automation. It will be installed automatically via npx when first used.

### System Requirements

- Node.js 18+
- Claude Code with MCP support
- Terrazul CLI (`tz`)

## Installation

```bash
# Add to your project
tz add @leourbina/ux-researcher

# Apply the package
tz apply
```

## Configuration

During `tz apply`, you'll be prompted to configure:

| Setting | Description | Example |
|---------|-------------|---------|
| Target URL | Default URL for evaluations | `https://example.com` |
| App Type | Type of application | `web-app`, `e-commerce`, `saas` |
| Evaluation Scope | What to evaluate | `all`, `heuristics`, `accessibility` |
| WCAG Level | Accessibility conformance | `A`, `AA`, `AAA` |
| Screenshot Dir | Where to save screenshots | `./ux-reports/screenshots` |
| Report Format | Output format | `markdown`, `json` |

## Quick Start

### Run a Heuristics Evaluation

```
/analyze-ux https://example.com
```

### Perform an Accessibility Audit

```
/accessibility-audit https://example.com
```

### Test a User Flow

```
/test-flow signup https://example.com
```

## Available Commands

| Command | Description |
|---------|-------------|
| `/analyze-ux [url]` | Comprehensive Nielsen's heuristics evaluation |
| `/accessibility-audit [url]` | WCAG accessibility audit |
| `/test-flow <type> [url]` | Test user flows (signup, login, checkout, etc.) |

## Available Skills

| Skill | Description |
|-------|-------------|
| `batch-ux-audit` | Multi-page comprehensive evaluation |
| `wcag-compliance` | Deep WCAG criterion-by-criterion testing |
| `flow-analysis` | Multi-flow comparison and optimization |
| `report-generator` | Consistent report formatting |

### Using Skills

```
Use the batch-ux-audit skill to evaluate:
- Homepage
- Signup page
- Dashboard
```

```
Use the wcag-compliance skill to audit https://example.com at Level AA
```

```
Use the flow-analysis skill to compare signup flow against competitor
```

```
Use the report-generator skill to create a comprehensive report from findings
```

## Specialized Agents

| Agent | Expertise |
|-------|-----------|
| `heuristics-evaluator` | Nielsen's 10 heuristics specialist |
| `accessibility-auditor` | WCAG 2.1 compliance expert |
| `flow-tester` | User journey testing specialist |

## Puppeteer Tools

The following browser automation tools are available via MCP:

```
puppeteer_launch          - Start browser
puppeteer_new_page        - Create tab
puppeteer_navigate        - Go to URL
puppeteer_click           - Click element
puppeteer_type            - Enter text
puppeteer_get_text        - Extract content
puppeteer_screenshot      - Capture page
puppeteer_evaluate        - Run JavaScript
puppeteer_wait_for_selector - Wait for element
puppeteer_close_page      - Close tab
puppeteer_close_browser   - Close browser
```

## Nielsen's 10 Heuristics

1. **Visibility of System Status** - Keep users informed
2. **Match Between System and Real World** - Speak users' language
3. **User Control and Freedom** - Support undo/redo
4. **Consistency and Standards** - Follow conventions
5. **Error Prevention** - Design to prevent errors
6. **Recognition Rather Than Recall** - Make options visible
7. **Flexibility and Efficiency** - Provide shortcuts
8. **Aesthetic and Minimalist Design** - Remove clutter
9. **Error Recovery** - Help users recover from errors
10. **Help and Documentation** - Provide guidance

## WCAG 2.1 Levels

| Level | Description | Contrast Requirement |
|-------|-------------|----------------------|
| A | Minimum accessibility | N/A |
| AA | Standard (recommended) | 4.5:1 normal, 3:1 large |
| AAA | Enhanced accessibility | 7:1 normal, 4.5:1 large |

## Severity Scale

All evaluations use a consistent 0-4 severity scale:

| Severity | Label | Priority |
|----------|-------|----------|
| 0 | Not an issue | None |
| 1 | Cosmetic | Low |
| 2 | Minor | Medium |
| 3 | Major | High |
| 4 | Critical | Urgent |

## Example Workflows

### Complete Site Audit

```
1. Use batch-ux-audit skill to evaluate key pages
2. Review findings across heuristics and accessibility
3. Use report-generator skill for stakeholder presentation
```

### Pre-Launch Accessibility Check

```
1. /accessibility-audit --level=AA
2. Review WCAG compliance status
3. Address critical issues before launch
```

### Conversion Optimization

```
1. /test-flow signup
2. Identify friction points
3. Use flow-analysis skill to compare alternatives
```

## Report Output

Reports are generated in your configured format (markdown/JSON) and include:

- **Executive Summary** - Overall score and key findings
- **Detailed Findings** - Categorized issues with evidence
- **Priority Matrix** - Impact vs effort analysis
- **Recommendations** - Actionable remediation steps

## Troubleshooting

### Puppeteer Not Working

```bash
# Test Puppeteer MCP manually
npx puppeteer-mcp-claude serve --help
```

### MCP Server Issues

1. Restart Claude Code session
2. Verify mcp_servers.json configuration
3. Check npx can access the package

### Element Not Found

- Use `puppeteer_wait_for_selector` before interacting
- Verify selector is correct
- Check element is visible

## Resources

- [Nielsen Norman Group](https://www.nngroup.com/) - UX research and guidelines
- [WCAG 2.1 Quick Reference](https://www.w3.org/WAI/WCAG21/quickref/) - Accessibility criteria
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/) - Color contrast tool
- [ARIA Authoring Practices](https://www.w3.org/WAI/ARIA/apg/) - Accessible component patterns

## License

MIT

## Author

Leonardo Urbina
