# Quick Start Commands

## Essential Commands

### Initial Setup:
```powershell
# Navigate to project
cd d:\app

# Install dependencies
flutter pub get

# Check Flutter installation
flutter doctor
```

### Running the App:
```powershell
# List available devices
flutter devices

# Run on any available device
flutter run

# Run on specific device
flutter run -d <device-id>

# Run on web browser
flutter run -d web
```

### Development Workflow:
```powershell
# While app is running:
r     # Hot reload (fast refresh)
R     # Hot restart (full restart)
d     # Open DevTools
q     # Quit app

# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

### Android Studio Shortcuts:
- **Ctrl+F5** - Run without debugging
- **Shift+F10** - Run with debugging
- **Ctrl+Shift+F10** - Run tests
- **Ctrl+S** - Save and hot reload

## Three Development Paths:

### Path 1: Android Studio (Full IDE)
1. Install Android Studio + Flutter plugin
2. Open project: `d:\app`
3. Create AVD emulator
4. Click Run button

### Path 2: DartPad Testing
1. Visit: https://dartpad.dev
2. Copy code from `DARTPAD_TESTING.md`
3. Test individual components
4. Validate logic before full build

### Path 3: Command Line + Device
1. Connect Android device via USB
2. Enable USB debugging
3. Run: `flutter run`
4. Use any text editor for coding

## Troubleshooting Quick Fixes:
```powershell
# Flutter not recognized
flutter --version

# Dependencies issues
flutter clean && flutter pub get

# Android licenses
flutter doctor --android-licenses

# Emulator won't start
flutter emulators --launch <emulator-name>
```
