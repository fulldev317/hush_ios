//
//  LoginViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class LoginViewModel: LoginViewModeled {
    
    // MARK: - Properties

    @Published var showEmailScreen = false
    var loginWithMailViewModel = LoginWithEmailViewModel()
    func loginWithEmail() {
        
        showEmailScreen.toggle()
    }
    
    func loginWithApple(email: String, name: String, result: @escaping (Bool) -> Void) {
        AuthAPI.shared.appleConnect(email: email, name: name) { (user, error) in
            if error != nil {
                result(false)
            } else if let user = user {
              
                let isLoggedIn = UserDefault(.isLoggedIn, default: false)
                isLoggedIn.wrappedValue = true
                
                Common.setUserInfo(user)
                Common.setAddressInfo("Los Angels, CA, US")
                let jsonData = try! JSONEncoder().encode(user)
                let jsonString = String(data:jsonData, encoding: .utf8)!
                
                let currentUser = UserDefault(.currentUser, default: "")
                currentUser.wrappedValue = jsonString
                result(true)
            }
        }
    }
}
