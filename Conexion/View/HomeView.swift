//
//  HomeView.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedTab = 0 // Control de pestañas
    var user: AppUser
    @Environment(\.presentationMode) var presentationMode // Para cerrar la vista
    var onLogout: () -> Void
    
    var body: some View {
        ZStack {
            Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255, opacity: 0.05)
                .edgesIgnoringSafeArea(.all)
            
            TabView(selection: $selectedTab) {
                VStack {
                    Text("Centro Cultural\nUNSA")
                        .font(.system(size: 34, weight: .bold))
                        .padding(.horizontal, 40)
                        .background(Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Text("Bienvenido \(user.email ?? "no email")")
                        .font(.system(size: 25))
                        .padding()
                    
                    // Imagen del home
                    Image("Home_Image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                    
                    Button(action: logout) {
                        Text("Cerrar sesión")
                            .font(.headline)
                            .padding()
                            .frame(width: 150)
                            .background(Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity)
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
                
                VStack {
                    GaleriasView()
                }
                .tabItem {
                    Label("Galerías", systemImage: "photo.fill.on.rectangle.fill")
                }
                .tag(1)
                
                VStack {
                    MapView()
                }
                .tabItem {
                    Label("Mapa", systemImage: "map.fill")
                }
                .tag(2)
            }
            .accentColor(Color(red: 120 / 255, green: 0 / 255, blue: 2 / 255))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private func logout() {
           Task {
               do {
                   try await SupabaseManager.shared.signOut() // Llama al método público
                   onLogout()
               } catch {
                   print("Error al cerrar sesión: \(error.localizedDescription)")
               }
           }
       }
}
