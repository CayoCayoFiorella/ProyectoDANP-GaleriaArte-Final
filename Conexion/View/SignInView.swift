//
//  SignInView.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import Foundation
import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistrationPresented = false
    @State private var errorMessage: String?
    
    @Binding var appUser: AppUser?
    
    var body: some View{
        Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255)
            .edgesIgnoringSafeArea(.all)
        VStack(spacing: 40) {
            
            // Título "UNSA"
            Text("UNSA")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 20)
            
            // Imagen entre el título y el formulario
            Image("Galerias_image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
        
            VStack(spacing: 10) {
                
                Text("Inicio de Sesión")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Inicia sesión con tu Usuario y Contraseña")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            
                AppTextField(placeHolder: "Email address", text: $email)
                    .background(Color.white)
                    .cornerRadius(20)
                AppSecureField(placeHolder: "Password", text: $password)
                    .background(Color.white)
                    .cornerRadius(20)
            }
            .padding(.horizontal, 24)
            
            
            Button {
                Task {
                    do {
                        let appUser = try await viewModel.signInWithEmail(email: email, password: password)
                        self.appUser = appUser
                    } catch let error as AppError {
                        errorMessage = error.errorDescription
                    } catch {
                        errorMessage = "Ocurrió un error inesperado."
                    }
                }
            } label: {
                Text("Iniciar Sesión")
                    .padding()
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)                    
                    .background(Color.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            .padding(.horizontal, 24)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top)
            }
            
            Button("¿No tienes cuenta? Registrate aquí") {
                isRegistrationPresented.toggle()
            }
            .foregroundColor(Color.white)
            .sheet(isPresented: $isRegistrationPresented) {
                RegistrationView(appUser: $appUser)
                    .environmentObject(viewModel)
            }
        }
    }
}
