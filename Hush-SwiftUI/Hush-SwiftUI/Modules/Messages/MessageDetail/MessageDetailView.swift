//
//  MessageDetailView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import CoreLogic

struct MessageDetailView<ViewModel: MessageDetailViewModeled>: View, HeaderedScreen {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var app: App
    @State private var keyboardHeight: CGFloat = 0
    
    // MARK: - Lifecycle
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: -15) {
                Text(viewModel.name()).font(.thin(48)).foregroundColor(.hOrange)
                HStack {
                    HapticButton(action: { self.mode.wrappedValue.dismiss() }) {
                        HStack(spacing: 23) {
                            Image("onBack_icon")
                            Text("Back to messages").foregroundColor(.white).font(.thin())
                        }
                    }
                    Spacer()
                    Image("story3")
                        .aspectRatio()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                        .padding(.trailing, 20)
                        .overlay(Circle()
                            .fill(Color(0x27AE60))
                            .square(22)
                            .padding(.trailing, 9),
                        alignment: .topTrailing)
                }
            }.padding([.horizontal, .top])
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(self.viewModel.messages(), id: \.id) { message in
                        ContentMessageView(time: message.time, contentMessage: message.text, isCurrentUser: message.userID == "SELF", shouldShowDate: self.messageShouldShowDate(message))
                            .rotationEffect(.degrees(180))
                            .padding(message.userID == "SELF" ? .trailing : .leading, 70)
                    }
                }.padding(.bottom, 30)
            }
            .rotationEffect(.degrees(180))
            SendTextField(placeholder: "SAD", onsend: {
                self.viewModel.sendMessage($0)
            }).padding(.horizontal, 15)
        }//.keyboardAdaptive()
        .offset(x: 0, y: keyboardHeight == 0 ? 0 : -keyboardHeight + 70)
        .observeKeyboardHeight($keyboardHeight, withAnimation: .default)
        .background(Color.hBlack.edgesIgnoringSafeArea(.all))
    }
    
    func messageShouldShowDate(_ message: HushMessage) -> Bool {
        let messages = viewModel.messages()
        guard let index = messages.firstIndex(where: { $0.id == message.id }), index > 0 else { return true }
        return messages[index - 1].userID != message.userID
    }
}

struct MessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MessageDetailView(viewModel: MessageDetailViewModel(MessagesViewModel().item(at: 3))).withoutBar()
            }
        }
    }
}
