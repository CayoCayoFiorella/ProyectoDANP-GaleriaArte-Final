//
//  AppError.swift
//  Conexion
//
//  Created by Fiorella on 10/12/24.
//

import Foundation
enum AppError: LocalizedError {
    case invalidForm
    case registrationFailed
    case loginFailed
    case fetchSessionFailed
    case networkError(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidForm:
            return "El formulario no es válido. Por favor, revisa los campos."
        case .registrationFailed:
            return "El registro falló. Por favor, intenta nuevamente."
        case .loginFailed:
            return "El inicio de sesión falló. Verifica tus credenciales."
        case .fetchSessionFailed:
            return "No se pudo obtener la sesión actual."
        case .networkError(let error):
            return "Error de red: \(error.localizedDescription)"
        case .unknown:
            return "Ocurrió un error desconocido. Por favor, intenta nuevamente."
        }
    }
}
