//
//  DiscoverCodable.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 6/10/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

struct Game: Codable {

    init() {
    }
    
    var id: String?
    var name: String?
    var status: Int?
    var distance: String?
    var age: String?
    var city: String?
    var bio: String?
    var isFan: Int?
    var total: String?
    var photo: String?
    var discoverPhoto: String?
    var story: String?
    var stories: String?
    var error: Int?
    var full: FullInfo?
    var liked: Bool?

    struct FullInfo: Codable {
        var online: String?
        var online_day: String?
    }
}


