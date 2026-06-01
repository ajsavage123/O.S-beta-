#!/bin/bash
# apply_patches.sh

AOSP_ROOT="aosp" # Adjust to your AOSP root directory

echo "Applying patches to AOSP source tree at $AOSP_ROOT..."

# SystemUI Patches
cd $AOSP_ROOT/frameworks/base
patch -p1 < ../../gravityos/patches/systemui_qs_layout.patch

# Settings Patches
cd ../../packages/apps/Settings
patch -p1 < ../../../gravityos/patches/settings_about_page.patch

# Launcher Patches
cd ../Launcher3
patch -p1 < ../../../gravityos/patches/launcher_simplified_dark.patch

# Overlays
echo "Copying overlays..."
cp -r ../../../gravityos/overlays/* ../../../$AOSP_ROOT/

echo "Patches applied successfully."
