//
//  DiscoveryViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

protocol StoriesViewModeled: ObservableObject {
    
    var messages: [String] { get set }
    
    func index(_ element: String) -> Int
}
