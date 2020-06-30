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
    var picked: (String) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(picked: picked, textField: UITextField(), selectedDate: "")
    }
    
    func makeUIView(context: Context) -> UITextField {
        
        let field = UITextField()
        field.inputView = context.coordinator.inputView
        field.inputAccessoryView = context.coordinator.createToolBar()
        field.textColor = .white
        field.textAlignment = .center
        
        context.coordinator.textField = field
        
        return field
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        
        uiView.text = text
    }
}

extension DatePickerField {
    
    class Coordinator: NSObject {
        
        var view: DatePickerField!
        var textField: UITextField
        private var picked: (String) -> Void
        private var selectedDate: String

        private lazy var formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            return formatter
        }()
                
        var inputView: UIDatePicker {
            let picker = UIDatePicker()
            picker.datePickerMode = .date
            picker.maximumDate = Date()
            picker.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
            
            return picker
        }
        
        @objc
        private func handleDatePicker(_ datePicker: UIDatePicker) {
            selectedDate = formatter.string(from: datePicker.date)
        }
        
        func createToolBar() -> UIToolbar {
            
            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(nextPressed))
            
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
            
            toolBar.isTranslucent = false
            toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
            
            return toolBar
        }
        
        init(picked: @escaping (String) -> Void, textField: UITextField, selectedDate: String )
        {
           self.picked = picked
           self.textField = textField
           self.selectedDate = selectedDate
        }
        
        @objc
        private func nextPressed() {
            if selectedDate.count == 0 {
                return
            }
            picked(selectedDate)
            self.textField.resignFirstResponder()
            //UIApplication.shared.windows.first?.endEditing(true)
        }
        
        @objc
        private func cancelPressed() {
            self.textField.resignFirstResponder()
        }
    }
}
