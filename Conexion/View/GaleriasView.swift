// GaleriaView.swift
// Conexion
//
// Created by Fiorella on 9/12/24.
//
import Foundation
import SwiftUI

struct GaleriasView: View {
    @StateObject private var viewModel = GaleriasViewModel()
    @State private var searchText = ""
    
    var filteredGalleries: [Galeria] {
        if searchText.isEmpty {
            return viewModel.galerias
        } else {
            return viewModel.galerias.filter { galeria in
                galeria.nombre.contains(searchText) || galeria.autor.contains(searchText)}
        }
    }
    
    let columns = [
        GridItem(.fixed(180), spacing: 16), // Ancho fijo de 180 para cada celda
        GridItem(.fixed(180), spacing: 16)  // Ancho fijo de 180 para cada celda
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255, opacity: 0.05)
                    .edgesIgnoringSafeArea(.all) // Aplica el color al fondo
                
                VStack {
                    TextField("Buscar por nombre o autor", text: $searchText)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let error = viewModel.error {
                        Text("Error: \(error)")
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(filteredGalleries) { galeria in
                                    NavigationLink(destination: ArtworksView(galleryId: galeria.id, galleryName: galeria.nombre, galleryTitle: galeria.titulo)) {
                                        VStack {
                                            Text(galeria.nombre)
                                                .font(.headline)
                                                .foregroundColor(Color.black)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                                .padding(.horizontal)
                                            
                                            /*AsyncImage(url: URL(string: galeria.url_imagen))
                                                .frame(width: 150, height: 150)
                                                .aspectRatio(contentMode: .fit) // .fill
                                                .clipped()*/
                                            
                                            AsyncImage(url: URL(string: galeria.url_imagen)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(width: 150, height: 150)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .shadow(radius: 2)
                                            
                                            Text(galeria.autor)
                                                .font(.headline)
                                                .foregroundColor(Color.white)
                                                .background(Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255))
                                                .cornerRadius(5)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .padding(.horizontal, 5)
                                            
                                            Spacer(minLength: 5)
                                            
                                            Text(galeria.titulo)
                                                .font(.subheadline)
                                                .foregroundColor(Color.white)
                                                .background(Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255))
                                                .cornerRadius(5)
                                                .frame(maxWidth: .infinity, alignment: .center)
                                                .lineLimit(2)
                                                .padding(.horizontal, 5)
                                        }
                                        .frame(height: 240)
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: .gray, radius: 5)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle("Galerías")
            .onAppear {
                viewModel.fetchGallery()
            }
        }
    }
}
