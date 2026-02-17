# Device Support Documentation

## Current Support Status

### SDK Version: 8.4.1 (Released 2026-02-03)

The app currently builds for a **core set of tested devices**. This reduced list ensures reliable CI/CD builds without requiring device files to be downloaded separately.

### Supported Devices (v1.0.0)

| Device Family | Models | Status |
|--------------|--------|--------|
| **Fenix 7** | 7, 7S, 7X | ✅ Fully Supported |
| **Venu 2** | 2, 2 Plus | ✅ Fully Supported |
| **Forerunner** | 955 | ✅ Fully Supported |

## Why the Limited Device List?

### Technical Background

Connect IQ SDK requires **device-specific files** to be downloaded for each device you want to build for. In CI/CD environments:

1. **Default SDK installation** doesn't include all device files
2. **Device downloads require** either:
   - Manual SDK Manager GUI (not available in CI)
   - Garmin account credentials (security risk in CI)
   - Third-party CLI tools (additional complexity)

### Solution Approach

We chose to **focus on core devices** that:
- Are widely available in the SDK
- Represent different device families
- Cover most use cases for CPR training

## Adding More Devices

### For Local Development

If you want to build for additional devices locally:

#### Option 1: Using SDK Manager (GUI)
1. Open Garmin Connect IQ SDK Manager
2. Go to "Devices" tab
3. Search and download desired devices
4. Add device IDs to `manifest.xml`
5. Build normally

#### Option 2: Using CLI Tool
```bash
# Install connect-iq-sdk-manager CLI
brew install lindell/connect-iq-sdk-manager-cli/connect-iq-sdk-manager

# Download devices from manifest
connect-iq-sdk-manager device download --manifest=manifest.xml
```

### For CI/CD

To add devices to CI/CD, you would need to:

1. **Option A: Use SDK Manager CLI** (requires credentials)
   - Add `GARMIN_USERNAME` and `GARMIN_PASSWORD` secrets
   - Add CLI installation to workflow
   - Download devices before build

2. **Option B: Build device-specific packages**
   - Build separate `.prg` files for specific devices
   - Use docker images with pre-downloaded devices

3. **Option C: Expand core device list** (if devices work without download)
   - Test which device IDs work in SDK 8.4.1 by default
   - Add validated IDs to manifest.xml

## Potential Additional Devices

### Devices Removed in v1.0.0

These were in earlier versions but removed due to "Invalid device id" errors in SDK 8.4.1:

| Device ID | Model Name | Notes |
|-----------|------------|-------|
| `fenix6` | Fenix 6 | May require device files |
| `fenix6s` | Fenix 6S | May require device files |
| `fenix6xpro` | Fenix 6X Pro | May require device files |
| `fenix5` | Fenix 5 | May require device files |
| `fenix5s` | Fenix 5S | May require device files |
| `fenix5x` | Fenix 5X | May require device files |
| `venu` | Venu | May require device files |
| `venu2s` | Venu 2S | May require device files |
| `vivoactive3` | Vivoactive 3 | May require device files |
| `vivoactive4` | Vivoactive 4 | May require device files |
| `vivoactive4s` | Vivoactive 4S | May require device files |
| `forerunner245` | Forerunner 245 | May require device files |
| `forerunner255` | Forerunner 255 | May require device files |
| `forerunner945` | Forerunner 945 | May require device files |
| `epix2` | Epix 2 | May require device files |
| `marq` | MARQ Series | May require device files |

### Validation Process

To validate a device ID works in CI:

1. Add device ID to manifest.xml locally
2. Push to a test branch
3. Check CI build logs for "Invalid device id" warnings
4. If successful, device can be added to main manifest

## Device ID Reference

### Official Documentation

- [Garmin Connect IQ Compatible Devices](https://developer.garmin.com/connect-iq/compatible-devices/)
- [Device Reference](https://developer.garmin.com/connect-iq/device-reference/)

### Common Device ID Patterns

```xml
<!-- Fenix Series -->
<iq:product id="fenix7"/>
<iq:product id="fenix7s"/>
<iq:product id="fenix7x"/>
<iq:product id="fenix7pro"/>

<!-- Forerunner Series -->
<iq:product id="fr955"/>           <!-- Forerunner 955 -->
<iq:product id="fr965"/>           <!-- Forerunner 965 -->
<iq:product id="fr255"/>           <!-- Forerunner 255 -->

<!-- Venu Series -->
<iq:product id="venu2"/>
<iq:product id="venu2plus"/>
<iq:product id="venu3"/>

<!-- Epix Series -->
<iq:product id="epix2"/>
<iq:product id="epix2pro"/>
```

## Testing Device Compatibility

### Simulator Testing

```bash
# Test on specific device
monkeyc -o bin/test.prg -f monkey.jungle -d fenix7
connectiq

# Launch simulator for device
monkeydo bin/test.prg fenix7
```

### Physical Device Testing

1. Build `.iq` package (universal for all manifest devices)
2. Install via Garmin Express or Connect IQ app
3. Test functionality on actual hardware

## Troubleshooting

### "Invalid device id" Error

**Cause:** Device files not downloaded in SDK

**Solutions:**
1. Download device via SDK Manager
2. Remove device from manifest if not critical
3. Use universal `.iq` build (works for downloaded devices)

### Build Works Locally but Fails in CI

**Cause:** Local SDK has device files, CI doesn't

**Solutions:**
1. Add device download step to CI workflow
2. Use pre-configured Docker image
3. Reduce manifest to core devices only

### Device Not Available in SDK Manager

**Cause:** Very old or very new devices may not be in current SDK

**Solutions:**
1. Update to latest SDK version
2. Check device is Connect IQ compatible
3. Contact Garmin Developer support

## Future Plans

### Roadmap for Device Support

- [ ] **v1.1**: Add Fenix 6 series support
- [ ] **v1.2**: Add Vivoactive 4 series support
- [ ] **v1.3**: Add Forerunner 245/255 support
- [ ] **v2.0**: Full device matrix with Docker-based CI

### Contributing

If you have a device not currently supported:

1. Test the app with your device using sideloading
2. Report results in GitHub Issues
3. We'll add support if compatible

## References

- [Connect IQ SDK Documentation](https://developer.garmin.com/connect-iq/)
- [SDK Manager CLI Tool](https://github.com/lindell/connect-iq-sdk-manager-cli)
- [Connect IQ Forums](https://forums.garmin.com/developer/connect-iq/)

---

**Last Updated:** 2026-02-17
**SDK Version:** 8.4.1
**App Version:** 1.0.0
