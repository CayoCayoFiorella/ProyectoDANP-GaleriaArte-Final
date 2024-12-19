//
//  SignInViewModel.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import Foundation
import SwiftUI

@MainActor
class SignInViewModel: ObservableObject {
    
    func isFormatValid(email: String, password: String) -> Bool {
        guard email.isValidEmail(), password.count > 7 else {
            return false
        }
        return true
    }
    
    func registerNewUserWithEmail (email: String, password: String) async throws -> AppUser  {
        if isFormatValid(email: email, password: password) {
            return try await SupabaseManager.shared.registerNewUserWithEmail(email: email, password: password)
        } else {
            print ("formulario de registro invalido")
            throw NSError()
        }
    }
    
    
    func signInWithEmail(email: String, password: String) async throws -> AppUser {
        if isFormatValid(email: email, password: password) {
            return try await SupabaseManager.shared.signInWithEmail(email: email, password: password)
        } else {
            print ("formulario de inicio de sesion invalido")
            throw NSError()
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}
