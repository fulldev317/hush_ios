//
//  UserProfileViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 09.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import UIKit

enum UserProfileMode {
    case photo
    case info
    
    mutating func toggle() {
        
        self = self == .photo ? .info : .photo
    }
}

protocol UserProfileViewModeled: ObservableObject {
    
    var mode: UserProfileMode { get }
    var aboutMe: String { get set }
    var location: String { get set }
    var photos: [UIImage] { get }
    var stories: [UIImage] { get }
    
    func switchMode()
}
