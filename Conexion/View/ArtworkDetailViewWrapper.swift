//
//  ArtworkDetailViewWrapper.swift
//  Conexion
//
//  Created by Fiorella on 18/12/24.
//

import SwiftUI

struct ArtworkDetailViewWrapper: View {
    let galleryId: Int
    let artworkIndex: Int
    @StateObject private var artworkViewModel = ArtworkViewModel()

    var body: some View {
        Group {
            if artworkViewModel.isLoading {
                ProgressView()
            } else if let error = artworkViewModel.error {
                Text("Error: \(error)")
            } else if artworkIndex < artworkViewModel.paintings.count {
                ArtworkDetailView(artwork: artworkViewModel.paintings[artworkIndex])
            } else {
                Text("No se encontró la pintura")
            }
        }
        .onAppear {
            artworkViewModel.fetchArtwork(for: galleryId)
        }
    }
}
