//
//  HushConversation.swift
//  CoreLogic
//
//  Created by Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

public struct HushMessage {
    
    public let id: String
    public let userID: String
    public let text: String
    public let time: Double
    
    public init(_ id: String = UUID().uuidString, userID: String, text: String, time: Double) {
        self.id = id
        self.userID = userID
        self.text = text
        self.time = time
    }
}

public struct HushConversation {
    
    public let id: String
    public let username: String
    public let text: String
    public let imageURL: String
    public let time: Double
    public var messages: [HushMessage]
    
    public init(_ id: String = UUID().uuidString, username: String, text: String, imageURL: String, time: Double, messages: [HushMessage]) {
        
        self.id = id
        self.username = username
        self.text = text
        self.imageURL = imageURL
        self.time = time
        self.messages = messages
    }
    
    // TODO: - Temp solution
    
    public mutating func sendMessage(_ message: HushMessage) {
        
        messages.insert(message, at: 0)
    }
}
