//
//  CustomTabBar.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selected: String

    var body: some View {
        VStack(spacing: 0) {
           
            HStack {
                Spacer()

                Button(action: {
                    selected = "Inicio"
                }) {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Inicio")
                            .font(.caption)
                    }
                    .foregroundColor(selected == "Inicio" ? Color("PrimaryGreen") : .gray)
                }

                Spacer()

                Button(action: {
                    selected = "Mis cultivos"
                }) {
                    VStack {
                        Image(systemName: "leaf.fill")
                        Text("Mis cultivos")
                            .font(.caption)
                    }
                    .foregroundColor(selected == "Mis cultivos" ? Color("PrimaryGreen") : .gray)
                }

                Spacer()

                Button(action: {
                    selected = "Comunidad"
                }) {
                    VStack {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                        Text("Comunidad")
                            .font(.caption)
                    }
                    .foregroundColor(selected == "Comunidad" ? Color("PrimaryGreen") : .gray)
                }

                Spacer()
            }
            .padding(.top, 8)
            .padding(.bottom, 12)
            .background(Color.white)
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(edges: .bottom) // ← Muy importante para bajar la barra hasta el borde
    }
}
