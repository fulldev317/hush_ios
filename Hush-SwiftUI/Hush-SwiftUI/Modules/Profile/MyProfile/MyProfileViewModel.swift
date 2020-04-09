//
//  MyProfileViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

let Gender: [String] = ["Male","Female", "Couple", "Gay"]

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
    @Published var gender = Gender.first!
    @Published var sexuality = "No"
    @Published var living = "No"
    @Published var bio = "No"
    @Published var language = "English"
    
    init() {
        
    }
}
