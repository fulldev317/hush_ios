//
//  DiscoveriesSettingsViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

enum Gender: String, CaseIterable {
    case male
    case female
    case lesbian
    case gay
    //case everyone
    
    var title: String { rawValue.capitalized }
    static let allTitles = allCases.map { $0.title }
}


protocol DiscoveriesSettingsViewModeled: ObservableObject {
    var gender: Gender { get set }
    var message: String { get set }
    var dragFlag: Bool { get set }
    var location: String { get set }
    var closeAPISelectorCompletion: (() -> Void)? { get set }
    
    func updateMessage()
}
