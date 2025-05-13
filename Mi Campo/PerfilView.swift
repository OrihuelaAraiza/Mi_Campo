//
//  PerfilView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI

struct Cosecha: Identifiable {
    let id = UUID()
    var cultivo: String
    var fechaSiembra: String
    var fechaCosecha: String
    var cantidad: Int
    var ganancia: Double
    var costo: Double
    var problemas: [String]
}

struct PerfilView: View {
    @ObservedObject var viewModel: CultivoViewModel
    var name: String
    var phone: String
    var role: String
    var onLogout: () -> Void
    @Environment(\.dismiss) var dismiss

    @State private var cosechas: [Cosecha] = []
    @State private var showForm = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Text("👤 Perfil del usuario")
                        .font(.title.bold())
                        .padding(.top)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("🧑 Nombre: \(name)")
                        Text("📱 Teléfono: \(phone)")
                        Text("💼 Rol: \(role)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .padding(.horizontal)

                    Button("Agregar cosecha pasada") {
                        showForm = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("PrimaryGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)

                    if !cosechas.isEmpty {
                        Text("📊 Historial de cosechas")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)

                        ForEach(cosechas) { cosecha in
                            CosechaMetricsCard(cosecha: cosecha)
                                .padding(.horizontal)
                        }
                    }

                    Button(action: {
                        viewModel.borrarTodo()
                        onLogout()
                        dismiss()
                    }) {
                        Text("Cerrar sesión")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .background(Color("YellowBackground").ignoresSafeArea())
            .sheet(isPresented: $showForm) {
                AgregarCosechaView { nueva in
                    cosechas.append(nueva)
                    showForm = false
                }
            }
            .navigationBarItems(trailing: Button("Cerrar") { dismiss() })
        }
    }
}
