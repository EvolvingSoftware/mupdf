# Docrafta PDF Editor - MuPDF Integration

## Project Overview
We are creating a SwiftUI PDF editor that will include a custom version of MuPDF built from source. The MuPDF library will be directly included in the program's distribution.

## Repository Information
- **Main Repository**: https://github.com/EvolvingSoftware/mupdf
- **Branch**: master
- **Local Branch**: docrafta-dev (for feature development)
- **Last Commit**: Mark this as the EvolvingSoftware fork of MuPDF

## Project Structure
- Using the EvolvingSoftware fork of MuPDF as our base
- Building MuPDF from source for direct inclusion in our SwiftUI app
- Customizing MuPDF for our specific PDF editing needs

## Development Workflow
1. Make changes in feature branches from `docrafta-dev`
2. Merge finished features into `docrafta-dev`
3. Periodically merge `docrafta-dev` into `master` after testing
4. Push directly to `master` for minor updates (as verified)

## MuPDF Integration Plan
1. Build MuPDF library from source using custom build scripts
2. Include the compiled library directly in the iOS app bundle
3. Create Swift wrappers for the C functions we need
4. Use Swift Package Manager or manual linking to integrate

## Custom Build Workflow
We have created custom build scripts for iOS and macOS targets:

1. **Build Scripts Location**: `scripts/docrafta/`
2. **Main Build Script**: `scripts/docrafta/build-ios-macos.sh`
3. **Documentation**: `scripts/docrafta/README.md`

### Usage
```bash
# Navigate to the mupdf directory
cd mupdf

# Build for all targets (iOS simulator, iOS device, macOS)
./scripts/docrafta/build-ios-macos.sh

# Build for specific target
./scripts/docrafta/build-ios-macos.sh ios-sim
./scripts/docrafta/build-ios-macos.sh ios-device
./scripts/docrafta/build-ios-macos.sh macos
```

### Output Structure
The built libraries and headers will be placed in the `install` directory:
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

## Next Steps
1. Test the build scripts to ensure they work correctly
2. Create a simple proof-of-concept that loads and displays a PDF using our custom MuPDF build
3. Implement basic editing features through the MuPDF API
4. Develop the SwiftUI interface for PDF editing

## Build Commands
```bash
# Navigate to the mupdf directory
cd mupdf

# Build the tools (basic build)
make tools

# Build for iOS/macOS targets using our custom scripts
./scripts/docrafta/build-ios-macos.sh
```

## Key Files
- `DOCRFTA.md` - Documentation for Docrafta integration
- `README` - Marked as EvolvingSoftware fork
- `Qwen.md` - This file with project information
- `scripts/docrafta/build-ios-macos.sh` - Custom build script for iOS/macOS
- `scripts/docrafta/README.md` - Documentation for build scripts

## Repository Management
- We have direct push access to the EvolvingSoftware/mupdf repository
- Changes can be pushed directly to master for minor updates
- Feature development should use the docrafta-dev branch
- Pull requests can be used for major changes or code review