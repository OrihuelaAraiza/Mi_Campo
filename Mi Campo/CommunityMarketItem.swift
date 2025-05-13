//
//  CommunityMarketItem.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI

struct CommunityMarketItem: View {
    var emoji: String = "🍅"
    var nombre: String = "Tomates"
    var productor: String = "Lucía"
    var precio: String = "$15/kg"
    var telefono: String = "55 1234 5678"
    var cantidadDisponible: String = "100 kg"

    @State private var showContact = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(emoji)
                    .font(.system(size: 36))
                VStack(alignment: .leading, spacing: 4) {
                    Text(nombre)
                        .font(.headline)
                    Text("Por: \(productor)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("📦 Disponible: \(cantidadDisponible)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                Text(precio)
                    .font(.subheadline.bold())
            }

            Button(action: {
                withAnimation {
                    showContact.toggle()
                }
            }) {
                Text("Me interesa")
                    .font(.subheadline.bold())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("PrimaryGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            if showContact {
                ContactoCard(
                    nombre: productor,
                    telefono: telefono,
                    cantidadDisponible: cantidadDisponible
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .padding()
        .background(Color.white.opacity(0.95))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 3)
        .padding(.horizontal)
    }
}

struct ContactoCard: View {
    var nombre: String
    var telefono: String
    var cantidadDisponible: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("📇 Contacto")
                .font(.headline)

            Text("👤 Nombre: \(nombre)")
            Text("📞 Teléfono: \(telefono)")
            Text("📦 Disponible: \(cantidadDisponible)")

            HStack(spacing: 16) {
                // Botón copiar
                Button(action: {
                    UIPasteboard.general.string = telefono
                }) {
                    HStack {
                        Image(systemName: "doc.on.doc.fill")
                        Text("Copiar")
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .foregroundColor(Color("PrimaryGreen"))
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                }

                // Botón llamar
                Button(action: {
                    if let url = URL(string: "tel://\(telefono.filter { $0.isNumber })") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text("Llamar")
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color("PrimaryGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("LightGreen").opacity(0.3))
        .cornerRadius(12)
    }
}
