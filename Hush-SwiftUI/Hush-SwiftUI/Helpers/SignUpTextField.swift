//
//  SignUpTextField.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct SignUpTextField: View {
    
    let placeholder: String
    let icon: Image
    
    var isSecured = false
    
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                icon.resizable().frame(width: 15, height: 15).aspectRatio(contentMode: .fit)
                
                if isSecured {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            Rectangle().frame(height: 1).foregroundColor(Color(0x4E596F))
        }.frame(height: 50)
    }
}

struct SignUpTextField_Previews: PreviewProvider {
    
    @State static var text = ""
    static var previews: some View {
        SignUpTextField(placeholder: "Type Some Text", icon: Image("user_icon"), text: $text)
    }
}
