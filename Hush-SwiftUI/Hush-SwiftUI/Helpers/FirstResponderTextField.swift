//
//  FirstResponderTextField.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 10.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct FirstResponderTextField: UIViewRepresentable {
    let title: String
    @Binding var text: String
    @Binding var isFirstResponder: Bool
    
    let textColor: UIColor?
    let font: UIFont?
    
    func makeUIView(context: Context) -> UITextField {
        UITextField()
    }
    
    func updateUIView(_ textField: UITextField, context: Context) {
        textField.text = text
        textField.placeholder = title
        textField.textColor = textColor
        textField.font = font
        
        if isFirstResponder {
            textField.delegate = context.coordinator
            textField.becomeFirstResponder()
        } else {
            textField.delegate = nil
            textField.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        let parent: FirstResponderTextField
        init(_ parent: FirstResponderTextField) {
            self.parent = parent
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            false
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? String()
        }
    }
}
