//
//  SettingsViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class SettingsViewModel: SettingsViewModeled {
    
    // MARK: - Properties

    @Published var message = "Hellow World!"
    @Published var dragFlag: Bool = true
    
    func updateMessage() {

        message = "New Message"
    }
}
