//
//  HushMessagesStorage.swift
//  CoreLogic
//
//  Created by Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

protocol HushConversationsStorage {    
    func getMessages() -> [HushConversation]
    func search(by query: String) -> [HushConversation]
    func delete(message: HushConversation)
//    func send(_ message: HushMessage, to conversation: HushConversation)
}
