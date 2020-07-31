//
//  MessageItem.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 7/24/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

struct MessageItem: Codable {
    var id: String?
    var profilePhoto: String?
    var name: String?
    var online: Int?
    
    init(user_id: String, name: String, image: String, online: Int) {
        self.id = user_id
        self.name = name
        self.profilePhoto = image
        self.online = online
    }
}
