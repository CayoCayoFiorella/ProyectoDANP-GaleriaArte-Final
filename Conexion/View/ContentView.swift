//
//  ContentView.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var appUser: AppUser? = nil
    
    var body: some View {
        //GaleriasView()  // Llamamos a la vista que muestra las galerías
        ZStack {
            if let user = appUser {
                HomeView(user: user, onLogout: {
                    appUser = nil
                })
                
            }else {
                SignInView(appUser: $appUser)
            }
        }
        
        .onAppear() {
            Task {
                self.appUser = try await SupabaseManager.shared.getCurrentSession()
            }
        }
        
    }
}
