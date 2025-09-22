//
//  InfoSheet.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import Nebula
import SwiftUI
struct InfoSheet<Content: View>: View {
    let content: Content
    let showCloseButton: Bool
    let ctaButtonTitle: String?
    let onCTAPressed: (() -> Void)?
    let onClose: (() -> Void)?
    
    init(
        showCloseButton: Bool = true,
        ctaButtonTitle: String? = nil,
        onCTAPressed: (() -> Void)? = nil,
        onClose: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.showCloseButton = showCloseButton
        self.ctaButtonTitle = ctaButtonTitle
        self.onCTAPressed = onCTAPressed
        self.onClose = onClose
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if showCloseButton {
                HStack {
                    Spacer()
                    Button(action: {
                        onClose?()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
            }
            
            content
            
            if let ctaTitle = ctaButtonTitle {
                PrimaryButton(title: ctaTitle, action: {
                    onCTAPressed?()
                }, cornerRadius: .infinity)
                .paddingHorizontal(.regular)
                .paddingVertical(.regular)
            }
        }
        .background(ColorToken.backgroundPrimary.color)
    }
}

struct InfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        InfoSheet(
            showCloseButton: true,
            ctaButtonTitle: "Got it",
            onCTAPressed: { print("CTA Pressed") },
            onClose: { print("Close Pressed") }
        ) {
            UnavailableFeatureSheetView()
        }
    }
}
