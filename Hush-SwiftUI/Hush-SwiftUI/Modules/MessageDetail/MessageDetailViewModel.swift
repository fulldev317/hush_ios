//
//  MessageDetailViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine
import CoreLogic

class MessageDetailViewModel: MessageDetailViewModeled {
    
    @Published var changed = false
    
    // MARK: - Properties

    var conv: HushConversation!
    
    init(_ conversation: HushConversation) {
        self.conv = conversation
    }
    
    func messages() -> [HushMessage] {
        conv.messages
    }
    
    func name() -> String {
        conv.username
    }
    
    func sendMessage(_ text: String) {
        
        conv.sendMessage(HushMessage(userID: "SELF", text: text, time: Date().timeIntervalSinceNow))
        changed.toggle()
    }
}
