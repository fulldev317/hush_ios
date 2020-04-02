//
//  UserCardViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import UIKit

protocol UserCardViewModeled: ObservableObject {
    
    var age: Int { get }
    var image: UIImage { get }
    var name: String { get }
    var selected: Bool { get }
    
    func select()
}
