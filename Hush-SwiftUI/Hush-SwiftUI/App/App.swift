//
//  App.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import SwiftUI

class App: ObservableObject {
    
    @Published var logedIn = true {
        didSet {
            notlogged = !logedIn
        }
    }
    @Published var showPremium = false
    @Published var onProfileEditing = false
    @Published var notlogged = true
    @Published var selectingGender = false
    @Published var isFirstResponder = false
    @Published var showStory = false
    @Published var showSignupButtons = false
    
    let profile = MyProfileViewModel()
    let discovery = DiscoveryViewModel()
    let stories = StoriesViewModel()
    let messages = MessagesViewModel()
       
}
