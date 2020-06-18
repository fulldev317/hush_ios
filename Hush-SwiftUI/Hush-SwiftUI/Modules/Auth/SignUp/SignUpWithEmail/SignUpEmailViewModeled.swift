//
//  SignUpEmailViewPresenter.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

protocol SignUpEmailViewModeled: ObservableObject {
        
    var name: String { get set }
    var username: String { get set }
    var email: String { get set }
    var password: String { get set }
    var hasError: Bool { get set }
    var showAddPhotoScreen: Bool { get set }
    var showLoginScreen: Bool { get set }
    var hasErrorMessage: Bool { get set }
    var errorMessage: String { get set }

    func submit(result: @escaping (Bool) -> Void)
    func login()
}
