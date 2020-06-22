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
    @Published var hasErrorMessage = false
    @Published var errorMessage = ""

    func submit(result: @escaping (Bool) -> Void) {
       
        if (name.count == 0) {
            return
        }
        
        if (username.count == 0) {
            return
        }
        
        if (email.count == 0) {
            return
        }
        
        if (password.count == 0) {
            return
        }
        
        AuthAPI.shared.emailExistCheck(name: name, email: email, username: username, password: password) { (error) in
            if let error = error {
                self.hasErrorMessage = true
                self.errorMessage = error.message
                result(false)
            } else {
                self.hasErrorMessage = false
                self.errorMessage = ""
                self.showAddPhotoScreen.toggle()
                result(true)
            }
        }
        
    }
    
    func login() {
    
        showLoginScreen.toggle()
    }
}
