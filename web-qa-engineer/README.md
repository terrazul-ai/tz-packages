# @terrazul/qa-engineer

AI-powered QA Engineer for testing functionality based on product/feature specifications, supporting frontend browser automation (Puppeteer/Playwright) and backend API testing with comprehensive reporting.

## Features

- **Functional Testing** - Test frontend functionality using browser automation
- **API Testing** - Validate backend APIs with comprehensive coverage
- **Free-form Specs** - Accept any specification format (markdown, PRD, user stories, etc.)
- **Dynamic Detection** - Automatically detect project tech stack and patterns
- **Comprehensive Reporting** - Generate detailed QA reports with findings and fixes
- **Browser Flexibility** - Support for both Puppeteer and Playwright
- **Multiple Test Types** - Regression, E2E, and API validation skills

## Prerequisites

- Terrazul CLI (`tz`) installed
- Node.js (for MCP server execution via npx)
- Claude Code or compatible AI tool

## Installation

```bash
# Add the package
tz add @terrazul/qa-engineer

# Apply to render templates
tz apply
```

## Configuration

During setup, you'll be prompted for:

| Setting | Description |
|---------|-------------|
| **Target URL** | The URL to test (e.g., `http://localhost:3000`) |
| **API Base URL** | Backend API URL (or `auto-detect`) |
| **Browser Engine** | `playwright`, `puppeteer`, or `both` |
| **Screenshot Dir** | Where to save screenshots (`./qa-reports/screenshots`) |
| **Report Output** | Where to save reports (`./qa-reports`) |
| **Spec Format** | Your typical spec format (`freeform`, `markdown`, etc.) |

The package also uses AI to detect your project's:
- Frontend/backend frameworks
- API patterns and endpoints
- Authentication methods
- Existing test patterns

## Quick Start

### Test a Feature
```
/test-feature "User should be able to log in with email and password"
```

### Test an API Endpoint
```
/test-api /api/users
```

### Generate QA Report
```
/qa-report
```

### Run Regression Tests
```
Use the regression-test skill to validate existing functionality after the recent deployment
```

### Run E2E Tests
```
Use the e2e-test skill to test the complete signup-to-dashboard flow
```

## Available Commands

| Command | Usage | Purpose |
|---------|-------|---------|
| `/test-feature` | `/test-feature <spec>` | Test frontend feature based on spec |
| `/test-api` | `/test-api <endpoint>` | Test backend API endpoint |
| `/qa-report` | `/qa-report [type]` | Generate QA report (summary/full/bugs/all) |
| `/help` | `/help` | Show package help and usage information |

## Available Skills

| Skill | Purpose |
|-------|---------|
| `regression-test` | Run regression tests after changes |
| `e2e-test` | Execute end-to-end user journey tests |
| `api-validation` | Comprehensive API endpoint validation |

## Specialized Agents

### Functional Tester
- Tests frontend functionality using browser automation
- Designs test cases from specifications
- Captures screenshots as evidence
- Documents pass/fail results

### API Tester
- Tests backend APIs using curl
- Validates request/response schemas
- Tests authentication and authorization
- Checks error handling

### Report Generator
- Consolidates findings from all tests
- Creates executive summaries
- Generates detailed bug reports
- Prioritizes issues by severity

## Browser Automation Tools

### Playwright (Recommended)
```
browser_navigate - Navigate to URL
browser_click - Click on element
browser_type - Type text
browser_take_screenshot - Capture screenshot
browser_wait_for - Wait for element
browser_evaluate - Execute JavaScript
```

### Puppeteer
```
puppeteer_launch - Start browser
puppeteer_navigate - Navigate to URL
puppeteer_click - Click element
puppeteer_type - Type text
puppeteer_screenshot - Capture screenshot
puppeteer_wait_for_selector - Wait for element
```

## Severity Scale

All issues are rated:

| Severity | Label | Definition |
|----------|-------|------------|
| 4 | Critical | Feature broken, must fix immediately |
| 3 | Major | Works incorrectly, fix before release |
| 2 | Minor | Works but has issues, schedule fix |
| 1 | Cosmetic | Visual/text only, nice to have |

## Example Workflows

### Pre-Release QA

```bash
# 1. Test critical features
/test-feature "Test login, signup, and password reset flows"

# 2. Validate APIs
/test-api auth
/test-api /api/users

# 3. Run regression
Use the regression-test skill for full regression before release

# 4. Generate report
/qa-report full
```

### After Deployment

```bash
# 1. Quick smoke test
/test-feature "Smoke test core functionality"

# 2. Targeted regression
Use the regression-test skill to test areas affected by the deployment

# 3. Summary report
/qa-report summary
```

### API Development

```bash
# 1. Validate new endpoint
Use the api-validation skill to thoroughly test the new /api/orders endpoint

# 2. Test integration
Use the e2e-test skill to test the complete order flow end-to-end

# 3. Document findings
/qa-report bugs
```

## Report Output

Reports are saved to the configured output directory:

```
qa-reports/
├── qa-report-2025-01-14.md      # Full report
├── qa-summary-2025-01-14.md     # Executive summary
├── screenshots/                  # Test evidence
│   ├── TC-001-step-1.png
│   └── ...
└── bugs/                         # Individual bug reports
    ├── BUG-001.md
    └── ...
```

## Troubleshooting

### Browser not launching
- Ensure Node.js is installed
- Try: `npx @anthropic-ai/mcp-playwright@latest` manually to test

### API tests failing authentication
- Check if API requires authentication
- Set up auth token in environment or test setup

### Screenshots not saving
- Verify screenshot directory exists and is writable
- Check path in configuration

## Resources

- [Terrazul CLI Documentation](https://github.com/terrazul-ai/terrazul)
- [Playwright Documentation](https://playwright.dev/)
- [Puppeteer Documentation](https://pptr.dev/)

## License

MIT
