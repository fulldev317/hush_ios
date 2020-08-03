//
//  LoginResponse.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 8/3/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

struct LoginResponse: Decodable {
    
    var error: Int
    var errorMessage: String
    var user: User
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorMessage = "error_m"
        case user
    }
}
