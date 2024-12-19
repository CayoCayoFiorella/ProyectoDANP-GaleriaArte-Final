//
//  ArtworksView.swift
//  Conexion
//
//  Created by Fiorella on 11/12/24.
//

import SwiftUI

struct ArtworksView: View {
    @StateObject private var viewModel = ArtworkViewModel()
    @State private var searchText = ""
    let galleryId: Int
    let galleryName: String
    let galleryTitle: String
    
    init(galleryId: Int, galleryName: String, galleryTitle: String) {
        self.galleryId = galleryId
        self.galleryName = galleryName
        self.galleryTitle = galleryTitle
    }
    
    var filteredArtworks: [Artwork] {
        if searchText.isEmpty {
            return viewModel.paintings
        } else {
            return viewModel.paintings.filter { artwork in
                artwork.titulo.contains(searchText) || artwork.artista.contains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255, opacity: 0.05)
                    .edgesIgnoringSafeArea(.all) // Aplica el color al fondo

                VStack (spacing:0){
                    Text("\"\(galleryTitle)\"")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 10)

                    TextField("Buscar por titulo o artista", text: $searchText)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    if viewModel.isLoading && viewModel.paintings.isEmpty {
                        ProgressView()
                    } else if let error = viewModel.error {
                        Text("Error: \(error)")
                    } else if filteredArtworks.isEmpty {
                        VStack {
                            Text("No hay pinturas disponibles.")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text("Por favor, intenta con otra galería.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    } else {
                        List {
                            ForEach(filteredArtworks.indices, id: \.self) { index in
                                let painting = filteredArtworks[index]
                                NavigationLink(destination: ArtworkDetailView(artwork: painting)) {
                                    HStack(alignment: .center, spacing: 10) {
                                        AsyncImage(url: URL(string: painting.url_imagen)) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .shadow(radius: 2)
                                        VStack(alignment: .leading) {
                                            Text(painting.titulo)
                                                .font(.headline)
                                            Text(painting.artista)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding(.vertical, 5)
                                }
                                .background(index % 2 == 0
                                    ? Color(red: 120/255, green: 0, blue: 0, opacity: 0.4)
                                    : Color(red: 120/255, green: 0, blue: 0, opacity: 0.15))
                                .cornerRadius(8)
                            }

                            // Trigger to load more data
                            if viewModel.isLoading {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                            } else {
                                Color.clear
                                    .onAppear {
                                        viewModel.fetchArtwork(for: galleryId)
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle(galleryName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(galleryName)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.primary)
                }
            }
            .onAppear {
                viewModel.fetchArtwork(for: galleryId)
            }
        }
    }

}

