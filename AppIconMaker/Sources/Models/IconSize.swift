//
//  IconSize.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import Foundation

struct IconSize: Identifiable, Hashable {
    let id = UUID()
    let platform: Platform
    let size: CGFloat
    let scale: Int
    let idiom: String

    var filename: String {
        "\(idiom)-\(Int(size))x\(Int(size))@\(scale)x.png"
    }

    var displayName: String {
        "\(Int(size * CGFloat(scale)))×\(Int(size * CGFloat(scale))) (\(idiom))"
    }

    var pixelSize: Int {
        Int(size * CGFloat(scale))
    }

    enum Platform: String, CaseIterable {
        case iOS = "iOS"
        case macOS = "macOS"
        case watchOS = "watchOS"
        case appStore = "App Store"

        var icon: String {
            switch self {
            case .iOS: return "iphone"
            case .macOS: return "desktopcomputer"
            case .watchOS: return "applewatch"
            case .appStore: return "app.badge"
            }
        }
    }
}

extension IconSize {
    static let allSizes: [IconSize] = iOSSizes + macOSSizes + watchOSSizes + appStoreSizes

    static let iOSSizes: [IconSize] = [
        // iPhone Notification
        IconSize(platform: .iOS, size: 20, scale: 2, idiom: "iphone"),
        IconSize(platform: .iOS, size: 20, scale: 3, idiom: "iphone"),
        // iPhone Settings
        IconSize(platform: .iOS, size: 29, scale: 2, idiom: "iphone"),
        IconSize(platform: .iOS, size: 29, scale: 3, idiom: "iphone"),
        // iPhone Spotlight
        IconSize(platform: .iOS, size: 40, scale: 2, idiom: "iphone"),
        IconSize(platform: .iOS, size: 40, scale: 3, idiom: "iphone"),
        // iPhone App
        IconSize(platform: .iOS, size: 60, scale: 2, idiom: "iphone"),
        IconSize(platform: .iOS, size: 60, scale: 3, idiom: "iphone"),
        // iPad Notification
        IconSize(platform: .iOS, size: 20, scale: 1, idiom: "ipad"),
        IconSize(platform: .iOS, size: 20, scale: 2, idiom: "ipad"),
        // iPad Settings
        IconSize(platform: .iOS, size: 29, scale: 1, idiom: "ipad"),
        IconSize(platform: .iOS, size: 29, scale: 2, idiom: "ipad"),
        // iPad Spotlight
        IconSize(platform: .iOS, size: 40, scale: 1, idiom: "ipad"),
        IconSize(platform: .iOS, size: 40, scale: 2, idiom: "ipad"),
        // iPad App
        IconSize(platform: .iOS, size: 76, scale: 1, idiom: "ipad"),
        IconSize(platform: .iOS, size: 76, scale: 2, idiom: "ipad"),
        // iPad Pro
        IconSize(platform: .iOS, size: 83.5, scale: 2, idiom: "ipad")
    ]

    static let macOSSizes: [IconSize] = [
        IconSize(platform: .macOS, size: 16, scale: 1, idiom: "mac"),
        IconSize(platform: .macOS, size: 16, scale: 2, idiom: "mac"),
        IconSize(platform: .macOS, size: 32, scale: 1, idiom: "mac"),
        IconSize(platform: .macOS, size: 32, scale: 2, idiom: "mac"),
        IconSize(platform: .macOS, size: 128, scale: 1, idiom: "mac"),
        IconSize(platform: .macOS, size: 128, scale: 2, idiom: "mac"),
        IconSize(platform: .macOS, size: 256, scale: 1, idiom: "mac"),
        IconSize(platform: .macOS, size: 256, scale: 2, idiom: "mac"),
        IconSize(platform: .macOS, size: 512, scale: 1, idiom: "mac"),
        IconSize(platform: .macOS, size: 512, scale: 2, idiom: "mac")
    ]

    static let watchOSSizes: [IconSize] = [
        // Notification Center
        IconSize(platform: .watchOS, size: 24, scale: 2, idiom: "watch"),
        IconSize(platform: .watchOS, size: 27.5, scale: 2, idiom: "watch"),
        // Companion Settings
        IconSize(platform: .watchOS, size: 29, scale: 2, idiom: "watch"),
        IconSize(platform: .watchOS, size: 29, scale: 3, idiom: "watch"),
        // Home Screen
        IconSize(platform: .watchOS, size: 40, scale: 2, idiom: "watch"),
        IconSize(platform: .watchOS, size: 44, scale: 2, idiom: "watch"),
        IconSize(platform: .watchOS, size: 46, scale: 2, idiom: "watch"),
        IconSize(platform: .watchOS, size: 50, scale: 2, idiom: "watch"),
        // Short Look
        IconSize(platform: .watchOS, size: 86, scale: 2, idiom: "watch"),
        IconSize(platform: .watchOS, size: 98, scale: 2, idiom: "watch"),
        IconSize(platform: .watchOS, size: 108, scale: 2, idiom: "watch")
    ]

    static let appStoreSizes: [IconSize] = [
        IconSize(platform: .appStore, size: 1024, scale: 1, idiom: "ios-marketing")
    ]
}
