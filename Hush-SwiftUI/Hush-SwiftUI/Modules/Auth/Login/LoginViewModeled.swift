//
//  LoginViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

protocol LoginViewModeled: ObservableObject {
    
    associatedtype loginWithMailViewModel: LoginWithEmailViewModeled
    
    var showEmailScreen: Bool { get set }
    var loginWithMailViewModel: loginWithMailViewModel { get set }
    
    func loginWithEmail()
    
}
