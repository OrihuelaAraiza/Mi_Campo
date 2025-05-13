//
//  CultivoViewModel.swift
//  Mi Campo
//
//  Created by Juan Pablo Orihuela Araiza on 12/05/25.
//

import Foundation

class CultivoViewModel: ObservableObject {
    @Published var cultivos: [Cultivo] = [] {
        didSet {
            saveCultivos()
        }
    }

    private let storageKey = "savedCultivos"

    init() {
        loadCultivos()
    }

    func saveCultivos() {
        if let data = try? JSONEncoder().encode(cultivos) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    func loadCultivos() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([Cultivo].self, from: data) {
            self.cultivos = decoded
        }
    }

    func borrarTodo() {
        cultivos.removeAll()
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}
