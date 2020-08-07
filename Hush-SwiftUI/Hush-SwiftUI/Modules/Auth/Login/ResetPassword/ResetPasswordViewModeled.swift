//
//  ResetPasswordViewModeled.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 07.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

protocol ResetPasswordViewModeled: ObservableObject {
    var password: String { get set }
    var repeatPassword: String { get set }
    var hasErrorMessage: Bool { get set }
    var errorMessage: String { get set }
    var showSignUp: Bool { get set }
    var showLogin: Bool { get set }

    func submit(email: String, password: String, result: @escaping (Bool) -> Void)
}
