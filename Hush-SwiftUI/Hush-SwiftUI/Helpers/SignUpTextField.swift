//
//  SignUpTextField.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct HTextField: UIViewRepresentable {
    
    let placeholder: String
    var placeholderColor: UIColor = .lightText
    
    @Binding var text: String
    var textColor: UIColor = .black
    var font: UIFont = .thin(18)
    
    let isSecure: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        
        let field = UITextField()
        field.textColor = textColor
        field.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColor, .font: font])
        field.isSecureTextEntry = isSecure
        field.delegate = context.coordinator
        
        return field
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        
        uiView.text = text
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        var parrent: HTextField
        init(_ parrent: HTextField) {
            self.parrent = parrent
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            parrent.text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            textField.resignFirstResponder()
            
            return true
        }
    }
}

struct SignUpTextField: View {
    
    let placeholder: String
    let icon: Image
    
    var isSecured = false
    
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                icon.resizable().frame(width: 15, height: 15).aspectRatio(contentMode: .fit)
                
                HTextField(placeholder: placeholder, placeholderColor: .white, text: $text, textColor: .white, isSecure: isSecured)
            }
            Rectangle().frame(height: 1).foregroundColor(Color(0x4E596F))
        }.frame(minHeight: 40, maxHeight: 50)
    }
}

struct SignUpTextField_Previews: PreviewProvider {
    
    @State static var text = ""
    static var previews: some View {
        SignUpTextField(placeholder: "Type Some Text", icon: Image("user_icon"), text: $text)
    }
}
