//
//  DiscoveryViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class DiscoveryViewModel: DiscoveryViewModeled {

    // MARK: - Properties

    @Published var messages = Array(0..<100).map({ _ in UUID().uuidString })
    
    var settingsViewModel = SettingsViewModel()
    
    func index(_ element: String) -> Int {

        messages.firstIndex(of: element)!
    }
}
