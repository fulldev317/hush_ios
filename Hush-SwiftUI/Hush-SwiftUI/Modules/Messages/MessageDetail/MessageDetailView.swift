//
//  MessageDetailView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct MessageDetailView<ViewModel: MessageDetailViewModeled>: View, HeaderedScreen {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var app: App
    
    
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
                }.frame(height: 40)
                HStack {
                    HapticButton(action: { self.mode.wrappedValue.dismiss() }) {
                        HStack {
                        Image("backArrow")
                            .aspectRatio(.fit)
                            .frame(width: 25, height: 25)
                            Text("Back to messages").foregroundColor(.white).font(.thin())
                        }
                    }
                    Spacer()
                }
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(self.viewModel.messages(), id: \.id) {
                            ContentMessageView(time: $0.time, contentMessage: $0.text, isCurrentUser: $0.userID == "SELF")
                                .rotationEffect(.degrees(180))
                        }
                    }.padding(.bottom, 30)
                }
                .rotationEffect(.degrees(180))
                SendTextField(placeholder: "SAD", onsend: {
                    self.viewModel.sendMessage($0)
                }).padding(.horizontal, 15)
            }.keyboardAdaptive()
            
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
