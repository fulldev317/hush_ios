//
//  MessageDetailView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessageDetailView<ViewModel: MessageDetailViewModeled>: View, HeaderedScreen {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var app: App
    @State private var keyboardHeight: CGFloat = 0
    @State var indexPathToSetVisible: IndexPath?

    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    // MARK: - Lifecycle
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        Common.setUnreadChatEnabled(enabled: false)
        
        if (Common.messageLoaded()) {

            self.viewModel.isShowingIndicator = true
            
            self.viewModel.userChat { result in
                viewModel.isShowingIndicator = false
                if (result == true) {
                    Common.setMessageLoaded(loaded: false)
                }
            }
        } else {
            self.viewModel.chatMessages = Common.chatMessage()
        }
    }
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text($viewModel.peerName.wrappedValue).font(.thin(48)).foregroundColor(.hOrange)
                    .onReceive(timer) { input in
                        self.viewModel.userChat { result in
                            if (result == true) {
                                
                            }
                        }
                    }
                    HStack(alignment: .top) {
                        HapticButton(action: {
                            self.mode.wrappedValue.dismiss()
                            self.timer.upstream.connect().cancel()
                        }) {
                            HStack(spacing: 23) {
                                Image("onBack_icon")
                                Text("Back to messages").foregroundColor(.white).font(.thin())
                            }
                        }
                        Spacer()
                        WebImage(url: URL(string: $viewModel.peerImagePath.wrappedValue))
                        .resizable()
                        .placeholder {
                            Image("placeholder_s").frame(width: 60, height: 60, alignment: .center)
                        }
                        .background(Color.white)
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                        .overlay(Circle()
                        .fill(self.viewModel.peerOnline == 1 ? Color(0x27AE60) : Color(0xe4e5e8))
                            .square(22)
                            .padding(.trailing, 0),
                             alignment: .topTrailing)
                        
                    }
                }.padding([.horizontal])
                
                if (self.viewModel.chatMessages.count > 0) {
                    if ($keyboardHeight.wrappedValue > 0) {
                        HushScrollView(scrollToEnd: true) {
                            ForEach(self.viewModel.chatMessages, id: \.id) { message in
                                self.viewForMessage(message)
                            }
                        }
                    } else {
                        HushScrollView(scrollToEnd: true) {
                            ForEach(self.viewModel.chatMessages, id: \.id) { message in
                                self.viewForMessage(message)
                            }
                        }
                    }
                } else {
                    Spacer()
                }


                SendTextField(placeholder: "Type your Message", onsend: viewModel.sendMessage(_:), onimage: viewModel.sendImage(_:))
                    .padding(.horizontal, 15)

                if (keyboardHeight > 0) {
                    Spacer(minLength: keyboardHeight - 70)
                }
                
            }
            .observeKeyboardHeight($keyboardHeight, withAnimation: .default)
            .background(Color.hBlack.edgesIgnoringSafeArea(.all))
                
            HushIndicator(showing: self.viewModel.isShowingIndicator)

        }
    }
    
    private func viewForMessage(_ message: HushMessage) -> some View {
        Group {
            if message.isText {
                viewForTextMessage(message)
            }
            
            if message.isImage {
                viewForImageMessage(message)
            }
                
        }
    }
    
    private func viewForTextMessage(_ message: HushMessage) -> some View {
        guard case let .text(textMessage) = message else { fatalError() }
        return ContentTextMessageView(
            time: message.time,
            contentMessage: textMessage.text.parseSpecialText(),
            isCurrentUser: message.userID == "SELF",
            shouldShowDate: self.messageShouldShowDate(message)
        )
        .padding(message.userID == "SELF" ? .leading : .trailing, 40)
        
    }
    
    private func viewForImageMessage(_ message: HushMessage) -> some View {
        guard case let .image(imageMessage) = message else { fatalError() }
        return ContentImageMessageView(image: imageMessage.image, time: message.createdAt, isCurrentUser: message.userID == "SELF", shouldShowDate: self.messageShouldShowDate(message))
            .padding(message.userID == "SELF" ? .trailing : .leading, 20)
        
    }
    
    func messageShouldShowDate(_ message: HushMessage) -> Bool {
        let messages = viewModel.chatMessages
        guard let index = messages.firstIndex(of: message), index > 0 else { return true }
        return messages[index - 1].userID != message.userID
    }
}

struct MessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MessageDetailView(viewModel: MessageDetailViewModel(MessageItem(user_id: "111", name: "Test", image: "https://www.hushdating.app/assets/sources/uploads/thumb_5efdff0a0e620_image1.jpg", online: 0))).withoutBar()
            }
        }
    }
}
