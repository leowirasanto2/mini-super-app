//
//  InfoSheetController.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import SwiftUI
import Combine

final class InfoSheetController: ObservableObject {
    @Published var showUnavailableFeatureSheet: Bool = false

    func presentUnavailableFeature() {
        showUnavailableFeatureSheet = true
    }

    func dismissUnavailableFeature() {
        showUnavailableFeatureSheet = false
    }
}
