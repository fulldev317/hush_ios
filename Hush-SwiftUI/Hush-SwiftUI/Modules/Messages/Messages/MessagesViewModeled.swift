//
//  MessagesViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import CoreLogic

protocol MessagesViewModeled: ObservableObject {
    
    var searchQuery: String { get set }
    var items: [HushConversation] { get }
    var message: String { get set }
    
    func item(at index: Int) -> HushConversation
    func numberOfItems() -> Int
    func createConversation(message: String)
}
