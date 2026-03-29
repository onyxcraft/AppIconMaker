//
//  MainViewModel.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import AppKit
import Combine
import SwiftUI
import UniformTypeIdentifiers

@MainActor
class MainViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var sourceImage: NSImage?
    @Published var generatedIcons: [IconSize: NSImage] = [:]
    @Published var options = IconGenerationOptions()
    @Published var exportFormat: ExportFormat = .xcassets
    @Published var isGenerating = false
    @Published var isExporting = false
    @Published var errorMessage: String?
    @Published var successMessage: String?

    // MARK: - Services
    private let iconGenerator = IconGenerator()
    private let exportService = ExportService()

    // MARK: - Computed Properties
    var hasSourceImage: Bool {
        sourceImage != nil
    }

    var hasGeneratedIcons: Bool {
        !generatedIcons.isEmpty
    }

    var iconsByPlatform: [(IconSize.Platform, [IconSize: NSImage])] {
        let platforms = IconSize.Platform.allCases
        return platforms.compactMap { platform in
            let platformIcons = generatedIcons.filter { $0.key.platform == platform }
            guard !platformIcons.isEmpty else { return nil }
            return (platform, platformIcons)
        }
    }

    // MARK: - Actions
    func loadImage(from url: URL) {
        guard let image = NSImage(contentsOf: url) else {
            errorMessage = "Failed to load image from \(url.lastPathComponent)"
            return
        }

        sourceImage = image
        errorMessage = nil
        successMessage = "Image loaded successfully"

        // Auto-generate icons
        generateIcons()
    }

    func generateIcons() {
        guard let sourceImage = sourceImage else {
            errorMessage = "No source image loaded"
            return
        }

        isGenerating = true
        errorMessage = nil

        Task {
            await Task.yield() // Allow UI to update

            let icons = iconGenerator.generateIcons(from: sourceImage, options: options)
            self.generatedIcons = icons
            self.isGenerating = false

            if icons.isEmpty {
                self.errorMessage = "Failed to generate icons"
            } else {
                self.successMessage = "Generated \(icons.count) icons"
            }
        }
    }

    func exportIcons() {
        guard !generatedIcons.isEmpty else {
            errorMessage = "No icons to export"
            return
        }

        let panel = NSSavePanel()
        panel.allowedContentTypes = exportFormat == .xcassets ? [UTType(filenameExtension: "xcassets")!] : [.folder]
        panel.canCreateDirectories = true
        panel.nameFieldStringValue = exportFormat == .xcassets ? "AppIcon.appiconset" : "AppIcons"
        panel.message = "Choose where to save the generated icons"

        panel.begin { [weak self] response in
            guard let self = self, response == .OK, let url = panel.url else { return }

            self.performExport(to: url)
        }
    }

    func exportIndividualIcon(_ iconSize: IconSize) {
        guard let icon = generatedIcons[iconSize] else {
            errorMessage = "Icon not found"
            return
        }

        let panel = NSSavePanel()
        panel.allowedContentTypes = [.png]
        panel.canCreateDirectories = true
        panel.nameFieldStringValue = iconSize.filename

        panel.begin { [weak self] response in
            guard let self = self, response == .OK, let url = panel.url else { return }

            do {
                try self.exportService.exportIndividualIcon(icon, size: iconSize, to: url)
                self.successMessage = "Icon exported successfully"
            } catch {
                self.errorMessage = "Export failed: \(error.localizedDescription)"
            }
        }
    }

    func clearAll() {
        sourceImage = nil
        generatedIcons = [:]
        errorMessage = nil
        successMessage = nil
    }

    func togglePlatform(_ platform: IconSize.Platform) {
        if options.includedPlatforms.contains(platform) {
            options.includedPlatforms.remove(platform)
        } else {
            options.includedPlatforms.insert(platform)
        }

        if hasSourceImage {
            generateIcons()
        }
    }

    // MARK: - Private Methods
    private func performExport(to url: URL) {
        isExporting = true
        errorMessage = nil

        Task {
            do {
                try exportService.export(icons: generatedIcons, format: exportFormat, to: url)
                self.successMessage = "Icons exported successfully to \(url.lastPathComponent)"
            } catch {
                self.errorMessage = "Export failed: \(error.localizedDescription)"
            }

            self.isExporting = false
        }
    }
}
