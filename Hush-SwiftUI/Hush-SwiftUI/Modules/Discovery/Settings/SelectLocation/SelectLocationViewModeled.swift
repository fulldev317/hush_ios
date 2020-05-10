//
//  SelectLocationViewModeled.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 10.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

protocol SelectLocationViewModeled: ObservableObject {
    associatedtype SettingsViewModel: SettingsViewModeled
    var query: String { get set }
    var searchResult: String { get }
    var settingsViewModel: SettingsViewModel { get }
}
