//
//  WeatherSummaryView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//

import SwiftUI

struct WeatherSummaryView: View {
    let forecast: [DailyWeather]

    var body: some View {
        VStack(spacing: 16) {
            Text("🌤️ Pronóstico semanal")
                .font(.largeTitle.bold())
                .padding(.top)

            if forecast.isEmpty {
                ProgressView("Cargando clima...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else {
                ScrollView {
                    ForEach(forecast) { day in
                        HStack(spacing: 16) {
                            Image(systemName: day.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.orange)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(day.day)
                                    .font(.title3.bold())
                                Text(day.description)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }

                            Spacer()

                            Text("\(day.temp)°C")
                                .font(.title2)
                                .bold()
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        .padding(.horizontal)
                    }
                }
            }

            Spacer()
        }
        .background(Color("YellowBackground").ignoresSafeArea())
    }
}
