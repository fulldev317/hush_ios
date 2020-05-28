//
//  Notifications.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 28/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import SwiftyJSON

class Notifications {
    
    internal var fan: NotificationType!
    internal var matchMe: NotificationType!
    internal var nearMe: NotificationType!
    internal var message: NotificationType!

    static func parseFromJson(_ json: JSON) -> Notifications {
        let notification = Notifications()
        notification.fan = NotificationType.parseFromJson(json["fan"])
        notification.matchMe = NotificationType.parseFromJson(json["match_me"])
        notification.nearMe = NotificationType.parseFromJson(json["near_me"])
        notification.message = NotificationType.parseFromJson(json["message"])
        return notification
    }
    
    class NotificationType {
        
        internal var email: String!
        internal var push: String!
        internal var inapp: String!

        static func parseFromJson(_ json: JSON) -> NotificationType {
            let type = NotificationType()
            type.email = json["email"].string
            type.push = json["push"].string
            type.inapp = json["inapp"].string
            return type
        }
    }
}
