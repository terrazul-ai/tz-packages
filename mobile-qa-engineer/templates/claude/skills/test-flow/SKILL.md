---
name: test-flow
description: Test specific mobile app flows against product specifications using mobile-mcp
---

# Test Flow Skill

Tests specific user flows in mobile applications against provided specifications, validating expected behavior and documenting deviations.

## When to Use

- Testing a specific feature or user journey
- Validating against acceptance criteria
- Regression testing after changes
- Verifying bug fixes
- User story validation
- Pre-release verification

## Capabilities

1. **Spec Parsing**: Accept specs in freeform, markdown, user stories, or PRD format
2. **Step Execution**: Execute flow steps with screenshot evidence
3. **State Validation**: Verify expected state at each checkpoint
4. **Deviation Reporting**: Document any differences from expected behavior
5. **Severity Assessment**: Rate issues by impact (Critical/Major/Minor/Cosmetic)

## Workflow

### Phase 1: Spec Analysis

Parse the provided specification to extract:

- **Flow Goal**: What the user is trying to accomplish
- **Preconditions**: Required state before starting
- **Steps**: Ordered list of actions
- **Expected Results**: What should happen at each step
- **Success Criteria**: How to know the flow completed correctly
- **Edge Cases**: Boundary conditions to verify

### Phase 2: Environment Setup

1. **Create run directory**:
   ```
   [reportOutputDir]/[timestamp]-[flow-slug]/
   ├── screenshots/
   ├── bugs/
   └── README.md
   ```

2. **Launch app and set preconditions**:
   - Navigate to starting point
   - Set up required state (logged in, data present, etc.)

3. **Document initial state**:
   - Screenshot starting point
   - Capture UI hierarchy

### Phase 3: Step Execution

For each step in the flow:

1. **Pre-action**:
   - Screenshot current state
   - Capture UI hierarchy using `mobile_list_elements_on_screen`

2. **Execute action**:
   - Tap: `mobile_click_on_screen_at_coordinates`
   - Type: `mobile_type_keys`
   - Swipe: `mobile_swipe_on_screen`
   - Navigate: `mobile_open_url` for deep links

3. **Post-action**:
   - Wait for UI to settle
   - Screenshot resulting state
   - Validate expected outcome

4. **Record result**:
   - PASS: Matches expected result
   - FAIL: Deviates from expected
   - BLOCKED: Cannot proceed

### Phase 4: Validation

At each checkpoint, verify:

- **UI State**: Correct screen displayed
- **Data Display**: Correct information shown
- **Element State**: Buttons enabled/disabled as expected
- **Navigation**: Correct path taken
- **Feedback**: Appropriate messages shown

### Phase 5: Deviation Documentation

For any failures, document:

```markdown
## Deviation: Step [N]

**Expected**: [What should happen]
**Actual**: [What actually happened]
**Severity**: Critical / Major / Minor / Cosmetic
**Impact**: [User impact]

### Evidence
- Before: screenshots/step-N-before.png
- After: screenshots/step-N-after.png

### Notes
[Additional observations]
```

### Phase 6: Report Generation

```markdown
# Flow Test Report: [Flow Name]

**Date**: [Date]
**Spec**: [Spec reference]
**Platform**: [iOS/Android]
**Device**: [Device Name]

## Summary

| Metric | Value |
|--------|-------|
| Steps Executed | X |
| Passed | X |
| Failed | X |
| Blocked | X |
| Overall Status | PASS / FAIL |

## Flow Execution

### Step 1: [Step Description]
- **Action**: [What was done]
- **Expected**: [Expected result]
- **Actual**: [Actual result]
- **Status**: PASS / FAIL
- **Screenshot**: [Reference]

### Step 2: [Step Description]
...

## Deviations Found

[List of deviations with severity]

## Recommendations

[Suggested fixes or improvements]
```

## Spec Format Examples

### Freeform Text
```
User should be able to log in with email and password, see the home screen, and navigate to their profile.
```

### Markdown Spec
```markdown
## Login Flow

**Goal**: User successfully logs in

### Steps
1. Open app
2. Enter email in email field
3. Enter password in password field
4. Tap "Sign In" button
5. Verify home screen appears
6. Verify user name displayed in header

### Acceptance Criteria
- [ ] Login completes within 3 seconds
- [ ] User session persisted
- [ ] Correct user data displayed
```

### User Story
```
As a returning user
I want to log in with my credentials
So that I can access my personalized content

Given I am on the login screen
When I enter valid email and password
And I tap the sign in button
Then I should see the home screen
And my name should appear in the header
```

## Usage Examples

### Test from Freeform Spec
```
Use the test-flow skill to test: "User can complete checkout with credit card"
```

### Test from File
```
Use the test-flow skill to test the flow in specs/login-flow.md
```

### Test with Specific Focus
```
Use the test-flow skill to test the password reset flow, focusing on error handling
```

### Regression Test
```
Use the test-flow skill to verify the login bug fix: users should no longer see blank screen after login
```

## Severity Guidelines

| Severity | Criteria | Example |
|----------|----------|---------|
| Critical | Flow cannot complete, data loss, security issue | Cannot submit form, crash |
| Major | Flow completes but incorrectly, significant UX issue | Wrong data displayed, navigation broken |
| Minor | Flow works but has issues, cosmetic problems | Slow response, alignment off |
| Cosmetic | Visual only, no functional impact | Typo, color inconsistency |

## Best Practices

1. **Clear preconditions**: Ensure starting state is well-defined
2. **Step granularity**: Break complex actions into atomic steps
3. **Wait appropriately**: Allow time for network requests and animations
4. **Screenshot liberally**: Capture before and after every action
5. **Validate thoroughly**: Check all aspects of expected state
6. **Note observations**: Document anything unexpected, even if not a failure
7. **Test edge cases**: Include boundary conditions from spec

## Output

The test generates:

- `README.md` - Run metadata
- `screenshots/` - Visual evidence for all steps
- `test-results.md` - Full test execution report
- `bugs/` - Individual bug reports (if deviations found)
