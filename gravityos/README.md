# GravityOS Demo Project

This project contains a minimal custom Android OS prototype based on AOSP (Android 14).

## Project Structure
- `gravityos/branding/`: Boot animation and wallpaper assets.
- `gravityos/overlays/`: Android resource overlays for SystemUI, Settings, and Launcher.
- `gravityos/patches/`: Source code patches for framework and app modifications.
- `gravityos/manifests/`: Minimal AOSP manifest for building a lightweight image.
- `gravityos/scripts/`: Build and execution scripts.
- `gravityos/docs/`: Build and testing documentation.
- `gravityos/emulator/`: Verification results and screenshots.
- `gravityos/apps/`: Custom GravityOS applications (e.g., GravityBrowser).

## Quick Start
1.  **Environment Setup**: Run `./gravityos/scripts/setup_environment.sh`.
2.  **Mock Build/Modification**: Use `./gravityos/scripts/apply_patches.sh` to see how changes are applied to a source tree.
3.  **Emulator**: Refer to `gravityos/docs/emulator_setup.md` to run the demo.

## Key Features
- **Dark Theme**: Forced dark theme for Launcher and SystemUI.
- **Branding**: "GravityOS Beta" boot animation placeholder and custom wallpaper.
- **Settings**: New "GravityOS Info" page under About Phone.
- **Quick Settings**: Simplified 4-tile layout (WiFi, Bluetooth, Flashlight, Settings).

## Known Issues
- Emulation without hardware acceleration (KVM) is extremely slow.
- Some branding changes require a system remount on stock images.
