//
//  UserCodable.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 6/10/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

struct Stories: Codable {

    init() {
    }
    var story: String?
    var stories: [Story]?
    
    enum CodingKeys: String, CodingKey {
        case stories
    }
    
    
}


