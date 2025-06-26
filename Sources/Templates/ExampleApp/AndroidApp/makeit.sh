#!/usr/bin/env bash
set -e

# Start timing the build process
start_time=$(date +%s)

# Use Windows adb.exe from WSL
ADB="/mnt/c/Users/ipado/Downloads/platform-tools-latest-windows/platform-tools/adb.exe"
  
# rm -rf __build

kotlinc   -cp "$ANDROID_SDK_ROOT/platforms/android-33/android.jar" -d __build/obj   java/com/example/MainActivity.kt

NDK=$ANDROID_SDK_ROOT/ndk/25.2.9519653
CLANG=$NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi23-clang

mkdir -p __build/apk/lib/armeabi-v7a

$CLANG -shared -fPIC \
  -o __build/apk/lib/armeabi-v7a/libnative_lib.so \
  jni/native_lib.c \
  -llog

d8 --min-api 26 --no-desugaring --output __build/apk/ $(find __build/obj -name '*.class')

aapt package -f   -M AndroidManifest.xml   -S res   -I "$ANDROID_SDK_ROOT/platforms/android-33/android.jar"   -F __build/minapp.unsigned.apk   __build/apk/

## Repacking app with dex files

# Unzip into a temp dir
rm -rf __build/tmp_apk
mkdir -p __build/tmp_apk
unzip -q __build/minapp.unsigned.apk -d __build/tmp_apk

# Copy in all .dex files
cp __build/apk/*.dex __build/tmp_apk/

# Re-create the unsigned APK with code and assets
cd __build/tmp_apk
zip -q -r ../minapp.unsigned.apk ./*
cd -

## End of repacking app with dex files


zipalign -f -p 4 \
  __build/minapp.unsigned.apk \
  __build/minapp.aligned.apk

# rm ./keystore.jks

# keytool -genkeypair -keystore keystore.jks -alias androidkey \
#   -dname "CN=you, OU=you, O=you, L=Paris, S=France, C=FR" \
#   -validity 10000 -keyalg RSA -keysize 2048 \
#   -storepass android -keypass android

zip -g __build/minapp.aligned.apk __build/apk/classes.dex \
                          __build/apk/lib/armeabi-v7a/libnative_lib.so

apksigner sign --ks keystore.jks \
  --ks-key-alias androidkey \
  --ks-pass pass:android \
  --key-pass pass:android \
  --out __build/minapp.apk \
  __build/minapp.aligned.apk

$ADB devices

$ADB install -r __build/minapp.apk

# Calculate and display the total build time
end_time=$(date +%s)
build_duration=$((end_time - start_time))
minutes=$((build_duration / 60))
seconds=$((build_duration % 60))
milliseconds=$((build_duration * 1000))
echo "Build completed in ${minutes}m ${seconds}s ${milliseconds}ms"
