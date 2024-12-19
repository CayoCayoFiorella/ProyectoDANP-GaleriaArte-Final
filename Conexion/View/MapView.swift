//
//  MapView.swift
//  Conexion
//
//  Created by Fiorella on 10/12/24.
//
import Foundation
import SwiftUI
import CoreGraphics

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                // Fondo color con opacidad aplicada a toda la vista
                Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255, opacity: 0.05)
                    .edgesIgnoringSafeArea(.all) // Aplica el color al fondo
                
                GeometryReader { geometry in
                    let size = geometry.size
                    
                    Color.clear
                        .onAppear {
                            viewModel.calculateGalleryFrames(in: size)
                            viewModel.generateArtworkCircles(in: size)
                            viewModel.generateGreenArea(in: size)
                            viewModel.generateArtworkLabels()
                        }
                        .onChange(of: size) { newSize in
                            viewModel.calculateGalleryFrames(in: newSize)
                            viewModel.generateArtworkCircles(in: newSize)
                            viewModel.generateGreenArea(in: newSize)
                        }
                    
                    // Dibujar las galerías
                    ForEach(viewModel.galleryFrames.indices, id: \.self) { index in
                        let frame = viewModel.galleryFrames[index]
                        Rectangle()
                            .stroke(Color.black, lineWidth: 2)
                            .frame(width: frame.width, height: frame.height)
                            .position(x: frame.midX, y: frame.midY)
                        
                        // Enlace de navegación para cada galería
                        NavigationLink(destination: ArtworksView(
                            galleryId: index + 1,
                            galleryName: viewModel.galleryNames[index],
                            galleryTitle: "Título de \(viewModel.galleryNames[index])"
                        )) {
                            Text(viewModel.galleryNames[index])
                                .foregroundColor(.brown)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(5)
                                .position(x: frame.midX, y: frame.midY)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    // Dibujar los círculos de obras de arte
                    ForEach(viewModel.artworkCircles.indices, id: \.self) { index in
                        let circle = viewModel.artworkCircles[index]
                        
                        // Determinar la galería asociada al círculo
                        if let galleryId = viewModel.getGalleryId(for: circle) {
                            // Verificar que el índice de la pintura sea válido para la galería
                            let artworkIndex = viewModel.getArtworkIndex(for: index, in: galleryId)
                            
                            NavigationLink(destination: ArtworkDetailViewWrapper(galleryId: galleryId, artworkIndex: artworkIndex)) {
                                ZStack {
                                    // Círculo
                                    Circle()
                                        .fill(Color.orange.opacity(0.6)) // Color de los círculos
                                        .frame(width: 20, height: 20)
                                        .position(x: circle.x, y: circle.y)
                                    
                                    // Texto dentro del círculo
                                    Text(viewModel.artworkLabels[index])
                                        .foregroundColor(.black)
                                        .font(.system(size: 10))
                                        .frame(width: 20, height: 20) // Tamaño del frame igual al del círculo
                                        .position(x: circle.x, y: circle.y) // Asegurar que el texto se alinee con el círculo
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                    // Dibujar círculos verdes
                    ForEach(viewModel.greenArea.indices, id: \.self) { index in
                        let circleGreen = viewModel.greenArea[index]
                        Circle()
                            .fill(Color.green.opacity(0.6))
                            .frame(width: 40, height: 40)
                            .position(x: circleGreen.x, y: circleGreen.y)
                    }
                }
            }
            .padding()
            .navigationTitle("Mapa")
        }
    }
}
