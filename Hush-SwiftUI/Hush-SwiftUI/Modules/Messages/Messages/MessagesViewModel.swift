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
    
    var searchQuery: String = ""
    
    private let storage = FakeStorage()
    
    var items: [HushConversation] {
        storage.getMessages()
    }
    
    func updateMessage() {

        message = "New Message"
    }
    
    func item(at index: Int) -> HushConversation {
        
        storage.getMessages()[index]
    }
    
    func numberOfItems() -> Int {
        
        storage.getMessages().count
    }
    
    func createConversation(message: String) {
        storage.storage.insert(HushConversation(
            username: storage.faker.name.firstName(),
            text: message,
            imageURL: storage.faker.internet.image(width: 100, height: 100),
            messages: [.text(HushTextMessage(userID: "SELF", text: message))]
        ), at: 0)
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
            HushConversation(username: faker.name.firstName(), text: faker.lorem.paragraph(), imageURL: faker.internet.image(width: 100, height: 100), time: faker.date.birthday(2, 10), messages: (0..<10).map { i in
                .text(HushTextMessage(userID: i.isMultiple(of: 3) ? "SELF" : "DEF", text: faker.lorem.paragraph()))
            })
        }
    }
    
    fileprivate let faker = Faker()
    fileprivate var storage: [HushConversation] = []
}
