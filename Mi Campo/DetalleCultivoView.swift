//
//  DetalleCultivoView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//

import SwiftUI

struct DetalleCultivoView: View {
    let cultivo: Cultivo

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("🌱 \(cultivo.nombre)")
                    .font(.largeTitle.bold())
                    .padding(.top)

                InfoRow(label: "🧪 Tipo", value: cultivo.tipo)
                InfoRow(label: "📦 Cantidad", value: cultivo.cantidad)
                InfoRow(label: "🌾 Área", value: cultivo.area)
                InfoRow(label: "🌍 Suelo", value: cultivo.suelo)
                InfoRow(label: "🎓 Experiencia", value: cultivo.experiencia)

                Spacer()
            }
            .padding()
        }
        .background(Color("YellowBackground").ignoresSafeArea())
        .navigationTitle("Detalles del cultivo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoRow: View {
    var label: String
    var value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.title3)
                .frame(width: 120, alignment: .leading)
            Spacer()
            Text(value)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(12)
    }
}
