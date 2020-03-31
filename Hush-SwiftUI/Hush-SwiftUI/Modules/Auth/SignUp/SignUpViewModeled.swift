//
//  SignUpViewModeled.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

protocol SignUpViewModeled: ObservableObject {
    
    associatedtype EmailViewModel: SignUpEmailViewModeled
    
    var showEmailScreen: Bool { get set }
    var emailPresenter: EmailViewModel { get }
    
    func login()
    func terms()
    func privacy()
    
    func emailPressed()
    func googlePressed()
    func facebookPressed()
    func applePressed()
    func snapPressed()
}
