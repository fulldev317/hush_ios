//
//  CardCuraselElementViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class CardCuraselElementViewModel: CardCuraselElementViewModeled {
    
    // MARK: - Properties

    @Published var message = "Hellow World!"
    let image: UIImage = UIImage(named: "image3")!

    func updateMessage() {

        message = "New Message"
    }
}
