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
    
    @Published var discoveries: [(name: String, age: Int, liked: Bool)] = []
    var settingsViewModel = DiscoveriesSettingsViewModel()
    
    init() {
        for i in 18...99 {
            discoveries.append((name: "Emily", age: i, liked: false))
        }
    }
    
    func discovery(_ i: Int, _ j: Int) -> Discovery {
        discoveries[i * 2 + j]
    }
    
    func like(_ i: Int, _ j: Int) {
        discoveries[i * 2 + j].liked.toggle()
    }
}
