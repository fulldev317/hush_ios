//
//  DatePickerField.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 01.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct DatePickerField: UIViewRepresentable {
    
    @Binding var text: String
    
    let coordinator = Coordinator()
    
    func makeCoordinator() -> Coordinator {
        
        coordinator.view = self
        
        return coordinator
    }
    
    func makeUIView(context: Context) -> UITextField {
        
        let field = UITextField()
        field.inputView = context.coordinator.picker
        field.inputAccessoryView = context.coordinator.createToolBar()
        field.textColor = .white
        field.textAlignment = .center
        
        return field
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        
        uiView.text = text
    }
}

extension DatePickerField {
    
    class Coordinator: NSObject {
        
        var view: DatePickerField!
        
        private lazy var formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            return formatter
        }()
        
        lazy var picker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.datePickerMode = .date
            picker.maximumDate = Date()
            
            return picker
        }()
        
        override init() {
            super.init()
            picker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        }
        
        @objc
        private func handleDatePicker(_ datePicker: UIDatePicker) {
            
            view.text = formatter.string(from: datePicker.date)
        }
        
        func createToolBar() -> UIToolbar {
            
            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(nextPressed))
            
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            toolBar.isTranslucent = false
            toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
            
            return toolBar
        }
        
        @objc
        private func nextPressed() {
            
            UIApplication.shared.windows.first?.endEditing(true)
        }
    }
}
