//
//  AppController.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 27/07/25.
//

import Combine

final class AppController: ObservableObject {
    @Published var isLoggedIn: Bool = false

    func setUserLoggedIn() {
        print("++++")
        isLoggedIn = true
    }

    func setUserLoggedOut() {
        isLoggedIn = false
    }
}
