# Regression Test

Re-run documented test cases to verify app functionality.

## Usage

```
/regression-test <test-cases-path>
```

## Examples

```
/regression-test qa-reports/test-cases/
/regression-test test-cases/auth/
/regression-test --priority=critical
```

## Test Case Format

Test cases should be markdown files:

```markdown
# TC-[ID]: [Test Name]

**Priority**: Critical / High / Medium / Low
**Preconditions**: [Required state]

## Steps

1. **[Action]**
   - Expected: [Result]

2. **[Action]**
   - Expected: [Result]

## Success Criteria

- [ ] [Criterion 1]
- [ ] [Criterion 2]
```

## Process

1. **Discover test cases**:
   - Load from specified path
   - Parse ID, steps, expected results
   - Order by priority (Critical first)

2. **Execute tests**:
   - For each test case:
     - Reset state if needed
     - Execute steps with screenshots
     - Validate expected results
     - Record PASS/FAIL/BLOCKED

3. **Compare to baseline** (if available):
   - Identify regressions (newly failed)
   - Identify fixes (newly passed)

4. **Generate report**:
   - Summary with pass/fail counts
   - List of failures
   - Regression analysis

## Output

- Regression test report
- Individual test results
- Screenshots as evidence
- Pass/fail summary
