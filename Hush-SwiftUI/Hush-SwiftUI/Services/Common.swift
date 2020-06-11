//
//  Common.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 6/11/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

var _user: User?

class Common: NSObject {
    static func setUserInfo(_ user: User) {
        _user = user
    }
    
    static func userInfo() -> User {
        return _user!
    }
}
