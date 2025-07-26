//
//  ColorToken.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import Foundation
import SwiftUI

enum ColorToken: String, CaseIterable {
    case labelDefault
    case labelStaticWhite
    case labelDisabled
    
    case backgroundDefault
    case backgroundDisabled

    case borderDisabled
    case borderDefault
    case borderStaticWhite
    
    case buttonActive // blue
    case buttonDisabled // gray disabled
    case buttonWarning // yellow
    case buttonNegative // red
    
    var color: Color {
        switch self {
        case .labelDefault:
            return Color(red: 0, green: 0, blue: 0)
        case .labelStaticWhite:
            return Color(red: 1, green: 1, blue: 1)
        case .labelDisabled:
            return Color(red: 0.6, green: 0.6, blue: 0.6)
        case .backgroundDefault:
            return Color(red: 0.95, green: 0.95, blue: 0.95)
        case .backgroundDisabled:
            return Color(red: 0.8, green: 0.8, blue: 0.8)
        case .borderDisabled:
            return Color(red: 0.8, green: 0.8, blue: 0.8)
        case .borderDefault:
            return Color(red: 0.9, green: 0.9, blue: 0.9)
        case .borderStaticWhite:
            return Color(red: 1, green: 1, blue: 1)
        case .buttonActive:
            return Color(red: 0.0, green: 0.5, blue: 1.0) // Blue
        case .buttonDisabled:
            return Color(red: 0.8, green: 0.8, blue: 0.8) // Gray Disabled
        case .buttonWarning:
            return Color(red: 1.0, green: 0.85, blue: 0.0) // Yellow
        case .buttonNegative:
            return Color(red: 1.0, green: 0.0, blue: 0.0) // Red
        }
    }
    
    var uiColor: UIColor {
        UIColor(self.color)
    }
}

// Extension for SwiftUI View
extension View {
    func colorToken(_ token: ColorToken) -> some View {
        self.foregroundColor(token.color)
    }
}

// Extension for UIKit
extension UILabel {
    func setColorToken(_ token: ColorToken) {
        self.textColor = token.uiColor
    }
}
