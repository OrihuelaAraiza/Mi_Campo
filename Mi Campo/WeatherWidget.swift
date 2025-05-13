//
//  WeatherWidget.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//

import SwiftUI

struct WeatherWidget: View {
    let temperature: String
    let condition: String
    let iconName: String
    var refreshAction: () -> Void
    var forecast: [DailyWeather]

    @State private var isLoading = false
    @State private var animate = false
    @State private var showToast = false
    @State private var showWeeklySheet = false

    var body: some View {
        VStack {
            Button {
                showWeeklySheet = true
            } label: {
                HStack {
                    Image(systemName: iconName)
                        .font(.system(size: 40))
                        .rotationEffect(.degrees(animate ? 3 : -3))
                        .foregroundColor(.orange)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: animate)
                        .onAppear { animate = true }

                    VStack(alignment: .leading) {
                        Text("Clima actual")
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(temperature)
                            .font(.title2.bold())
                            .foregroundColor(.black)
                        Text(condition)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Button(action: {
                        isLoading = true
                        refreshAction()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading = false
                            showToast = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                showToast = false
                            }
                        }
                    }) {
                        if isLoading {
                            ProgressView()
                        } else {
                            Image(systemName: "arrow.clockwise.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                        }
                    }
                    .disabled(isLoading)
                }
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(16)
            }
            .sheet(isPresented: $showWeeklySheet) {
                WeatherSummaryView(forecast: forecast)
            }

            if showToast {
                Text("Clima actualizado")
                    .font(.caption)
                    .foregroundColor(.green)
                    .transition(.opacity)
            }
        }
    }
}
