//
//  SignupScreen.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import SwiftUI
import Nebula

struct SignupScreen: View {
    @State var usernameText = ""
    @State var emailText = ""
    @State var passwordText = ""
    @State var passwordValidateText = ""
    @State var isValidatePasswordFieldAppear = false
    @State var isLoadingSignUp = false
    @State var isFormValid = false
    
    @Binding var path: NavigationPath
    @EnvironmentObject var sheetController: InfoSheetController
    @EnvironmentObject var appController: AppController
    
    var body: some View {
        VStack(spacing: Spacing.default) {
            NebulaIllustration.strategy.image
            
            MSAInputField(
                text: $usernameText,
                placeholder: "Name",
                inputType: .text
            )
            
            MSAInputField(
                text: $emailText,
                placeholder: "Email",
                inputType: .email
            )
            
            MSAInputField(
                text: $passwordText,
                placeholder: "Enter your password",
                inputType: .password
            )
            
            if isValidatePasswordFieldAppear {
                MSAInputField(
                    text: $passwordValidateText,
                    placeholder: "Re-Enter your password",
                    inputType: .password
                )
            }
            
            if isFormValid {
                PrimaryButton(
                    title: "Sign Up",
                    action: {
                        isLoadingSignUp = true
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.isLoadingSignUp = false
                            self.appController.showToast(message: "Welcome \(self.usernameText)! You are all set.")
                            self.appController.updateRegisteredUser(username: usernameText, password: passwordText)
                            self.path = NavigationPath([Screen.loginForm])
                        }
                    }
                )
                .loading(isLoadingSignUp)
            }
        }
        .paddingHorizontal(.regular)
        .onChange(of: usernameText) { _, _ in
            validateForm()
        }
        .onChange(of: emailText) { _, _ in
            validateForm()
        }
        .onChange(of: passwordText) { _, newValue in
            withAnimation {
                isValidatePasswordFieldAppear = passwordText.count >= 6
            }
            validateForm()
        }
        .onChange(of: passwordValidateText) { _, _ in
            validateForm()
        }
    }
    
    private func validateForm() {
        let isUsernameValid = !usernameText.trimmingCharacters(in: .whitespaces).isEmpty
        let isEmailValid = emailText.contains("@") && emailText.contains(".")
        let isPasswordValid = passwordText.count >= 6
        let isPasswordMatch = !isValidatePasswordFieldAppear || passwordText == passwordValidateText
        
        isFormValid = isUsernameValid && isEmailValid && isPasswordValid && isPasswordMatch
    }
}

#Preview {
    SignupScreen(
        path: .constant(
            NavigationPath()
        )
    )
    .environmentObject(InfoSheetController())
    .environmentObject(AppController())
}
