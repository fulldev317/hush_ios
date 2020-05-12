//
//  DiscoveryViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

protocol StoriesViewModeled: ObservableObject {
    associatedtype Settings: StoriesSettingsViewModeled
    var settingsViewModel: Settings { get }
}
