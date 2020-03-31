//
//  HTextField.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 31.03.2020.
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
    let coordinator = Coordinator()
    
    func makeCoordinator() -> Coordinator {
        
        coordinator.parent = self
        
        return coordinator
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
        
        var parent: HTextField!
    
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            parent.text = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
            textField.resignFirstResponder()
            
            return true
        }
    }
}
