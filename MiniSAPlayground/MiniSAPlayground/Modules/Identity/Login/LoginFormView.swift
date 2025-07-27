//
//  LoginFormView.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import Foundation
import Nebula
import SwiftUI

struct LoginFormView: View {
    @State var usernameText: String = ""
    @State var passwordText: String = ""
    @State var isLoggingIn = false
    @State var loginFailedMessage: String?
    @Binding var path: NavigationPath
    @EnvironmentObject var sheetController: InfoSheetController
    @EnvironmentObject var appController: AppController
    
    var body: some View {
        VStack(spacing: Spacing.default) {
            NebulaIllustration.strategy.image
            
            MSAInputField(
                text: $usernameText,
                placeholder: "Username or email address",
                inputType: .text
            )
            
            MSAInputField(
                text: $passwordText,
                placeholder: "Enter your password",
                inputType: .password
            )
            
            VStack {
                PrimaryButton(
                    title: "Sign in",
                    action: {
                        signIn()
                    },
                    cornerRadius: .infinity,
                    size: .medium,
                    buttonType: .active
                )
                .loading(isLoggingIn)
                
                if !isLoggingIn {
                    SecondaryButton(
                        title: "Forgot password",
                        action: {
                            sheetController.presentUnavailableFeature()
                        },
                        cornerRadius: .infinity,
                        size: .medium,
                        buttonType: .active
                    )
                }
            }
        }
        .paddingHorizontal(.regular)
        .onAppear {
            if let username = appController.registeredUsername {
                self.usernameText = username
            }
        }
        .onChange(of: loginFailedMessage) { _, _ in
            if let message = loginFailedMessage {
                appController.showToast(message: message)
            }
        }
    }
    
    private func signIn() {
        guard !usernameText.isEmpty && !passwordText.isEmpty else {
            return
        }
        withAnimation {
            isLoggingIn = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoggingIn = false
            guard passwordText == appController.registeredPassword else {
                loginFailedMessage = "Incorrect password :("
                return
            }
            loginFailedMessage = nil
            path.removeLast()
            appController.setUserLoggedIn()
        }
    }
}

#Preview {
    LoginFormView(path: .constant(NavigationPath()))
        .environmentObject(InfoSheetController())
        .environmentObject(AppController())
}
