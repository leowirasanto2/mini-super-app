//
//  ContentView.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import SwiftUI
import Nebula

struct ContentView: View {
    var body: some View {
        VStack(spacing: .regular) {
            Text("Hello, world!")
                .typography(.titleLarge)
            Text("This is a subtitle with longer text to demonstrate the typography style.")
                .typography(.bodyRegular)
            Text("Many thing is coming")
                .typography(.captionRegular)
                .colorToken(.labelDisabled)
            
            PrimaryButton(title: "Excited!") {
                //no op
            }
            .paddingVertical(.large)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
