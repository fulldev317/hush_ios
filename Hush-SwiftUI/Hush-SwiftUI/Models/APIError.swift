//
//  APIError.swift
//  Hush-SwiftUI
//
//  Created by iOS-dev on 28/05/2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import SwiftyJSON

class APIError {
    
    internal var error: Int!
    internal var message: String!
    
    init(_ error: Int, _ message: String) {
        self.error = error
        self.message = message
    }
}
