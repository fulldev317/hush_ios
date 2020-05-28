//
//  Match.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 28/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import SwiftyJSON

class Match {
    
    internal var id: String!
    internal var name: String!
    internal var firstName: String!
    internal var age: String!
    internal var city: String!
    internal var photo: String!
    internal var error: Int!
    internal var lastA: String!
    internal var status: Int!
    internal var online: Int!
    internal var unread: Int!
    internal var story: String!
    internal var stories: [Int]! //TODO
    internal var premium: String!
    internal var lastM: String!
    internal var lastMT: String!
    internal var lastMTime: String!
    internal var credits: String!
    internal var checkM: Int!
    internal var gift: Int!

    static func parseFromJson(_ json: JSON) -> Match {
        let match = Match()
        match.id = json["id"].string
        match.name = json["name"].string
        match.firstName = json["firstName"].string
        match.age = json["age"].string
        match.city = json["city"].string
        match.photo = json["photo"].string
        match.error = json["error"].int
        match.lastA = json["last_a"].string
        match.status = json["status"].int
        match.online = json["online"].int
        match.unread = json["unread"].int
        match.story = json["story"].string
        //match.stories = json["stories"].string //TODO
        match.premium = json["premium"].string
        match.lastM = json["last_m"].string
        match.lastMT = json["last_m_t"].string
        match.lastMTime = json["last_m_time"].string
        match.credits = json["credits"].string
        match.checkM = json["check_m"].int
        match.gift = json["gift"].int

        return match
    }
}
