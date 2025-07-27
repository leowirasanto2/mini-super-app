//
//  AppController.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 27/07/25.
//

import Combine
import Foundation

final class AppController: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isShowingToast: Bool = false
    @Published var toastMessage = ""
    
    @Published var registeredUsername: String?
    @Published var registeredPassword: String?

    func setUserLoggedIn() {
        isLoggedIn = true
    }

    func setUserLoggedOut() {
        isLoggedIn = false
    }
    
    func showToast(message: String) {
        isShowingToast = true
        toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isShowingToast = false
            self.toastMessage = ""
        }
    }
    
    func updateRegisteredUser(username: String, password: String) {
        registeredUsername = username
        registeredPassword = password
    }
}
