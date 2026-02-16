# CPR Trainer - Installation & Development

## Prerequisites

### 1. Install Connect IQ SDK

1. Download the Connect IQ SDK: https://developer.garmin.com/connect-iq/sdk/
2. Install the SDK on your computer
3. Add SDK tools to your PATH

**Windows:**
```bash
# SDK is typically installed here:
C:\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-7.x.x\bin
```

**macOS:**
```bash
# Add to ~/.zshrc or ~/.bash_profile:
export PATH="$HOME/ConnectIQ/Sdks/connectiq-sdk-mac-7.x.x/bin:$PATH"
```

**Linux:**
```bash
# Add to ~/.bashrc:
export PATH="$HOME/connectiq-sdk-lin-7.x.x/bin:$PATH"
```

### 2. Visual Studio Code with Connect IQ Extension (Recommended)

1. Install Visual Studio Code: https://code.visualstudio.com/
2. Install the "Monkey C" extension by Garmin
3. Open this project in VS Code

**OR**

### 2. Eclipse IDE with Connect IQ Plugin

1. Install Eclipse IDE
2. Install Connect IQ Plugin: https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/

## Build the Project

### With VS Code (Recommended)

1. Open project in VS Code
2. Press `Ctrl+Shift+P` and select "Monkey C: Build for Device"
3. Select your Garmin device from the list
4. The .prg file will be created in the `bin/` folder

### With Command Line

```bash
# Navigate to project directory
cd /path/to/garmin-cpr

# Build for specific device (e.g., fenix7)
monkeyc -o bin/CPRTrainer.prg -f monkey.jungle -y developer_key.der -d fenix7

# Build for all supported devices
monkeyc -o bin/CPRTrainer.prg -f monkey.jungle -y developer_key.der
```

## Generate Developer Key

On first build, you need a developer key:

```bash
# Generate new developer key
openssl genrsa -out developer_key.pem 4096
openssl pkcs8 -topk8 -inform PEM -outform DER -in developer_key.pem -out developer_key.der -nocrypt
```

The `developer_key.der` is used for all your Connect IQ apps.

## Transfer App to Your Watch

### Method 1: Via USB (Quick & Easy)

1. Connect your Garmin watch via USB to computer
2. Watch appears as drive (e.g., "GARMIN")
3. Copy the `.prg` file to:
   ```
   GARMIN/GARMIN/APPS/
   ```
4. Safely disconnect watch from computer
5. On watch: Menu → Activities → CPR Trainer

### Method 2: Connect IQ Simulator (For Testing)

```bash
# Start simulator
connectiq

# Or in VS Code: Ctrl+Shift+P → "Monkey C: Run"
```

### Method 3: Garmin Express (For End Users)

After publishing to Connect IQ Store, users can install via Garmin Express or Garmin Connect Mobile App.

## Test App in Simulator

### With VS Code:
1. Press `F5` or select "Run → Start Debugging"
2. Select your target device
3. Simulator opens automatically

### With Command Line:
```bash
# Start simulator with app
connectiq
# Then in simulator: File → Load App → Select .prg file
```

## Development Tips

### Enable Logging
In code you can use `System.println()`:
```monkey-c
System.println("Debug: Compression count = " + _compressionCount);
```

Logs appear in VS Code Debug Console or Connect IQ Simulator Output.

### Live Reload
With VS Code and Connect IQ Simulator, you can live-test changes without connecting the watch.

## Troubleshooting

### "monkeyc command not found"
- Ensure Connect IQ SDK is installed
- Add SDK bin path to your PATH

### "Invalid developer key"
- Generate new developer key with OpenSSL commands above
- Ensure `developer_key.der` is in project directory

### App doesn't start on watch
- Check that your watch is listed in `manifest.xml` under `<iq:products>`
- Ensure watch firmware is up to date

### Compilation errors
- Check syntax in `.mc` files
- Ensure all resources are present in `resources/` folders

## Next Steps

After successful installation on your watch:
1. Test the app thoroughly
2. Collect feedback
3. See [PUBLISHING.md](PUBLISHING.md) for publishing to Connect IQ Store
