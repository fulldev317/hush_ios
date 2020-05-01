//
//  AddPhotosViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import AVFoundation
import UIKit

class AddPhotosViewModel: AddPhotosViewModeled {
    
    // MARK: - Properties

    @Published var messageLabel = "With Hush’s own Filters you can make \nyour photo as private as you like!"
    @Published var canGoNext = false
    @Published var selectedImage: UIImage?
    
    var disposals = Set<AnyCancellable>()
    
    init() {
        $selectedImage
            .map { $0 != nil }
            .removeDuplicates()
            .assign(to: \.canGoNext, on: self)
        .store(in: &disposals)
    }
}
