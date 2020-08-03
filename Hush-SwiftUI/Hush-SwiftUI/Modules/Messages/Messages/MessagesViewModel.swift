//
//  MessagesViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine
import Fakery

class MessagesViewModel: MessagesViewModeled {

    // MARK: - Properties
    
    @Published var filter: MessagesFilter = .all {
        didSet {
            if filter == .all {
                filteredItems = items
            } else if filter == .notRead {
                filteredItems =  items.filter { $0.unread > 0 }
            } else if filter == .usersOnline {
                filteredItems =  items.filter { $0.online > 0 }
            }
        }
    }
    @Published var message = "Hellow World!"
    @Published var isShowingIndicator: Bool = false
    @Published var showMessageFilter: Bool = false
    @Published var items: [HushConversation] = []
    @Published var filteredItems: [HushConversation] = []

    @Published var searchQuery: String = "" {
        didSet {
            if (searchQuery.count == 0) {
                filteredItems = items
            } else {
                filteredItems =  items.filter { $0.username.lowercased().contains(searchQuery.lowercased()) }
            }
        }
    }
    
    private let storage = FakeStorage()
        
    func updateMessage() {

        message = "New Message"
    }
    
    func getChat(result: @escaping (Bool) -> Void) {

        self.isShowingIndicator = true
        
        ChatAPI.shared.get_chat(completion: { (memberList, error) in
            self.isShowingIndicator = false
            self.items.removeAll()
            self.filteredItems.removeAll()
            
            if error == nil {
                if let memberList = memberList {
                    for member in memberList {
                        if let member = member {
                            let item = HushConversation(id: member.id!, username: member.name!, text: member.last_m!.parseSpecialText(), imageURL: member.photo!, time: member.last_m_time!, unread: member.unread!, online: member.online!, messages: [])
                                self.items.append(item)
                                self.filteredItems.append(item)
                        }
                    }
                }
                result(true)
            } else {
                result(false)
            }
        })
    }
    
    func item(at index: Int) -> HushConversation {
        
        storage.getMessages()[index]
    }
    
    func numberOfItems() -> Int {
        
        storage.getMessages().count
    }
    
    func deleteContersation(atOffsets offsets: IndexSet) {
        objectWillChange.send()
        storage.storage.remove(atOffsets: offsets)
    }
}


fileprivate class FakeStorage: HushConversationsStorage {
    
    func getMessages() -> [HushConversation] {
        
        storage
    }
    
    func search(by query: String) -> [HushConversation] {
        
        storage.filter { $0.username.contains(query) || $0.text.contains(query) }
    }
    
    func delete(message: HushConversation) {
        
        if let index = storage.firstIndex(where: { message.id == $0.id }) {
            storage.remove(at: index)
        }
    }
    
    init() {
        storage = Array(0..<10).map { _ in
            HushConversation(username: faker.name.firstName(), text: faker.lorem.paragraph(), imageURL: faker.internet.image(width: 100, height: 100), time: "", unread: 1, online: 1, messages: (0..<10).map { i in
                .text(HushTextMessage(id: String(i), userID: i.isMultiple(of: 3) ? "SELF" : "DEF", text: faker.lorem.paragraph()))
            })
        }
    }
    
    fileprivate let faker = Faker()
    fileprivate var storage: [HushConversation] = []
}
