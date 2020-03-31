//
//  LoginWithEmailViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

protocol LoginWithEmailViewModeled: ObservableObject {
    
    var email: String { get set }
    var password: String { get set }
    
    var hasErrorMessage: Bool { get set }
    var errorMessage: String { get set }
    
    func submit()
}
