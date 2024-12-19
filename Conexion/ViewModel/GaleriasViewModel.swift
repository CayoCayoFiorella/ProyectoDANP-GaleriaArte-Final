//
//  GaleriasViewModel.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import Foundation

class GaleriasViewModel: ObservableObject {
    @Published var galerias: [Galeria] = []
    @Published var isLoading = true
    @Published var error: String?
    
    private let manager = SupabaseManager.shared
    
    func fetchGallery() {
        manager.getGalleries { [weak self] galerias, error in
            DispatchQueue.main.async {
                if let galerias = galerias {
                    self?.galerias = galerias
                    self?.isLoading = false
                } else if let error = error {
                    self?.error = error.localizedDescription
                    self?.isLoading = false
                }
            }
        }
    }
}

