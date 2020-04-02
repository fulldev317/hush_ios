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
    
    var messages: [String] { get set }
    
    func index(_ element: String) -> Int
}
