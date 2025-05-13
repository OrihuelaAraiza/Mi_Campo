//
//  WeeklyWeatherView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//

import SwiftUI

struct DailyForecast: Identifiable {
    let id = UUID()
    let day: String
    let temperature: String
    let condition: String
    let recommendation: String
}

struct WeeklyWeatherView: View {
    let forecast: [DailyForecast]

    var body: some View {
        NavigationView {
            List(forecast) { day in
                VStack(alignment: .leading, spacing: 6) {
                    Text("📅 \(day.day)").font(.title3.bold())
                    Text("🌡️ \(day.temperature)").font(.footnote)
                    Text("☁️ \(day.condition)").font(.caption2.italic())
                    Text("🌱 Recomendación: \(day.recommendation)").font(.caption)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Clima semanal")
        }
    }
}
