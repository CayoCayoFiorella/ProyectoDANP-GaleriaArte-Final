//
//  GalleryShape.swift
//  Conexion
//
//  Created by Fiorella on 10/12/24.
//

import Foundation
import SwiftUI

struct GalleryShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Dibujar las galerías
        path.addRect(CGRect(x: 20, y: 350, width: 200, height: 100)) // Galeria 1
        path.addRect(CGRect(x: 20, y: 150, width: 100, height: 200)) // Galeria 2
        path.addRect(CGRect(x: 120, y: 150, width: 100, height: 80)) // Galeria 3
        path.addRect(CGRect(x: 20, y: -50, width: 100, height: 180))  // Galeria 4
        path.addRect(CGRect(x: 120, y: -50, width: 100, height: 80)) // Sala
        path.addRect(CGRect(x: 280, y: 150, width: 100, height: 100)) // Galeria 5
        path.addRect(CGRect(x: 280, y: 250, width: 100, height: 150)) // Galeria 6
        path.addRect(CGRect(x: 320, y: -50, width: 60, height: 80)) // Baño
        return path
    }
}
