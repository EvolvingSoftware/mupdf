#!/bin/bash
#
# Script to build MuPDF for iOS and macOS targets
#
# This script builds the MuPDF library for iOS and macOS targets
# and creates universal binaries that can be used in Xcode projects.
#
# Usage:
#   ./build-ios-macos.sh [target]
#
# Targets:
#   ios-sim        Build for iOS simulator
#   ios-device     Build for iOS device
#   macos          Build for macOS
#   all            Build all targets (default)
#

set -e

# Configuration
MUROOT=$(cd "$(dirname "$0")/../.." && pwd)
SCRIPTS_DIR="$MUROOT/scripts/docrafta"
BUILD_DIR="$MUROOT/build/docrafta"
INSTALL_DIR="$MUROOT/install"

# iOS deployment targets
IOS_SIMULATOR_DEPLOYMENT_TARGET="12.0"
IOS_DEVICE_DEPLOYMENT_TARGET="12.0"
MACOS_DEPLOYMENT_TARGET="10.13"

# Architectures
IOS_SIMULATOR_ARCHS=("x86_64" "arm64")
IOS_DEVICE_ARCHS=("arm64")
MACOS_ARCHS=("x86_64" "arm64")

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print functions
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Build for a specific target and architecture
build_target() {
    local target=$1
    local arch=$2
    local sdk=$3
    local deployment_target=$4
    local build_dir=$5
    
    print_info "Building for $target ($arch)..."
    
    # Set up environment variables
    export SDKROOT=$(xcrun --sdk $sdk --show-sdk-path)
    export MACOSX_DEPLOYMENT_TARGET=$deployment_target
    
    # Build with make
    make -C "$MUROOT" \
        build="$build_dir" \
        OS="darwin" \
        XCFLAGS="-arch $arch -isysroot $SDKROOT -m$sdk-version-min=$deployment_target" \
        libs
    
    print_info "Build completed for $target ($arch)"
}

# Create universal binary
create_universal_binary() {
    local target=$1
    local build_dirs=("${@:2}")
    local output_dir="$INSTALL_DIR/$target"
    
    print_info "Creating universal binary for $target..."
    
    # Create output directory
    mkdir -p "$output_dir/lib"
    mkdir -p "$output_dir/include"
    
    # Copy headers (only once)
    if [ ! -d "$output_dir/include/mupdf" ]; then
        cp -r "$MUROOT/include/mupdf" "$output_dir/include/"
    fi
    
    # Create universal library
    local lib_files=()
    for build_dir in "${build_dirs[@]}"; do
        if [ -f "$MUROOT/build/$build_dir/libmupdf.a" ]; then
            lib_files+=("$MUROOT/build/$build_dir/libmupdf.a")
        fi
    done
    
    if [ ${#lib_files[@]} -gt 0 ]; then
        lipo -create "${lib_files[@]}" -output "$output_dir/lib/libmupdf.a"
        print_info "Created universal library at $output_dir/lib/libmupdf.a"
    else
        print_error "No library files found for $target"
        return 1
    fi
}

# Build for iOS simulator
build_ios_simulator() {
    local build_dirs=()
    
    for arch in "${IOS_SIMULATOR_ARCHS[@]}"; do
        local build_dir="ios-sim-$arch"
        build_target "iOS Simulator" "$arch" "iphonesimulator" "$IOS_SIMULATOR_DEPLOYMENT_TARGET" "$build_dir"
        build_dirs+=("$build_dir")
    done
    
    create_universal_binary "ios-simulator" "${build_dirs[@]}"
}

# Build for iOS device
build_ios_device() {
    local build_dirs=()
    
    for arch in "${IOS_DEVICE_ARCHS[@]}"; do
        local build_dir="ios-device-$arch"
        build_target "iOS Device" "$arch" "iphoneos" "$IOS_DEVICE_DEPLOYMENT_TARGET" "$build_dir"
        build_dirs+=("$build_dir")
    done
    
    create_universal_binary "ios-device" "${build_dirs[@]}"
}

# Build for macOS
build_macos() {
    local build_dirs=()
    
    for arch in "${MACOS_ARCHS[@]}"; do
        local build_dir="macos-$arch"
        build_target "macOS" "$arch" "macosx" "$MACOS_DEPLOYMENT_TARGET" "$build_dir"
        build_dirs+=("$build_dir")
    done
    
    create_universal_binary "macos" "${build_dirs[@]}"
}

# Main function
main() {
    local target=${1:-all}
    
    print_info "Starting MuPDF build for Docrafta project"
    print_info "MuPDF root: $MUROOT"
    print_info "Build directory: $BUILD_DIR"
    print_info "Install directory: $INSTALL_DIR"
    
    case $target in
        ios-sim)
            build_ios_simulator
            ;;
        ios-device)
            build_ios_device
            ;;
        macos)
            build_macos
            ;;
        all)
            build_ios_simulator
            build_ios_device
            build_macos
            ;;
        *)
            print_error "Unknown target: $target"
            echo "Usage: $0 [ios-sim|ios-device|macos|all]"
            exit 1
            ;;
    esac
    
    print_info "Build process completed successfully!"
    echo "Libraries and headers are available in: $INSTALL_DIR"
}

# Run main function
main "$@"