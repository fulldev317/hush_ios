//
//  ForgotPasswordViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class ForgotPasswordViewModel: ForgotPasswordViewModeled {
    
    
    // MARK: - Properties

    @Published var email = ""
    @Published var hasErrorMessage = false
    @Published var errorMessage = ""
    @Published var goToRoot = false
    @Published var showResetPassword = false

    func submit(email: String, result: @escaping (Bool) -> Void) {
        AuthAPI.shared.send_forgot_email(email: email) { (error) in
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
