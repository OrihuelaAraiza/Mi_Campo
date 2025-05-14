//
//  MyCropsView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//
//

import SwiftUI

struct MyCropsView: View {
    @State private var showChatbot = false
    @State private var showDetector = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Mis Cultivos")
                    .font(.largeTitle.bold())
                    .foregroundColor(Color("TextBlack"))
                    .padding(.top)
                    .padding(.horizontal)

            
                CarouselStyleView()

                VStack(spacing: 16) {
                   
                    NavigationLink(destination: PhotoAnalyzerView()) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Revisa la salud de tus cultivos")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Toma una foto o sube una imagen para detectar plagas o enfermedades")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color("PrimaryGreen"))
                        .cornerRadius(20)
                        .shadow(radius: 4)
                    }

              
                    Button(action: {
                        showChatbot = true
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "message.circle.fill")
                                .font(.title)
                            Text("Abrir asistente")
                                .font(.headline)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .background(Color("YellowBackground").ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showChatbot) {
                ChatView()
            }
        }
    }
}
