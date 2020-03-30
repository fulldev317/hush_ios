//
//  SignUpPresenter.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

protocol SignUpViewPresenter: ObservableObject {
    
    var showEmailScreen: Bool { get set }
    var emailPresenter: SignUpEmailPresenter { get }
    
    func login()
    func terms()
    func privacy()
    
    func emailPressed()
    func googlePressed()
    func facebookPressed()
    func applePressed()
    func snapPressed()
}

class SignUpPresenter: SignUpViewPresenter {
    
    @Published var showEmailScreen = false
    
    public let emailPresenter = SignUpEmailPresenter()
    
    func login() {
        
        print("login")
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
