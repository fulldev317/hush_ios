//
//  Spotlight.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 28/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import SwiftyJSON

class Spotlight {
    
    internal var id: String!
    internal var name: String!
    internal var gender: String!
    internal var firstName: String!
    internal var age: String!
    internal var city: String!
    internal var photo: String!
    internal var spotPhoto: String!
    internal var error: Int!
    internal var status: Int!

    static func parseFromJson(_ json: JSON) -> Spotlight {
        let spotlight = Spotlight()
        spotlight.id = json["id"].string
        spotlight.name = json["name"].string
        spotlight.gender = json["gender"].string
        spotlight.firstName = json["firstName"].string
        spotlight.age = json["age"].string
        spotlight.city = json["city"].string
        spotlight.photo = json["photo"].string
        spotlight.spotPhoto = json["spotPhoto"].string
        spotlight.error = json["error"].int
        spotlight.status = json["id"].int
        return spotlight
    }
}
