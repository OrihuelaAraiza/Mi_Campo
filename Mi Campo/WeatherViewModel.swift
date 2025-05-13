//
//  WeatherViewModel.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//
import Foundation
import CoreLocation
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var temperature: String = "--"
    @Published var condition: String = "Cargando..."
    @Published var recommendedCrop: String? = nil
    @Published var weatherIcon: String = "cloud.fill"
    @Published var weeklyForecast: [DailyWeather] = []

    init() {
        loadWeatherFromStorage()
    }

    func fetchWeather(for location: CLLocation) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current_weather=true&daily=temperature_2m_max,weathercode&timezone=auto"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data,
               let response = try? JSONDecoder().decode(OpenMeteoWeeklyResponse.self, from: data) {
                DispatchQueue.main.async {
                    let current = response.current_weather
                    self.temperature = String(format: "%.0f°C", current.temperature)
                    self.condition = current.weatherDescription
                    self.recommendedCrop = current.recommendation
                    self.weatherIcon = current.systemImageName

                    let forecast = zip(response.daily.time, response.daily.temperature_2m_max).enumerated().map { index, pair in
                        DailyWeather(day: self.shortDayName(index), temp: Int(pair.1), code: response.daily.weathercode[index])
                    }

                    self.weeklyForecast = forecast

                    // Guardar en UserDefaults
                    UserDefaults.standard.saveWeatherForecast(forecast)
                    UserDefaults.standard.saveCurrentWeather(
                        temp: self.temperature,
                        cond: self.condition,
                        icon: self.weatherIcon
                    )
                }
            }
        }.resume()
    }

    private func loadWeatherFromStorage() {
        self.weeklyForecast = UserDefaults.standard.loadWeatherForecast()
        let saved = UserDefaults.standard.loadCurrentWeather()
        self.temperature = saved.0
        self.condition = saved.1
        self.weatherIcon = saved.2
    }

    private func shortDayName(_ index: Int) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_MX")
        formatter.dateFormat = "E"
        let date = Calendar.current.date(byAdding: .day, value: index, to: Date())!
        return formatter.string(from: date).capitalized
    }
}
// MARK: - Modelos para clima actual y predicción semanal

struct OpenMeteoWeeklyResponse: Codable {
    let current_weather: OpenMeteoCurrentWeather
    let daily: DailyData
}

struct OpenMeteoCurrentWeather: Codable {
    let temperature: Double
    let weathercode: Int

    var weatherDescription: String {
        switch weathercode {
        case 0: return "Despejado ☀️"
        case 1, 2, 3: return "Parcialmente nublado 🌤"
        case 45, 48: return "Niebla 🌫"
        case 51, 53, 55: return "Llovizna 🌧"
        case 61, 63, 65: return "Lluvia 🌧"
        case 71, 73, 75: return "Nieve ❄️"
        case 95: return "Tormenta ⛈"
        default: return "Clima desconocido"
        }
    }

    var recommendation: String {
        switch weathercode {
        case 0: return "Ideal para maíz 🌽"
        case 1, 2, 3: return "Buena opción: jitomate 🍅"
        case 61, 63, 65: return "Calabaza resiste humedad 🎃"
        case 45, 48: return "Evitar siembra delicada 🌫"
        case 95: return "Reprogramar actividades ⛈"
        default: return "Sin recomendación específica"
        }
    }

    var systemImageName: String {
        switch weathercode {
        case 0: return "sun.max.fill"
        case 1, 2, 3: return "cloud.sun.fill"
        case 45, 48: return "cloud.fog.fill"
        case 51, 53, 55: return "cloud.drizzle.fill"
        case 61, 63, 65: return "cloud.rain.fill"
        case 71, 73, 75: return "cloud.snow.fill"
        case 95: return "cloud.bolt.fill"
        default: return "cloud.fill"
        }
    }
}

struct DailyData: Codable {
    let time: [String]
    let temperature_2m_max: [Double]
    let weathercode: [Int]
}

struct DailyWeather: Identifiable, Codable {
    let id: UUID
    let day: String
    let temp: Int
    let code: Int

    var icon: String {
        switch code {
        case 0: return "sun.max.fill"
        case 1, 2, 3: return "cloud.sun.fill"
        case 45, 48: return "cloud.fog.fill"
        case 51, 53, 55: return "cloud.drizzle.fill"
        case 61, 63, 65: return "cloud.rain.fill"
        case 71, 73, 75: return "cloud.snow.fill"
        case 95: return "cloud.bolt.fill"
        default: return "cloud.fill"
        }
    }

    var description: String {
        switch code {
        case 0: return "Soleado"
        case 1, 2, 3: return "Nublado"
        case 45, 48: return "Niebla"
        case 51...55: return "Llovizna"
        case 61...65: return "Lluvia"
        case 71...75: return "Nieve"
        case 95: return "Tormenta"
        default: return "Desconocido"
        }
    }

    init(id: UUID = UUID(), day: String, temp: Int, code: Int) {
        self.id = id
        self.day = day
        self.temp = temp
        self.code = code
    }
}
extension UserDefaults {
    func saveWeatherForecast(_ forecast: [DailyWeather]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(forecast) {
            set(encoded, forKey: "weeklyForecast")
        }
    }

    func loadWeatherForecast() -> [DailyWeather] {
        let decoder = JSONDecoder()
        if let data = data(forKey: "weeklyForecast"),
           let forecast = try? decoder.decode([DailyWeather].self, from: data) {
            return forecast
        }
        return []
    }

    func saveCurrentWeather(temp: String, cond: String, icon: String) {
        set(temp, forKey: "savedTemperature")
        set(cond, forKey: "savedCondition")
        set(icon, forKey: "savedIcon")
    }

    func loadCurrentWeather() -> (String, String, String) {
        let temp = string(forKey: "savedTemperature") ?? "--"
        let cond = string(forKey: "savedCondition") ?? "Cargando..."
        let icon = string(forKey: "savedIcon") ?? "cloud.fill"
        return (temp, cond, icon)
    }
}
