//
//  MiniSAPlaygroundApp.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import SwiftUI

@main
struct MiniSAPlaygroundApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(InfoSheetController())
                .environmentObject(AppController())
        }
    }
}
