//
//  DropZoneView.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import SwiftUI
import UniformTypeIdentifiers

struct DropZoneView: View {
    @Binding var sourceImage: NSImage?
    let onImageLoaded: (URL) -> Void

    @State private var isDragging = false

    var body: some View {
        VStack(spacing: 20) {
            if let image = sourceImage {
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 300)
                    .cornerRadius(12)
            } else {
                VStack(spacing: 16) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 64))
                        .foregroundColor(.secondary)

                    Text("Drag & Drop Image Here")
                        .font(.title2)
                        .fontWeight(.medium)

                    Text("or click to browse")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isDragging ? Color.accentColor.opacity(0.1) : Color(nsColor: .controlBackgroundColor))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(
                            isDragging ? Color.accentColor : Color.secondary.opacity(0.3),
                            style: StrokeStyle(lineWidth: 2, dash: [8])
                        )
                )
        )
        .onDrop(of: [.image, .fileURL], isTargeted: $isDragging) { providers in
            handleDrop(providers: providers)
        }
        .onTapGesture {
            selectImageFile()
        }
    }

    private func handleDrop(providers: [NSItemProvider]) -> Bool {
        guard let provider = providers.first else { return false }

        if provider.hasItemConformingToTypeIdentifier(UTType.fileURL.identifier) {
            provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { data, error in
                if let data = data as? Data,
                   let url = URL(dataRepresentation: data, relativeTo: nil) {
                    DispatchQueue.main.async {
                        onImageLoaded(url)
                    }
                }
            }
            return true
        }

        return false
    }

    private func selectImageFile() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.canChooseFiles = true
        panel.allowedContentTypes = [.png, .jpeg, .tiff, .heic]
        panel.message = "Select an image to generate app icons"

        panel.begin { response in
            if response == .OK, let url = panel.url {
                onImageLoaded(url)
            }
        }
    }
}
