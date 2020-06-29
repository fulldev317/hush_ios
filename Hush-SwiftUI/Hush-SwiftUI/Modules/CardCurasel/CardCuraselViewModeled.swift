//
//  CardCuraselViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import SwiftUI

protocol CardCuraselViewModeled: ObservableObject {
    
    var message: String { get set }
    var photos: [Photo] { get set }
    var name: String { get set }
    var age: String { get set }
    var address: String { get set }
    func updateMessage()
    
    func viewModel(for index: Int) -> CardCuraselElementViewModel
}
