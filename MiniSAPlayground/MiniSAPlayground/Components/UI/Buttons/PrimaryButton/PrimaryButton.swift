//
//  PrimaryButton.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import Foundation
import SwiftUI

struct PrimaryButton: View {
    enum Size {
        case small
        case medium
        case large
        
        var height: CGFloat {
            switch self {
            case .small: return 32
            case .medium: return 44
            case .large: return 56
            }
        }
        
        var horizontalPadding: CGFloat {
            switch self {
            case .small: return 12
            case .medium: return 16
            case .large: return 20
            }
        }
        
        var typography: Typography {
            switch self {
            case .small: return .bodySmall
            case .medium: return .bodyRegular
            case .large: return .bodyMedium
            }
        }
    }
    
    // MARK: - Properties
    let title: String
    let action: () -> Void
    let cornerRadius: CGFloat
    let size: Size
    
    // MARK: - Optional Properties with Default Values
    var isEnabled: Bool = true
    var foregroundColor: Color = ColorToken.labelStaticWhite.color
    var backgroundColor: Color = Color.blue
    
    // MARK: - Init
    init(
        title: String,
        action: @escaping () -> Void,
        cornerRadius: CGFloat = 8,
        size: Size = .medium
    ) {
        self.title = title
        self.action = action
        self.cornerRadius = cornerRadius
        self.size = size
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
            Text(title)
                .typography(size.typography)
                .colorToken(.labelStaticWhite)
                .frame(maxWidth: .infinity, minHeight: size.height)
                .padding(.horizontal, size.horizontalPadding)
        }
        .background(isEnabled ? backgroundColor : backgroundColor.opacity(0.5))
        .cornerRadius(cornerRadius)
        .disabled(!isEnabled)
    }
    
    // MARK: - Modifiers
    func disabled(_ disabled: Bool) -> PrimaryButton {
        var button = self
        button.isEnabled = !disabled
        return button
    }
    
    func foregroundColor(_ color: Color) -> PrimaryButton {
        var button = self
        button.foregroundColor = color
        return button
    }
    
    func backgroundColor(_ color: Color) -> PrimaryButton {
        var button = self
        button.backgroundColor = color
        return button
    }
}

// MARK: - Preview
struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            PrimaryButton(
                title: "Small Button",
                action: {},
                size: .small
            )
            .frame(width: 200)
            
            PrimaryButton(
                title: "Medium Button",
                action: {},
                size: .medium
            )
            .frame(width: 250)
            
            PrimaryButton(
                title: "Large Button",
                action: {},
                size: .large
            )
            .frame(width: 300)
            
            PrimaryButton(
                title: "Custom Radius",
                action: {},
                cornerRadius: 20,
                size: .medium
            )
            .backgroundColor(.green)
            .frame(width: 250)
            
            PrimaryButton(
                title: "Disabled Button",
                action: {},
                size: .medium
            )
            .disabled(true)
            .frame(width: 250)
        }
        .padding()
    }
}
