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
    
    var peerId: String { get set }
    var peerName: String { get set }
    var peerImagePath: String { get set }
    var peerOnline: Int { get set }
    var isShowingIndicator: Bool { get set }
    var chatMessages: [HushMessage] { get set }

    func userChat(result: @escaping (Bool) -> Void)
    func name() -> String
    func sendMessage(_ text: String)
    func sendImage(_ image: UIImage)
}
