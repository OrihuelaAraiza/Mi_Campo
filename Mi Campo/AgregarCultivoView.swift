//
//  AgregarCultivoView.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import SwiftUI
struct AgregarCultivoView: View {
    @Environment(\.dismiss) var dismiss

    @State private var nombre = ""
    @State private var tipo = "Maíz"
    @State private var otroTipo = ""
    @State private var cantidad = ""
    @State private var area = "1-5 ha"
    @State private var suelo = "Arenoso"
    @State private var experiencia = "Básico"

    var onAdd: (Cultivo) -> Void

    let tipos = ["Maíz", "Frijol", "Jitomate", "Chile", "Otro"]
    let areas = ["< 1 ha", "1-5 ha", "6-10 ha", "11-20 ha", "> 20 ha"]
    let suelos = ["Arenoso", "Arcilloso", "Franco", "Pedregoso"]
    let niveles = ["Básico", "Medio", "Experto"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre del cultivo", text: $nombre)

                Picker("Tipo de cultivo", selection: $tipo) {
                    ForEach(tipos, id: \.self) { Text($0) }
                }

                if tipo == "Otro" {
                    TextField("Especificar otro", text: $otroTipo)
                }

                TextField("Cantidad a sembrar (kg)", text: $cantidad)
                    .keyboardType(.numberPad)

                Picker("Área", selection: $area) {
                    ForEach(areas, id: \.self) { Text($0) }
                }

                Picker("Tipo de suelo", selection: $suelo) {
                    ForEach(suelos, id: \.self) { Text($0) }
                }

                Picker("Nivel de experiencia", selection: $experiencia) {
                    ForEach(niveles, id: \.self) { Text($0) }
                }
            }
            .navigationTitle("Nuevo cultivo")
            .navigationBarItems(
                leading: Button("Cancelar") { dismiss() },
                trailing: Button("Guardar") {
                    let cultivo = Cultivo(
                        nombre: nombre,
                        tipo: tipo == "Otro" ? otroTipo : tipo,
                        cantidad: cantidad,
                        area: area,
                        suelo: suelo,
                        experiencia: experiencia
                    )
                    onAdd(cultivo)
                    dismiss()
                }
            )
        }
    }
}
