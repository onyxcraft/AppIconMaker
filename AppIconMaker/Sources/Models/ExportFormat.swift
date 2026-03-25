//
//  ExportFormat.swift
//  AppIconMaker
//
//  Created by AppIconMaker
//

import Foundation

enum ExportFormat: String, CaseIterable {
    case pngFolder = "PNG Folder"
    case xcassets = "Xcode Asset Catalog (.xcassets)"

    var fileExtension: String {
        switch self {
        case .pngFolder: return ""
        case .xcassets: return "xcassets"
        }
    }

    var description: String {
        switch self {
        case .pngFolder:
            return "Export all icons as individual PNG files in a folder"
        case .xcassets:
            return "Export as Xcode .xcassets bundle ready to drop into your project"
        }
    }
}
