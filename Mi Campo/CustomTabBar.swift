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
        HStack {
            Spacer()

            Button(action: {
                selected = "Inicio"
            }) {
                VStack {
                    Image(systemName: "house.fill")
                    Text("Inicio")
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
                }
                .foregroundColor(selected == "Comunidad" ? Color("PrimaryGreen") : .gray)
            }

            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.95))
        .cornerRadius(20)
    }
}
