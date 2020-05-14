//
//  MessagesViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import Foundation

enum MessagesFilter: CaseIterable {
    case all
    case notRead
    case usersOnline
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .notRead:
            return "Not Read"
        case .usersOnline:
            return "Users Online"
        }
    }
}

protocol MessagesViewModeled: ObservableObject {
    var filter: MessagesFilter { get set }
    var searchQuery: String { get set }
    var items: [HushConversation] { get }
    var message: String { get set }
    
    func item(at index: Int) -> HushConversation
    func numberOfItems() -> Int
    func createConversation(message: String)
    func deleteContersation(atOffsets offsets: IndexSet)
}
