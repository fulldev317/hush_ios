//
//  DiscoveryViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

extension String: Identifiable {
    public var id: Int {
        hashValue
    }
}

protocol DiscoveryViewModeled: ObservableObject {
    associatedtype Settings: SettingsViewModeled
    typealias Discovery = (name: String, age: Int, liked: Bool)
    
    var discoveries: [(name: String, age: Int, liked: Bool)] { get set }
    var settingsViewModel: Settings { get set }
    func discovery(_ i: Int, _ j: Int) -> Discovery
    func like(_ i: Int, _ j: Int)
}
