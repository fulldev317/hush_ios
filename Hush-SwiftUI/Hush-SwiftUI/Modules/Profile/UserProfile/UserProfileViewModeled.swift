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
    var photoUrls: [String] { get set }
    var unlockedPhotos: Set<Int> { get set }
    var stories: [UIImage] { get }
    var name: String { get set }
    var address: String { get set }
    var bio: String { get set }
    var lookfor: String { get set }
    var gender: String { get set }
    var herefor: String { get set }

    func switchMode()
}
