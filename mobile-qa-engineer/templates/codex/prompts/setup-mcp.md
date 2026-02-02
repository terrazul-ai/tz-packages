# Mobile MCP Setup Wizard

Interactive setup wizard for mobile-mcp (iOS simulators/devices and Android emulators/devices).

## Usage

```
/setup-mcp
```

## Overview

This wizard **automates mobile testing setup**. It does as much as possible automatically and only prompts when truly blocked.

## Approach

1. **Detect and verify** - Run commands to check current state
2. **Install automatically** - Use package managers and CLI tools
3. **Configure silently** - Write config files when you have all info
4. **Prompt minimally** - Only ask when truly blocked

## Setup Flow

### Step 1: Environment Detection

```bash
uname -s                                    # Check OS
node --version                              # Node.js 18+
echo "ANDROID_HOME: ${ANDROID_HOME:-NOT SET}"
# macOS only:
xcode-select -p                             # Xcode CLI tools
```

### Step 2: Platform Selection

Ask the user:
- **iOS** (macOS only)
- **Android** (macOS, Linux, Windows)
- **Both**

---

# iOS SETUP (macOS Only)

### iOS Target Selection
- **iOS Simulator** (Recommended)
- **Physical iOS Device**
- **Both**

## iOS Simulator Setup

```bash
# List simulators
xcrun simctl list devices available

# Boot simulator
xcrun simctl boot "iPhone 16" || xcrun simctl boot "iPhone 15 Pro"
open -a Simulator

# Clone WebDriverAgent
cd ~ && git clone --depth 1 https://github.com/appium/WebDriverAgent.git

# Run WebDriverAgent (as background process)
cd ~/WebDriverAgent && xcodebuild -project WebDriverAgent.xcodeproj -scheme WebDriverAgentRunner \
  -destination 'platform=iOS Simulator,name=iPhone 16' test

# Verify
curl -s http://localhost:8100/status
```

**Important**: Run the xcodebuild command as a background bash process so WebDriverAgent keeps running.

## iOS Physical Device Setup

```bash
# Install go-ios
npm install -g go-ios

# List devices
ios list

# Start tunnel (as background process)
ios tunnel start --userspace

# Port forwarding (as background process)
ios forward 8100 8100
```

**Important**: Run both `ios tunnel` and `ios forward` as background bash processes so they keep running.

```bash
# Clone WebDriverAgent
cd ~ && git clone --depth 1 https://github.com/appium/WebDriverAgent.git

# Open in Xcode for signing
open ~/WebDriverAgent/WebDriverAgent.xcodeproj
```

**Manual Xcode Step:**
1. Select WebDriverAgentRunner target
2. Enable "Automatically manage signing"
3. Select Team (Apple ID)
4. Change Bundle Identifier if needed
5. Select device, run Product > Test

---

# ANDROID SETUP

### Android Step 1: Check SDK

```bash
echo "ANDROID_HOME: ${ANDROID_HOME:-NOT SET}"
```

If not set, add to shell profile:
```bash
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"
```

### Android Target Selection
- **Android Emulator** (Recommended)
- **Physical Android Device**
- **Both**

## Android Emulator Setup

```bash
# List AVDs
$ANDROID_HOME/emulator/emulator -list-avds

# Start emulator (as background process)
AVD=$($ANDROID_HOME/emulator/emulator -list-avds | head -1)
$ANDROID_HOME/emulator/emulator -avd "$AVD"

# Verify
$ANDROID_HOME/platform-tools/adb devices
```

**Important**: Run the emulator command as a background bash process so it keeps running.

## Android Physical Device Setup

**On the device:**
1. Settings > About phone > Tap Build number 7 times
2. Settings > System > Developer options > Enable USB debugging
3. Connect via USB, tap "Allow" when prompted
4. Select File transfer / MTP mode

```bash
# Verify
$ANDROID_HOME/platform-tools/adb devices
```

---

# MCP Configuration

### Codex (~/.codex/config.toml)

```toml
[mcp_servers.mobile-mcp]
command = "npx"
args = ["-y", "@mobilenext/mobile-mcp@latest"]
```

---

# Verification

```bash
# Test MCP server
npx -y @mobilenext/mobile-mcp@latest --help

# iOS
curl -s http://localhost:8100/status

# Android
$ANDROID_HOME/platform-tools/adb devices
```

Then run `/explore` to verify full setup.

---

# Troubleshooting

## iOS Issues
- **WebDriverAgent build fails**: Configure signing in Xcode
- **Device not detected**: Run `ios pair`
- **Port in use**: `lsof -i :8100` then `kill -9 <PID>`

## Android Issues
- **ANDROID_HOME not set**: Add to shell profile
- **Device unauthorized**: Check device for permission prompt
- **Device not detected**: Try different USB cable, restart ADB

---

# Summary Checklist

**Environment:**
- [ ] Node.js: Installed
- [ ] MCP Server: Configured

**iOS (if selected):**
- [ ] Xcode CLI tools: Installed
- [ ] WebDriverAgent: Running
- [ ] (Physical) go-ios, tunnel, port forwarding: Active

**Android (if selected):**
- [ ] ANDROID_HOME: Set
- [ ] ADB: Available
- [ ] Device connected and authorized
