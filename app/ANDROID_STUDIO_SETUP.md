# Android Studio Setup for Flutter Development

## Step 1: Install Android Studio

1. **Download Android Studio:**
   - Visit: https://developer.android.com/studio
   - Download the latest stable version
   - Run the installer and follow setup wizard

2. **Install Required Components:**
   - Android SDK
   - Android SDK Platform-Tools
   - Android SDK Build-Tools
   - Android Emulator
   - Intel x86 Emulator Accelerator (HAXM installer)

## Step 2: Install Flutter Plugin

1. **Open Android Studio**
2. **Go to File → Settings** (or Android Studio → Preferences on Mac)
3. **Select Plugins** from left panel
4. **Search for "Flutter"** in marketplace
5. **Install Flutter plugin** (this will also install Dart plugin)
6. **Restart Android Studio**

## Step 3: Configure Flutter SDK

1. **Go to File → Settings → Languages & Frameworks → Flutter**
2. **Set Flutter SDK path:** `C:\flutter` (or your installation path)
3. **Click Apply and OK**

## Step 4: Open Your Project

1. **Open Android Studio**
2. **Click "Open an existing project"**
3. **Navigate to:** `d:\app`
4. **Select the folder and click OK**

## Step 5: Setup Android Emulator

### Create Virtual Device:
1. **Tools → AVD Manager**
2. **Click "Create Virtual Device"**
3. **Select Phone → Pixel 4** (recommended)
4. **Download system image:** API 33 (Android 13)
5. **Configure AVD:**
   - Name: `Pixel_4_API_33`
   - RAM: 2048 MB
   - Internal Storage: 6 GB
6. **Click Finish**

### Start Emulator:
1. **Click play button** next to your AVD
2. **Wait for emulator to boot** (first time takes longer)

## Step 6: Run Your App

1. **Open project in Android Studio**
2. **Wait for indexing to complete**
3. **Select your emulator** from device dropdown
4. **Click Run button** (green triangle) or press `Shift+F10`

## Step 7: Development Features

### Hot Reload:
- **Save file** or press `Ctrl+S` for hot reload
- **Changes appear instantly** in running app

### Debugging:
- **Set breakpoints** by clicking line numbers
- **Run in debug mode** with bug icon
- **Use debugger console** for variable inspection

### Code Assistance:
- **Auto-completion** with `Ctrl+Space`
- **Quick fixes** with `Alt+Enter`
- **Refactoring** with `Ctrl+Alt+Shift+T`

## Troubleshooting

### Common Issues:

1. **Gradle sync failed:**
   ```
   File → Invalidate Caches and Restart
   ```

2. **Flutter not found:**
   - Verify Flutter SDK path in settings
   - Ensure Flutter is in system PATH

3. **Emulator won't start:**
   - Enable Virtualization in BIOS
   - Install Intel HAXM
   - Increase RAM allocation

4. **Build errors:**
   ```
   flutter clean
   flutter pub get
   ```

### Performance Tips:
- **Increase IDE memory:** Help → Edit Custom VM Options
- **Enable hardware acceleration** for emulator
- **Close unused projects** to save resources
