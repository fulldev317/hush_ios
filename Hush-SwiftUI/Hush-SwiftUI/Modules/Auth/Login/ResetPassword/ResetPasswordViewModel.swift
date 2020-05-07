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
    @Published var hasErrorMessage = false
    @Published var errorMessage = ""
    @Published var showSignUp = false
}
