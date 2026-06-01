# GravityOS Build Guide (Minimal AOSP)

This guide provides instructions for building the full GravityOS image from source.

## Environment Setup
Follow the `setup_environment.sh` script to install dependencies.

## Syncing Source
1. Initialize the repo:
   ```bash
   repo init -u https://android.googlesource.com/platform/manifest -b android-14.0.0_r1 --depth=1
   ```
2. Add GravityOS local manifest:
   ```bash
   cp gravityos/manifests/gravityos_minimal.xml .repo/local_manifests/
   ```
3. Sync:
   ```bash
   repo sync -c -j$(nproc)
   ```

## Applying Modifications
Run the patch script to apply source-level changes:
```bash
./gravityos/scripts/apply_patches.sh
```

## Compilation
1. Initialize build environment:
   ```bash
   source build/envsetup.sh
   ```
2. Select target:
   ```bash
   lunch sdk_phone_x86_64-userdebug
   ```
3. Build:
   ```bash
   m -j$(nproc)
   ```

## Known Issues
- **Performance**: Emulator performance is degraded without KVM.
- **Hardware Support**: This build is for x86_64 emulator ONLY. No physical device support.
- **Storage**: Full build requires ~300GB of disk space.
- **Boot Animation**: Custom animation may require manual remount if system is not built with the asset integrated.
