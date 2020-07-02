//
//  LocationTextField.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 10.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct LocationTextField: UIViewRepresentable {
    let title: String
    @Binding var text: String
    @Binding var isLocationResponder: Bool
    @Binding var isEditingLocation: Bool
    
    let textColor: UIColor?
    let font: UIFont?
    
    func makeUIView(context: Context) -> UITextField {
        UITextField()
    }
    
    func updateUIView(_ textField: UITextField, context: Context) {
        textField.text = text
        textField.attributedPlaceholder = NSAttributedString(string: title,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = textColor
        textField.font = font
        textField.delegate = context.coordinator
        textField.textAlignment = .center
        
        if isLocationResponder == false {
            textField.resignFirstResponder()
        } else {
            textField.becomeFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        let parent: LocationTextField
        init(_ parent: LocationTextField) {
            self.parent = parent
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.isLocationResponder = false
            parent.isEditingLocation = false
            textField.resignFirstResponder()
            return true
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            return true
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? String()

        }
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            parent.isLocationResponder = true
            return true
        }
    }
}
