//
//  WeatherWeeklySheet.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//

import SwiftUI

struct WeatherWeeklySheet: View {
    let forecast: [DailyWeather]

    var body: some View {
        VStack(spacing: 20) {
            Text("Pronóstico semanal")
                .font(.title.bold())

            ForEach(forecast) { day in
                HStack(spacing: 12) {
                    Image(systemName: day.icon)
                        .foregroundColor(.orange)
                        .font(.title2)

                    VStack(alignment: .leading) {
                        Text(day.day)
                            .font(.headline)
                        Text(day.description)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()
                    Text("\(day.temp)°C")
                        .font(.title3.bold())
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .background(Color("YellowBackground").ignoresSafeArea())
    }
}
