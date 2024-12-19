//
//  Manager.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import Foundation
import Supabase

class Manager {
    
    static let shared = Manager()
    
    private init() {}
    
    // Cliente de Supabase
        private let client = SupabaseClient(
            supabaseURL: URL(string: "https://qsafyyqlttkopjprmgrc.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFzYWZ5eXFsdHRrb3BqcHJtZ3JjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE0MjcyNzIsImV4cCI6MjA0NzAwMzI3Mn0.ithyCN2kF5K4vb3j8jDN6wNsnelJmubN2O8sO4z6R-s"
        )
        
    // Método para obtener las galerías
        func obtenerGalerias(completion: @escaping ([Galeria]?, Error?) -> Void) {
            Task {
                do {
                    // Realizar la consulta
                    let galerias: [Galeria] = try await client
                        .from("galerias")  // Tabla galerias
                        .select("id, nombre, autor, url_imagen")  // Seleccionamos id y nombre, autor
                        .execute()
                        .value

                    // Llamar al completion con las galerías obtenidas
                    completion(galerias, nil)
                } catch {
                    // Llamar al completion con el error
                    completion(nil, error)
                }
            }
        }
}
