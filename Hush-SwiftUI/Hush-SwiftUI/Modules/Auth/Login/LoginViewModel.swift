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
}
