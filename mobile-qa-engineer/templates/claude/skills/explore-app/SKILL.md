---
name: explore-app
description: Full mobile app exploration and assessment using mobile-mcp for iOS and Android automation
---

# Explore App Skill

Performs comprehensive exploration of a mobile application, discovering screens, evaluating design quality, and documenting the user interface.

## When to Use

- Starting QA on a new mobile app
- Discovering all screens and navigation paths
- Evaluating design consistency and quality
- Identifying potential UX issues
- Creating baseline documentation
- Onboarding to an unfamiliar app

## Capabilities

1. **Screen Discovery**: Breadth-first exploration of all reachable screens
2. **Design Evaluation**: Visual consistency, touch targets, hierarchy assessment
3. **UX Assessment**: Navigation clarity, task efficiency, feedback quality
4. **Bug Detection**: Crashes, unresponsive UI, layout issues, placeholder text
5. **Documentation**: Screenshot catalog with annotations

## Workflow

### Phase 1: Setup

1. **List available devices**:
   ```
   Use mobile_list_available_devices to find simulators/emulators
   ```

2. **Launch the app**:
   ```
   Use mobile_launch_app with the configured bundle ID
   ```

3. **Create run directory**:
   ```
   [reportOutputDir]/[timestamp]-explore/
   ├── screenshots/
   ├── bugs/
   └── README.md
   ```

### Phase 2: Screen Discovery

Perform breadth-first exploration:

1. **Capture initial state**:
   - Take screenshot of launch screen
   - Get UI element hierarchy using `mobile_list_elements_on_screen`

2. **Identify navigation elements**:
   - Tab bars, navigation bars, menus
   - Buttons, links, interactive elements

3. **Systematically visit each screen**:
   - Navigate using `mobile_click_on_screen_at_coordinates`
   - Scroll to reveal hidden content using `mobile_swipe_on_screen`
   - Screenshot each unique screen
   - Record navigation path

4. **Track visited screens**:
   - Maintain list of discovered screens
   - Avoid infinite loops in navigation

### Phase 3: Design Evaluation

For each screen, assess:

#### Touch Targets
- iOS: Minimum 44x44 points
- Android: Minimum 48x48 dp
- Flag undersized interactive elements

#### Visual Hierarchy
- Clear information structure
- Consistent spacing and alignment
- Appropriate use of typography

#### Design Consistency
- Consistent colors across screens
- Uniform button styles
- Consistent navigation patterns

#### Platform Guidelines
- iOS: Human Interface Guidelines compliance
- Android: Material Design compliance

### Phase 4: UX Assessment

Evaluate user experience:

#### Navigation Clarity
- Can users find what they need?
- Is navigation intuitive?
- Are back/forward paths clear?

#### Task Efficiency
- How many taps for common tasks?
- Are shortcuts available?
- Is important content accessible?

#### Feedback Quality
- Loading indicators present?
- Error states handled gracefully?
- Success confirmations shown?

### Phase 5: Bug Detection

Look for issues:

#### Crashes
- App terminates unexpectedly
- Freezes or hangs

#### UI Issues
- Elements overlapping
- Text truncation
- Broken images
- Placeholder text ("Lorem ipsum")

#### Layout Problems
- Content cut off by notch/home indicator
- Elements too close to edges
- Improper orientation handling

### Phase 6: Documentation

Generate exploration report:

```markdown
# App Exploration Report

**Date**: [Date]
**App**: [App Name]
**Platform**: [iOS/Android]
**Device**: [Device Name]

## Summary
- Screens discovered: X
- Navigation paths: X
- Issues found: X

## Screen Catalog

### [Screen Name]
- **Path**: Home > Settings > [Screen]
- **Screenshot**: screenshots/screen-name.png
- **Elements**: [Count] interactive elements
- **Issues**: [Any issues found]

## Issues Found

### Issue 1: [Title]
- **Severity**: [Critical/Major/Minor/Cosmetic]
- **Screen**: [Screen name]
- **Description**: [What's wrong]
- **Screenshot**: [Reference]

## Recommendations

[Prioritized recommendations based on findings]
```

## Usage Examples

### Full Exploration
```
Use the explore-app skill to perform a complete exploration of the app
```

### Focused Exploration
```
Use the explore-app skill to explore the settings section of the app
```

### Design Audit
```
Use the explore-app skill to evaluate the design consistency across all screens
```

### Navigation Assessment
```
Use the explore-app skill to document all navigation paths in the app
```

## Best Practices

1. **Start from clean state**: Terminate and relaunch app before exploration
2. **Be systematic**: Follow a consistent pattern (e.g., left-to-right, top-to-bottom)
3. **Document everything**: Screenshot every unique state
4. **Check all states**: Test logged in/out, empty/populated, loading/error
5. **Test both orientations**: Portrait and landscape (if supported)
6. **Note observations**: Don't just screenshot, describe what you see
7. **Prioritize issues**: Focus on critical issues first

## Output

The exploration generates:

- `README.md` - Run metadata and summary
- `screenshots/` - Visual evidence for all screens
- `exploration-report.md` - Full exploration documentation
- `bugs/` - Individual bug reports (if issues found)
