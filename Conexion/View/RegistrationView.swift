//
//  RegistrationView.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: SignInViewModel
    
    @State private var email = ""
    @State private var password = ""
    @Binding var appUser: AppUser?
    
    var body: some View {
        ZStack {
            // Fondo de color guinda
            Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Text("Registro")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Text("Llene los siguientes datos para su registro")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.top, 10)
            
                VStack(spacing: 10) {
                    AppTextField(placeHolder: "Email", text: $email)
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
                            let appUser = try await viewModel.registerNewUserWithEmail(email: email, password: password)
                            self.appUser = appUser
                            dismiss.callAsFunction()
                        } catch {
                            print ("error al registrarse")
                        }
                    }
                } label: {
                    Text("Registrar")
                        .padding()
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .padding(.top, 12)
                .padding(.horizontal, 24)
            }
        }
    }
}
