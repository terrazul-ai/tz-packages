---
name: regression-test
description: Re-run documented test cases for mobile apps to verify functionality after changes
---

# Regression Test Skill

Re-executes documented test cases to verify mobile app functionality remains correct after code changes, updates, or bug fixes.

## When to Use

- After code changes or bug fixes
- Before releases
- After dependency updates
- After platform/OS updates
- Scheduled regression cycles
- Validating hotfixes

## Capabilities

1. **Test Case Loading**: Parse test cases from files or directories
2. **Systematic Execution**: Run tests in defined order
3. **Baseline Comparison**: Compare results against previous runs
4. **Pass/Fail Tracking**: Clear status for each test
5. **Summary Generation**: Aggregate results with statistics

## Test Case Format

Test cases should be markdown files with this structure:

```markdown
# TC-[ID]: [Test Name]

**Priority**: Critical / High / Medium / Low
**Category**: [Feature area]
**Preconditions**: [Required state]

## Steps

1. **[Action]**
   - Expected: [Result]

2. **[Action]**
   - Expected: [Result]

3. **[Action]**
   - Expected: [Result]

## Success Criteria

- [ ] [Criterion 1]
- [ ] [Criterion 2]

## Notes

[Additional information]
```

## Workflow

### Phase 1: Test Discovery

1. **Load test cases**:
   - From single file: `test-case.md`
   - From directory: `test-cases/*.md`
   - From test suite: `test-suite.md` with references

2. **Parse test cases**:
   - Extract ID, name, priority
   - Parse steps and expected results
   - Identify preconditions

3. **Order by priority**:
   - Critical tests first
   - Then High, Medium, Low

### Phase 2: Environment Setup

1. **Create run directory**:
   ```
   [reportOutputDir]/[timestamp]-regression/
   ├── screenshots/
   ├── results/
   └── README.md
   ```

2. **Initialize summary**:
   ```markdown
   # Regression Test Run

   **Date**: [Date]
   **Platform**: [iOS/Android]
   **Device**: [Device]
   **Test Cases**: [Count]

   ## Status: IN_PROGRESS
   ```

3. **Launch app** to clean state

### Phase 3: Test Execution

For each test case:

1. **Reset state**:
   - Terminate and relaunch app if needed
   - Navigate to precondition state

2. **Execute steps**:
   - Perform each action
   - Screenshot before and after
   - Validate expected result

3. **Record result**:
   ```markdown
   ## TC-[ID]: [Name]

   **Status**: PASS / FAIL / BLOCKED / SKIP
   **Duration**: [Time]

   ### Step Results
   | Step | Action | Expected | Actual | Status |
   |------|--------|----------|--------|--------|
   | 1 | [Action] | [Expected] | [Actual] | PASS/FAIL |

   ### Evidence
   - screenshots/TC-[ID]-step-1.png
   - screenshots/TC-[ID]-step-2.png
   ```

4. **Continue or abort**:
   - On FAIL: Document and continue
   - On BLOCKED: Document reason, skip remaining steps
   - On Critical FAIL: Option to abort suite

### Phase 4: Baseline Comparison (Optional)

If previous run exists:

1. **Load baseline results**:
   - Previous pass/fail status
   - Previous screenshots

2. **Compare**:
   - New failures (was PASS, now FAIL)
   - Fixed issues (was FAIL, now PASS)
   - Consistent failures (still FAIL)

3. **Flag regressions**:
   - Tests that newly fail are regressions
   - Prioritize for investigation

### Phase 5: Report Generation

```markdown
# Regression Test Report

**Date**: [Date]
**Platform**: [iOS/Android]
**Device**: [Device]
**Duration**: [Total time]

## Summary

| Status | Count | Percentage |
|--------|-------|------------|
| PASS | X | X% |
| FAIL | X | X% |
| BLOCKED | X | X% |
| SKIP | X | X% |
| **Total** | **X** | **100%** |

## Result: [PASS / FAIL]

Pass Threshold: 100% (Critical), 95% (High), 90% (Medium)

## Failures

### TC-[ID]: [Name]
- **Priority**: [Priority]
- **Failed Step**: [Step number]
- **Expected**: [Expected]
- **Actual**: [Actual]
- **Evidence**: [Screenshot reference]

## Regressions (vs Previous Run)

[Tests that previously passed but now fail]

## Fixed Issues

[Tests that previously failed but now pass]

## Blocked Tests

[Tests that could not complete with reasons]

## Test Case Details

[Full results for each test case]

## Recommendations

[Suggested actions based on results]
```

## Usage Examples

### Run All Test Cases
```
Use the regression-test skill to run all test cases in qa-reports/test-cases/
```

### Run Specific Suite
```
Use the regression-test skill to run the login test suite in test-cases/auth/
```

### Run Critical Tests Only
```
Use the regression-test skill to run only Critical priority test cases
```

### Run with Comparison
```
Use the regression-test skill to run tests and compare against the previous baseline
```

### Run Single Test
```
Use the regression-test skill to run test case TC-001 in test-cases/login.md
```

## Test Organization

### Recommended Structure
```
qa-reports/
├── test-cases/
│   ├── auth/
│   │   ├── TC-001-login.md
│   │   ├── TC-002-logout.md
│   │   └── TC-003-forgot-password.md
│   ├── navigation/
│   │   ├── TC-010-tab-navigation.md
│   │   └── TC-011-deep-links.md
│   ├── features/
│   │   ├── TC-020-create-item.md
│   │   └── TC-021-edit-item.md
│   └── test-suite.md
└── baselines/
    └── [timestamp]/
        └── results.md
```

### Test Suite File
```markdown
# Mobile App Test Suite

## Critical Tests
- @test-cases/auth/TC-001-login.md
- @test-cases/auth/TC-002-logout.md

## High Priority Tests
- @test-cases/navigation/TC-010-tab-navigation.md

## Medium Priority Tests
- @test-cases/features/TC-020-create-item.md
```

## Best Practices

1. **Atomic test cases**: Each test should be independent
2. **Clear preconditions**: Document required state exactly
3. **Specific expected results**: Vague expectations cause confusion
4. **Consistent naming**: TC-[Category]-[Number] format
5. **Priority assignment**: Critical for core flows, lower for edge cases
6. **Regular updates**: Keep test cases current with app changes
7. **Baseline management**: Save successful runs as baselines

## Output

The regression run generates:

- `README.md` - Run metadata and configuration
- `screenshots/` - Evidence for all test steps
- `results/TC-[ID].md` - Individual test results
- `regression-report.md` - Full summary report
- `baseline.json` - Results for future comparison
