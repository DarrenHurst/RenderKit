//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-10-11.
//

import Foundation
import SwiftUI

protocol TableOptions {
    var  sectionSeperator: Visibility { get set }
}
 
enum TableListStyle: String, CaseIterable, Hashable {
    case grouped = "Grouped"
    case inset = "Inset"
    case insetGrouped = "InsetGrouped"
    case plain = "Plain"
    case sidebar = "Sidebar"
    
    // map to SwiftUI ListStyle
    var style: any SwiftUI.ListStyle {
        switch self {
        case .grouped:
            if #available(iOS 16, *) {
                return .grouped
            } else {
                return .plain
            }
        case .inset:
            return .inset
        case .insetGrouped:
            if #available(iOS 16, *) {
                return .insetGrouped
            } else {
                return .plain
            }
        case .plain:
            return .plain
        case .sidebar:
            return .sidebar
        }
    }
    
    var displayName: String {
        String(localized: String.LocalizationValue(self.rawValue))
    }
}
