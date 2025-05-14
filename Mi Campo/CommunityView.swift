//
//  CommunityView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI

struct ConsejoDetalle: Identifiable {
    let id = UUID()
    let user: String
    let avatar: String
    let content: String
    let detalle: String
}

struct CommunityView: View {
    @State private var selectedTab = "Foro"
    @State private var selectedConsejo: ConsejoDetalle?
    @State private var showDetalle = false

    let consejos: [ConsejoDetalle] = [
        ConsejoDetalle(user: "Consejos de riego", avatar: "👩🏾‍🌾", content: "Riega en la mañana para evitar evaporación.", detalle: "El riego temprano ayuda a minimizar la pérdida de agua por evaporación y mantiene las raíces frescas."),
        ConsejoDetalle(user: "Éxito con hortalizas", avatar: "👨🏼‍🌾", content: "Usa composta natural, funciona mejor.", detalle: "La composta natural mejora la estructura del suelo y provee nutrientes esenciales para las plantas."),
        ConsejoDetalle(user: "Cultiva con abonos", avatar: "🧑🏽‍🌾", content: "Mejoran la tierra y los rendimientos.", detalle: "Los abonos orgánicos aumentan la fertilidad del suelo y promueven microorganismos beneficiosos."),
        ConsejoDetalle(user: "Evita plagas", avatar: "🧓🏿", content: "Planta albahaca cerca de tomates.", detalle: "La albahaca ayuda a repeler insectos que comúnmente atacan los tomates."),
        ConsejoDetalle(user: "Cosecha inteligente", avatar: "👨🏻‍🌾", content: "Cosecha por la tarde en días secos.", detalle: "Las tardes secas reducen el riesgo de enfermedades post-cosecha."),
        ConsejoDetalle(user: "Cuidado del suelo", avatar: "👩🏽‍🌾", content: "No pises la tierra húmeda.", detalle: "Evitar pisar el suelo húmedo previene su compactación y mejora la oxigenación.")
    ]

    var body: some View {
        VStack(spacing: 0) {
            Text("Comunidad")
                .font(.largeTitle.bold())
                .foregroundColor(Color("TextBlack"))
                .padding(.horizontal)
                .padding(.top)

            Picker("", selection: $selectedTab) {
                Text("Foro").tag("Foro")
                Text("Mercado").tag("Mercado")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            ScrollView {
                VStack(spacing: 16) {
                    if selectedTab == "Foro" {
                        ForEach(consejos) { consejo in
                            Button(action: {
                                selectedConsejo = consejo
                                showDetalle = true
                            }) {
                                CommunityPost(user: consejo.user, avatar: consejo.avatar, content: consejo.content)
                            }
                        }
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
                        CommunityMarketItem(
                                                   emoji: "🌽",
                                                   nombre: "Elotes frescos",
                                                   productor: "Juana",
                                                   precio: "$12/kg",
                                                   telefono: "55 9876 5432",
                                                   cantidadDisponible: "150 kg"
                                               )

                                               CommunityMarketItem(
                                                   emoji: "🥬",
                                                   nombre: "Lechugas orgánicas",
                                                   productor: "Carlos",
                                                   precio: "$8/kg",
                                                   telefono: "55 6543 2109",
                                                   cantidadDisponible: "60 kg"
                                               )

                                               CommunityMarketItem(
                                                   emoji: "🍓",
                                                   nombre: "Fresas dulces",
                                                   productor: "Andrea",
                                                   precio: "$25/kg",
                                                   telefono: "55 3322 1100",
                                                   cantidadDisponible: "40 kg"
                                               )

                                               CommunityMarketItem(
                                                   emoji: "🧅",
                                                   nombre: "Cebollas blancas",
                                                   productor: "Rogelio",
                                                   precio: "$6/kg",
                                                   telefono: "55 4433 2211",
                                                   cantidadDisponible: "90 kg"
                                               )
                    }
                }
                .padding(.top, 8)
                .padding(.horizontal)
                .transition(.opacity.combined(with: .slide))
            }

            Spacer()
        }
        .background(Color("YellowBackground").ignoresSafeArea())
        .animation(.easeInOut(duration: 0.3), value: selectedTab)
        .sheet(item: $selectedConsejo) { consejo in
            VStack(spacing: 20) {
                Text(consejo.avatar)
                    .font(.system(size: 60))
                Text(consejo.user)
                    .font(.title2.bold())
                Text(consejo.detalle)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                Button("Cerrar") {
                    showDetalle = false
                    selectedConsejo = nil
                }
                .padding()
                .background(Color("PrimaryGreen"))
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding()
        }
    }
}
