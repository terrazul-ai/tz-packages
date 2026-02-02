---
name: accessibility-audit
description: Mobile accessibility testing for iOS and Android apps following WCAG and platform guidelines
---

# Accessibility Audit Skill

Performs comprehensive accessibility testing on mobile applications, validating compliance with WCAG guidelines and platform-specific accessibility requirements.

## When to Use

- Validating app accessibility compliance
- Pre-release accessibility verification
- Identifying accessibility barriers
- Ensuring inclusive user experience
- Meeting accessibility requirements
- Testing screen reader compatibility

## Capabilities

1. **Touch Target Validation**: Ensure interactive elements meet size minimums
2. **Label Verification**: Check accessibility labels on all elements
3. **Navigation Order**: Validate logical focus order
4. **Color Contrast**: Assess text and UI contrast
5. **Dynamic Type**: Test font scaling support
6. **Screen Reader**: Validate VoiceOver/TalkBack compatibility

## Platform Requirements

### iOS Accessibility Standards
| Criterion | Requirement |
|-----------|-------------|
| Touch Target | Minimum 44x44 points |
| Accessibility Label | Required on all interactive elements |
| Accessibility Hint | Recommended for complex actions |
| Dynamic Type | Support text scaling 1x-3x |
| Color Contrast | 4.5:1 for normal text, 3:1 for large text |

### Android Accessibility Standards
| Criterion | Requirement |
|-----------|-------------|
| Touch Target | Minimum 48x48 dp |
| Content Description | Required on all interactive elements |
| Clickable Spans | Must have accessible alternative |
| Font Scaling | Support up to 200% |
| Color Contrast | 4.5:1 for normal text, 3:1 for large text |

## Workflow

### Phase 1: Setup

1. **Create run directory**:
   ```
   [reportOutputDir]/[timestamp]-a11y-audit/
   ├── screenshots/
   ├── issues/
   └── README.md
   ```

2. **Launch app**:
   - Start fresh session
   - Navigate to starting point

### Phase 2: Touch Target Analysis

For each screen:

1. **Get element hierarchy**:
   ```
   Use mobile_list_elements_on_screen to get all elements with dimensions
   ```

2. **Identify interactive elements**:
   - Buttons
   - Links
   - Text inputs
   - Checkboxes, switches, sliders
   - Tappable images

3. **Measure touch targets**:
   - Calculate element dimensions
   - Flag elements below minimum:
     - iOS: < 44x44 points
     - Android: < 48x48 dp

4. **Document violations**:
   ```markdown
   ## Touch Target Violation

   **Element**: [Description]
   **Screen**: [Screen name]
   **Size**: [Actual size]
   **Required**: [Minimum size]
   **Screenshot**: [Reference]
   ```

### Phase 3: Accessibility Label Audit

1. **Check all interactive elements** for labels:
   - iOS: `accessibilityLabel` property
   - Android: `contentDescription` attribute

2. **Evaluate label quality**:
   - Descriptive: Clearly describes element purpose
   - Concise: Not overly verbose
   - Unique: Distinguishable from other elements
   - Action-oriented: For buttons, describes action

3. **Flag issues**:
   - Missing labels
   - Generic labels ("button", "image")
   - Duplicate labels on same screen
   - Labels that don't match visual text

### Phase 4: Navigation Order Testing

1. **Map focus order**:
   - Document the order elements receive focus
   - Test with swipe gestures (VoiceOver/TalkBack pattern)

2. **Evaluate logical flow**:
   - Order should match visual reading order
   - Related elements should be grouped
   - No focus traps

3. **Test keyboard/switch access** (if applicable):
   - Can all elements be reached?
   - Is focus indicator visible?

### Phase 5: Color Contrast Assessment

1. **Identify text elements**:
   - Headings
   - Body text
   - Button labels
   - Placeholders
   - Error messages

2. **Estimate contrast ratios**:
   - Compare text color to background
   - Flag potentially low contrast combinations

3. **Check non-text contrast**:
   - Icons and graphical elements
   - UI component boundaries
   - Focus indicators

### Phase 6: Dynamic Type Testing

1. **Test font scaling** (if device supports):
   - Increase text size to maximum
   - Verify text remains readable
   - Check for truncation
   - Ensure UI remains usable

2. **Document issues**:
   - Text cut off
   - Layout broken
   - Elements overlap
   - Scroll unavailable for long content

### Phase 7: Report Generation

```markdown
# Accessibility Audit Report

**Date**: [Date]
**App**: [App Name]
**Platform**: [iOS/Android]
**Device**: [Device Name]

## Executive Summary

| Category | Pass | Fail | Manual Check |
|----------|------|------|--------------|
| Touch Targets | X | X | - |
| Accessibility Labels | X | X | - |
| Navigation Order | X | X | X |
| Color Contrast | X | X | X |
| Dynamic Type | X | X | - |

**Overall**: [PASS / FAIL / NEEDS REVIEW]

## Touch Target Issues

[List of touch target violations]

## Label Issues

[List of missing or poor labels]

## Navigation Issues

[List of focus order problems]

## Color Contrast Issues

[List of contrast concerns]

## Dynamic Type Issues

[List of scaling problems]

## Recommendations

### Critical (Fix Immediately)
[Issues that block accessibility]

### High (Fix Before Release)
[Significant accessibility barriers]

### Medium (Plan to Fix)
[Issues affecting some users]

### Low (Nice to Have)
[Minor improvements]
```

## Usage Examples

### Full Audit
```
Use the accessibility-audit skill to perform a complete accessibility audit of the app
```

### Touch Target Focus
```
Use the accessibility-audit skill to check all touch targets meet minimum size requirements
```

### Screen-Specific Audit
```
Use the accessibility-audit skill to audit the checkout flow for accessibility issues
```

### Pre-Release Check
```
Use the accessibility-audit skill to verify accessibility compliance before the app release
```

## Common Issues

### Touch Target Issues
- Small icons without padding
- Inline links in text
- Close buttons in corners
- Tab bar icons

### Label Issues
- Images without descriptions
- Icon-only buttons
- Decorative elements incorrectly marked accessible
- Dynamic content not announced

### Navigation Issues
- Modal dialogs not trapping focus
- Off-screen elements in focus order
- Skip navigation missing
- Forms with poor field order

### Contrast Issues
- Light gray text on white
- Placeholder text too light
- Error states with poor contrast
- Disabled states unclear

## Best Practices

1. **Test systematically**: Cover every screen and state
2. **Use real devices**: Simulators may not reflect actual behavior
3. **Test with assistive tech**: Enable VoiceOver/TalkBack
4. **Include diverse states**: Empty, loading, error, populated
5. **Document thoroughly**: Screenshot every issue
6. **Prioritize by impact**: Critical issues first
7. **Provide solutions**: Suggest how to fix each issue

## Output

The audit generates:

- `README.md` - Audit metadata
- `screenshots/` - Evidence for all issues
- `accessibility-report.md` - Full audit report
- `issues/` - Individual issue files
