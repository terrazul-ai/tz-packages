---
name: qa-report
description: Generate comprehensive QA reports from mobile app testing with optional GitHub integration
---

# QA Report Skill

Generates comprehensive QA reports from mobile app testing, compiling findings, screenshots, and recommendations into structured documentation with optional GitHub issue creation.

## When to Use

- After completing a testing session
- Compiling results from multiple test runs
- Creating stakeholder reports
- Documenting release readiness
- Generating bug reports for developers
- Creating GitHub issues for tracking

## Capabilities

1. **Report Compilation**: Aggregate results from test runs
2. **Bug Documentation**: Detailed bug reports with evidence
3. **Severity Analysis**: Prioritize issues by impact
4. **GitHub Integration**: Create issues via gh CLI
5. **Multiple Formats**: Summary, full, or bugs-only reports

## Report Types

### Summary Report
High-level overview for stakeholders:
- Overall pass/fail status
- Issue counts by severity
- Key findings
- Recommendations

### Full Report
Comprehensive documentation:
- All test results
- Every screenshot
- Detailed bug reports
- Complete analysis

### Bugs-Only Report
Focused on issues:
- Bug list with details
- Reproducible steps
- Evidence
- Ready for GitHub import

## Workflow

### Phase 1: Data Collection

1. **Locate run directories**:
   ```
   [reportOutputDir]/[timestamp]-*/
   ```

2. **Parse run results**:
   - Test results (PASS/FAIL)
   - Screenshots captured
   - Bug reports generated
   - Observations noted

3. **Aggregate findings**:
   - Combine results from multiple runs
   - Deduplicate issues
   - Sort by severity

### Phase 2: Analysis

1. **Categorize issues**:
   - By severity (Critical/Major/Minor/Cosmetic)
   - By feature area
   - By platform (iOS/Android/Both)

2. **Identify patterns**:
   - Recurring issues
   - Platform-specific bugs
   - Regression vs new issues

3. **Assess release readiness**:
   - Any critical blockers?
   - Risk assessment
   - Confidence level

### Phase 3: Report Generation

#### Summary Report

```markdown
# QA Summary Report

**App**: [App Name]
**Version**: [Version]
**Date**: [Date]
**Tested By**: Mobile QA Engineer

## Executive Summary

**Status**: READY FOR RELEASE / NEEDS FIXES / BLOCKED

[1-2 sentence summary]

## Overview

| Category | Count |
|----------|-------|
| Tests Executed | X |
| Tests Passed | X |
| Tests Failed | X |
| Bugs Found | X |
| Critical Issues | X |
| Major Issues | X |

## Key Findings

### Critical Issues (X)
[Brief description of critical issues]

### Major Issues (X)
[Brief description of major issues]

## Platform Status

| Platform | Tests | Pass Rate | Critical | Major |
|----------|-------|-----------|----------|-------|
| iOS | X | X% | X | X |
| Android | X | X% | X | X |

## Recommendations

1. [Top priority action]
2. [Second priority action]
3. [Third priority action]

## Next Steps

- [ ] Fix critical issues
- [ ] Retest after fixes
- [ ] Final regression run
```

#### Full Report

```markdown
# QA Full Report

**App**: [App Name]
**Version**: [Version]
**Date Range**: [Start] - [End]
**Platforms**: iOS, Android
**Devices**: [Device list]

## Executive Summary

[Summary section same as above]

## Test Execution Summary

### By Category

| Category | Total | Pass | Fail | Skip |
|----------|-------|------|------|------|
| Auth | X | X | X | X |
| Navigation | X | X | X | X |
| Features | X | X | X | X |
| Accessibility | X | X | X | X |

### By Priority

| Priority | Total | Pass | Fail |
|----------|-------|------|------|
| Critical | X | X | X |
| High | X | X | X |
| Medium | X | X | X |
| Low | X | X | X |

## Detailed Bug Reports

### BUG-001: [Title]

**Severity**: Critical
**Platform**: iOS
**Feature**: Auth
**Found**: [Date]

#### Description
[Detailed description]

#### Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Step 3]

#### Expected Behavior
[What should happen]

#### Actual Behavior
[What actually happened]

#### Evidence
![Screenshot](screenshots/bug-001.png)

#### Environment
- Device: iPhone 15 Pro
- OS: iOS 17.2
- App Version: 1.0.0

---

### BUG-002: [Title]
...

## Test Results Detail

### TC-001: [Test Name]
- **Status**: PASS / FAIL
- **Platform**: iOS / Android
- **Duration**: Xs
- **Evidence**: [Screenshot refs]
- **Notes**: [Observations]

...

## Accessibility Findings

[Summary of accessibility audit results]

## Visual Regression

[Summary of visual changes detected]

## Performance Observations

[Any performance issues noted]

## Recommendations

### Immediate (Before Release)
[Critical fixes required]

### Short Term (Next Sprint)
[High priority improvements]

### Long Term (Backlog)
[Lower priority enhancements]

## Appendix

### Screenshots Index
[List of all screenshots]

### Test Case Coverage
[List of all test cases]

### Environment Details
[Full environment specification]
```

### Phase 4: GitHub Integration (Optional)

If GitHub repo is configured, create issues:

1. **Format bug for GitHub**:
   ```markdown
   ## Description
   [Bug description]

   ## Steps to Reproduce
   1. [Step 1]
   2. [Step 2]
   3. [Step 3]

   ## Expected Behavior
   [Expected]

   ## Actual Behavior
   [Actual]

   ## Environment
   - Platform: [iOS/Android]
   - Device: [Device]
   - App Version: [Version]

   ## Evidence
   [Screenshot or link]

   ---
   *Reported by Mobile QA Engineer*
   ```

2. **Create issue via gh CLI**:
   ```bash
   gh issue create \
     --repo [owner/repo] \
     --title "[BUG-ID]: [Title]" \
     --body "[Formatted body]" \
     --label "bug,mobile,qa" \
     --assignee "@me"
   ```

3. **Track created issues**:
   - Record issue numbers
   - Link in report

## Usage Examples

### Generate Summary
```
Use the qa-report skill to generate a summary report from today's testing
```

### Generate Full Report
```
Use the qa-report skill to generate a full QA report including all test results
```

### Bugs Only
```
Use the qa-report skill to generate a bugs-only report for the development team
```

### With GitHub Issues
```
Use the qa-report skill to generate a report and create GitHub issues for all bugs
```

### Specific Run
```
Use the qa-report skill to generate a report from qa-reports/20250202-143025-explore/
```

### Multi-Run Report
```
Use the qa-report skill to compile a report from all test runs this week
```

## Severity Guidelines

| Severity | Criteria | GitHub Label |
|----------|----------|--------------|
| Critical | Crash, data loss, security, complete feature failure | `priority/critical` |
| Major | Feature partially broken, significant UX issue | `priority/high` |
| Minor | Feature works with issues, cosmetic problems | `priority/medium` |
| Cosmetic | Visual only, typos, minor alignment | `priority/low` |

## Best Practices

1. **Be concise in summaries**: Executives don't read details
2. **Be thorough in bug reports**: Developers need specifics
3. **Include evidence**: Screenshots for every bug
4. **Prioritize clearly**: Critical issues first
5. **Be objective**: Facts, not opinions
6. **Recommend actions**: Don't just report problems
7. **Track over time**: Compare to previous reports

## Output

The report generates:

- `qa-report-summary.md` or `qa-report-full.md` - Main report
- `bugs/` - Individual bug report files
- `github-issues.md` - Created issue references (if enabled)
- `README.md` - Report metadata
