//
//  IconGenerationOptions.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import AppKit

struct IconGenerationOptions {
    var removeBackground: Bool = false
    var addRoundedCorners: Bool = false
    var backgroundColor: NSColor? = nil
    var cornerRadius: CGFloat = 0.2 // Percentage of icon size
    var includedPlatforms: Set<IconSize.Platform> = Set(IconSize.Platform.allCases)

    var hasBackgroundColor: Bool {
        backgroundColor != nil
    }
}
