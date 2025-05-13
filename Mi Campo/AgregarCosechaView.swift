//
//  AgregarCosechaView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//
import SwiftUI


struct AgregarCosechaView: View {
    @Environment(\.dismiss) var dismiss
    @State private var cultivo = ""
    @State private var siembra = ""
    @State private var cosecha = ""
    @State private var cantidad = ""
    @State private var ganancia = ""
    @State private var costo = ""
    @State private var problemas = ""

    var onGuardar: (Cosecha) -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Cultivo", text: $cultivo)
                TextField("Fecha de siembra", text: $siembra)
                TextField("Fecha de cosecha", text: $cosecha)
                TextField("Cantidad cosechada (kg)", text: $cantidad)
                    .keyboardType(.numberPad)
                TextField("Ganancia ($)", text: $ganancia)
                    .keyboardType(.decimalPad)
                TextField("Costo ($)", text: $costo)
                    .keyboardType(.decimalPad)
                TextField("Problemas (separados por coma)", text: $problemas)
            }
            .navigationTitle("Nueva Cosecha")
            .navigationBarItems(
                leading: Button("Cancelar") {
                    dismiss()
                },
                trailing: Button("Guardar") {
                    let nueva = Cosecha(
                        cultivo: cultivo,
                        fechaSiembra: siembra,
                        fechaCosecha: cosecha,
                        cantidad: Int(cantidad) ?? 0,
                        ganancia: Double(ganancia) ?? 0,
                        costo: Double(costo) ?? 0,
                        problemas: problemas.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
                    )
                    onGuardar(nueva)
                    dismiss()
                }
            )
        }
    }
}
