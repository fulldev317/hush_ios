//
//  AddPhotosViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class AddPhotosViewModel: AddPhotosViewModeled {
    
    // MARK: - Properties

    @Published var message = "Hellow World!"
    
    func updateMessage() {

        message = "New Message"
    }
}
