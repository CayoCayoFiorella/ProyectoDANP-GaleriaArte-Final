//
//  ArtworkViewModel.swift
//  Conexion
//
//  Created by Fiorella on 11/12/24.
//

import Foundation
class ArtworkViewModel: ObservableObject {
    @Published var paintings: [Artwork] = []
    @Published var isLoading = false
    @Published var error: String?

    private let manager = SupabaseManager.shared
    private var currentPage = 0
    private let pageSize = 10
    private var isLastPage = false

    func fetchArtwork(for galleryId: Int) {
        // Asegúrate de no cargar más datos si ya se está cargando o si es la última página
        guard !isLoading, !isLastPage else { return }
        
        isLoading = true
        error = nil

        // Log en consola para indicar que se inició una carga
        print("Cargando página \(currentPage + 1) con \(pageSize) elementos para la galería \(galleryId)...")

        manager.getArtwork(for: galleryId, page: currentPage, pageSize: pageSize) { [weak self] artwork, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.error = "Error: \(error.localizedDescription)"
                    print("Error al cargar los datos: \(error.localizedDescription)")
                } else if let artwork = artwork, !artwork.isEmpty {
                    self?.paintings.append(contentsOf: artwork)
                    self?.currentPage += 1
                    print("Página \(self?.currentPage ?? 0) cargada exitosamente con \(artwork.count) elementos.")
                } else {
                    self?.isLastPage = true
                    print("No hay más datos para cargar. Se alcanzó la última página.")
                }
            }
        }
    }
}


