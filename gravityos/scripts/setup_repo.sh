#!/bin/bash
# setup_repo.sh

set -e

WORKING_DIR=$(pwd)
AOSP_ROOT="${WORKING_DIR}/aosp"
MANIFEST_FILE="${WORKING_DIR}/gravityos/manifests/gravityos_minimal.xml"

mkdir -p "${AOSP_ROOT}"
cd "${AOSP_ROOT}"

echo "Initializing Repo with GravityOS minimal manifest..."
repo init -u https://android.googlesource.com/platform/manifest -b android-14.0.0_r1 --depth=1

# Symlink or copy our custom manifest
mkdir -p .repo/local_manifests
cp "${MANIFEST_FILE}" .repo/local_manifests/gravityos.xml

echo "Syncing projects... (this will take a long time and significant space)"
# repo sync -c -j4 --no-clone-bundle --no-tags

echo "Repo setup complete. Note: sync was skipped in this script to prevent environment overflow."
