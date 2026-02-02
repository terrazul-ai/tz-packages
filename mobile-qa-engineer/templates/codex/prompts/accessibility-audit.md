# Accessibility Audit

Run a mobile accessibility audit on the app.

## Usage

```
/accessibility-audit [options]
```

## Options

- `--screen=<name>` - Audit specific screen only
- `--focus=<area>` - Focus on: touch-targets, labels, navigation, contrast

## Standards

### iOS Requirements
- Touch targets: minimum 44x44 points
- Accessibility labels on all interactive elements
- Dynamic Type support (1x-3x scaling)
- Color contrast: 4.5:1 normal, 3:1 large text

### Android Requirements
- Touch targets: minimum 48x48 dp
- Content descriptions on all interactive elements
- Font scaling up to 200%
- Color contrast: 4.5:1 normal, 3:1 large text

## Process

1. **Launch app** and navigate to starting screen

2. **Touch target analysis**:
   - Get UI element hierarchy
   - Measure interactive element dimensions
   - Flag undersized elements

3. **Accessibility label audit**:
   - Check all interactive elements for labels
   - Evaluate label quality (descriptive, unique)
   - Flag missing or generic labels

4. **Navigation order testing**:
   - Map focus sequence
   - Verify logical order
   - Check for focus traps

5. **Color contrast assessment**:
   - Identify text elements
   - Assess contrast ratios
   - Flag low contrast

6. **Generate accessibility report**:
   - Summary by category
   - Issues with severity
   - Recommendations

## Output

- Accessibility audit report
- Screenshots of issues
- Prioritized fix recommendations
