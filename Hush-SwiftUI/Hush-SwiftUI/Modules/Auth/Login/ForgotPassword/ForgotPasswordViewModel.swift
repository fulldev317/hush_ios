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

    func submit() {
        
    }
}
