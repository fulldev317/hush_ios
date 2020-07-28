//
//  Match.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 28/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

struct ChatMessage: Codable {
    var id: String?
    var isMe: Bool?
    var seen: String?
    var type: String?
    var body: String?
    var story: String?
    var storyData: [Story]?
    var avatar: String?
    var gif: String?
    var gift: String?
    var photo: String?
    var timestamp: String?
}
