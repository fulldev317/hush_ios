//
//  App.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import UIKit

struct iOSApp {
    
    static func open(_ url: URL) {
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
