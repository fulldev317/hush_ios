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
    associatedtype Settings: DiscoveriesSettingsViewModeled
    //typealias Discovery = (name: String, age: Int, image: String, liked: Bool)
    
    //var discoveries: [(name: String, age: Int, image: String, liked: Bool)] { get set }
    var discoveries: [Discover] { get set }
    var settingsViewModel: Settings { get set }
    var isShowingIndicator: Bool { get set }

    func discovery(_ i: Int, _ j: Int) -> Discover
    func like(_ i: Int, _ j: Int)
    func loadDiscover(page: Int, result: @escaping (Bool) -> Void)
    func loadMatches(result: @escaping (Bool) -> Void)
    func loadMyLikes(result: @escaping (Bool) -> Void)
    func loadVisitedMe(result: @escaping (Bool) -> Void)
    func loadLikesMe(result: @escaping (Bool) -> Void)
    func setSettingsModel()
}
