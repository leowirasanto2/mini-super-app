//
//  SecondaryButton.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import Foundation
import SwiftUI

struct SecondaryButton: View {
    enum ButtonType: Equatable {
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
    let buttonType: ButtonType
    
    // MARK: - Optional Properties with Default Values
    var borderWidth: CGFloat = 2
    var isLoading = false
    
    // MARK: - Init
    init(
        title: String,
        action: @escaping () -> Void,
        cornerRadius: CGFloat = 8,
        size: Size = .medium,
        buttonType: ButtonType = .active
    ) {
        self.title = title
        self.action = action
        self.cornerRadius = cornerRadius
        self.size = size
        self.buttonType = buttonType
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            if buttonType != .disabled || !isLoading {
                action()
            }
        }) {
            HStack {
                if isLoading {
                    ProgressView()
                } else {
                    Text(isLoading ? "" : title)
                        .typography(size.typography)
                }
            }
            .foregroundColor(buttonType.textColor)
            .frame(maxWidth: .infinity, minHeight: size.height)
            .padding(.horizontal, size.horizontalPadding)
            .background(Color.clear)
        }
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(buttonType.borderColor, lineWidth: borderWidth)
        )
        .cornerRadius(cornerRadius)
        .disabled(buttonType == .disabled)
    }
    
    // MARK: - Modifiers
    func borderWidth(_ width: CGFloat) -> SecondaryButton {
        var button = self
        button.borderWidth = width
        return button
    }

    // MARK: - Loading State
    func loading(_ isLoading: Bool) -> SecondaryButton {
        var button = self
        button.isLoading = isLoading
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
                buttonType: .disabled
            )
            
            SecondaryButton(
                title: "Warning Button",
                action: {},
                size: .medium,
                buttonType: .warning
            )
            
            SecondaryButton(
                title: "Negative Button",
                action: {},
                size: .medium,
                buttonType: .negative
            )
            
            SecondaryButton(
                title: "Thick Border",
                action: {},
                size: .medium
            )
            .borderWidth(5)
            
            SecondaryButton(
                title: "Submit",
                action: {},
                size: .medium
            )
            .borderWidth(5)
            .loading(true)
        }
        .padding()
    }
}
