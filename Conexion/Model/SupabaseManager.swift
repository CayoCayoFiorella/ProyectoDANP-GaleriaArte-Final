//
//  SupabaseManager.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import Foundation
import Supabase

class SupabaseManager {
    
    static let shared = SupabaseManager()
    
    private init() {}
    
    // Cliente de Supabase
        private let client = SupabaseClient(
            supabaseURL: URL(string: "https://qsafyyqlttkopjprmgrc.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFzYWZ5eXFsdHRrb3BqcHJtZ3JjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE0MjcyNzIsImV4cCI6MjA0NzAwMzI3Mn0.ithyCN2kF5K4vb3j8jDN6wNsnelJmubN2O8sO4z6R-s"
        )
    // Metodo para cerrar sesion
    func signOut() async throws {
            try await client.auth.signOut()
    }
        
    // Método para obtener las galerías
        func getGalleries(completion: @escaping ([Galeria]?, Error?) -> Void) {
            Task {
                do {
                    // Realizar la consulta
                    let galerias: [Galeria] = try await client
                        .from("galerias")  // Tabla galerias
                        .select("id, nombre, autor, titulo, url_imagen")  // Seleccionamos id y nombre, autor
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
    
    // Método para obtener las pinturas por Id de galeria
    func getArtwork(for galleryId: Int, page: Int, pageSize: Int, completion: @escaping ([Artwork]?, Error?) -> Void) {
        Task {
            do {
                let start = page * pageSize
                let end = start + pageSize - 1
                
                // Realizar la consulta con rango para la paginación
                let artwork: [Artwork] = try await client
                    .from("pinturas")
                    .select("id, titulo, artista, año, tecnica, descripcion, url_imagen, id_galeria")
                    .eq("id_galeria", value: galleryId)
                    .range(from:start, to:end) // Aplica rango para obtener una "página"
                    .execute()
                    .value
                
                completion(artwork, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    
    // Obtener sesion actual
    func getCurrentSession() async throws -> AppUser {
        let session = try await client.auth.session
        print(session)
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    // Metodo para registro
    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser {
        if email.isValidEmail(), password.count > 7 {
            let regAuthResponse = try await client.auth.signUp(email: email, password: password)
            guard let session = regAuthResponse.session else {
                throw AppError.registrationFailed
            }
            return AppUser(uid: session.user.id.uuidString, email: session.user.email)
        } else {
            throw AppError.invalidForm
        }
    }
    
    
     /*
    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser {
        let response = try await client
            .from("usuarios")
            .insert(["email": email, "password": password])
            .select()
            .execute()
        
        guard let firstUser = response.first else {
            throw SignInError.registrationFailed
        }
        return AppUser(uid: String(firstUser["id"] as? Int ?? 0), email: firstUser["email"] as? String)
    }*/
    
    // Metodo para iniciar sesion
    func signInWithEmail(email: String, password: String) async throws -> AppUser {
        if email.isValidEmail(), password.count > 7 {
            do {
                let session = try await client.auth.signIn(email: email, password: password)
                return AppUser(uid: session.user.id.uuidString, email: session.user.email)
            } catch {
                throw AppError.networkError(error)
            }
        } else {
            throw AppError.invalidForm
        }
    }
    
    
}
