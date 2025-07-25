//
//  Typography.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import Foundation
import SwiftUI

enum Typography: String, CaseIterable {
    // Title styles
    case titleRegular
    case titleLarge
    
    // Subtitle style
    case subtitle
    
    // Body styles
    case bodyMedium
    case bodySmall
    case bodyRegular
    
    // Caption styles
    case captionRegular
    case captionSmall
    case captionMedium
    
    var font: Font {
        switch self {
        // Title styles
        case .titleRegular:
            return Font.system(size: 18, weight: .semibold)
        case .titleLarge:
            return Font.system(size: 24, weight: .bold)
            
        // Subtitle style
        case .subtitle:
            return Font.system(size: 16, weight: .medium)
            
        // Body styles
        case .bodyRegular:
            return Font.system(size: 14, weight: .regular)
        case .bodyMedium:
            return Font.system(size: 14, weight: .medium)
        case .bodySmall:
            return Font.system(size: 12, weight: .regular)
            
        // Caption styles
        case .captionRegular:
            return Font.system(size: 10, weight: .regular)
        case .captionSmall:
            return Font.system(size: 8, weight: .regular)
        case .captionMedium:
            return Font.system(size: 10, weight: .medium)
        }
    }
    
    var uiFont: UIFont {
        switch self {
        // Title styles
        case .titleRegular:
            return UIFont.systemFont(ofSize: 18, weight: .semibold)
        case .titleLarge:
            return UIFont.systemFont(ofSize: 24, weight: .bold)
            
        // Subtitle style
        case .subtitle:
            return UIFont.systemFont(ofSize: 16, weight: .medium)
            
        // Body styles
        case .bodyRegular:
            return UIFont.systemFont(ofSize: 14, weight: .regular)
        case .bodyMedium:
            return UIFont.systemFont(ofSize: 14, weight: .medium)
        case .bodySmall:
            return UIFont.systemFont(ofSize: 12, weight: .regular)
            
        // Caption styles
        case .captionRegular:
            return UIFont.systemFont(ofSize: 10, weight: .regular)
        case .captionSmall:
            return UIFont.systemFont(ofSize: 8, weight: .regular)
        case .captionMedium:
            return UIFont.systemFont(ofSize: 10, weight: .medium)
        }
    }
}

// Extension for SwiftUI View
extension View {
    func typography(_ style: Typography) -> some View {
        self.font(style.font)
    }
}

// Extension for UIKit
extension UILabel {
    func setTypography(_ style: Typography) {
        self.font = style.uiFont
    }
}
