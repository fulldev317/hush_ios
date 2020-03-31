//
//  LoginViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

protocol LoginViewModeled: ObservableObject {
    
    var message: String { get set }
    
    func updateMessage()
}
