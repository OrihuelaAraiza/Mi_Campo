//
//  CommunityView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI

struct CommunityView: View {
    @State private var selectedTab = "Foro"

    var body: some View {
        VStack(spacing: 0) {
            // Encabezado
            Text("Comunidad")
                .font(.largeTitle.bold())
                .foregroundColor(Color("TextBlack"))
                .padding(.horizontal)
                .padding(.top)

            // Picker estilizado
            Picker("", selection: $selectedTab) {
                Text("Foro").tag("Foro")
                Text("Mercado").tag("Mercado")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            // Contenido scrollable
            ScrollView {
                VStack(spacing: 16) {
                    if selectedTab == "Foro" {
                        CommunityPost(user: "Consejos de riego", avatar: "👩🏾‍🌾", content: "Riega en la mañana para evitar evaporación.")
                        CommunityPost(user: "Éxito con hortalizas", avatar: "👨🏼‍🌾", content: "Usa composta natural, funciona mejor.")
                        CommunityPost(user: "Cultiva con abonos", avatar: "🧑🏽‍🌾", content: "Mejoran la tierra y los rendimientos.")
                    } else {
                        CommunityMarketItem()
                        CommunityMarketItem(
                            emoji: "🍅",
                            nombre: "Tomates",
                            productor: "Lucía",
                            precio: "$15/kg",
                            telefono: "55 1234 5678",
                            cantidadDisponible: "100 kg"
                        )
                        CommunityMarketItem(
                            emoji: "🥕",
                            nombre: "Zanahorias",
                            productor: "Mario",
                            precio: "$10/kg",
                            telefono: "55 7890 1234",
                            cantidadDisponible: "75 kg"
                        )
                    }
                }
                .padding(.top, 8)
                .transition(.opacity.combined(with: .slide))
            }

            Spacer()
        }
        .background(Color("YellowBackground").ignoresSafeArea())
        .animation(.easeInOut(duration: 0.3), value: selectedTab)
    }
}
