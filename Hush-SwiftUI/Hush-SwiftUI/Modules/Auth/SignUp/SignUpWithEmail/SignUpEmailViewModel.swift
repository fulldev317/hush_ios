//
//  SignUpEmailPresenter.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

class SignUpEmailViewModel: SignUpEmailViewModeled {
    
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var hasError: Bool = false
    @Published var showAddPhotoScreen = false
    
    let picker: DVImagePicker
    var addPhotoViewModel: AddPhotosViewModel
    
    init() {
        self.picker = DVImagePicker()
        self.addPhotoViewModel = AddPhotosViewModel(picker)
    }
    
    func submit() {
        
        showAddPhotoScreen.toggle()
    }
}
