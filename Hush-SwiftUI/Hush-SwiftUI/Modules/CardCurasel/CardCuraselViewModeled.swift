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
    
    var discoveries: [Discover] { get set }
    var message: String { get set }
    var photos: [String] { get set }
    var name: String { get set }
    var age: String { get set }
    var address: String { get set }
    func loadDiscover(result: @escaping (Bool) -> Void)
    func updateMessage()
    var isShowingIndicator: Bool { get set }

    func viewModel(for index: Int) -> CardCuraselElementViewModel
}
