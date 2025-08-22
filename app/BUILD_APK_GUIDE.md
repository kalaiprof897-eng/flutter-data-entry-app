# Build APK Guide

## Prerequisites
- Flutter SDK installed and in PATH
- Android SDK configured
- Project dependencies installed

## Quick APK Build Commands

### Debug APK (for testing):
```powershell
cd d:\app
flutter build apk --debug
```
**Output location:** `build\app\outputs\flutter-apk\app-debug.apk`

### Release APK (optimized):
```powershell
cd d:\app
flutter build apk --release
```
**Output location:** `build\app\outputs\flutter-apk\app-release.apk`

### Split APKs by architecture (smaller size):
```powershell
cd d:\app
flutter build apk --split-per-abi
```
**Output locations:**
- `app-arm64-v8a-release.apk` (64-bit ARM)
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-x86_64-release.apk` (64-bit Intel)

## Build Process Steps

1. **Install dependencies:**
   ```powershell
   flutter pub get
   ```

2. **Clean previous builds:**
   ```powershell
   flutter clean
   ```

3. **Build APK:**
   ```powershell
   flutter build apk --release
   ```

4. **Locate APK:**
   - Navigate to: `d:\app\build\app\outputs\flutter-apk\`
   - File: `app-release.apk`

## APK Installation

### Install on connected device:
```powershell
flutter install
```

### Manual installation:
1. Transfer APK to Android device
2. Enable "Install from unknown sources"
3. Tap APK file to install

## Build Optimization

### Reduce APK size:
```powershell
# Split by architecture
flutter build apk --split-per-abi

# Enable obfuscation
flutter build apk --obfuscate --split-debug-info=build/debug-info
```

### Build for specific architecture:
```powershell
# ARM64 only (most modern devices)
flutter build apk --target-platform android-arm64

# ARM32 only (older devices)
flutter build apk --target-platform android-arm
```

## Troubleshooting

### Common build errors:

1. **Gradle build failed:**
   ```powershell
   cd android
   ./gradlew clean
   cd ..
   flutter clean
   flutter pub get
   flutter build apk
   ```

2. **SDK not found:**
   - Verify Android SDK path in Android Studio
   - Run: `flutter doctor -v`

3. **Dependencies conflict:**
   ```powershell
   flutter pub deps
   flutter pub upgrade
   ```

4. **Out of memory:**
   - Add to `android/gradle.properties`:
   ```
   org.gradle.jvmargs=-Xmx4g
   ```

## APK Information

### Check APK details:
```powershell
# APK size and contents
flutter build apk --analyze-size

# Build information
flutter build apk --verbose
```

### Expected APK size:
- **Debug APK:** ~40-60 MB
- **Release APK:** ~15-25 MB
- **Split APK (ARM64):** ~10-15 MB
