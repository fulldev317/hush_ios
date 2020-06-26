//
//  DiscoveriesSettingsViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class DiscoveriesSettingsViewModel: DiscoveriesSettingsViewModeled {
    
    // MARK: - Properties

    @Published var gender = Gender.male
    @Published var message = "Hellow World!"
    @Published var dragFlag: Bool = true
    @Published var location: String = "Los Angeles"
    @Published var closeAPISelectorCompletion: (() -> Void)?
    @Published var ageSelLower: Double = 0.0 {
        didSet {
            let ageLower = (Int(18 + (99 - 18) * ageSelLower))

        }
    }
    @Published var ageSelUpper: Double = 1.0 {
        didSet {
            let ageUpper = (Int(18 + (99 - 18) * ageSelUpper))

        }
    }
    
    @Published var selectedDistance : Double = 1.0 {
        didSet {
            //let miles = 10 + selectedDistance * 80
            //let kilometers = miles * 1.6
        }
    }
    func updateMessage() {

        message = "New Message"
    }
    
    func setGender(gender: Gender) {
        self.gender = gender
    }
}
