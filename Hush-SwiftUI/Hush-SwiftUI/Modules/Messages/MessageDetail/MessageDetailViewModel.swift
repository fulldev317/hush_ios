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
    @Published var peerImagePath: String = ""
    @Published var peerName: String = ""
    @Published var peerId: String = ""

    // MARK: - Properties

    var conversation: HushConversation!
    
    init(_ messageItem: MessageItem) {
        self.peerName = messageItem.name!
        self.peerId = messageItem.id!
        self.peerImagePath = messageItem.profilePhoto!
        //self.peerImagePath = "https://www.hushdating.app/assets/sources/uploads/thumb_5efdff0a0e620_image1.jpg"
    }
    
    func messages(conversation:HushConversation) -> [HushMessage] {
        return conversation.messages
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
