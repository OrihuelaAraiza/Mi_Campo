//
//  MainTabView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: String = "Inicio"
    @StateObject private var cultivoVM = CultivoViewModel()

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                selectedContentView()

                CustomTabBar(selected: $selectedTab)
                    .padding(.bottom, 8)
            }
            .background(Color("YellowBackground").ignoresSafeArea())
            .ignoresSafeArea(.keyboard)
        }
    }

    @ViewBuilder
    private func selectedContentView() -> some View {
        switch selectedTab {
        case "Inicio":
            HomeComercianteView(viewModel: cultivoVM)
        case "Mis cultivos":
            MyCropsView()
        case "Comunidad":
            CommunityView()
        default:
            HomeComercianteView(viewModel: cultivoVM)
        }
    }
}
