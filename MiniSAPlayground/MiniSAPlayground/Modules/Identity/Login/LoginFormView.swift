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
        .frame(width: UIScreen.main.bounds.width * 0.7)
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
