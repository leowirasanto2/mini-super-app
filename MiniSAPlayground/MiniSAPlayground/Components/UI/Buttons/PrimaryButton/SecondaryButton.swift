//
//  SecondaryButton.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import Foundation
import SwiftUI

struct SecondaryButton: View {
    enum ButtonState: Equatable {
        case active
        case negative
        case warning
        case disabled
        
        var borderColor: Color {
            switch self {
            case .active:
                return ColorToken.buttonActive.color
            case .negative:
                return ColorToken.buttonNegative.color
            case .warning:
                return ColorToken.buttonWarning.color
            case .disabled:
                return ColorToken.buttonDisabled.color
            }
        }
        
        var textColor: Color {
            switch self {
            case .active:
                return ColorToken.buttonActive.color
            case .negative:
                return ColorToken.buttonNegative.color
            case .warning:
                return ColorToken.buttonWarning.color
            case .disabled:
                return ColorToken.buttonDisabled.color
            }
        }
    }
    
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
            case .small: return .bodyMedium
            case .medium: return .bodyMedium
            case .large: return .titleRegular
            }
        }
    }
    
    // MARK: - Properties
    let title: String
    let action: () -> Void
    let cornerRadius: CGFloat
    let size: Size
    let buttonState: ButtonState
    
    // MARK: - Optional Properties with Default Values
    var borderWidth: CGFloat = 2
    
    // MARK: - Init
    init(
        title: String,
        action: @escaping () -> Void,
        cornerRadius: CGFloat = 8,
        size: Size = .medium,
        buttonState: ButtonState = .active
    ) {
        self.title = title
        self.action = action
        self.cornerRadius = cornerRadius
        self.size = size
        self.buttonState = buttonState
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            if buttonState != .disabled {
                action()
            }
        }) {
            Text(title)
                .typography(size.typography)
                .foregroundColor(buttonState.textColor)
                .frame(maxWidth: .infinity, minHeight: size.height)
                .padding(.horizontal, size.horizontalPadding)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(buttonState.borderColor, lineWidth: borderWidth)
                )
        }
        .cornerRadius(cornerRadius)
        .disabled(buttonState == .disabled)
    }
    
    // MARK: - Modifiers
    func borderWidth(_ width: CGFloat) -> SecondaryButton {
        var button = self
        button.borderWidth = width
        return button
    }
}

// MARK: - Preview
struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: Spacing.default) {
            SecondaryButton(
                title: "Small Button",
                action: {},
                size: .small
            )
            
            SecondaryButton(
                title: "Medium Button",
                action: {},
                size: .medium
            )
            
            SecondaryButton(
                title: "Large Button",
                action: {},
                size: .large
            )
            
            SecondaryButton(
                title: "Custom Radius",
                action: {},
                cornerRadius: 20,
                size: .medium
            )
            
            SecondaryButton(
                title: "Disabled Button",
                action: {},
                size: .medium,
                buttonState: .disabled
            )
            
            SecondaryButton(
                title: "Warning Button",
                action: {},
                size: .medium,
                buttonState: .warning
            )
            
            SecondaryButton(
                title: "Negative Button",
                action: {},
                size: .medium,
                buttonState: .negative
            )
            
            SecondaryButton(
                title: "Thick Border",
                action: {},
                size: .medium
            )
            .borderWidth(5)
        }
        .padding()
    }
}
