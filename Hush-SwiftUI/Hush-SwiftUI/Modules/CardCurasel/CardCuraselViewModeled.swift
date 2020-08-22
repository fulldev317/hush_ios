//
//  CardCuraselViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import SwiftUI

protocol CardCuraselViewModeled: ObservableObject {
    
    var games: [Game] { get set }
    var message: String { get set }
    var isBlock: Bool { get set }
    var isShowingIndicator: Bool { get set }
    var showUserProfile: Bool { get set }
    var showUpgrade: Bool { get set }
    var selectedUser: User { get set}
    //var photos: [String] { get set }
    var name: String { get set }
    var age: String { get set }
    var address: String { get set }
    func loadGame(result: @escaping (Bool) -> Void)
    func updateMessage()
    func setSettingsModel()
    func userLike(userID: String, like: String) 

}
