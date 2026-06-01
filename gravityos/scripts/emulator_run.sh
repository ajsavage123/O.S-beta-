#!/bin/bash
# emulator_run.sh

AVD_NAME="GravityOS_Pixel6"
EMULATOR_PATH="/opt/android-sdk/emulator/emulator"

# Check if AVD exists, if not create it
if ! "$EMULATOR_PATH" -list-avds | grep -q "$AVD_NAME"; then
    echo "Creating AVD $AVD_NAME..."
    echo "no" | /opt/android-sdk/cmdline-tools/latest/bin/avdmanager create avd -n "$AVD_NAME" -k "system-images;android-34;google_apis;x86_64" --device "pixel_6"
fi

echo "Starting emulator $AVD_NAME in headless mode..."
"$EMULATOR_PATH" -avd "$AVD_NAME" -no-window -no-audio -no-boot-anim -gpu off &

echo "Waiting for emulator to boot..."
adb wait-for-device
echo "Emulator connected."
