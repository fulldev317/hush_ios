//
//  LoginWithEmailViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine
import PushNotifications

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
                Common.setCurrentTab(tab: HushTabs.carusel)
                
                let jsonData = try! JSONEncoder().encode(user)
                let jsonString = String(data:jsonData, encoding: .utf8)!
                
                let currentUser = UserDefault(.currentUser, default: "")
                currentUser.wrappedValue = jsonString

                self.setPusherId(userId: user.id!)

                self.goToLogin.toggle()

                result(true)
            }
        }
    }
    
    func setPusherId(userId: String) {
        let tokenProvider = BeamsTokenProvider(authURL: "https://www.hushdating.app/requests/appapi.php") { () -> AuthData in
            let sessionToken = "E9AF1A15E2F1369770BCCE93A8B8EEC46A41ABE2617E43DC17F5337603A239D8"
            let headers = ["Authorization": "Bearer \(sessionToken)"] // Headers your auth endpoint needs
            let queryParams: [String: String] = ["action":"getBeamsToken", "uid":userId] // URL query params your auth endpoint needs
            return AuthData(headers: headers, queryParams: queryParams)
        }
        
        pushNotifications.setUserId(userId, tokenProvider: tokenProvider, completion: { error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            print("Successfully authenticated with Pusher Beams")
        })
    }
    
    
}
