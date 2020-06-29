//
//  MatchViewModeled.swift
//  Hush-SwiftUI
//
//  Created Maksym on 06.08.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

protocol MatchViewModeled: ObservableObject {
    //typealias Matches = (name: String, age: Int, liked: Bool)
    
    var matches: [Discover] { get set }
    func match(_ i: Int, _ j: Int) -> Discover
    func like(_ i: Int, _ j: Int)
    func loadMatches(result: @escaping (Bool) -> Void)
    var isShowingIndicator: Bool { get set }

}
