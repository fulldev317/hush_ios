//
//  UpgradeViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine

protocol UpgradeViewModeled: ObservableObject {
    
    var message: String { get set }
    
    func updateMessage()
}
