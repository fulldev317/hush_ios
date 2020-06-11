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
    @EnvironmentObject var app: App
    @Published var email = ""
    @Published var password = ""
    @Published var hasErrorMessage = false
    @Published var errorMessage = ""
    @Published var showForgotPassword = false
    @Published var goToLogin: Bool = false

    var forgotPasswordViewModel = ForgotPasswordViewModel()
    
    func submit(result: @escaping (Bool) -> Void) {
        AuthAPI.shared.login(email: email, password: password) { (user, error) in
            if let error = error {
                self.hasErrorMessage = true
                self.errorMessage = error.message
                result(false)
            } else if let user = user {
                self.hasErrorMessage = false
                self.errorMessage = ""
                let isLoggedIn = UserDefault(.isLoggedIn, default: false)
                isLoggedIn.wrappedValue = true
                
                Common.setUserInfo(user)
                
                let jsonData = try! JSONEncoder().encode(user)
                let jsonString = String(data:jsonData, encoding: .utf8)!
                
                let currentUser = UserDefault(.currentUser, default: "")
                currentUser.wrappedValue = jsonString

                self.goToLogin.toggle()

                result(true)
            }
        }
    }
}
