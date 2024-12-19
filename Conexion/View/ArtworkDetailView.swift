//
//  ArtworkDetailView.swift
//  Conexion
//
//  Created by Fiorella on 15/12/24.
//

import SwiftUI

struct ArtworkDetailView: View {
    let artwork: Artwork

    var body: some View {
        ZStack {
            // Color de fondo
            Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255, opacity: 0.05)
                .edgesIgnoringSafeArea(.all) // Aplica el color al fondo

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("\"\(artwork.titulo)\"")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)

                    AsyncImage(url: URL(string: artwork.url_imagen)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("**Artista:** \(artwork.artista)")
                            .font(.headline)
                        Text("**Fecha de creación:** \(artwork.año)")
                            .font(.subheadline)
                        Text("**Técnica:** \(artwork.tecnica)")
                            .font(.subheadline)
                        Text("**Descripción:**")
                            .font(.headline)
                        Text(artwork.descripcion)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .navigationTitle("Detalle de la Pintura")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

}

