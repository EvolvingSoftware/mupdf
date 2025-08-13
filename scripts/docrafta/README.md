# Docrafta Build Scripts

This directory contains custom build scripts for the Docrafta project, specifically for building MuPDF for iOS and macOS targets.

## Build Script

The main build script is `build-ios-macos.sh` which can build MuPDF for:

1. iOS Simulator
2. iOS Device
3. macOS

## Usage

```bash
# Build for all targets
./scripts/docrafta/build-ios-macos.sh

# Build for specific target
./scripts/docrafta/build-ios-macos.sh ios-sim
./scripts/docrafta/build-ios-macos.sh ios-device
./scripts/docrafta/build-ios-macos.sh macos
```

## Output

The built libraries and headers will be placed in the `install` directory with the following structure:

```
install/
├── ios-simulator/
│   ├── lib/libmupdf.a
│   └── include/mupdf/
├── ios-device/
│   ├── lib/libmupdf.a
│   └── include/mupdf/
└── macos/
    ├── lib/libmupdf.a
    └── include/mupdf/
```

## Integration with Xcode

To integrate the built MuPDF library with your Xcode project:

1. Add the appropriate `libmupdf.a` file to your project
2. Add the `include` directory to your header search paths
3. Link against the required system frameworks:
   - UIKit (iOS)
   - Foundation
   - CoreGraphics
   - QuartzCore

## Requirements

- Xcode with command line tools installed
- iOS SDK
- macOS SDK

## Customization

You can customize the build by modifying the following variables in the script:

- `IOS_SIMULATOR_DEPLOYMENT_TARGET`: Minimum iOS version for simulator
- `IOS_DEVICE_DEPLOYMENT_TARGET`: Minimum iOS version for devices
- `MACOS_DEPLOYMENT_TARGET`: Minimum macOS version
- `IOS_SIMULATOR_ARCHS`: Architectures for iOS simulator
- `IOS_DEVICE_ARCHS`: Architectures for iOS devices
- `MACOS_ARCHS`: Architectures for macOS