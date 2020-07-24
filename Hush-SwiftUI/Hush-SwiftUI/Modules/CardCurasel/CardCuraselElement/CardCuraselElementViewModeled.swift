//
//  CardCuraselElementViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import UIKit

protocol CardCuraselElementViewModeled: ObservableObject {
    
    var message: String { get set }
    var image: UIImage { get }
    var conversation: HushConversation? { get set }
    func updateMessage()
}
