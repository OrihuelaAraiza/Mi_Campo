//
//  MyCropsView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI

struct Crop: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let progress: String
}

struct MyCropsView: View {
    let crops = [
        Crop(name: "Zanahoria", icon: "🥕", progress: "Riego pendiente"),
        Crop(name: "Lechuga", icon: "🥬", progress: "Listo para cosechar"),
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Mis Cultivos")
                    .font(.largeTitle.bold())
                    .padding(.top)
                    .foregroundColor(Color("TextBlack"))
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(crops) { crop in
                            HStack {
                                Text(crop.icon)
                                    .font(.largeTitle)
                                
                                VStack(alignment: .leading) {
                                    Text(crop.name)
                                        .font(.title2.bold())
                                        .foregroundColor(Color("TextBlack"))
                                    
                                    Text(crop.progress)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color("SoftWhite"))
                            .cornerRadius(16)
                            .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .background(Color("YellowBackground"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
