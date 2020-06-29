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
    @Published var location: String = "Los Angles, FA, US"
    @Published var closeAPISelectorCompletion: (() -> Void)?
    @Published var ageSelLower: Double = 18 {
        didSet {
            let ageLower = (Int(18 + (99 - 18) * ageSelLower))
            AuthAPI.shared.update_age(lower: String(ageLower), upper: String(Int(ageSelUpper))) { (error) in
                
            }
        }
    }
    @Published var ageSelUpper: Double = 99 {
        didSet {
            let ageUpper = (Int(18 + (99 - 18) * ageSelUpper))
            AuthAPI.shared.update_age(lower: String(Int(ageSelLower)), upper: String(ageUpper)) { (error) in
                
            }
        }
    }
    
    @Published var selectedDistance : Double = 1.0 {
        didSet {
            let miles = 10 + selectedDistance * 80
            let kilometers = miles * 1.6
            AuthAPI.shared.update_radius(radius: String(kilometers)) { (error) in
                
            }
        }
    }
    func updateMessage() {

        message = "New Message"
    }
    
    func setGender(gender: Gender) {
        self.gender = gender
    }
}
