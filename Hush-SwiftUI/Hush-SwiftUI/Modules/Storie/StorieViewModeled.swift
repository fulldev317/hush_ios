//
//  StorieViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import UIKit

protocol StorieViewModeled: ObservableObject {
    
    var message: String { get set }
    var placeholder: UIImage { get }
    
    func updateMessage()
}
