//
//  ForgotPasswordViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

protocol ForgotPasswordViewModeled: ObservableObject {
    
    var email: String { get set }
    var hasErrorMessage: Bool { get set }
    var errorMessage: String { get set }
    var goToRoot: Bool { get set }
    var showResetPassword: Bool { get set }

    func submit(email: String, result: @escaping (Bool) -> Void)
}
