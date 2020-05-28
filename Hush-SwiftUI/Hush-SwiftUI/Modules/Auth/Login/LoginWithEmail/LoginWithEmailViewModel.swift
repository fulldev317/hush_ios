//
//  LoginWithEmailViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class LoginWithEmailViewModel: LoginWithEmailViewModeled {
    
    // MARK: - Properties

    @Published var email = ""
    @Published var password = ""
    @Published var hasErrorMessage = false
    @Published var errorMessage = ""
    @Published var showForgotPassword = false
    @Published var goToLogin: Bool = false
    
    var forgotPasswordViewModel = ForgotPasswordViewModel()
    
    func submit() {
        AuthAPI.shared.login(email: email, password: password)
        //goToLogin.toggle()
    }
}
