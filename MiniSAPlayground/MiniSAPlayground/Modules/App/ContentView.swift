//
//  ContentView.swift
//  MiniSAPlayground
//
//  Created by Leo Wirasanto Laia on 26/07/25.
//

import SwiftUI
import Nebula

struct ContentView: View {
    @EnvironmentObject private var sheetController: InfoSheetController
    @EnvironmentObject private var appController: AppController
    @State private var path = NavigationPath()
    @State private var isSplashScreenFinished = false
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: .regular) {
                if appController.isLoggedIn {
                    Text("This is landing page")
                    
                    SecondaryButton(title: "Logout") {
                        withAnimation {
                            appController.setUserLoggedOut()
                        }
                    }
                    .paddingHorizontal(.regular)
                } else {
                    if !isSplashScreenFinished {
                        ZStack {
                            NebulaIllustration.beingCreative.image
                            VStack {
                                Spacer()
                                Text("v1.0.0")
                                    .typography(.captionRegular)
                                    .colorToken(.labelDisabled)
                                    .padding(.large)
                            }
                        }
                    } else {
                        LoginScreen(
                            path: $path
                        )
                    }
                }
            }
            .navigationDestination(for: Screen.self) { screen in
                let _ = print("Screen \(screen)")
                switch screen {
                case .loginForm:
                    LoginFormView(
                        path: $path
                    )
                default:
                    Text("Unavailable screen")
                        .onAppear {
                            sheetController.presentUnavailableFeature()
                        }
                }
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isSplashScreenFinished = true
                }
            }
        })
        .sheet(isPresented: $sheetController.showUnavailableFeatureSheet) {
            InfoSheet(
                showCloseButton: true,
                ctaButtonTitle: "Alright!",
                onCTAPressed: {
                    sheetController.dismissUnavailableFeature()
                },
                onClose: {
                    sheetController.dismissUnavailableFeature()
                },
                content: {
                    UnavailableFeatureSheetView()
                }
            )
            .environmentObject(sheetController)
            .presentationDetents([.height(380)])
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(InfoSheetController())
        .environmentObject(AppController())
}
