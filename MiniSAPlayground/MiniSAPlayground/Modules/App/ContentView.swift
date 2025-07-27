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
        ZStack {
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
                    switch screen {
                    case .loginForm:
                        LoginFormView(path: $path)
                    case .signupForm:
                        SignupScreen(path: $path)
                    default:
                        Text("Unavailable screen")
                            .onAppear {
                                sheetController.presentUnavailableFeature()
                            }
                    }
                }
            }
            
            if appController.isShowingToast {
                toastView
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
    
    private var toastView: some View {
        VStack {
            Spacer()
            Text(appController.toastMessage)
                .typography(.bodyMedium)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.regular)
                .background(ColorToken.labelStaticWhite.color)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: ColorToken.buttonActive.color, radius: 1)
        }
        .padding(.regular)
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeInOut, value: appController.isShowingToast)
    }
}

#Preview {
    ContentView()
        .environmentObject(InfoSheetController())
        .environmentObject(AppController())
}
