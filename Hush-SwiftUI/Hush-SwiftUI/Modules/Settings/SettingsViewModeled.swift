//
//  SettingsViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

protocol SettingsViewModeled: ObservableObject {
    
    var message: String { get set }
    var dragFlag: Bool { get set }
    
    func updateMessage()
}
