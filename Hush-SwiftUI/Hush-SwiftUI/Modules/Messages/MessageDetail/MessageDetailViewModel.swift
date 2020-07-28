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
    @Published var isShowingIndicator: Bool = false
    @Published var chatMessages: [HushMessage] = []
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
    }
    
    func userChat(result: @escaping (Bool) -> Void) {

        self.isShowingIndicator = true

        ChatAPI.shared.userChat(to_user_id: self.peerId) { (messageList, error) in
            self.isShowingIndicator = false
            self.chatMessages.removeAll()

            if error == nil {
                if let messageList = messageList {
                    for message in messageList {
                        if (message != nil) {

                            let strDate = message!.timestamp!
                            var date = Date()
                            if strDate.count > 0 {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "MMM d yyyy"
                                date = dateFormatter.date(from:strDate)!
                            }
                            
                            if message!.type == "text" {
                                let hushMessage: HushTextMessage = HushTextMessage(id: message!.id!, userID: message!.isMe! ? "SELF" : "DEF", text: message!.body!, time: date)
                                self.chatMessages.append(.text(hushMessage))
                            } else {
                                let hushMessage = HushImageMessage(id: message!.id!, userID: message!.isMe! ? "SELF" : "DEF", image: UIImage(named: message!.body!)!, time: date)
                                self.chatMessages.append(.image(hushMessage))
                            }
                        }
                    }
                }
                result(true)
            } else {
                result(false)
            }
        }
    }
    
    func name() -> String {
        conversation.username
    }
    
    func sendMessage(_ text: String) {
        let lastMessage = self.chatMessages.last
        let last_id = Int(lastMessage!.id)
        let message = HushTextMessage(id: String(last_id! + 1), userID: "SELF", text: text)
        
        changed = true
        ChatAPI.shared.sendMessage(to_user_id: peerId, message: text, type: "text") { (error) in
            self.changed = false
            if error == nil {
                self.chatMessages.append(.text(message))
            }
        }
    }
    
    func sendImage(_ image: UIImage) {
        let message = HushImageMessage(userID: "SELF", image: image)
        conversation.sendMessage(.image(message))
        changed.toggle()
    }
}
