//
//  ArtWork.swift
//  Conexion
//
//  Created by Fiorella on 11/12/24.
//

import Foundation

// Modelo para la tabla "Pintura"
struct Artwork: Identifiable, Decodable {
    let id: Int
    let titulo: String
    let artista: String
    let año: Int
    let tecnica: String
    let descripcion: String
    let url_imagen: String
    let id_galeria: Int
}

