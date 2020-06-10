//
//  UserDefault.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 12.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

@propertyWrapper
class UserDefault<Value>: ObservableObject {
    var objectWillChange = PassthroughSubject<(), Never>()
    let key: DefaultKey
    
    init(_ key: DefaultKey, default defaultValue: Value) {
        self.key = key
        defaults.register(defaults: [key.rawValue : defaultValue])
    }
    
    var wrappedValue: Value {
        get { defaults.object(forKey: key.rawValue) as! Value }
        set {
            objectWillChange.send()
            defaults.set(newValue, forKey: key.rawValue)
        }
    }
    
    private var defaults: UserDefaults { .standard }
}

extension UserDefault {
    enum DefaultKey: String {
        case isFirstLaunch
        case isLoggedIn
        case currentUser
    }
}
