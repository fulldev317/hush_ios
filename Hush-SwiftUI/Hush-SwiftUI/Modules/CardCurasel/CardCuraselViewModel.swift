//
//  CardCuraselViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class CardCuraselViewModel: CardCuraselViewModeled {
        
    // MARK: - Properties
    
    @Published var message = "Hellow World!"
    @Published var photos: [Photo] = []
    @Published var name: String = "Alex"
    @Published var age: String = "32"
    @Published var address: String = "London, UK"
    
    func updateMessage() {
        
        message = "New Message"
    }
    
    func viewModel(for index: Int) -> CardCuraselElementViewModel {
       
        return CardCuraselElementViewModel()
    }
}
