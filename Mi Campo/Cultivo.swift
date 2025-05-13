//
//  Cultivo.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//

import Foundation

struct Cultivo: Identifiable, Codable {
    let id: UUID
    let nombre: String
    let tipo: String
    let cantidad: String
    let area: String
    let suelo: String
    let experiencia: String

    init(id: UUID = UUID(), nombre: String, tipo: String, cantidad: String, area: String, suelo: String, experiencia: String) {
        self.id = id
        self.nombre = nombre
        self.tipo = tipo
        self.cantidad = cantidad
        self.area = area
        self.suelo = suelo
        self.experiencia = experiencia
    }
}
