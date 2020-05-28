//
//  Photo.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 28/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photo {
    
    internal var id: String!
    internal var thumb: String!
    internal var photo: String!
    internal var approved: String!
    internal var profile: String!
    internal var blocked: String!

    static func parseFromJson(_ json: JSON) -> Photo {
        let photo = Photo()
        photo.id = json["id"].string
        photo.thumb = json["thumb"].string
        photo.photo = json["photo"].string
        photo.approved = json["approved"].string
        photo.profile = json["profile"].string
        photo.blocked = json["blocked"].string
        return photo
    }
}
