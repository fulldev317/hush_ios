//
//  HushConversation.swift
//  CoreLogic
//
//  Created by Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import UIKit

private protocol HushMessageProtocol {
    var id: String { get }
    var userID: String { get }
    var time: Date { get }
}

struct HushTextMessage: Hashable, Equatable, HushMessageProtocol {
    var id: String = UUID().uuidString
    var userID: String
    var text: String
    var time: Date = Date()
}

struct HushImageMessage: Hashable, Equatable, HushMessageProtocol {
    var id: String = UUID().uuidString
    var userID: String
    var image: UIImage
    var time: Date = Date()
}

enum HushMessage: Hashable, Equatable {
    case text(HushTextMessage)
    case image(HushImageMessage)
    
    var id: String { messageDetail(at: \.id) }
    var userID: String { messageDetail(at: \.userID) }
    var time: TimeInterval { messageDetail(at: \.time).timeIntervalSince1970 }
    var createdAt: Date { messageDetail(at: \.time) }
    
    var isText: Bool {
        guard case .text = self else { return false }
        return true
    }
    
    var isImage: Bool {
        guard case .image = self else { return false }
        return true
    }
    
    private func messageDetail<Target>(at keyPath: KeyPath<HushMessageProtocol, Target>) -> Target {
        switch self {
        case let .text(message): return message[keyPath: keyPath]
        case let .image(message): return message[keyPath: keyPath]
        }
    }
}

struct HushConversation: Hashable, Equatable {
    var id: String = UUID().uuidString
    var username: String
    var text: String
    var imageURL: String
    var time: String
    var messages: [HushMessage]
    
    // TODO: - Temp solution
    
    mutating func sendMessage(_ message: HushMessage) {
        messages.insert(message, at: 0)
    }
}
