//
//  StorieViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class StorieViewModel: StorieViewModeled {
    
    // MARK: - Properties

    @Published var message = "Hellow World!"
    
    var placeholder: UIImage = UIImage(named: "stories_placeholder")!
    var numberOfStories: Int = 8
    
    
    func updateMessage() {

        message = "New Message"
    }
}
