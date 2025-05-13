//
//  HomeComercianteView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI
import CoreLocation

struct HomeComercianteView: View {
    @ObservedObject var viewModel: CultivoViewModel
    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherVM = WeatherViewModel()
    @State private var showForm = false
    @State private var showProfile = false
    @State private var animate = false
    @State private var selectedFilter: FilterOption = .nombre

    @AppStorage("userRole") var userRole: String = ""
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userPhone") var userPhone: String = ""

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(spacing: 0) {

            // Header
            HStack {
                VStack(alignment: .leading) {
                    Text("Hola, \(userName) 👋")
                        .font(.title3)
                        .minimumScaleFactor(0.8)
                    Text("Mis cultivos")
                        .font(.largeTitle.bold())
                        .foregroundColor(Color("TextBlack"))
                }
                Spacer()
                Button(action: { showProfile = true }) {
                    Image(systemName: "person.crop.circle")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            .padding(.top)

            // Scroll principal
            ScrollView {
                VStack(spacing: 16) {

                    WeatherWidget(
                        temperature: weatherVM.temperature,
                        condition: weatherVM.condition,
                        iconName: weatherVM.weatherIcon,
                        refreshAction: {
                            if let loc = locationManager.userLocation {
                                weatherVM.fetchWeather(for: loc)
                            } else {
                                locationManager.requestPermission()
                            }
                        },
                        forecast: weatherVM.weeklyForecast
                    )
                    .padding(.horizontal)

                    // Recomendación cultivo
                    if let rec = weatherVM.recommendedCrop {
                        Text("🌿 Recomendación: \(rec)")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.85))
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }

                    // Botón añadir cultivo (efecto rebote)
                    Button {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                            showForm = true
                        }
                    } label: {
                        HStack {
                            Image(systemName: "plus.square.fill.on.square.fill")
                                .font(.title2)
                            Text("Añadir cultivo")
                                .font(.headline)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("PrimaryGreen"))
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(color: Color("PrimaryGreen").opacity(0.3), radius: 4, x: 0, y: 3)
                    }
                    .padding(.horizontal)

                    Divider()
                        .padding(.horizontal)

                    // Cultivos
                    if viewModel.cultivos.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "leaf.circle")
                                .font(.system(size: 60))
                                .foregroundColor(.green)
                                .rotationEffect(.degrees(animate ? 10 : -10))
                                .animation(Animation.easeInOut(duration: 1).repeatForever(), value: animate)
                                .onAppear { animate = true }

                            Text("Aún no tienes cultivos 🌱")
                                .font(.title3)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    } else {
                        Picker("Filtrar por", selection: $selectedFilter) {
                            Text("Nombre").tag(FilterOption.nombre)
                            Text("Tipo").tag(FilterOption.tipo)
                            Text("Fecha").tag(FilterOption.fecha)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)

                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(filtrarCultivos(viewModel.cultivos)) { cultivo in
                                NavigationLink(destination: DetalleCultivoView(cultivo: cultivo)) {
                                    CultivoCard(cultivo: cultivo)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .contextMenu {
                                    Button("Eliminar", role: .destructive) {
                                        withAnimation(.easeInOut) {
                                            viewModel.cultivos.removeAll { $0.id == cultivo.id }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
                .padding()
            }
        }
        .background(Color("YellowBackground").ignoresSafeArea())
        .onAppear {
            if let location = locationManager.userLocation {
                weatherVM.fetchWeather(for: location)
            } else {
                locationManager.requestPermission()
            }
        }
        .sheet(isPresented: $showForm) {
            AgregarCultivoView { nuevo in
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    viewModel.cultivos.append(nuevo)
                }
                showForm = false
            }
        }
        .sheet(isPresented: $showProfile) {
            PerfilView(viewModel: viewModel,
                       name: userName,
                       phone: userPhone,
                       role: userRole,
                       onLogout: {
                           UserDefaults.standard.set(false, forKey: "hasLaunchedBefore")
                       })
        }
    }

    // Filtrado inteligente
    func filtrarCultivos(_ cultivos: [Cultivo]) -> [Cultivo] {
        switch selectedFilter {
        case .nombre:
            return cultivos.sorted { $0.nombre < $1.nombre }
        case .tipo:
            return cultivos.sorted { $0.tipo < $1.tipo }
        case .fecha:
            return cultivos // A futuro se puede ordenar por fecha si se agrega campo
        }
    }

    enum FilterOption: String, CaseIterable, Identifiable {
        case nombre, tipo, fecha
        var id: String { rawValue }
    }
}
