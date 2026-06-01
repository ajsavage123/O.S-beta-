# GravityOS Testing Guide

This document outlines the test cases and verification steps for the GravityOS Demo.

## Test Checklist

| ID | Test Case | Expected Result | Status |
|----|-----------|-----------------|--------|
| 1  | System Boot | Emulator reaches the lock screen/home screen. | [ ] |
| 2  | Home Screen Load | Default launcher is visible with GravityOS wallpaper. | [ ] |
| 3  | GravityOS Info | Settings -> About Phone -> GravityOS Info shows version 1.0. | [ ] |
| 4  | UI Rotation | UI survives rotation without crashing. | [ ] |
| 5  | Dark Theme | SystemUI and Launcher default to Dark Theme. | [ ] |
| 6  | Reboot | System successfully reboots and retains changes. | [ ] |

## Automated Verification Script
You can run the basic verification script to check boot status:

```bash
./gravityos/scripts/verify_boot.sh
```

## Manual Verification Steps
1. **Check Branding**:
   - `adb shell cat /system/build.prop | grep "gravity"`
2. **Check Settings**:
   - Navigate to `Settings > About Phone`.
   - Verify `GravityOS Info` entry exists.
3. **Check Launcher**:
   - Press the Home button.
   - Verify the simplified layout and dark background.
