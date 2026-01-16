---
name: report-generator
description: Generate consistent, well-formatted reports from UX evaluation findings
---

# Report Generator Skill

Ensure consistent, professional report formatting across all UX evaluation types. This skill standardizes output format, severity scales, and report structure.

## When to Use

- After completing any evaluation (heuristics, accessibility, flow)
- When combining findings from multiple evaluations
- When creating executive summaries
- When exporting to different formats
- When generating stakeholder presentations

## Capabilities

1. **Standardized formatting** - Consistent structure across all reports
2. **Severity normalization** - Unified 0-4 scale
3. **Multiple output formats** - Markdown, JSON
4. **Executive summaries** - High-level findings
5. **Priority matrices** - Impact vs effort analysis
6. **Remediation roadmaps** - Actionable timelines

## Standard Report Structure

All reports follow this structure:

```markdown
# [Report Type] Report

## Metadata
- URL, date, evaluator, scope

## Executive Summary
- Overall score/status
- Key metrics
- Top 3-5 findings
- Critical actions

## Detailed Findings
- Organized by category
- Each with: severity, location, evidence, fix

## Priority Matrix
- Impact vs effort analysis
- Quick wins highlighted

## Recommendations
- Immediate, short-term, long-term
- Estimated effort

## Appendix
- Screenshots
- Methodology
- References
```

## Severity Scale (Universal)

All evaluations use this scale:

| Severity | Label | Definition | Priority |
|----------|-------|------------|----------|
| 0 | Not an issue | No problem found | None |
| 1 | Cosmetic | Minor issue | Low - fix if time |
| 2 | Minor | Causes inconvenience | Medium - schedule fix |
| 3 | Major | Significant problem | High - fix soon |
| 4 | Critical | Catastrophic issue | Urgent - fix now |

### Mapping from Other Scales

| Source Scale | Severity 4 | Severity 3 | Severity 2 | Severity 1 |
|--------------|------------|------------|------------|------------|
| WCAG | Critical | Serious | Moderate | Minor |
| Friction | Score 5 | Score 4 | Score 3 | Score 1-2 |
| Nielsen | Catastrophe | Major | Minor | Cosmetic |

## Report Templates

### Heuristics Report

```markdown
# UX Heuristics Evaluation Report

**URL**: [Target]
**Date**: [Date]
**Evaluation Type**: Nielsen's 10 Usability Heuristics

## Executive Summary

**Overall UX Score**: [X/100]

| Severity | Count |
|----------|-------|
| Critical (4) | X |
| Major (3) | X |
| Minor (2) | X |
| Cosmetic (1) | X |

### Heuristic Scores

| Heuristic | Score | Issues |
|-----------|-------|--------|
| H1: Visibility | X/5 | Y |
| ... | ... | ... |

### Top Issues
1. [Issue] - Severity [X]
2. [Issue] - Severity [X]
3. [Issue] - Severity [X]

## Detailed Findings

### H1: Visibility of System Status

**Score**: X/5

#### Issue H1.1: [Title]
- **Severity**: [0-4]
- **Location**: [Element/page]
- **Description**: [What the issue is]
- **Evidence**: [Screenshot ref]
- **Recommendation**: [How to fix]

[Continue for each issue...]

## Priority Matrix

[Impact vs Effort grid]

## Recommendations

### Immediate (This week)
1. [Fix] - Effort: [Low/Med/High]

### Short-term (This month)
1. [Fix] - Effort: [Low/Med/High]

### Long-term (Quarter)
1. [Fix] - Effort: [Low/Med/High]
```

### Accessibility Report

```markdown
# WCAG [Level] Accessibility Audit Report

**URL**: [Target]
**Date**: [Date]
**Conformance Target**: Level [A/AA/AAA]

## Executive Summary

**Compliance Status**: [Compliant/Partial/Non-Compliant]

| Criteria | Passed | Failed | N/A |
|----------|--------|--------|-----|
| Level A | X | X | X |
| Level AA | X | X | X |

### Critical Issues
1. [Issue] - Criterion [X.X.X]
2. [Issue] - Criterion [X.X.X]

## Issues by Principle

| Principle | Severity 4 | Severity 3 | Severity 2 | Severity 1 |
|-----------|------------|------------|------------|------------|
| Perceivable | X | X | X | X |
| Operable | X | X | X | X |
| Understandable | X | X | X | X |
| Robust | X | X | X | X |

## Detailed Findings

### Perceivable

#### Issue P.1: [Title]
- **Criterion**: [X.X.X Name]
- **Level**: [A/AA/AAA]
- **Severity**: [0-4]
- **Location**: [Element]
- **Impact**: [Who affected]
- **Current**: [State now]
- **Required**: [What should be]
- **Code Fix**:
  ```html
  <!-- Before -->
  ...
  <!-- After -->
  ...
  ```

[Continue...]

## Remediation Roadmap

[Timeline with fixes]
```

### Flow Report

```markdown
# User Flow Test Report

**Flow**: [Name]
**URL**: [Target]
**Date**: [Date]

## Executive Summary

| Metric | Value |
|--------|-------|
| Status | [Pass/Partial/Fail] |
| Steps | X |
| Duration | Xm Xs |
| Friction Points | X |
| Predicted Completion | X% |

### Key Findings
1. [Finding]
2. [Finding]
3. [Finding]

## Flow Visualization

[Mermaid diagram]

## Step Analysis

### Step 1: [Name]

| Metric | Value |
|--------|-------|
| Duration | Xs |
| Friction Score | [1-5] |

**Issues**:

#### Issue 1.1: [Title]
- **Severity**: [0-4]
- **Type**: [Discoverability/Clarity/Efficiency/Error]
- **Description**: [Details]
- **Impact**: [User impact]
- **Recommendation**: [Fix]

[Continue...]

## Friction Summary

| Priority | Issues |
|----------|--------|
| High (4-5) | X |
| Moderate (3) | X |
| Low (1-2) | X |

## Recommendations

[Prioritized list]
```

## Output Formats

### Markdown (Default)
Human-readable reports for documentation and sharing.

### JSON
Structured data for tooling and integration:

```json
{
  "metadata": {
    "url": "https://example.com",
    "date": "2025-01-15",
    "type": "heuristics",
    "evaluator": "UX Researcher"
  },
  "summary": {
    "score": 72,
    "issues": {
      "critical": 1,
      "major": 4,
      "minor": 8,
      "cosmetic": 3
    }
  },
  "findings": [
    {
      "id": "H1.1",
      "heuristic": "Visibility of System Status",
      "severity": 3,
      "title": "No loading indicator",
      "location": ".submit-btn",
      "description": "...",
      "recommendation": "..."
    }
  ],
  "recommendations": {
    "immediate": [...],
    "shortTerm": [...],
    "longTerm": [...]
  }
}
```

## Usage Examples

### Generate from Heuristics Evaluation

```
Use the report-generator skill to format the heuristics findings into a comprehensive report with executive summary and priority matrix.
```

### Combine Multiple Evaluations

```
Use the report-generator skill to create a unified report combining:
- Heuristics evaluation findings
- Accessibility audit results
- Flow test analysis

Generate both markdown and JSON outputs.
```

### Executive Summary Only

```
Use the report-generator skill to create a 1-page executive summary of the audit findings for stakeholder presentation.
```

## Best Practices

1. **Use consistent terminology** - Stick to the severity scale
2. **Include evidence** - Every finding needs screenshot reference
3. **Be specific** - Reference exact elements/selectors
4. **Prioritize actionably** - Quick wins first
5. **Provide solutions** - Not just problems
6. **Consider audience** - Technical detail for devs, summary for execs
