//
//  PrimaryButton.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import Foundation
import SwiftUI

struct PrimaryButton: View {
    enum ButtonType: Equatable {
        case active
        case negative
        case warning
        case disabled
        
        var background: Color {
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
        
        var horizontalPadding: Spacing {
            switch self {
            case .small: return .small
            case .medium: return .medium
            case .large: return .large
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
    var foregroundColor: Color = ColorToken.labelStaticWhite.color
    var backgroundColor: Color = ColorToken.buttonActive.color
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
            if buttonType != .disabled && !isLoading {
                action()
            }
        }) {
            HStack {
                if isLoading {
                    ProgressView()
                        .tint(ColorToken.labelStaticWhite.color)
                } else {
                    Text(title)
                        .typography(size.typography)
                        .colorToken(.labelStaticWhite)
                }
            }
            .frame(maxWidth: .infinity, minHeight: size.height)
            .padding(.horizontal, size.horizontalPadding)
        }
        .background(buttonType.background)
        .cornerRadius(cornerRadius)
        .disabled(buttonType == .disabled || isLoading)
    }
    
    // MARK: - Modifiers
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
    
    // MARK: - Loading State
    func loading(_ isLoading: Bool) -> PrimaryButton {
        var button = self
        button.isLoading = isLoading
        return button
    }
}

// MARK: - Preview
struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: Spacing.default) {
            PrimaryButton(
                title: "Small Button",
                action: {},
                size: .small
            )
            
            PrimaryButton(
                title: "Medium Button",
                action: {},
                size: .medium
            )
            
            PrimaryButton(
                title: "Large Button",
                action: {},
                size: .large
            )
            
            PrimaryButton(
                title: "Custom Radius",
                action: {},
                cornerRadius: 20,
                size: .medium
            )
            
            PrimaryButton(
                title: "Disabled Button",
                action: {},
                size: .medium,
                buttonType: .disabled
            )
            
            PrimaryButton(
                title: "Loading Button",
                action: {},
                size: .medium
            )
            .loading(true)
        }
        .padding()
    }
}