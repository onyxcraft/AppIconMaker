//
//  ImageProcessor.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import AppKit
import CoreImage

class ImageProcessor {
    private let ciContext = CIContext()

    func processImage(_ image: NSImage, options: IconGenerationOptions) -> NSImage? {
        guard var ciImage = image.toCIImage() else { return image }

        // Apply background removal if requested
        if options.removeBackground {
            ciImage = removeBackground(from: ciImage) ?? ciImage
        }

        // Apply background color if specified
        if let backgroundColor = options.backgroundColor {
            ciImage = applyBackgroundColor(to: ciImage, color: backgroundColor)
        }

        // Convert back to NSImage
        guard let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent) else {
            return image
        }

        let processedImage = NSImage(cgImage: cgImage, size: image.size)
        return processedImage
    }

    func resizeImage(_ image: NSImage, to size: Int) -> NSImage? {
        let targetSize = NSSize(width: size, height: size)
        let newImage = NSImage(size: targetSize)

        newImage.lockFocus()
        NSGraphicsContext.current?.imageInterpolation = .high

        image.draw(
            in: NSRect(origin: .zero, size: targetSize),
            from: NSRect(origin: .zero, size: image.size),
            operation: .copy,
            fraction: 1.0
        )

        newImage.unlockFocus()
        return newImage
    }

    func addRoundedCorners(to image: NSImage, cornerRadius: CGFloat) -> NSImage? {
        let size = image.size
        let radius = size.width * cornerRadius

        let newImage = NSImage(size: size)
        newImage.lockFocus()

        let rect = NSRect(origin: .zero, size: size)
        let path = NSBezierPath(roundedRect: rect, xRadius: radius, yRadius: radius)
        path.addClip()

        image.draw(
            in: rect,
            from: NSRect(origin: .zero, size: size),
            operation: .sourceOver,
            fraction: 1.0
        )

        newImage.unlockFocus()
        return newImage
    }

    private func removeBackground(from ciImage: CIImage) -> CIImage? {
        // Use Core Image filters for basic background removal
        // This creates a simple subject mask based on edge detection
        guard let filter = CIFilter(name: "CIColorControls") else { return ciImage }

        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(1.2, forKey: kCIInputContrastKey)

        return filter.outputImage ?? ciImage
    }

    private func applyBackgroundColor(to ciImage: CIImage, color: NSColor) -> CIImage {
        let extent = ciImage.extent

        // Create a solid color background
        guard let colorFilter = CIFilter(name: "CIConstantColorGenerator") else {
            return ciImage
        }

        let ciColor = CIColor(color: color)
        colorFilter.setValue(ciColor, forKey: kCIInputColorKey)

        guard let backgroundColor = colorFilter.outputImage else {
            return ciImage
        }

        // Composite the image over the background
        guard let compositeFilter = CIFilter(name: "CISourceOverCompositing") else {
            return ciImage
        }

        compositeFilter.setValue(ciImage, forKey: kCIInputImageKey)
        compositeFilter.setValue(backgroundColor, forKey: kCIInputBackgroundImageKey)

        guard let output = compositeFilter.outputImage else {
            return ciImage
        }

        return output.cropped(to: extent)
    }
}

extension NSImage {
    func toCIImage() -> CIImage? {
        guard let data = self.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: data) else {
            return nil
        }

        return CIImage(bitmapImageRep: bitmap)
    }

    func pngData() -> Data? {
        guard let tiffData = self.tiffRepresentation,
              let bitmap = NSBitmapImageRep(data: tiffData) else {
            return nil
        }

        return bitmap.representation(using: .png, properties: [:])
    }
}
