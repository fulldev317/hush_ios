//
//  MatchViewModeled.swift
//  Hush-SwiftUI
//
//  Created Maksym on 06.08.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

protocol MatchViewModeled: ObservableObject {
    typealias Matches = (name: String, age: Int, liked: Bool)
    
    var matches: [(name: String, age: Int, liked: Bool)] { get set }
    func match(_ i: Int, _ j: Int) -> Matches
    func like(_ i: Int, _ j: Int)
}
