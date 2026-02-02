# QA Report

Generate a comprehensive QA report from testing results.

## Usage

```
/qa-report [type]
```

## Types

- `summary` - High-level overview (default)
- `full` - Complete detailed report
- `bugs` - Bugs-only report

## Options

- `--github` - Create GitHub issues for bugs (if repo configured)

## Process

1. **Collect data**:
   - Locate test run directories
   - Parse test results
   - Gather bug reports
   - Collect screenshots

2. **Analyze findings**:
   - Categorize by severity
   - Group by feature area
   - Identify patterns
   - Assess release readiness

3. **Generate report**:

### Summary Report
```markdown
# QA Summary Report

## Status: READY / NEEDS FIXES / BLOCKED

## Overview
- Tests Run: X
- Pass: X (X%)
- Critical Issues: X

## Key Findings
[Top issues]

## Recommendations
[Priority actions]
```

### Full Report
- All test results
- Every bug with details
- Complete analysis
- Screenshots

### Bugs-Only Report
- Bug list
- Reproducible steps
- Evidence

4. **GitHub integration** (optional):
   - Create issues for each bug
   - Track issue numbers

## Severity Guidelines

| Severity | Criteria |
|----------|----------|
| Critical | Crash, data loss, security |
| Major | Feature broken |
| Minor | Works with issues |
| Cosmetic | Visual only |

## Output

- QA report document
- Bug reports
- GitHub issues (if enabled)
