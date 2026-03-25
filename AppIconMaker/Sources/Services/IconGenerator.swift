//
//  IconGenerator.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import AppKit

class IconGenerator {
    private let imageProcessor = ImageProcessor()

    func generateIcons(
        from sourceImage: NSImage,
        options: IconGenerationOptions
    ) -> [IconSize: NSImage] {
        var generatedIcons: [IconSize: NSImage] = [:]

        // First process the source image with options
        guard let processedImage = imageProcessor.processImage(sourceImage, options: options) else {
            return generatedIcons
        }

        // Get sizes for selected platforms
        let sizes = IconSize.allSizes.filter { options.includedPlatforms.contains($0.platform) }

        for iconSize in sizes {
            let pixelSize = iconSize.pixelSize

            // Resize to target size
            guard var resizedImage = imageProcessor.resizeImage(processedImage, to: pixelSize) else {
                continue
            }

            // Apply rounded corners if needed (but not for App Store icons)
            if options.addRoundedCorners && iconSize.platform != .appStore {
                if let roundedImage = imageProcessor.addRoundedCorners(
                    to: resizedImage,
                    cornerRadius: options.cornerRadius
                ) {
                    resizedImage = roundedImage
                }
            }

            generatedIcons[iconSize] = resizedImage
        }

        return generatedIcons
    }
}
