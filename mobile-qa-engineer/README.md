# Mobile QA Engineer

AI-powered QA testing for mobile applications using `@mobilenext/mobile-mcp` for iOS and Android automation.

## Features

- **Cross-Platform Testing**: Test iOS simulators/devices and Android emulators/devices
- **App Type Support**: Native, React Native, Flutter, Ionic, and hybrid apps
- **Accessibility Testing**: WCAG compliance, touch targets, screen reader support
- **Visual Documentation**: Screenshot catalogs and visual regression testing
- **Comprehensive Reporting**: Markdown reports with optional GitHub integration

## Installation

```bash
tz add @terrazul/mobile-qa-engineer
tz apply
```

## Quick Start

### 1. Run the Setup Wizard

After installation, run the interactive setup wizard:

```
/setup-mcp
```

This wizard **automates everything possible** and only prompts when truly necessary.

#### What It Does

**Platform Detection:**
- Detects OS (macOS, Linux, Windows)
- Checks Node.js, Xcode (macOS), Android SDK
- Asks which platform: iOS, Android, or Both

**iOS Setup (macOS only):**
- Asks: Simulator or Physical Device
- Clones WebDriverAgent automatically
- Boots simulator or sets up go-ios for physical devices
- Only manual step: Xcode code signing for physical devices

**Android Setup:**
- Asks: Emulator or Physical Device
- Verifies ANDROID_HOME and ADB
- Starts emulator or guides physical device USB debugging
- Fully automated for emulators

#### What Gets Configured

**iOS Simulators:**
- WebDriverAgent cloned to `~/WebDriverAgent`
- Simulator booted and ready
- WebDriverAgent running on port 8100

**iOS Physical Devices:**
- go-ios installed globally
- USB tunnel (`ios tunnel start --userspace`)
- Port forwarding (`ios forward 8100 8100`)
- WebDriverAgent signed and deployed via Xcode

**Android Emulators:**
- ANDROID_HOME environment variable
- Emulator started and ready
- ADB connection verified

**Android Physical Devices:**
- Developer Mode and USB debugging enabled
- ADB connection authorized
- Device ready for testing

### 3. Run Your First Test

```
/explore
```

This performs a full app exploration, discovering screens and documenting the UI.

## Available Commands

| Command | Description |
|---------|-------------|
| `/explore` | Full app exploration and assessment |
| `/test-flow <spec>` | Test a specific flow against a specification |
| `/accessibility-audit` | Run mobile accessibility audit |
| `/screenshot-catalog` | Generate visual documentation |
| `/regression-test <cases>` | Re-run documented test cases |
| `/qa-report [type]` | Generate QA report (summary/full/bugs) |
| `/setup-mcp` | Configure MCP server credentials |
| `/help` | Show available commands and skills |

## Available Skills

| Skill | Description |
|-------|-------------|
| `explore-app` | Full app exploration and assessment |
| `test-flow` | Test specific flows against specs |
| `accessibility-audit` | Mobile accessibility testing |
| `regression-test` | Re-run documented test cases |
| `screenshot-catalog` | Generate visual documentation |
| `qa-report` | Generate comprehensive QA reports |

## Platform Support

| Platform | Tool | Context | Commands | Skills | Agents | MCP |
|----------|------|---------|----------|--------|--------|-----|
| Claude | Yes | CLAUDE.md | 8 | 6 | 4 | JSON |
| Codex | Yes | AGENTS.md | 8 (prompts) | 6 | No | TOML |
| Gemini | Yes | GEMINI.md | 8 | 6 | No | JSON |

## Configuration

During package setup, you'll be asked to configure:

| Setting | Default | Description |
|---------|---------|-------------|
| `targetPlatform` | both | iOS, Android, or both |
| `deviceType` | simulator | simulator, emulator, real-device, auto-detect |
| `appIdentifier` | (required) | Bundle ID (iOS) or package name (Android) |
| `appPath` | none | Path to .ipa/.apk for installation |
| `screenshotDir` | ./qa-reports/screenshots | Screenshot storage |
| `reportOutputDir` | ./qa-reports | Report output location |
| `githubRepo` | none | owner/repo for GitHub issue creation |

## Mobile MCP Tools

The package uses `@mobilenext/mobile-mcp` which provides:

| Tool | Description |
|------|-------------|
| `mobile_list_available_devices` | List simulators/emulators/devices |
| `mobile_launch_app` | Start the app under test |
| `mobile_terminate_app` | Clean up after tests |
| `mobile_take_screenshot` | Capture screen state |
| `mobile_save_screenshot` | Save to specific path |
| `mobile_list_elements_on_screen` | Get UI hierarchy + coordinates |
| `mobile_click_on_screen_at_coordinates` | Tap interactions |
| `mobile_swipe_on_screen` | Scroll, swipe gestures |
| `mobile_type_keys` | Text input |
| `mobile_press_button` | HOME, BACK, VOLUME buttons |
| `mobile_open_url` | Deep link testing |

## Testing Workflows

### Exploratory Testing

```
/explore
```

Performs breadth-first exploration:
1. Lists available devices
2. Launches the app
3. Discovers all reachable screens
4. Evaluates design quality (touch targets, hierarchy)
5. Documents UX issues
6. Generates exploration report

### Flow Testing

```
/test-flow "User can complete checkout"
/test-flow specs/login-flow.md
```

Tests specific user flows:
1. Parses specification
2. Executes steps with screenshots
3. Validates expected state
4. Reports deviations with severity

### Accessibility Audit

```
/accessibility-audit
```

Checks mobile accessibility:
- Touch target sizes (iOS 44pt, Android 48dp)
- Accessibility labels
- Navigation order
- Color contrast
- Font scaling support

### Regression Testing

```
/regression-test qa-reports/test-cases/
```

Re-runs documented tests:
1. Loads test case files
2. Executes systematically
3. Compares against baselines
4. Generates pass/fail summary

## Report Output

Reports are generated in `qa-reports/` with the structure:

```
qa-reports/
├── 20250202-143025-explore/
│   ├── README.md
│   ├── screenshots/
│   │   ├── home-screen.png
│   │   ├── settings-screen.png
│   │   └── ...
│   ├── bugs/
│   │   ├── BUG-001-touch-target.md
│   │   └── ...
│   └── report.md
└── latest -> 20250202-143025-explore/
```

## Requirements

- **iOS Testing**: macOS with Xcode and iOS Simulators
- **Android Testing**: Android SDK with emulators or connected devices
- **Node.js**: For running the mobile-mcp server

## Troubleshooting

### MCP Server Not Connecting

```bash
# Test the server directly
npx -y @mobilenext/mobile-mcp@latest --help

# Verify environment
echo $ANDROID_HOME
xcrun simctl list devices
```

### No Devices Found

```bash
# iOS: Boot a simulator
xcrun simctl boot "iPhone 15 Pro"

# Android: Start an emulator
emulator -avd Pixel_7_API_34
```

### App Not Launching

- Verify the app identifier is correct
- Ensure the app is installed on the simulator/emulator
- Check that the device is booted and ready

## License

MIT
