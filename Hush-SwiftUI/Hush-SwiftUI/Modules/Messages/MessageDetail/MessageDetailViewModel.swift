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
    @Published var peerOnline: Int = 0
    // MARK: - Properties

    var conversation: HushConversation!
    
    init(_ messageItem: MessageItem) {
        self.peerName = messageItem.name!
        self.peerId = messageItem.id!
        self.peerImagePath = messageItem.profilePhoto!
        self.peerOnline = messageItem.online!
    }
    
    deinit {
         
     }
    
    func userChat(result: @escaping (Bool) -> Void) {

        ChatAPI.shared.user_chat(to_user_id: self.peerId) { (messageList, error) in
           
            
            if error == nil {
                if let messageList = messageList {
                    
                    if messageList.count < self.chatMessages.count {
                        result(true)
                        return
                    }
                    
                    self.chatMessages.removeAll()
                    Common.setChatMessage(message: [])
                    for message in messageList {
                        if let message = message {

                            let strDate = message.timestamp!
                            var date = Date()
                            if strDate.count > 0 {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "MMM d yyyy"
                                date = dateFormatter.date(from:strDate)!
                            }
                            
                            if message.type == "text" {
                                let hushMessage: HushTextMessage = HushTextMessage(id: message.id!, userID: message.isMe! ? "SELF" : "DEF", text: message.body!, time: date)
                                self.chatMessages.append(.text(hushMessage))
                            } else {
                                let hushMessage = HushImageMessage(id: message.id!, userID: message.isMe! ? "SELF" : "DEF", image: message.body!, time: date)
                                self.chatMessages.append(.image(hushMessage))
                            }
                        }
                    }
                }
                Common.setChatMessage(message: self.chatMessages)
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
        var last_id: Int = 0
        if (lastMessage != nil) {
            last_id = Int(lastMessage!.id)! + 1
        }
        let message = HushTextMessage(id: String(last_id), userID: "SELF", text: text)
        self.chatMessages.append(.text(message))
        Common.setChatMessage(message: self.chatMessages)
        
        changed = true
        ChatAPI.shared.sendMessage(to_user_id: peerId, message: text, type: "text") { (error) in
            self.changed = false
            if error == nil {
                
            }
        }
    }
    
    func sendImage(_ image: UIImage) {
        
        self.isShowingIndicator = true

        UserAPI.shared.upload_image(image: image) { (dic, error) in
            self.isShowingIndicator = false

            if error == nil {
                let imagePath = dic!["path"] as! String
                //let imageThumb = dic!["thumb"] as! String
                
                let lastMessage = self.chatMessages.last
                var last_id: Int = 0
                if (lastMessage != nil) {
                    last_id = Int(lastMessage!.id)! + 1
                }
                let message = HushImageMessage(id: String(last_id), userID: "SELF", image: imagePath)
                self.chatMessages.append(.image(message))
                Common.setChatMessage(message: self.chatMessages)
                self.changed = true
                
                ChatAPI.shared.sendMessage(to_user_id: self.peerId, message: imagePath, type: "image") { (error) in
                    self.changed = false
                    if error == nil {
                        
                    }
                }
            }
        }
    }
}
