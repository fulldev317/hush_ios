//
//  Photo.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 28/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

struct Photo: Codable {
    
    var id: String
    var thumb: String
    var photo: String
    var approved: String
    var profile: String
    var blocked: String

    enum CodingKeys: String, CodingKey {
        case id
        case thumb
        case photo
        case approved
        case profile
        case blocked
    }
}
