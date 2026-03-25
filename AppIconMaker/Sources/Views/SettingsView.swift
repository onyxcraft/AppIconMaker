//
//  SettingsView.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import SwiftUI

struct SettingsView: View {
    @Binding var options: IconGenerationOptions
    @Binding var exportFormat: ExportFormat
    let onRegenerateIcons: () -> Void

    var body: some View {
        Form {
            Section("Platform Selection") {
                ForEach(IconSize.Platform.allCases, id: \.self) { platform in
                    Toggle(isOn: Binding(
                        get: { options.includedPlatforms.contains(platform) },
                        set: { isSelected in
                            if isSelected {
                                options.includedPlatforms.insert(platform)
                            } else {
                                options.includedPlatforms.remove(platform)
                            }
                            onRegenerateIcons()
                        }
                    )) {
                        Label(platform.rawValue, systemImage: platform.icon)
                    }
                }
            }

            Section("Image Processing") {
                Toggle("Remove Background", isOn: $options.removeBackground)
                    .onChange(of: options.removeBackground) { _ in
                        onRegenerateIcons()
                    }

                Toggle("Add Rounded Corners", isOn: $options.addRoundedCorners)
                    .onChange(of: options.addRoundedCorners) { _ in
                        onRegenerateIcons()
                    }

                if options.addRoundedCorners {
                    VStack(alignment: .leading) {
                        Text("Corner Radius: \(Int(options.cornerRadius * 100))%")
                            .font(.caption)

                        Slider(value: $options.cornerRadius, in: 0...0.5)
                            .onChange(of: options.cornerRadius) { _ in
                                onRegenerateIcons()
                            }
                    }
                }

                ColorPicker("Background Color", selection: Binding(
                    get: { options.backgroundColor ?? .clear },
                    set: { options.backgroundColor = $0 }
                ), supportsOpacity: true)
                .onChange(of: options.backgroundColor) { _ in
                    onRegenerateIcons()
                }

                if options.hasBackgroundColor {
                    Button("Clear Background Color") {
                        options.backgroundColor = nil
                        onRegenerateIcons()
                    }
                    .font(.caption)
                }
            }

            Section("Export Format") {
                Picker("Format", selection: $exportFormat) {
                    ForEach(ExportFormat.allCases, id: \.self) { format in
                        Text(format.rawValue).tag(format)
                    }
                }
                .pickerStyle(.radioGroup)

                Text(exportFormat.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .formStyle(.grouped)
    }
}
