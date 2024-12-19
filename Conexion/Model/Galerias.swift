//
//  Galerias.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import Foundation
// Modelo para la tabla "galerias"
struct Galeria: Identifiable, Decodable {
    let id: Int
    let nombre: String
    let autor: String
    let titulo: String
    let url_imagen: String
}
