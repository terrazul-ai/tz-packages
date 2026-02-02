# Explore App

Perform full exploration and assessment of the mobile app.

## Usage

```
/explore [options]
```

## Options

- `--section=<name>` - Explore only a specific section
- `--depth=<N>` - Limit navigation depth

## Process

1. **List available devices** using `mobile_list_available_devices`
2. **Launch the app** with the configured bundle ID
3. **Systematically discover screens**:
   - Use breadth-first exploration
   - Navigate to each reachable screen
   - Capture screenshots
   - Document navigation paths
4. **Evaluate design quality**:
   - Check touch target sizes (iOS 44pt, Android 48dp)
   - Assess visual hierarchy
   - Check design consistency
5. **Detect issues**:
   - Look for crashes, UI glitches
   - Check for placeholder text
   - Note layout problems
6. **Generate exploration report**

## Output

- Exploration report with screen catalog
- Screenshots of all discovered screens
- List of issues found with severity
- Navigation map

## Next Steps

After exploring:
- Use `/test-flow` to test specific flows
- Use `/accessibility-audit` for a11y verification
- Use `/qa-report` to compile findings
