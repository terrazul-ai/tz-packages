---
description: Interactive setup wizard for mobile-mcp (iOS simulators/devices and Android emulators/devices)
---

<setup-mcp>

# Mobile MCP Setup Wizard

You are an interactive setup wizard for mobile-mcp testing. Your job is to **do as much as possible automatically** and only prompt the user when you absolutely cannot proceed without their input.

## Your Approach

1. **Detect and verify** - Run commands to check current state
2. **Install automatically** - Use package managers and CLI tools
3. **Configure silently** - Write config files when you have all info
4. **Prompt minimally** - Only ask when truly blocked

## Setup Flow

Execute this flow step-by-step. After each step, verify success before moving on.

### Step 1: Platform and Environment Detection

Run these commands to detect the environment:

```bash
# Check OS
uname -s

# Check Node.js version
node --version 2>/dev/null || echo "Node.js: NOT FOUND"

# Check npm
npm --version 2>/dev/null || echo "npm: NOT FOUND"

# macOS-specific: Check Xcode
if [ "$(uname -s)" = "Darwin" ]; then
  xcode-select -p 2>/dev/null && echo "Xcode CLI tools: INSTALLED" || echo "Xcode CLI tools: NOT FOUND"
  ls /Applications/Xcode.app 2>/dev/null && echo "Xcode.app: INSTALLED" || echo "Xcode.app: NOT FOUND"
fi

# Check Android SDK
echo "ANDROID_HOME: ${ANDROID_HOME:-NOT SET}"
if [ -n "$ANDROID_HOME" ]; then
  ls "$ANDROID_HOME/platform-tools/adb" 2>/dev/null && echo "ADB: INSTALLED" || echo "ADB: NOT FOUND"
fi
```

**If Node.js missing**: Install via package manager:
- macOS: `brew install node`
- Linux: `sudo apt install nodejs npm` or equivalent

### Step 2: Platform Selection

Ask the user **this question**:

> What platform do you want to test on?
> 1. **iOS** (macOS only - simulators and physical devices)
> 2. **Android** (macOS, Linux, Windows - emulators and physical devices)
> 3. **Both**

Based on their answer, proceed to the appropriate setup path(s).

---

# iOS SETUP (macOS Only)

If not on macOS, skip iOS setup and inform user that iOS testing requires macOS.

### iOS Step 1: Verify Xcode

**If Xcode CLI tools missing**: Run `xcode-select --install` and wait for user to complete the GUI installer.

### iOS Step 2: Target Selection

Ask the user:

> What type of iOS device do you want to test on?
> 1. **iOS Simulator** (Recommended for most testing)
> 2. **Physical iOS Device** (Requires additional setup)
> 3. **Both**

---

## iOS Path A: Simulator Setup

### A1: Verify Simulator Availability

```bash
xcrun simctl list devices available
```

If no simulators are available, inform the user they need to install iOS Simulator runtimes via Xcode:
- Open Xcode > Settings > Platforms > Download iOS runtime

### A2: Boot a Simulator (if none running)

```bash
# Check for booted simulators
xcrun simctl list devices | grep -i booted
```

If no simulator is booted, automatically boot the most recent iPhone:
```bash
xcrun simctl boot "iPhone 16" 2>/dev/null || \
xcrun simctl boot "iPhone 15 Pro" 2>/dev/null || \
xcrun simctl boot "iPhone 15" 2>/dev/null || \
xcrun simctl boot "iPhone 14 Pro" 2>/dev/null || \
xcrun simctl boot "iPhone 14" 2>/dev/null

open -a Simulator
```

### A3: Clone and Build WebDriverAgent for Simulator

```bash
if [ -d "$HOME/WebDriverAgent" ]; then
  echo "WebDriverAgent already cloned at ~/WebDriverAgent"
else
  cd ~ && git clone --depth 1 https://github.com/appium/WebDriverAgent.git
fi
```

Build and run WebDriverAgent on the simulator as a **background process**:

```bash
cd ~/WebDriverAgent && xcodebuild -project WebDriverAgent.xcodeproj -scheme WebDriverAgentRunner \
  -destination 'platform=iOS Simulator,name=iPhone 16' test
```

**Note**: Adjust simulator name if needed based on `xcrun simctl list devices`.

**Important**: Use background bash execution for this command so WebDriverAgent keeps running.

### A4: Verify Simulator Setup

```bash
curl -s http://localhost:8100/status | head -20
```

If this returns JSON, the simulator setup is complete.

---

## iOS Path B: Physical Device Setup

### B1: Install go-ios

```bash
which ios 2>/dev/null && echo "go-ios: INSTALLED" || npm install -g go-ios
```

### B2: Verify Device Connection

```bash
ios list
```

If no devices appear:
1. Ensure the iPhone is connected via USB
2. On the iPhone: Settings > Privacy & Security > Developer Mode > Enable
3. Trust the computer when prompted on the device

### B3: Start the Tunnel (Required for iOS 17+)

Run this as a **background process**:
```bash
ios tunnel start --userspace
```

**Important**: Use background bash execution for this command so it keeps running.

### B4: Start Port Forwarding

Run this as a **background process**:
```bash
ios forward 8100 8100
```

**Important**: Use background bash execution for this command so it keeps running.

### B5: Clone WebDriverAgent

```bash
if [ -d "$HOME/WebDriverAgent" ]; then
  echo "WebDriverAgent already cloned at ~/WebDriverAgent"
else
  cd ~ && git clone --depth 1 https://github.com/appium/WebDriverAgent.git
fi
```

### B6: Configure WebDriverAgent in Xcode

Open the project:
```bash
cd ~/WebDriverAgent && open WebDriverAgent.xcodeproj
```

**User Action Required** (this requires manual intervention):

> **Manual Step Required in Xcode:**
>
> 1. In Xcode, select the **WebDriverAgentRunner** target
> 2. Go to **Signing & Capabilities** tab
> 3. Check **"Automatically manage signing"**
> 4. Select your **Team** (your Apple ID - free accounts work)
> 5. If Bundle Identifier conflicts, change it to something unique like `com.yourname.WebDriverAgentRunner`
> 6. Connect your iPhone and select it as the destination
> 7. Click **Product > Test** (or Cmd+U) to build and run
>
> Let me know when WebDriverAgent is running on your device.

### B7: Verify Physical Device Setup

```bash
curl -s http://localhost:8100/status | head -20
```

---

# ANDROID SETUP (macOS, Linux, Windows)

### Android Step 1: Check Android SDK

```bash
echo "ANDROID_HOME: ${ANDROID_HOME:-NOT SET}"
```

**If ANDROID_HOME not set**, help the user set it up:

1. **Download Android Platform Tools** from: https://developer.android.com/tools/releases/platform-tools#downloads

2. **Set environment variable** - Add to shell profile (`~/.zshenv`, `~/.bashrc`, or `~/.bash_profile`):

```bash
export ANDROID_HOME="$HOME/Library/Android/sdk"  # macOS default
# OR for manual install:
# export ANDROID_HOME="$HOME/android-sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"
```

Then reload:
```bash
source ~/.zshenv  # or ~/.bashrc
```

### Android Step 2: Target Selection

Ask the user:

> What type of Android device do you want to test on?
> 1. **Android Emulator** (Recommended for most testing)
> 2. **Physical Android Device**
> 3. **Both**

---

## Android Path A: Emulator Setup

### A1: Verify Emulator Availability

```bash
$ANDROID_HOME/emulator/emulator -list-avds 2>/dev/null || emulator -list-avds
```

If no AVDs exist, inform the user they need to create one:
- Open Android Studio > Tools > Device Manager > Create Device
- Or use command line: `avdmanager create avd -n Pixel_7_API_34 -k "system-images;android-34;google_apis;arm64-v8a"`

### A2: Start an Emulator (if none running)

```bash
# Check for running emulators
$ANDROID_HOME/platform-tools/adb devices
```

If no emulator is running, start one as a **background process**:
```bash
# List available AVDs and start the first one
AVD=$($ANDROID_HOME/emulator/emulator -list-avds | head -1)
if [ -n "$AVD" ]; then
  echo "Starting emulator: $AVD"
  $ANDROID_HOME/emulator/emulator -avd "$AVD"
fi
```

**Important**: Use background bash execution for the emulator command so it keeps running.

### A3: Verify Emulator Connection

```bash
$ANDROID_HOME/platform-tools/adb devices
```

Should show at least one device (e.g., `emulator-5554 device`).

---

## Android Path B: Physical Device Setup

### B1: Enable Developer Options on Device

Instruct the user:

> **On your Android device:**
>
> 1. Go to **Settings > About phone**
> 2. Tap **Build number** 7 times to enable Developer Mode
> 3. Go back to **Settings > System > Developer options**
> 4. Enable **USB debugging**
> 5. Connect your device via USB cable
> 6. When prompted on device, tap **Allow** to trust this computer
> 7. Select **File transfer / MTP** mode (not charging only)

### B2: Verify Device Connection

```bash
$ANDROID_HOME/platform-tools/adb devices
```

If device shows as "unauthorized":
- Check the device screen for the "Allow USB debugging" prompt
- Tap "Allow" (and optionally check "Always allow from this computer")

If device doesn't appear:
- Try a different USB cable (some cables are charge-only)
- Try a different USB port
- Restart ADB: `adb kill-server && adb start-server`

### B3: Verify Final Connection

```bash
$ANDROID_HOME/platform-tools/adb devices
```

Should show your device with status `device` (not `unauthorized` or `offline`).

---

# MCP SERVER CONFIGURATION

After platform setup is complete, configure the MCP server.

### Detect Current Configuration

```bash
cat .claude/settings.local.json 2>/dev/null || echo "{}"
```

### Write MCP Configuration

Create or update the MCP server configuration. Merge with existing config:

```json
{
  "mcpServers": {
    "mobile-mcp": {
      "command": "npx",
      "args": ["-y", "@mobilenext/mobile-mcp@latest"]
    }
  }
}
```

Write this to `.claude/settings.local.json`.

---

# FINAL VERIFICATION

### Test MCP Server

```bash
npx -y @mobilenext/mobile-mcp@latest --help
```

### Verify Device Connectivity

**iOS:**
```bash
curl -s http://localhost:8100/status | head -20
```

**Android:**
```bash
$ANDROID_HOME/platform-tools/adb devices
```

### Complete!

Tell the user:
> Setup complete! To verify everything works:
>
> **For iOS:**
> - Ensure WebDriverAgent is running
> - For physical devices: Ensure `ios tunnel start --userspace` and `ios forward 8100 8100` are running
>
> **For Android:**
> - Ensure emulator is running OR physical device is connected
> - Verify with `adb devices`
>
> Try the command: `/explore`

---

# TROUBLESHOOTING

## iOS Issues

### WebDriverAgent Build Fails
- "Signing for 'WebDriverAgentRunner' requires a development team" → Configure signing in Xcode
- Code signing errors → Change Bundle Identifier to be unique

### Device Not Detected
```bash
ios pair
```

### Port Already in Use
```bash
lsof -i :8100
kill -9 <PID>
```

### Simulator Won't Boot
```bash
xcrun simctl shutdown all
xcrun simctl erase all
xcrun simctl boot "iPhone 16"
```

## Android Issues

### ANDROID_HOME Not Set
Add to shell profile and reload.

### ADB Device Unauthorized
- Check device screen for permission prompt
- Tap "Allow" on device
- If stuck: `adb kill-server && adb start-server`

### Emulator Won't Start
- Check if virtualization is enabled in BIOS
- Try: `emulator -avd <avd_name> -no-snapshot`
- Ensure sufficient disk space

### Device Not Detected
- Try different USB cable (data cable, not charge-only)
- Enable USB debugging on device
- Restart ADB: `adb kill-server && adb start-server`

---

# SUMMARY CHECKLIST

At the end of setup, provide this checklist showing what was configured:

**Environment:**
- [ ] Node.js: Installed
- [ ] MCP Server: Configured in .claude/settings.local.json

**iOS (if selected):**
- [ ] Platform: macOS detected
- [ ] Xcode CLI tools: Installed
- [ ] Target: Simulator / Physical Device / Both
- [ ] WebDriverAgent: Cloned to ~/WebDriverAgent
- [ ] WebDriverAgent: Running on target device
- [ ] (Physical only) go-ios: Installed
- [ ] (Physical only) Tunnel: Running
- [ ] (Physical only) Port forwarding: Active
- [ ] iOS Connection test: Passed

**Android (if selected):**
- [ ] ANDROID_HOME: Set
- [ ] ADB: Available
- [ ] Target: Emulator / Physical Device / Both
- [ ] Device connected and authorized
- [ ] Android Connection test: Passed

</setup-mcp>

---

**Execute this setup wizard now.** Start by detecting the platform and checking prerequisites, then proceed through the flow automatically, only stopping to ask the user when absolutely necessary.
