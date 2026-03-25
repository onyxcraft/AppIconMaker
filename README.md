# AppIconMaker

Generate complete App Store icon sets from a single image for iOS, macOS, and watchOS.

![macOS 14+](https://img.shields.io/badge/macOS-14%2B-blue)
![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange)
![SwiftUI](https://img.shields.io/badge/UI-SwiftUI-blue)
![License MIT](https://img.shields.io/badge/License-MIT-green)

## Features

- **Drag & Drop Interface**: Simply drag any image into the app
- **Complete Icon Sets**: Generate all required sizes for iOS (20×20 to 1024×1024), macOS, and watchOS
- **Multiple Export Formats**:
  - PNG folder with organized subfolders by platform
  - `.xcassets` ready to drop directly into Xcode
- **Live Preview Grid**: See all generated icons in real-time
- **Background Removal**: Remove image backgrounds using Core Image (optional)
- **Rounded Corners**: Preview and apply customizable rounded corners
- **Background Colors**: Apply solid background colors to transparent images
- **Individual Export**: Export specific icon sizes as needed
- **App Store Connect Ready**: 1024×1024 icon without rounded corners
- **Dark Mode**: Full dark mode support

## Requirements

- macOS 14.0 or later
- Xcode 15.0 or later (for development)

## Installation

### From Source

1. Clone this repository:
   ```bash
   git clone https://github.com/lopodragon/appiconmaker.git
   cd appiconmaker
   ```

2. Open `AppIconMaker.xcodeproj` in Xcode

3. Build and run (⌘R)

### From App Store

Coming soon at $4.99 USD

## Usage

### Basic Usage

1. **Load an Image**:
   - Drag and drop an image onto the drop zone
   - Or click the drop zone to browse for an image
   - Supported formats: PNG, JPEG, TIFF, HEIC

2. **Review Generated Icons**:
   - Icons are automatically generated for all platforms
   - Preview all sizes in the grid view
   - Icons are grouped by platform: iOS, macOS, watchOS, App Store

3. **Export**:
   - Click "Export All" to save all icons
   - Choose between PNG folder or .xcassets format
   - Or hover over individual icons and click the download button to export specific sizes

### Advanced Features

#### Settings Panel

Access settings by clicking the "Settings" button in the sidebar:

- **Platform Selection**: Toggle iOS, macOS, watchOS, or App Store icon generation
- **Remove Background**: Automatically remove image backgrounds (experimental)
- **Rounded Corners**: Add rounded corners with adjustable radius (0-50%)
- **Background Color**: Apply a solid color background to transparent images
- **Export Format**: Choose between PNG folder or .xcassets

#### Keyboard Shortcuts

- `⌘K` - Clear current image and start over
- `⌘E` - Export all icons
- `⌘,` - Open settings (coming soon)

## Icon Sizes Generated

### iOS
- Notification: 20×20 (@2x, @3x), 20×20 iPad (@1x, @2x)
- Settings: 29×29 (@2x, @3x), 29×29 iPad (@1x, @2x)
- Spotlight: 40×40 (@2x, @3x), 40×40 iPad (@1x, @2x)
- App Icon: 60×60 (@2x, @3x)
- iPad App: 76×76 (@1x, @2x)
- iPad Pro: 83.5×83.5 (@2x)

### macOS
- 16×16 (@1x, @2x)
- 32×32 (@1x, @2x)
- 128×128 (@1x, @2x)
- 256×256 (@1x, @2x)
- 512×512 (@1x, @2x)

### watchOS
- Notification: 24×24, 27.5×27.5, 29×29 (@2x, @3x)
- Home Screen: 40×40, 44×44, 46×46, 50×50
- Short Look: 86×86, 98×98, 108×108

### App Store
- 1024×1024 (no alpha channel, no rounded corners)

## Architecture

AppIconMaker is built with a clean MVVM architecture:

```
AppIconMaker/
├── Sources/
│   ├── AppIconMakerApp.swift          # App entry point
│   ├── Models/                         # Data models
│   │   ├── IconSize.swift             # Icon size definitions
│   │   ├── ExportFormat.swift         # Export format enum
│   │   └── IconGenerationOptions.swift # Configuration options
│   ├── ViewModels/                     # Business logic
│   │   └── MainViewModel.swift        # Main view model
│   ├── Views/                          # SwiftUI views
│   │   ├── MainView.swift             # Main app view
│   │   ├── DropZoneView.swift         # Drag & drop interface
│   │   ├── IconPreviewGridView.swift  # Icon grid preview
│   │   └── SettingsView.swift         # Settings panel
│   └── Services/                       # Core services
│       ├── ImageProcessor.swift       # Core Image processing
│       ├── IconGenerator.swift        # Icon generation
│       └── ExportService.swift        # File export
└── Resources/
    └── Assets.xcassets/               # App assets
```

### Technologies

- **SwiftUI**: Modern declarative UI framework
- **AppKit**: macOS native APIs
- **Core Image**: Image processing and manipulation
- **Combine**: Reactive programming
- **No External Dependencies**: Pure Swift implementation

## Development

### Building

```bash
xcodebuild -project AppIconMaker.xcodeproj -scheme AppIconMaker -configuration Release
```

### Testing

```bash
xcodebuild test -project AppIconMaker.xcodeproj -scheme AppIconMaker
```

### Code Style

- Swift 5.0+
- MVVM architecture
- SwiftUI best practices
- No force unwrapping
- Comprehensive error handling

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'feat: add some amazing feature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with ❤️ for the iOS/macOS developer community
- Uses Apple's Core Image framework for image processing
- Icon specifications from [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)

## Support

- **Issues**: [GitHub Issues](https://github.com/lopodragon/appiconmaker/issues)
- **Discussions**: [GitHub Discussions](https://github.com/lopodragon/appiconmaker/discussions)

## Roadmap

- [ ] Batch processing multiple images
- [ ] Custom icon templates
- [ ] Advanced background removal with ML
- [ ] Icon validation and warnings
- [ ] Export presets
- [ ] Command-line interface
- [ ] Integration with popular design tools

## Bundle Information

- **Bundle ID**: com.lopodragon.appiconmaker
- **Price**: $4.99 USD (one-time purchase)
- **Category**: Developer Tools
- **Version**: 1.0.0

---

Made with care for macOS developers
