//
//  LoginScreen.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import SwiftUI
import Nebula

struct LoginScreen: View {
    @Binding var path: NavigationPath
    @EnvironmentObject var sheetController: InfoSheetController

    var body: some View {
        VStack(spacing: Spacing.default) {
            NebulaIllustration.teamPeople.image
            VStack(spacing: .small){
                Text("Hello")
                    .typography(.titleLarge)

                Text("Welcome to UR Everything, where you can do anything")
                    .typography(.bodyRegular)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
                    .paddingHorizontal(.large)
            }

            VStack(spacing: Spacing.default) {
                PrimaryButton(
                    title: "Login",
                    action: {
                        path.append(Screen.loginForm)
                    },
                    cornerRadius: .infinity,
                    size: .medium,
                    buttonType: .active)

                SecondaryButton(
                    title: "Sign Up",
                    action: {
                        //TODO: add signup action
                        DispatchQueue.main.async {
                            sheetController.presentUnavailableFeature()
                        }
                    },
                    cornerRadius: .infinity,
                    buttonType: .active)
            }
            .paddingVertical(.regular)
            .frame(width: UIScreen.main.bounds.width * 0.7)
        }
    }
}

#Preview {
    LoginScreen(path: .constant(NavigationPath()))
        .environmentObject(InfoSheetController())
}
