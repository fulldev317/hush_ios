//
//  App.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation
import SwiftUI

struct AppKey: EnvironmentKey {
    static let defaultValue: App = App()
}

extension EnvironmentValues {
    var app: App {
        get {
            return self[AppKey.self]
        }
        set {
            self[AppKey.self] = newValue
        }
    }
}

class App: ObservableObject {
    
}
