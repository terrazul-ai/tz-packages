# Test Flow

Test a specific user flow against a specification.

## Usage

```
/test-flow <spec-or-description>
```

## Examples

```
/test-flow "User can log in with email and password"
/test-flow specs/checkout-flow.md
/test-flow "Test the password reset flow"
```

## Process

1. **Parse the specification** to extract:
   - Flow goal
   - Preconditions
   - Steps to execute
   - Expected results
   - Success criteria

2. **Set up environment**:
   - Launch the app
   - Navigate to starting point
   - Set up required state

3. **Execute each step**:
   - Screenshot before action
   - Perform action (tap, type, swipe)
   - Screenshot after action
   - Validate expected result
   - Record PASS/FAIL

4. **Document deviations**:
   - Note any failures
   - Capture evidence
   - Assess severity

5. **Generate test report**:
   - Summary with pass/fail counts
   - Step-by-step results
   - Recommendations

## Severity Guidelines

| Severity | Criteria |
|----------|----------|
| Critical | Cannot complete flow, data loss |
| Major | Feature works incorrectly |
| Minor | Works with issues |
| Cosmetic | Visual only |

## Output

- Test results document
- Screenshots for each step
- Bug reports for failures
