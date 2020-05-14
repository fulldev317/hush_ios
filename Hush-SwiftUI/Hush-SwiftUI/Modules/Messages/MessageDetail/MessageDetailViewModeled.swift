//
//  MessageDetailViewModeled.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import Combine
import UIKit

protocol MessageDetailViewModeled: ObservableObject {
    
    func messages() -> [HushMessage]
    func name() -> String
    func sendMessage(_ text: String)
    func sendImage(_ image: UIImage)
}
