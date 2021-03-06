//
//  Match.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 28/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

struct Match: Decodable {
    var id: String?
    var name: String?
    var firstName: String?
    var age: String?
    var city: String?
    var last_a: String?
    var premium: String?
    var photo: String?
    var error: Int?
    var story: String?
    var stories: String?
    var status: Int?
    var last_m: String?
    var last_m_time: String?
    var credits: String?
    var check_m: String?
    var gift: Int?
    var liked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstName
        case age
        case city
        case last_a
        case premium
        case photo
        case error
        case story
        case stories
        case status
        case last_m
        case last_m_time
        case credits
        case check_m
        case gift
        case liked
    }
}
