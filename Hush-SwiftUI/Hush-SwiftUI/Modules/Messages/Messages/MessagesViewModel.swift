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
    
    @Published var filter: MessagesFilter = .all
    @Published var message = "Hellow World!"
    @Published var isShowingIndicator: Bool = false
    @Published var items: [HushConversation] = []

    var searchQuery: String = ""
    
    private let storage = FakeStorage()
        
    func updateMessage() {

        message = "New Message"
    }
    
    func getChat(result: @escaping (Bool) -> Void) {
        
        self.isShowingIndicator = true
        
        ChatAPI.shared.getChat(completion: { (memberList, error) in
            self.isShowingIndicator = false
            self.items.removeAll()
            
            if error == nil {
                if let memberList = memberList {
                    for member in memberList {
                        if (member != nil) {
                            self.items.append(HushConversation(id: member!.id!, username: member!.name!, text: member!.last_m!.parseSpecialText(), imageURL: member!.photo!, time: member!.last_m_time!, messages: []))
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
            HushConversation(username: faker.name.firstName(), text: faker.lorem.paragraph(), imageURL: faker.internet.image(width: 100, height: 100), time: "", messages: (0..<10).map { i in
                .text(HushTextMessage(id: String(i), userID: i.isMultiple(of: 3) ? "SELF" : "DEF", text: faker.lorem.paragraph()))
            })
        }
    }
    
    fileprivate let faker = Faker()
    fileprivate var storage: [HushConversation] = []
}
