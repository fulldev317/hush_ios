//
//  UpgradeViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class UpgradeViewModel: UpgradeViewModeled {
    
    // MARK: - Properties

    @Published var message = "Hellow World!"
    
    func updateMessage() {

        message = "New Message"
    }
}
