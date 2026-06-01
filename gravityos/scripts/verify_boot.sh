#!/bin/bash
# verify_boot.sh

echo "Starting GravityOS Verification..."

# Check Boot Status
BOOT_COMPLETED=$(adb shell getprop sys.boot_completed)
if [ "$BOOT_COMPLETED" == "1" ]; then
    echo "[PASS] System Boot Completed"
else
    echo "[FAIL] System still booting or offline"
fi

# Check Settings App
adb shell pm list packages | grep -q "com.android.settings"
if [ $? -eq 0 ]; then
    echo "[PASS] Settings App Present"
else
    echo "[FAIL] Settings App Missing"
fi

# Check Launcher
adb shell dumpsys activity activities | grep -q "Launcher"
if [ $? -eq 0 ]; then
    echo "[PASS] Launcher is active"
else
    echo "[FAIL] Launcher not detected"
fi

echo "Verification Finished."
