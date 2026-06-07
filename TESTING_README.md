# GravityOS Beta - Complete Testing Guide

This guide provides comprehensive instructions for setting up, installing, and testing the GravityOS custom Android OS prototype on your development machine using the Android Emulator.

---

## Table of Contents

1. [System Requirements](#system-requirements)
2. [Prerequisites Installation](#prerequisites-installation)
3. [Quick Start](#quick-start)
4. [Detailed Setup Instructions](#detailed-setup-instructions)
5. [Testing Procedures](#testing-procedures)
6. [Troubleshooting](#troubleshooting)
7. [Frequently Asked Questions](#frequently-asked-questions)

---

## System Requirements

Before you begin, ensure your machine meets these requirements:

### Hardware
- **CPU**: Intel/AMD processor with virtualization support (VT-x/AMD-V)
- **RAM**: Minimum 8GB (16GB recommended for smooth operation)
- **Storage**: 25GB+ free disk space (for emulator image, AOSP source, and build artifacts)
- **Network**: High-speed internet connection (AOSP download is ~15-20GB)

### Software
- **Operating System**: Windows, macOS, or Linux
- **Android SDK**: Version 34 or higher
- **Java Development Kit (JDK)**: Version 11 or higher
- **Git**: For cloning and version control

### Optional but Highly Recommended
- **KVM/Hypervisor**: 
  - Linux: KVM enabled in BIOS
  - Windows: Hyper-V or Windows Subsystem for Android (WSA)
  - macOS: Built-in virtualization support
- **HAXM or Hypervisor Framework**: For hardware acceleration on macOS

---

## Prerequisites Installation

### 1. Install Java Development Kit (JDK)

**Windows/macOS:**
- Download from [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) or use [OpenJDK](https://adoptium.net/)
- Verify installation:
  ```bash
  java -version
  javac -version
  ```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install default-jdk
```

### 2. Install Android SDK

**Option A: Android Studio (Recommended)**
1. Download [Android Studio](https://developer.android.com/studio)
2. Run the installer and follow the setup wizard
3. Open SDK Manager (`Tools > SDK Manager`)
4. Install:
   - Android SDK Platform 34
   - Android SDK Build-Tools 34.x.x
   - Android Emulator
   - Android SDK Platform-Tools
   - System Image: `system-images;android-34;google_apis;x86_64`

**Option B: Command-line SDK Installation**
```bash
# Download commandlinetools (replace with latest version)
wget https://dl.google.com/android/repository/commandlinetools-linux-9123335_latest.zip
unzip commandlinetools-linux-9123335_latest.zip

# Set ANDROID_HOME
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Install SDK components
sdkmanager "platforms;android-34" "build-tools;34.0.0" "emulator" "platform-tools" "system-images;android-34;google_apis;x86_64"
```

### 3. Install Git

**Windows:**
- Download from [git-scm.com](https://git-scm.com/)

**macOS:**
```bash
brew install git
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get install git
```

### 4. Clone the GravityOS Repository

```bash
git clone https://github.com/ajsavage123/O.S-beta-.git
cd O.S-beta-
```

---

## Quick Start

For users who just want to get up and running quickly:

```bash
# 1. Navigate to project directory
cd O.S-beta-

# 2. Run environment setup
./gravityos/scripts/setup_environment.sh

# 3. Create Android Virtual Device
avdmanager create avd -n GravityOS_Pixel6 -k "system-images;android-34;google_apis;x86_64" --device "pixel_6"

# 4. Start the emulator
./gravityos/scripts/emulator_run.sh

# 5. Wait for device boot, then apply GravityOS modifications
./gravityos/scripts/apply_gravity_changes.sh

# 6. Run verification tests
./gravityos/scripts/verify_boot.sh
```

---

## Detailed Setup Instructions

### Step 1: Set Environment Variables

Ensure your system can find the Android SDK and Java tools.

**Linux/macOS (add to `~/.bashrc` or `~/.zshrc`):**
```bash
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
```

**Windows (Command Prompt):**
```cmd
setx ANDROID_HOME %USERPROFILE%\AppData\Local\Android\Sdk
setx PATH %PATH%;%ANDROID_HOME%\tools;%ANDROID_HOME%\tools\bin;%ANDROID_HOME%\platform-tools;%ANDROID_HOME%\emulator
```

Reload your terminal after setting environment variables.

### Step 2: Verify Android SDK Installation

```bash
# Check emulator is available
emulator -version

# Check ADB is available
adb version

# List available system images
sdkmanager --list_modules | grep system-images
```

### Step 3: Run Environment Setup Script

```bash
cd O.S-beta-
chmod +x gravityos/scripts/*.sh  # Make scripts executable (Linux/macOS)
./gravityos/scripts/setup_environment.sh
```

This script performs initial configuration and checks system requirements.

### Step 4: Create Android Virtual Device (AVD)

Create a Pixel 6 emulator with Android 14 (API 34):

```bash
avdmanager create avd \
  -n GravityOS_Pixel6 \
  -k "system-images;android-34;google_apis;x86_64" \
  --device "pixel_6"
```

**Expected Output:**
```
Auto-selecting single ABI x86_64
Created AVD 'GravityOS_Pixel6' based on Pixel 6, API 34, x86_64, Google APIs, with skin pixel_6
```

**Verify AVD was created:**
```bash
avdmanager list avd
```

### Step 5: Start the Emulator

```bash
./gravityos/scripts/emulator_run.sh
```

Or manually:
```bash
emulator -avd GravityOS_Pixel6 -no-snapshot-load -writable-system &
```

**Important Flags:**
- `-writable-system`: Allows modifications to system partition (required for branding changes)
- `-no-snapshot-load`: Starts fresh (use `-snapshot-load` to resume from saved state)
- `&`: Runs in background (Linux/macOS)

**Expected Output:**
```
emulator: Creating virtual device
emulator: Using core hw config from: ~/.android/avd/GravityOS_Pixel6.avd/hardware-qemu.ini
emulator: Emulator boot started
emulator: Cold boot; erasing disk cache
...
```

**Wait for full boot:** The emulator may take 2-5 minutes to fully boot (depends on your machine).

### Step 6: Verify Device is Connected

```bash
adb wait-for-device
adb devices
```

**Expected Output:**
```
List of attached devices
emulator-5554          device
```

### Step 7: Apply GravityOS Modifications

Once the emulator is fully booted:

```bash
./gravityos/scripts/apply_gravity_changes.sh
```

This script:
- Pushes branding assets to the system partition
- Applies resource overlays
- Configures system properties

### Step 8: Reboot the Emulator

```bash
adb reboot
adb wait-for-device
```

---

## Testing Procedures

### Automated Verification

Run the provided verification script:

```bash
./gravityos/scripts/verify_boot.sh
```

This checks:
- Device connectivity
- Boot animation presence
- GravityOS properties set correctly

### Manual Verification Checklist

Complete the following tests to ensure GravityOS is properly installed:

#### Test 1: System Boot ✓
- **Objective**: Verify emulator boots successfully
- **Steps**:
  1. Start emulator: `./gravityos/scripts/emulator_run.sh`
  2. Wait for boot to complete (look for home screen)
  3. Verify no crash dialogs appear
- **Expected Result**: Emulator reaches home screen without errors

#### Test 2: Home Screen & Branding ✓
- **Objective**: Verify custom wallpaper and launcher
- **Steps**:
  1. Press Home button or tap app drawer
  2. Observe the home screen
- **Expected Result**: 
  - Custom GravityOS wallpaper visible
  - Simplified launcher layout
  - Dark theme applied

#### Test 3: GravityOS Info Page ✓
- **Objective**: Verify custom settings page exists
- **Steps**:
  1. Open Settings app
  2. Navigate to: `About Phone`
  3. Look for "GravityOS Info" entry
  4. Tap and verify version shows "1.0"
- **Expected Result**: 
  - GravityOS Info page appears
  - Displays version and branding information

#### Test 4: Dark Theme Verification ✓
- **Objective**: Confirm dark theme is enforced
- **Steps**:
  1. Open Settings app
  2. Check theme setting: `Display > Theme`
  3. Navigate through various system apps (Clock, Calendar, etc.)
  4. Check SystemUI (status bar, quick settings)
- **Expected Result**: 
  - All UI elements use dark theme
  - No light theme option available or forced dark

#### Test 5: Quick Settings Layout ✓
- **Objective**: Verify simplified 4-tile quick settings
- **Steps**:
  1. Swipe down from top to open Quick Settings
  2. Observe tile layout
- **Expected Result**: 
  - Shows 4 tiles: WiFi, Bluetooth, Flashlight, Settings
  - Simplified layout (not the full Android grid)

#### Test 6: Build Properties ✓
- **Objective**: Verify system properties set
- **Steps**:
  ```bash
  adb shell cat /system/build.prop | grep -i gravity
  ```
- **Expected Result**: 
  - Output shows GravityOS branding properties
  - Example: `ro.product.brand=GravityOS`

#### Test 7: UI Rotation ✓
- **Objective**: Verify UI survives rotation
- **Steps**:
  1. Open a system app (Settings, Calendar, etc.)
  2. Rotate device (Ctrl+Left/Right in emulator or device setting)
  3. Verify no crashes
- **Expected Result**: 
  - UI rotates smoothly
  - No force-close dialogs
  - App remains responsive

#### Test 8: System Reboot ✓
- **Objective**: Verify changes persist after reboot
- **Steps**:
  1. Verify wallpaper is visible
  2. Reboot system: `adb reboot`
  3. Wait for boot completion
  4. Verify wallpaper and branding still present
- **Expected Result**: 
  - All modifications persist after reboot
  - No need to re-apply changes

### Test Results Table

Record your results in this table:

| ID | Test Case | Expected Result | Status | Notes |
|----|-----------|-----------------|--------|-------|
| 1  | System Boot | Emulator reaches home screen | [ ] Pass [ ] Fail | |
| 2  | Home Screen Load | Custom wallpaper and launcher visible | [ ] Pass [ ] Fail | |
| 3  | GravityOS Info | Settings > About Phone shows GravityOS Info v1.0 | [ ] Pass [ ] Fail | |
| 4  | Dark Theme | SystemUI and all apps use dark theme | [ ] Pass [ ] Fail | |
| 5  | Quick Settings | 4-tile simplified layout visible | [ ] Pass [ ] Fail | |
| 6  | Build Properties | `adb shell` shows GravityOS properties | [ ] Pass [ ] Fail | |
| 7  | UI Rotation | Screen rotation works without crashing | [ ] Pass [ ] Fail | |
| 8  | Reboot | Changes persist after system reboot | [ ] Pass [ ] Fail | |

---

## Troubleshooting

### Issue 1: "Command not found: emulator"
**Solution:**
```bash
# Ensure Android SDK tools are in PATH
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools
# Add to ~/.bashrc or ~/.zshrc for persistence
```

### Issue 2: "No system images found"
**Solution:**
```bash
# Install the required system image
sdkmanager "system-images;android-34;google_apis;x86_64"
```

### Issue 3: Emulator runs very slowly
**Solution:**
- Enable **KVM** (Linux), **Hyper-V** (Windows), or **HAXM** (macOS)
- Use `-accel on` flag: `emulator -avd GravityOS_Pixel6 -accel on`
- Increase allocated RAM in AVD configuration

### Issue 4: "adb: command not found"
**Solution:**
```bash
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

### Issue 5: "adb wait-for-device" times out
**Solution:**
1. Check if emulator is running: `emulator -list-avds`
2. Restart ADB server:
   ```bash
   adb kill-server
   adb start-server
   adb devices
   ```
3. Recreate AVD if corrupted:
   ```bash
   rm -rf ~/.android/avd/GravityOS_Pixel6*
   avdmanager create avd -n GravityOS_Pixel6 ...
   ```

### Issue 6: "Permission denied" when running scripts (Linux/macOS)
**Solution:**
```bash
chmod +x gravityos/scripts/*.sh
```

### Issue 7: Modifications not appearing after `apply_gravity_changes.sh`
**Solution:**
1. Verify device is fully booted: `adb shell getprop sys.boot_completed`
2. Ensure `-writable-system` flag was used
3. Reboot the emulator: `adb reboot`
4. Re-run script: `./gravityos/scripts/apply_gravity_changes.sh`

### Issue 8: Emulator crashes after applying changes
**Solution:**
1. Stop emulator: `adb emu kill`
2. Delete and recreate AVD:
   ```bash
   rm -rf ~/.android/avd/GravityOS_Pixel6*
   avdmanager create avd -n GravityOS_Pixel6 ...
   ```
3. Start fresh and apply changes again

---

## Frequently Asked Questions

### Q: Can I test GravityOS on my physical Android phone?
**A:** Not easily. GravityOS is a complete OS replacement that requires device-specific compilation and flashing. This project is designed for emulator-based development and testing. Physical device support would require:
- Full AOSP source compilation
- Device-specific kernel and drivers
- Bootloader unlock (may not be possible on all phones)
- Risk of bricking your device

### Q: How long does the emulator take to boot?
**A:** 
- Cold boot: 2-5 minutes (depends on your machine)
- Warm boot (snapshot): 10-30 seconds
- Use `-snapshot-save` and `-snapshot-load` for faster iterations

### Q: Why is the emulator so slow?
**A:** 
- Without hardware acceleration (KVM, HAXM, Hyper-V): Can be very slow
- Enable hardware acceleration in your system BIOS/settings
- Allocate more RAM to the emulator
- Use `-accel on` flag

### Q: Can I modify the branding/wallpaper?
**A:** Yes! Edit files in `gravityos/branding/` and `gravityos/overlays/` directories, then re-run `apply_gravity_changes.sh`

### Q: What happens if I want to restore the emulator to stock Android?
**A:** 
```bash
adb emu kill
rm -rf ~/.android/avd/GravityOS_Pixel6*
avdmanager create avd -n GravityOS_Pixel6 ...
emulator -avd GravityOS_Pixel6
```

### Q: How do I save the current state and resume later?
**A:** 
```bash
# Start with snapshot save enabled
emulator -avd GravityOS_Pixel6 -snapshot first_boot -snapshot-save

# Later, resume from snapshot
emulator -avd GravityOS_Pixel6 -snapshot-load
```

### Q: Can I run multiple emulators simultaneously?
**A:** Yes, but you need sufficient RAM. Each emulator requires 2GB+. Create separate AVDs with different names.

### Q: Where are logcat/debug logs?
**A:** 
```bash
# Real-time logs
adb logcat

# Filter by tag
adb logcat | grep GravityOS

# Save to file
adb logcat > /tmp/gravity_logs.txt
```

### Q: How do I uninstall GravityOS and start fresh?
**A:** 
```bash
avdmanager delete avd -n GravityOS_Pixel6
rm -rf ~/.android/avd/GravityOS_Pixel6*
# Then recreate using steps in Setup Instructions
```

---

## Advanced Testing

### Custom ROM Building (Optional)

To build the full ROM from AOSP source:

1. **Download AOSP source** (~80GB):
   ```bash
   mkdir -p ~/android/lineage
   cd ~/android/lineage
   repo init -u https://github.com/LineageOS/android.git -b lineage-21.0
   repo sync
   ```

2. **Apply GravityOS patches:**
   ```bash
   ./gravityos/scripts/apply_patches.sh ~/android/lineage
   ```

3. **Build the system image:**
   ```bash
   source build/envsetup.sh
   lunch gravityos-userdebug  # if configured
   make -j$(nproc)
   ```

4. **Flash to emulator:**
   ```bash
   fastboot flashall
   ```

---

## Support & Contribution

- **Issues**: Report bugs or request features on [GitHub Issues](https://github.com/ajsavage123/O.S-beta-)
- **Documentation**: See `gravityos/docs/` for additional documentation
- **Contributing**: Submit pull requests with improvements

---

## License

This project includes AOSP code governed by the [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0).

---

**Last Updated**: June 2026  
**GravityOS Version**: Beta 1.0  
**Android Version**: Android 14 (API 34)
