//
//  SignUpPresenter.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

class SignUpViewModel: SignUpViewModeled {
    
    @Published var showEmailScreen = false
    @Published var showLoginScreen = false
    
    func login() {
        
        showLoginScreen.toggle()
    }
    
    func terms() {
        
        iOSApp.open(URL(string: "http://google.com")!)
    }
    
    func privacy() {
        
        iOSApp.open(URL(string: "http://google.com")!)
    }
    
    func emailPressed() {
        
        showEmailScreen = true
    }
    
    func googlePressed() {
        
    }
    
    func facebookPressed() {
        
    }
    
    func applePressed() {
        
    }
    
    func snapPressed() {
          
    }
}
