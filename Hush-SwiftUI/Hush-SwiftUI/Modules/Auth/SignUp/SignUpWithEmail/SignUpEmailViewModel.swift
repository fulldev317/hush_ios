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
    @Published var showLoginScreen = false
        
    func submit() {
        
        let regName = UserDefault(.regName, default: "")
        regName.wrappedValue = name
        let regUsername = UserDefault(.regUsername, default: "")
        regUsername.wrappedValue = username
        let regEmail = UserDefault(.regEmail, default: "")
        regEmail.wrappedValue = email
        let regPassword = UserDefault(.regPassword, default: "")
        regPassword.wrappedValue = password
        
        showAddPhotoScreen.toggle()
    }
    
    func login() {
    
        showLoginScreen.toggle()
    }
}
