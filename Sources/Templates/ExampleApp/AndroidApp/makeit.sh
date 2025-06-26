#!/usr/bin/env bash
set -e

# Start timing the build process
start_time=$(date +%s)

ADB="/mnt/c/Users/ipado/Downloads/platform-tools-latest-windows/platform-tools/adb.exe"

# Detect Android SDK location
detect_android_sdk() {
    # Check if ANDROID_SDK_ROOT is already set
    if [ -n "$ANDROID_SDK_ROOT" ] && [ -d "$ANDROID_SDK_ROOT" ]; then
        echo "Using ANDROID_SDK_ROOT from environment: $ANDROID_SDK_ROOT"
        return 0
    fi
    
    # Try common locations
    local possible_locations=(
        "$HOME/Android/Sdk"
        "$HOME/Library/Android/sdk"
        "/usr/local/lib/android/sdk"
        "/mnt/c/Users/$USER/AppData/Local/Android/Sdk"
        "/mnt/c/Android/Sdk"
    )
    
    for loc in "${possible_locations[@]}"; do
        if [ -d "$loc" ]; then
            export ANDROID_SDK_ROOT="$loc"
            echo "Found Android SDK at: $ANDROID_SDK_ROOT"
            return 0
        fi
    done
    
    echo "Could not find Android SDK. Please set ANDROID_SDK_ROOT environment variable."
    exit 1
}

# Detect Android SDK
detect_android_sdk

echo "Using ADB at: $ADB"

# Create a temporary build directory in WSL native filesystem
TEMP_BUILD_DIR="$HOME/android_project"
echo "Creating temporary build directory at: $TEMP_BUILD_DIR"
rm -rf "$TEMP_BUILD_DIR"
mkdir -p "$TEMP_BUILD_DIR"

# Copy project files to WSL native filesystem
echo "Copying project files to WSL native filesystem..."
cp -r * "$TEMP_BUILD_DIR/"

# Change to the temporary directory
cd "$TEMP_BUILD_DIR"

# Clean Gradle
rm -rf .gradle
rm -rf build
./gradlew --stop

# Build the project with Gradle
./gradlew --no-daemon clean assembleDebug

# Copy the APK back to the original location
mkdir -p ../build/outputs/apk/debug/
cp build/outputs/apk/debug/ExampleApp-debug.apk ../build/outputs/apk/debug/

echo "Build completed successfully! APK is at build/outputs/apk/debug/ExampleApp-debug.apk"
echo "To install on a device, connect it and run:"
echo "$ADB install -r build/outputs/apk/debug/ExampleApp-debug.apk"

# Uninstall previous version if exists
echo "Uninstalling previous version if it exists..."
$ADB uninstall com.example || true

echo "Installing new version..."
$ADB install -r build/outputs/apk/debug/ExampleApp-debug.apk

# Calculate and display the total build time
end_time=$(date +%s)
build_duration=$((end_time - start_time))
minutes=$((build_duration / 60))
seconds=$((build_duration % 60))
echo "Build completed in ${minutes}m ${seconds}s"
