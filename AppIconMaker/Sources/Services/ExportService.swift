//
//  ExportService.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import AppKit
import UniformTypeIdentifiers

class ExportService {
    func export(
        icons: [IconSize: NSImage],
        format: ExportFormat,
        to url: URL
    ) throws {
        switch format {
        case .pngFolder:
            try exportAsPNGFolder(icons: icons, to: url)
        case .xcassets:
            try exportAsXCAssets(icons: icons, to: url)
        }
    }

    func exportIndividualIcon(_ icon: NSImage, size: IconSize, to url: URL) throws {
        guard let pngData = icon.pngData() else {
            throw ExportError.imageConversionFailed
        }

        try pngData.write(to: url)
    }

    private func exportAsPNGFolder(icons: [IconSize: NSImage], to url: URL) throws {
        let fileManager = FileManager.default

        // Create directory if it doesn't exist
        try fileManager.createDirectory(at: url, withIntermediateDirectories: true)

        // Group by platform and export
        let platforms = IconSize.Platform.allCases

        for platform in platforms {
            let platformIcons = icons.filter { $0.key.platform == platform }
            guard !platformIcons.isEmpty else { continue }

            let platformFolder = url.appendingPathComponent(platform.rawValue)
            try fileManager.createDirectory(at: platformFolder, withIntermediateDirectories: true)

            for (iconSize, image) in platformIcons {
                guard let pngData = image.pngData() else { continue }

                let fileURL = platformFolder.appendingPathComponent(iconSize.filename)
                try pngData.write(to: fileURL)
            }
        }
    }

    private func exportAsXCAssets(icons: [IconSize: NSImage], to url: URL) throws {
        let fileManager = FileManager.default

        // Create .xcassets bundle
        let xcassetsURL = url.appendingPathComponent("AppIcon.appiconset")
        try fileManager.createDirectory(at: xcassetsURL, withIntermediateDirectories: true)

        // Generate Contents.json
        let contentsJSON = generateContentsJSON(for: icons)
        let jsonData = try JSONSerialization.data(withJSONObject: contentsJSON, options: .prettyPrinted)
        let jsonURL = xcassetsURL.appendingPathComponent("Contents.json")
        try jsonData.write(to: jsonURL)

        // Export icon images
        for (iconSize, image) in icons {
            guard let pngData = image.pngData() else { continue }

            let fileURL = xcassetsURL.appendingPathComponent(iconSize.filename)
            try pngData.write(to: fileURL)
        }
    }

    private func generateContentsJSON(for icons: [IconSize: NSImage]) -> [String: Any] {
        var images: [[String: String]] = []

        for iconSize in icons.keys.sorted(by: { $0.pixelSize < $1.pixelSize }) {
            images.append([
                "filename": iconSize.filename,
                "idiom": iconSize.idiom,
                "scale": "\(iconSize.scale)x",
                "size": "\(Int(iconSize.size))x\(Int(iconSize.size))"
            ])
        }

        return [
            "images": images,
            "info": [
                "author": "appiconmaker",
                "version": 1
            ]
        ]
    }

    enum ExportError: LocalizedError {
        case imageConversionFailed
        case directoryCreationFailed

        var errorDescription: String? {
            switch self {
            case .imageConversionFailed:
                return "Failed to convert image to PNG format"
            case .directoryCreationFailed:
                return "Failed to create export directory"
            }
        }
    }
}
