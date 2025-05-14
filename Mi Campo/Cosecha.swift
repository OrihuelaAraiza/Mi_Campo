//
//  Cosecha.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 13/05/25.
//

import Foundation

struct Cosecha: Identifiable, Codable {
    let id: UUID
    var cultivo: String
    var fechaSiembra: String
    var fechaCosecha: String
    var cantidad: Int
    var ganancia: Double
    var costo: Double
    var problemas: [String]

    init(id: UUID = UUID(), cultivo: String, fechaSiembra: String, fechaCosecha: String, cantidad: Int, ganancia: Double, costo: Double, problemas: [String]) {
        self.id = id
        self.cultivo = cultivo
        self.fechaSiembra = fechaSiembra
        self.fechaCosecha = fechaCosecha
        self.cantidad = cantidad
        self.ganancia = ganancia
        self.costo = costo
        self.problemas = problemas
    }
}
