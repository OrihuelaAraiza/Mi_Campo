import SwiftUI

struct PerfilView: View {
    @ObservedObject var viewModel: CultivoViewModel
    var name: String
    var phone: String
    var role: String
    var onLogout: () -> Void
    @Environment(\.dismiss) var dismiss

    @State private var cosechas: [Cosecha] = []
    @State private var showForm = false

    let cosechaKey = "cosechasGuardadas"

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
                        clearCosechas()
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
            .onAppear(perform: cargarCosechas)
            .sheet(isPresented: $showForm) {
                AgregarCosechaView { nueva in
                    cosechas.append(nueva)
                    guardarCosechas()
                    showForm = false
                }
            }
            .background(Color("YellowBackground").ignoresSafeArea())
            .navigationBarItems(trailing: Button("Cerrar") { dismiss() })
        }
    }

    func guardarCosechas() {
        if let encoded = try? JSONEncoder().encode(cosechas) {
            UserDefaults.standard.set(encoded, forKey: cosechaKey)
        }
    }

    func cargarCosechas() {
        if let data = UserDefaults.standard.data(forKey: cosechaKey),
           let decoded = try? JSONDecoder().decode([Cosecha].self, from: data) {
            cosechas = decoded
        }
    }

    func clearCosechas() {
        UserDefaults.standard.removeObject(forKey: cosechaKey)
        cosechas = []
    }
}
