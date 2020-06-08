//
//  MatchViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.08.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class MatchViewModel: MatchViewModeled {
    

    // MARK: - Properties
    
    @Published var matches: [(name: String, age: Int, liked: Bool)] = []
    
    init() {
        for i in 18...99 {
            matches.append((name: "Emily", age: i, liked: false))
        }
    }
    
    func match(_ i: Int, _ j: Int) -> Matches {
        matches[i * 2 + j]
    }
    
    func like(_ i: Int, _ j: Int) {
        matches[i * 2 + j].liked.toggle()
    }
}
