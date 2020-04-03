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
    
    func updateMessage() {
        
        message = "New Message"
    }
    
    func viewModel(for index: Int) -> CardCuraselElementViewModel {
        
        CardCuraselElementViewModel()
    }
}
