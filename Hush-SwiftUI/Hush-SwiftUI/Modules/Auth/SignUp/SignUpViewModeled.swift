//
//  SignUpViewModeled.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

protocol SignUpViewModeled: ObservableObject {
        
    var showEmailScreen: Bool { get set }
    var showLoginScreen: Bool { get set }
    
    func login()
    func terms()
    func privacy()
    
    func emailPressed()
    func googlePressed()
    func facebookPressed()
    func applePressed()
    func snapPressed()
}
