# Device & Emulator Setup Guide

## Option 1: Android Emulator (Recommended for Development)

### Prerequisites:
- Android Studio installed
- Flutter SDK configured
- Hardware acceleration enabled

### Create Android Virtual Device (AVD):

1. **Open Android Studio**
2. **Tools → AVD Manager**
3. **Click "Create Virtual Device"**

### Recommended Configurations:

#### For Development Testing:
- **Device:** Pixel 4 or Pixel 6
- **API Level:** 33 (Android 13) or 34 (Android 14)
- **RAM:** 2048 MB
- **Internal Storage:** 6 GB
- **Graphics:** Hardware - GLES 2.0

#### For Performance Testing:
- **Device:** Pixel 7 Pro
- **API Level:** 34 (Android 14)
- **RAM:** 4096 MB
- **Internal Storage:** 8 GB

### Start Emulator:
```powershell
# From command line
flutter emulators --launch <emulator_id>

# Or from Android Studio
# AVD Manager → Click Play button
```

### Emulator Performance Tips:
- **Enable hardware acceleration** in BIOS
- **Allocate sufficient RAM** (minimum 2GB)
- **Use SSD storage** for better performance
- **Close other applications** while running emulator

## Option 2: Physical Android Device

### Enable Developer Options:
1. **Settings → About Phone**
2. **Tap "Build Number" 7 times**
3. **Developer Options will appear in Settings**

### Enable USB Debugging:
1. **Settings → Developer Options**
2. **Enable "USB Debugging"**
3. **Enable "Install via USB"**
4. **Enable "USB Debugging (Security Settings)"**

### Connect Device:
1. **Connect via USB cable**
2. **Allow USB debugging** when prompted
3. **Verify connection:**
   ```powershell
   flutter devices
   ```

### Device Requirements:
- **Android 5.0+** (API level 21+)
- **ARM64 or x86_64 architecture**
- **Minimum 2GB RAM** (4GB recommended)
- **Minimum 8GB storage** (16GB recommended)

## Option 3: Web Browser (For Testing UI)

### Enable Web Support:
```powershell
flutter config --enable-web
```

### Run on Web:
```powershell
cd d:\app
flutter run -d web
```

### Supported Browsers:
- **Chrome** (recommended)
- **Edge**
- **Firefox**
- **Safari** (macOS only)

### Web Limitations:
- No SQLite database (uses IndexedDB)
- Limited file system access
- Some plugins may not work

## Running Your Data Entry App

### Check Available Devices:
```powershell
flutter devices
```

### Run on Specific Device:
```powershell
# Run on emulator
flutter run -d emulator-5554

# Run on physical device
flutter run -d <device-id>

# Run on web
flutter run -d web

# Run on all connected devices
flutter run -d all
```

### Development Commands:
```powershell
# Hot reload (while app is running)
r

# Hot restart
R

# Quit
q

# Open DevTools
d
```

## Troubleshooting

### Emulator Issues:

1. **Emulator won't start:**
   ```powershell
   # Check virtualization
   systeminfo | find "Hyper-V"
   
   # Disable Hyper-V if needed
   bcdedit /set hypervisorlaunchtype off
   ```

2. **Slow performance:**
   - Increase RAM allocation
   - Enable hardware acceleration
   - Use x86_64 system images

3. **Graphics issues:**
   - Change Graphics to "Software - GLES 2.0"
   - Update graphics drivers

### Physical Device Issues:

1. **Device not detected:**
   - Install device drivers
   - Try different USB cable
   - Enable "File Transfer" mode

2. **Permission denied:**
   - Revoke and re-grant USB debugging
   - Check device authorization

3. **Build failures:**
   - Enable "Install via USB"
   - Disable "Verify apps over USB"

### General Issues:

1. **Flutter not found:**
   ```powershell
   # Add to PATH
   $env:PATH += ";C:\flutter\bin"
   ```

2. **Gradle sync failed:**
   ```powershell
   flutter clean
   flutter pub get
   ```

3. **Dependencies issues:**
   ```powershell
   flutter doctor --android-licenses
   flutter doctor -v
   ```

## Performance Monitoring

### Flutter Inspector:
- **Open DevTools** while app is running
- **Widget Inspector** for UI debugging
- **Performance View** for frame analysis

### Memory Profiling:
- **Memory tab** in DevTools
- **Monitor heap usage**
- **Detect memory leaks**

### Network Monitoring:
- **Network tab** in DevTools
- **Monitor API calls**
- **Debug connectivity issues**
