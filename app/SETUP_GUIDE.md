# Flutter Setup Guide

## Installing Flutter

### Windows Installation:

1. **Download Flutter SDK:**
   - Go to https://flutter.dev/docs/get-started/install/windows
   - Download the latest stable release
   - Extract to `C:\flutter` (or your preferred location)

2. **Add Flutter to PATH:**
   - Open System Properties → Advanced → Environment Variables
   - Add `C:\flutter\bin` to your PATH variable
   - Restart your command prompt/PowerShell

3. **Install Dependencies:**
   ```powershell
   # Check if Flutter is working
   flutter --version
   
   # Install dependencies for this project
   cd d:\app
   flutter pub get
   ```

4. **Setup Android Development:**
   - Install Android Studio from https://developer.android.com/studio
   - Install Android SDK and accept licenses:
   ```powershell
   flutter doctor --android-licenses
   ```

5. **Verify Installation:**
   ```powershell
   flutter doctor
   ```

## Running the Data Entry App

### Option 1: Using Android Emulator
```powershell
cd d:\app
flutter run
```

### Option 2: Using Physical Device
1. Enable Developer Options and USB Debugging on your Android device
2. Connect via USB
3. Run: `flutter run`

### Option 3: Web Version (for testing)
```powershell
cd d:\app
flutter run -d web
```

## Troubleshooting

### Common Issues:

1. **"flutter command not found"**
   - Ensure Flutter is in your PATH
   - Restart terminal after adding to PATH

2. **Android licenses not accepted**
   - Run: `flutter doctor --android-licenses`
   - Accept all licenses

3. **No devices available**
   - Start Android emulator from Android Studio
   - Or connect physical device with USB debugging

4. **Build errors**
   - Run: `flutter clean && flutter pub get`
   - Check `flutter doctor` for missing dependencies

## Alternative: Online Development

If you can't install Flutter locally, you can use:
- **DartPad**: https://dartpad.dev (for testing Dart code)
- **FlutterFlow**: https://flutterflow.io (visual Flutter builder)
- **Replit**: https://replit.com (online Flutter environment)

## Project Features

Once running, you'll have access to:
- ✅ Add/Edit data entries with validation
- ✅ Search and filter functionality  
- ✅ SQLite local storage
- ✅ Export/Import (JSON/CSV)
- ✅ Modern Material Design UI
- ✅ Full CRUD operations
