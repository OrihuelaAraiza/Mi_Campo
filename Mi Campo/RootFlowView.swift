//
//  RootFlowView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI

struct RootFlowView: View {
    @State private var showSplash = true
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore = false
    @AppStorage("userRole") var userRole = ""

    var body: some View {
        Group {
            if showSplash {
                SplashScreenView(isActive: $showSplash)
            } else {
                if !hasLaunchedBefore {
                    WelcomeView()
                } else {
                    MainTabView() // o HomeComercianteView() si aún no tienes más vistas
                }
            }
        }
    }
}
