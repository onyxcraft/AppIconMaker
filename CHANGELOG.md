# Changelog

All notable changes to AppIconMaker will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-03-25

### Added
- Initial release of AppIconMaker
- Drag and drop interface for loading images
- Generate all required App Icon sizes for iOS (20×20 to 1024×1024)
- Generate all required App Icon sizes for macOS
- Generate all required App Icon sizes for watchOS
- Export as PNG folder with platform-organized subfolders
- Export as .xcassets ready to drop into Xcode
- Live preview grid showing all generated icon sizes
- Background removal option using Core Image
- Rounded corners preview with adjustable radius
- Background color application for transparent images
- Individual icon export functionality
- App Store Connect icon support (1024×1024 without rounded corners)
- Full dark mode support
- Platform selection toggle (iOS, macOS, watchOS, App Store)
- Settings panel with image processing options
- Keyboard shortcuts (⌘K for clear, ⌘E for export)
- MVVM architecture with SwiftUI
- Zero external dependencies
- macOS 14+ support
- Sandboxed app with file access entitlements

### Technical Details
- SwiftUI-based user interface
- Core Image integration for image processing
- AppKit integration for file operations
- Combine framework for reactive updates
- Organized MVVM architecture
- Comprehensive error handling
- High-resolution image support

### Bundle Information
- Bundle ID: com.lopodragon.appiconmaker
- Price: $4.99 USD (one-time purchase)
- Category: Developer Tools
- Minimum macOS Version: 14.0

[1.0.0]: https://github.com/lopodragon/appiconmaker/releases/tag/v1.0.0
