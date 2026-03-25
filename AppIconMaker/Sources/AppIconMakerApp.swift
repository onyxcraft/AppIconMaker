//
//  AppIconMakerApp.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import SwiftUI

@main
struct AppIconMakerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(replacing: .newItem) {}

            CommandMenu("File") {
                Button("Clear") {
                    NotificationCenter.default.post(name: NSNotification.Name("ClearAll"), object: nil)
                }
                .keyboardShortcut("k", modifiers: [.command])

                Divider()

                Button("Export Icons...") {
                    NotificationCenter.default.post(name: NSNotification.Name("ExportIcons"), object: nil)
                }
                .keyboardShortcut("e", modifiers: [.command])
            }
        }
    }
}
