//
//  UnavailableFeatureSheetView.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import Nebula
import SwiftUI

struct UnavailableFeatureSheetView: View {
    var body: some View {
        VStack(spacing: Spacing.medium) {
            NebulaIllustration.hotAirBalloon.image
            VStack(spacing: Spacing.default) {
                Text("Oops, not quite ready!")
                    .typography(.titleRegular)
                Text("This feature is currently under construction. Our devs are working their magic, check back soon! 🛠️✨")
                    .multilineTextAlignment(.center)
                    .typography(.bodyRegular)
                    .paddingHorizontal(.regular)
            }
        }
    }
}

#Preview {
    UnavailableFeatureSheetView()
}
