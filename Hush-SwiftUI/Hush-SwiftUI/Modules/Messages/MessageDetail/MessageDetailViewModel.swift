//
//  MessageDetailViewModel.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Combine

class MessageDetailViewModel: MessageDetailViewModeled {
    
    @Published private var changed = false
    
    // MARK: - Properties

    var conversation: HushConversation!
    
    init(_ conversation: HushConversation) {
        self.conversation = conversation
    }
    
    func messages() -> [HushMessage] {
        conversation.messages
    }
    
    func name() -> String {
        conversation.username
    }
    
    func sendMessage(_ text: String) {
        let message = HushTextMessage(userID: "SELF", text: text)
        conversation.sendMessage(.text(message))
        changed.toggle()
    }
    
    func sendImage(_ image: UIImage) {
        let message = HushImageMessage(userID: "SELF", image: image)
        conversation.sendMessage(.image(message))
        changed.toggle()
    }
}
