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
    @State private var fechaSiembra = Date()
    @State private var fechaCosecha = Date()
    @State private var cantidad = ""
    @State private var ganancia = ""
    @State private var costo = ""
    @State private var problemas = ""

    var onGuardar: (Cosecha) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Datos generales")) {
                    TextField("Nombre del cultivo", text: $cultivo)

                    DatePicker("Fecha de siembra", selection: $fechaSiembra, displayedComponents: .date)
                        .datePickerStyle(.graphical)

                    DatePicker("Fecha de cosecha", selection: $fechaCosecha, in: fechaSiembra..., displayedComponents: .date)
                        .datePickerStyle(.graphical)
                }

                Section(header: Text("Producción")) {
                    TextField("Cantidad cosechada (kg)", text: $cantidad)
                        .keyboardType(.numberPad)
                    TextField("Ganancia ($)", text: $ganancia)
                        .keyboardType(.decimalPad)
                    TextField("Costo ($)", text: $costo)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Observaciones")) {
                    TextField("Problemas (separados por coma)", text: $problemas)
                }
            }
            .navigationTitle("Nueva Cosecha")
            .navigationBarItems(
                leading: Button("Cancelar") {
                    dismiss()
                },
                trailing: Button("Guardar") {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"

                    let nueva = Cosecha(
                        cultivo: cultivo,
                        fechaSiembra: formatter.string(from: fechaSiembra),
                        fechaCosecha: formatter.string(from: fechaCosecha),
                        cantidad: Int(cantidad) ?? 0,
                        ganancia: Double(ganancia) ?? 0,
                        costo: Double(costo) ?? 0,
                        problemas: problemas
                            .split(separator: ",")
                            .map { $0.trimmingCharacters(in: .whitespaces) }
                    )

                    onGuardar(nueva)
                    dismiss()
                }
            )
        }
    }
}
