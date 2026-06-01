# GravityOS Emulator Setup Guide

This guide describes how to set up the GravityOS demo environment using a standard Android Emulator.

## Prerequisites
- Android SDK (Platform Tools, Emulator, System Images)
- At least 8GB RAM
- 20GB+ Disk Space (for emulator image and cache)
- KVM enabled (recommended for performance)

## Step 1: Create the AVD
Use the `avdmanager` tool to create a Pixel 6 based AVD with Android 14 (API 34).

```bash
avdmanager create avd -n GravityOS_Pixel6 -k "system-images;android-34;google_apis;x86_64" --device "pixel_6"
```

## Step 2: Start the Emulator
Run the emulator using the provided script or the following command:

```bash
emulator -avd GravityOS_Pixel6 -no-snapshot-load -writable-system
```

*Note: `-writable-system` is required to apply branding changes to the system partition.*

## Step 3: Apply GravityOS Modifications
Once the device is booted (`adb wait-for-device`), run the application script:

```bash
./gravityos/scripts/apply_gravity_changes.sh
```

## Step 4: Verification
Follow the `testing_guide.md` to verify the installation.
