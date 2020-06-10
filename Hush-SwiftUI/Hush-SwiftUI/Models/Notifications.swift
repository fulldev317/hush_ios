//
//  Notifications.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 28/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

struct Notifications: Codable {
    
    var fan: NotificationType!
    var matchMe: NotificationType!
    var nearMe: NotificationType!
    var message: NotificationType!

    enum CodingKeys: String, CodingKey {
        case fan
        case matchMe = "match_me"
        case nearMe = "near_me"
        case message
    }
        
    struct NotificationType: Codable {
        var email: String
        var push: String
        var inapp: String
    }
}
