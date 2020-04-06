//
//  MessageDetailView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct SendTextField: View {
    
    let placeholder: String
    let onsend: (String) -> Void
    
    @State private var text: String = ""
    @State private var height: CGFloat = 40
    
    var body: some View {
        HStack {
            MultilineTextField(placeholder, text: $text, height: $height)
                .padding(.vertical, 20)
                .foregroundColor(.white)
            HapticButton(action: {
                self.onsend(self.text)
                self.text = ""
            }) {
                Text("Send")
                    .font(.regular(17))
                    .foregroundColor(Color(0x9B9B9B))
            }
        }
        .padding(.horizontal, 15)
        .frame(height: height)
        .background(Color(0x4F4F4F).cornerRadius(8))
    }
}

struct MessageDetailView<ViewModel: MessageDetailViewModeled>: View, HeaderedScreen {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack {
                
                HStack {
                    Rectangle().frame(height: 0.9).foregroundColor(Color(0x4F4F4F))
                    Image("image3")
                        .aspectRatio()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                        .padding(.trailing, 20)
                }
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.messages(), id: \.id) {
                            ContentMessageView(contentMessage: $0.text, isCurrentUser: $0.userID == "SELF")
                        }
                    }
                }
                SendTextField(placeholder: "SAD", onsend: {
                    self.viewModel.sendMessage($0)
                }).padding(.horizontal, 15)
            }.keyboardAdaptive().padding(.top, top + 10)
            
            header([Text(viewModel.name()).font(.thin(48)).foregroundColor(.hOrange)])
        }.background(Color.hBlack.edgesIgnoringSafeArea(.all))
    }
}

struct MessageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MessageDetailView(viewModel: MessageDetailViewModel(MessagesViewModel().item(at: 3))).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                MessageDetailView(viewModel: MessageDetailViewModel(MessagesViewModel().item(at: 3))).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                MessageDetailView(viewModel: MessageDetailViewModel(MessagesViewModel().item(at: 3))).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
