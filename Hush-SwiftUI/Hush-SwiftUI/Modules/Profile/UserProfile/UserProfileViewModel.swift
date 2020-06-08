//
//  UserProfileViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 09.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class UserProfileViewModel: UserProfileViewModeled {
    
    // MARK: - Properties

    @Published var mode: UserProfileMode = .photo
    
    var aboutMe = "Hello World!"
    var location = "Hello World!"
    let photos: [UIImage] = Array(0..<3).compactMap { UIImage(named: "image\($0.isMultiple(of: 2) ? 2 : 3)") }
    let stories: [UIImage] = Array(0..<20).compactMap { UIImage(named: "image\($0.isMultiple(of: 2) ? 2 : 3)") }
    
    func updateMessage() {

        
    }
    
    func switchMode() {
        
        mode.toggle()
    }
}
