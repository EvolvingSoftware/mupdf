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
1. Build MuPDF library from source using `make` commands
2. Include the compiled library directly in the iOS app bundle
3. Create Swift wrappers for the C functions we need
4. Use Swift Package Manager or manual linking to integrate

## Next Steps
1. Successfully build the MuPDF library for iOS/macOS targets
2. Create a simple proof-of-concept that loads and displays a PDF using our custom MuPDF build
3. Implement basic editing features through the MuPDF API
4. Develop the SwiftUI interface for PDF editing

## Build Commands
```bash
# Navigate to the mupdf directory
cd mupdf

# Build the tools (basic build)
make tools

# For iOS/macOS integration, we'll need to configure specific build targets
# This will require additional configuration for cross-compilation
```

## Key Files
- `DOCRFTA.md` - Documentation for Docrafta integration
- `README` - Marked as EvolvingSoftware fork
- `Qwen.md` - This file with project information

## Repository Management
- We have direct push access to the EvolvingSoftware/mupdf repository
- Changes can be pushed directly to master for minor updates
- Feature development should use the docrafta-dev branch
- Pull requests can be used for major changes or code review