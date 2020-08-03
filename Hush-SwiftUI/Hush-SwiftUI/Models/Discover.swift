//
//  DiscoverCodable.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 6/10/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

struct Discover: Codable {

    init() {
        id = "123456"
        name = "Max Zaiets"
        firstName = "Max"
        age = "30"
        gender = "1"
        city = "Los Angels, US"
        photo = "image1"
        liked = false
    }
    
    init(match: Match) {
        id = match.id
        name = match.name
        firstName = match.firstName
        age = match.age
        city = match.city
        photo = match.photo
        error = match.error
        story = match.story
        status = match.status
        liked = match.liked
    }
    var id: String?
    var name: String?
    var firstName: String?
    var age: String?
    var gender: String?
    var city: String?
    var photo: String?
    var photoBig: String?
    var error: Int?
    var show: Int?
    var status: Int?
    var blocked: Int?
    var margin: String?
    var story: String?
    var stories: String?
    var fan: Int?
    var match: Int?
    var liked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case firstName
        case age
        case gender
        case city
        case photo
        case photoBig
        case error
        case show
        case status
        case blocked
        case margin
        case story
        case stories
        case fan
        case match
    }
}


