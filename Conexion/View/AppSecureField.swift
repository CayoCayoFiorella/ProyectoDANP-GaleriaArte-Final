//
//  AppSecureField.swift
//  Conexion
//
//  Created by Fiorella on 9/12/24.
//

import SwiftUI

struct AppSecureField: View {
    var placeHolder: String
    @Binding var text: String
    
    var body: some View {
            SecureField(placeHolder, text: $text)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(uiColor: .black), lineWidth: 1)
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
    }
}
