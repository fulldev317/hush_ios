//
//  SelectLocationViewModel.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 10.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

let locations = [
    "London, England, United Kingdom",
    "Palo Alto, California, United States",
    "Los Angeles, California, United States",
]

class SelectLocationViewModel<SettingsViewModel: SettingsViewModeled>: SelectLocationViewModeled {
    @Published var query = ""
    @Published var searchResult = ""
    unowned let settingsViewModel: SettingsViewModel
    
    private var disposals = [AnyCancellable]()
    init(_ settingsViewModel: SettingsViewModel) {
        self.settingsViewModel = settingsViewModel
        $query.map { query in
            locations.first { location in
                location.lowercased().contains(query.lowercased())
            } ?? String()
        }.assign(to: \.searchResult, on: self)
        .store(in: &disposals)
        
    }
}
