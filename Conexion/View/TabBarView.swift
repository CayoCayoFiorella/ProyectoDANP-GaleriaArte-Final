//
//  TabBarView.swift
//  Conexion
//
//  Created by Fiorella on 10/12/24.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView(user: <#AppUser#>)
            }
            .tabItem {
                Label("Home", systemImage: "House")
            }
            .tag(0)
            
            NavigationView {
                VStack {
                    Text("Galerías")
                        .font(.title)
                    Text("Galerías")
                }
            }
            .tabItem {
                Label("Galerías", systemImage: "photo.fill.on.rectangle.fill")
            }
            .tag(1)

            NavigationView {
                VStack {
                    Text("Mapa")
                        .font(.title)
                    Text("Mapa")
                }
            }
            .tabItem {
                Label("Mapa", systemImage: "map.fill")
            }
            .tag(2)

            NavigationView {
                VStack {
                    Text("QR Scanner")
                        .font(.title)
                    Text("Scanner")
                }
            }
            .tabItem {
                Label("QR", systemImage: "qrcode")
            }
            .tag(3)
        }
    }
}
