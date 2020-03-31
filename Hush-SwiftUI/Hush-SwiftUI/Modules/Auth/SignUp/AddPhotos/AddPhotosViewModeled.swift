//
//  AddPhotosViewModeled.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Foundation

protocol AddPhotosViewModeled: ObservableObject {
    
    var messageLabel: String { get set }
    func addPhotoPressed()
}
