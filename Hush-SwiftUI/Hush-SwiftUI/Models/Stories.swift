//
//  Story.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 7/23/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

struct Stories: Codable {
    var id: String?
    var profile_photo: String?
    var profile_photo_big: String?
    var city: String?
    var country: String?
    var address: String?
    var age: String?
    var fadeDelay: Int?
    var video: Int?
    var name: String?
    var status: Int?
    var story: String?
    var liked: Bool?
}
