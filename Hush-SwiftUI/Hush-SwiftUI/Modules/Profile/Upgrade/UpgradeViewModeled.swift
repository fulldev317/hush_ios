//
//  UpgradeViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import SwiftUI

protocol UpgradeViewModeled: ObservableObject {
    
    var message: String { get set }
    var uiElements: [UpgradeUIItem<AnyView>] { get }
    func updateMessage()
}
