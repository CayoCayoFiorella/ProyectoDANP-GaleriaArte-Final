//
//  AppTextField.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import Foundation
import SwiftUI

struct AppTextField: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
            TextField(placeHolder, text: $text)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(uiColor: .black), lineWidth: 1)
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
    }
}
