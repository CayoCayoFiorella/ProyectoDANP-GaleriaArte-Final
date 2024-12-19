//
//  Galeria-Pintura.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//
import Foundation

// Modelo para la tabla "galerias"
struct Galeria: Decodable {
    let id: Int
    let nombre: String
    let autor: String
    let url_imagen: String
}
