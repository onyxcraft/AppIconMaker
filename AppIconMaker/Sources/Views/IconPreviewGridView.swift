//
//  IconPreviewGridView.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import SwiftUI

struct IconPreviewGridView: View {
    let icons: [IconSize: NSImage]
    let onExportIndividual: (IconSize) -> Void

    private let columns = [
        GridItem(.adaptive(minimum: 120, maximum: 150), spacing: 16)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(Array(icons.keys.sorted(by: { $0.pixelSize < $1.pixelSize })), id: \.self) { iconSize in
                    if let image = icons[iconSize] {
                        IconPreviewCard(
                            image: image,
                            iconSize: iconSize,
                            onExport: {
                                onExportIndividual(iconSize)
                            }
                        )
                    }
                }
            }
            .padding()
        }
    }
}

struct IconPreviewCard: View {
    let image: NSImage
    let iconSize: IconSize
    let onExport: () -> Void

    @State private var isHovered = false

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .background(Color(nsColor: .quaternaryLabelColor))
                    .cornerRadius(8)

                if isHovered {
                    Button(action: onExport) {
                        Image(systemName: "square.and.arrow.down")
                            .font(.system(size: 12))
                            .padding(6)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .padding(4)
                }
            }

            VStack(spacing: 2) {
                Text("\(iconSize.pixelSize)×\(iconSize.pixelSize)")
                    .font(.caption)
                    .fontWeight(.medium)

                Label(iconSize.platform.rawValue, systemImage: iconSize.platform.icon)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isHovered ? Color(nsColor: .controlBackgroundColor) : Color.clear)
        )
        .onHover { hovering in
            isHovered = hovering
        }
    }
}
