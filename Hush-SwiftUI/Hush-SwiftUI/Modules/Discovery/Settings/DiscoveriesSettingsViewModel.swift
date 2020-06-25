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
    
    func updateMessage() {

        message = "New Message"
    }
    
    func setGender(gender: Gender) {
        self.gender = gender
    }
}
