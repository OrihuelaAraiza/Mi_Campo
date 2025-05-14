//
//  ConsejoCarrusel.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//

import SwiftUI

struct Consejo: Identifiable {
    let id = UUID()
    let titulo: String
    let descripcion: String
    let icono: String
}

struct CarouselStyleView: View {
    let consejos: [Consejo] = [
        Consejo(titulo: "Riega temprano", descripcion: "Evita la evaporación regando al amanecer 🌅", icono: "drop.fill"),
        Consejo(titulo: "Revisa tus hojas", descripcion: "Hojas amarillas pueden ser exceso de agua 🍃", icono: "leaf.fill"),
        Consejo(titulo: "Observa el clima", descripcion: "Adapta tus tareas según la temperatura ☀️", icono: "sun.max.fill"),
        Consejo(titulo: "Fertiliza correctamente", descripcion: "El fertilizante ideal depende del suelo", icono: "bolt.circle.fill"),
        Consejo(titulo: "Ventilación importa", descripcion: "Evita plagas manteniendo aire fresco 🌬️", icono: "wind")
    ]

    @State private var currentIndex = 0
    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 12) {
            TabView(selection: $currentIndex) {
                ForEach(consejos.indices, id: \.self) { i in
                    let consejo = consejos[i]
                    
                    VStack(spacing: 12) {
                        Image(systemName: consejo.icono)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color("PrimaryGreen"))

                        Text(consejo.titulo)
                            .font(.title3.bold())
                            .foregroundColor(Color("TextBlack"))

                        Text(consejo.descripcion)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 4)
                    .padding(.horizontal, 20)
                    .tag(i)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 260)
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % consejos.count
                }
            }
        }
        .padding(.bottom, 20)
    }
}
