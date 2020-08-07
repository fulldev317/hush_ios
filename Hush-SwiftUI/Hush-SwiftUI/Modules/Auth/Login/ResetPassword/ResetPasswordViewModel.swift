//
//  ResetPasswordViewModel.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 07.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

class ResetPasswordViewModel: ResetPasswordViewModeled {
    
    @Published var password = ""
    @Published var repeatPassword = ""
    @Published var hasErrorMessage = true
    @Published var errorMessage = "Passwords must be at least 6 characters"
    @Published var showSignUp = false
    @Published var showLogin = false
    
    func submit(email: String, password: String, result: @escaping (Bool) -> Void) {
        AuthAPI.shared.reset_password(email: email, password: password) { (error) in
            if let error = error {
                self.hasErrorMessage = true
                self.errorMessage = error.message
                result(false)
            } else {
                self.hasErrorMessage = false
                self.errorMessage = ""
                result(true)
            }
        }
    }
}
