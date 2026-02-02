# Mobile QA Engineer - Help

AI-powered QA testing for mobile applications.

## Available Prompts

| Prompt | Description |
|--------|-------------|
| `/explore` | Full app exploration and assessment |
| `/test-flow <spec>` | Test a specific flow |
| `/accessibility-audit` | Run accessibility audit |
| `/screenshot-catalog` | Generate visual documentation |
| `/regression-test <cases>` | Re-run documented test cases |
| `/qa-report [type]` | Generate QA report |
| `/setup-mcp` | **Interactive setup wizard** (iOS & Android) |
| `/help` | Show this help |

## Available Skills

| Skill | Description |
|-------|-------------|
| `explore-app` | Full app exploration |
| `test-flow` | Test specific flows |
| `accessibility-audit` | Mobile a11y testing |
| `regression-test` | Re-run test cases |
| `screenshot-catalog` | Visual documentation |
| `qa-report` | Generate reports |

## Quick Start

### 1. Setup (Interactive Wizard)
```
/setup-mcp
```

This wizard **automates everything possible**:

**iOS (macOS only):**
- Clones WebDriverAgent, boots simulator
- Sets up go-ios for physical devices

**Android:**
- Verifies ANDROID_HOME, starts emulator
- Guides USB debugging for physical devices

### 3. Explore
```
/explore
```

### 4. Test Flows
```
/test-flow "User can log in"
```

### 5. Generate Report
```
/qa-report
```

## MCP Tools

| Tool | Description |
|------|-------------|
| `mobile_list_available_devices` | List devices |
| `mobile_launch_app` | Start app |
| `mobile_terminate_app` | Stop app |
| `mobile_take_screenshot` | Capture screen |
| `mobile_list_elements_on_screen` | Get UI hierarchy |
| `mobile_click_on_screen_at_coordinates` | Tap |
| `mobile_swipe_on_screen` | Scroll/swipe |
| `mobile_type_keys` | Text input |

## Platform Guidelines

### iOS
- Touch targets: 44x44 points minimum
- Accessibility labels required

### Android
- Touch targets: 48x48 dp minimum
- Content descriptions required

## Severity Scale

| Level | Description |
|-------|-------------|
| Critical | Crash, data loss |
| Major | Feature broken |
| Minor | Works with issues |
| Cosmetic | Visual only |
