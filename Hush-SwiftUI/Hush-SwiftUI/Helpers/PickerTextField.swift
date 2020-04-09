//
//  PickerTextField.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 08.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct PickerTextField: UIViewRepresentable {
    
    var title: String
    var titles: [String]
    var picked: (String) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(titles: titles, picked: picked)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let field = UITextField()
        field.inputView = context.coordinator.inputView
        field.textAlignment = .right
        field.textColor = .white
        
        return field
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        
        uiView.text = title
    }
}

extension PickerTextField {
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        
        private var titles: [String]
        private var picked: (String) -> Void
        var inputView: UIPickerView {
            let picker = UIPickerView()
            picker.dataSource = self
            picker.delegate = self

            return picker
        }
        
        init(titles: [String], picked: @escaping (String) -> Void) {
            self.picked = picked
            self.titles = titles
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            
            1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            titles.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            
            titles[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            
            picked(titles[row])
        }
    }
}

struct PickerTextField_Previews: PreviewProvider {
    
    @State static var str = "some"
    static var previews: some View {
        VStack {
            Text(str)
            PickerTextField(title: str, titles: ["1", "2", "3"], picked: { s in
                self.str = s
            })
        }
    }
}


struct DateTextField: UIViewRepresentable {
    
    var title: String
    var picked: (Date) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(picked: picked)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let field = UITextField()
        field.inputView = context.coordinator.inputView
        field.textAlignment = .right
        field.textColor = .white
        
        return field
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        
        uiView.text = title
    }
}


extension DateTextField {
    
    class Coordinator: NSObject {
        
        private var picked: (Date) -> Void
        var inputView: UIDatePicker {
            let picker = UIDatePicker()
            picker.datePickerMode = .date
            picker.maximumDate = Date()
            picker.addTarget(self, action: #selector(changed(_:)), for: .valueChanged)
            
            return picker
        }
        
        init(picked: @escaping (Date) -> Void) {
            self.picked = picked
        }
        
        @objc private func changed(_ picker: UIDatePicker) {
            picked(picker.date)
        }
    }
}
