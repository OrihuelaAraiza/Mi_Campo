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
                    .ignoresSafeArea(.keyboard)

                CustomTabBar(selected: $selectedTab)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: -2)
                    .ignoresSafeArea(edges: .bottom) // 👈 esto asegura que se vaya al fondo
            }
            .background(Color("YellowBackground").ignoresSafeArea())
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
