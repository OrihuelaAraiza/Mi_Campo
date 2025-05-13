//
//  CultivoCard.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//

import SwiftUI

struct CultivoCard: View {
    let cultivo: Cultivo
    @Namespace private var animation

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
      
            Text(emojiForType(cultivo.tipo))
                .font(.system(size: 36))
                .frame(maxWidth: .infinity, alignment: .topTrailing)


            Text(cultivo.nombre)
                .font(.title3.bold())
                .frame(maxWidth: .infinity, alignment: .center)

     
            VStack(alignment: .leading, spacing: 4) {
                Text("🧪 Tipo: \(cultivo.tipo)").font(.footnote)
                Text("📦 Cantidad: \(cultivo.cantidad)").font(.footnote)
                Text("🌾 Área: \(cultivo.area)").font(.footnote)
                Text("🌍 Suelo: \(cultivo.suelo)").font(.caption2.italic())
                Text("🎓 Experiencia: \(cultivo.experiencia)").font(.caption2.italic())
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor(for: cultivo.tipo))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 4)
        .matchedGeometryEffect(id: cultivo.id, in: animation)
    }

    func backgroundColor(for tipo: String) -> Color {
        switch tipo.lowercased() {
            case "lechuga": return Color(hex: "#ccffcc")
            case "jitomate": return Color(hex: "#ffcccc")
            case "maíz": return Color(hex: "#fff2cc")
            case "calabaza": return Color(hex: "#ffe6cc")
            default: return Color(hex: "#e0e0e0")
        }
    }

    func emojiForType(_ tipo: String) -> String {
        switch tipo.lowercased() {
            case "lechuga": return "🥬"
            case "jitomate": return "🍅"
            case "maíz": return "🌽"
            case "calabaza": return "🎃"
            default: return "🪴"
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.replacingOccurrences(of: "#", with: ""))
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        self.init(
            .sRGB,
            red: Double((rgb >> 16) & 0xFF) / 255,
            green: Double((rgb >> 8) & 0xFF) / 255,
            blue: Double(rgb & 0xFF) / 255,
            opacity: 1
        )
    }
}
