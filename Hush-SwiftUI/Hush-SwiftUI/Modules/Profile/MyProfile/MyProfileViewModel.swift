//
//  MyProfileViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class MyProfileViewModel: MyProfileViewModeled {
    
    // MARK: - Properties

    @Published var message = "Hellow World!"
    @Published var basicsViewModel: BioViewMode = BioViewMode()
    
    func updateMessage() {

        message = "New Message"
    }
}

class BioViewMode: ObservableObject {
    
    @Published var username: String = "username"
    @Published var isPremium = "Yes"
    @Published var isVerified = "No"
    @Published var age = "21"
    @Published var gender = Gender.male
    @Published var sexuality = Gender.female
    @Published var living = "No"
    @Published var bio = "Hi, I'm Jack, 18 years old and I'm from London, Unite Kindom"
    @Published var language = "English"
    
    init() {
        
    }
}
