//
//  CosechaMetricsCard.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//
import SwiftUI

struct CosechaMetricsCard: View {
    var cosecha: Cosecha

    var utilidad: Double {
        cosecha.ganancia - cosecha.costo
    }

    var estadoEmoji: String {
        if utilidad > 0 { return "😄" }
        else if utilidad == 0 { return "😐" }
        else { return "😞" }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("🌿 \(cosecha.cultivo)")
                .font(.headline)

            HStack {
                Text("🗓️ Siembra: \(cosecha.fechaSiembra)")
                Spacer()
                Text("🌾 Cosecha: \(cosecha.fechaCosecha)")
            }

            Text("📦 Cantidad cosechada: \(cosecha.cantidad) kg")
            Text("💰 Ganancia: $\(Int(cosecha.ganancia))")
            Text("💸 Costo: $\(Int(cosecha.costo))")
            Text("📈 Utilidad: $\(Int(utilidad)) \(estadoEmoji)")

            if !cosecha.problemas.isEmpty {
                Text("⚠️ Problemas: \(cosecha.problemas.joined(separator: ", "))")
            }

            // Visuales
            HStack {
                Text("🧺")
                    .font(.title)
                    .repeatView(cosecha.cantidad / 20)
                Spacer()
                Text("🪙")
                    .font(.title2)
                    .repeatView(Int(cosecha.ganancia / 100))
                Spacer()
                Text("💵")
                    .font(.title2)
                    .repeatView(Int(cosecha.costo / 200))
                Spacer()
                Text(estadoEmoji)
                    .font(.largeTitle)
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(16)
    }
}

extension Text {
    func repeatView(_ times: Int) -> some View {
        HStack(spacing: 2) {
            ForEach(0..<min(times, 10), id: \.self) { _ in self }
        }
    }
}
