//
//  MainView.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var showingSettings = false

    var body: some View {
        NavigationSplitView {
            // Sidebar
            VStack(spacing: 0) {
                List {
                    Section("Platforms") {
                        ForEach(viewModel.iconsByPlatform, id: \.0) { platform, icons in
                            Label {
                                HStack {
                                    Text(platform.rawValue)
                                    Spacer()
                                    Text("\(icons.count)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            } icon: {
                                Image(systemName: platform.icon)
                            }
                        }
                    }

                    Section {
                        Button(action: { showingSettings.toggle() }) {
                            Label("Settings", systemImage: "gear")
                        }
                    }
                }
                .listStyle(.sidebar)
            }
            .frame(minWidth: 200, idealWidth: 220, maxWidth: 280)
        } detail: {
            // Main content
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("AppIconMaker")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Spacer()

                    if viewModel.hasSourceImage {
                        Button("Clear") {
                            viewModel.clearAll()
                        }
                        .keyboardShortcut("k", modifiers: [.command])
                    }
                }
                .padding()

                Divider()

                // Content
                ScrollView {
                    VStack(spacing: 24) {
                        // Drop zone
                        DropZoneView(
                            sourceImage: $viewModel.sourceImage,
                            onImageLoaded: { url in
                                viewModel.loadImage(from: url)
                            }
                        )
                        .padding(.horizontal)

                        // Icons preview
                        if viewModel.isGenerating {
                            ProgressView("Generating icons...")
                                .padding()
                        } else if viewModel.hasGeneratedIcons {
                            VStack(spacing: 16) {
                                HStack {
                                    Text("\(viewModel.generatedIcons.count) Icons Generated")
                                        .font(.headline)

                                    Spacer()

                                    Button(action: viewModel.exportIcons) {
                                        Label("Export All", systemImage: "square.and.arrow.down")
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .disabled(viewModel.isExporting)
                                }
                                .padding(.horizontal)

                                IconPreviewGridView(
                                    icons: viewModel.generatedIcons,
                                    onExportIndividual: { iconSize in
                                        viewModel.exportIndividualIcon(iconSize)
                                    }
                                )
                            }
                        }

                        // Status messages
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .padding()
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(8)
                                .padding(.horizontal)
                        }

                        if let success = viewModel.successMessage {
                            Text(success)
                                .foregroundColor(.green)
                                .padding()
                                .background(Color.green.opacity(0.1))
                                .cornerRadius(8)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView(
                options: $viewModel.options,
                exportFormat: $viewModel.exportFormat,
                onRegenerateIcons: viewModel.generateIcons
            )
            .frame(width: 500, height: 600)
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}

#Preview {
    MainView()
}
