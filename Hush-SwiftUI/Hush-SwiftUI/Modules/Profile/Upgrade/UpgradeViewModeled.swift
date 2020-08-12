//
//  UpgradeViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import SwiftUI
import Purchases

protocol UpgradeViewModeled: ObservableObject {
    
    var message: String { get set }
    var showingIndicator: Bool { get set }
    
    var oneWeek: Bool { get set }
    var oneMonth: Bool { get set }
    var threeMonth: Bool { get set }
    var offering: Purchases.Offering? { get set }
    var uiElements: [UpgradeUIItem<AnyView>] { get }
    func updateMessage()
    func upgradeOneWeek(result: @escaping (Bool, String) -> Void)
    func upgradeOneMonth(result: @escaping (Bool, String) -> Void)
    func upgradeThreeMonth(result: @escaping (Bool, String) -> Void)


}
