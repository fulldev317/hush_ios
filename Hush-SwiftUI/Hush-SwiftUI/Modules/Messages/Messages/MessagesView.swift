//
//  MessagesView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct SearchTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<_Label>) -> some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(Color(0x4F4F4F))
            HStack {
                Image("search")
                    .aspectRatio(.fit)
                    .frame(width: 26, height: 26)
                configuration.foregroundColor(.white)
            }.padding(.horizontal, 10)
            
        }
        .frame(height: 40)
        .padding(.horizontal, 16)
    }
}

extension HushConversation: Identifiable { }

struct MessagesView<ViewModel: MessagesViewModeled>: View, HeaderedScreen {
    
    // MARK: - Properties
    @EnvironmentObject private var app: App
    @ObservedObject var viewModel: ViewModel
    @State private var selectedMessage: HushConversation?
    @State private var openUpgradePage = false
    @State private var keyboardPresented: Bool = false
    @State private var keyboardHeight: CGFloat = 0

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        Common.setUnreadChatEnabled(enabled: false)
        self.viewModel.getChat { result in
            if (result == true) {
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
        
    }
    // MARK: - Lifecycle
    @ViewBuilder
    var body: some View {
        ZStack {
            if Common.premium() && selectedMessage != nil {
                NavigationLink(destination: MessageDetailView(viewModel: MessageDetailViewModel(MessageItem(user_id: selectedMessage!.id, name: selectedMessage!.username, image: selectedMessage!.imageURL, online: selectedMessage!.online)))
                    .withoutBar()
                    .onDisappear { self.selectedMessage = nil }, isActive: .constant(true), label: EmptyView.init)
            }
                        
            VStack(spacing: 0) {
                TextField("Search...", text: $viewModel.searchQuery)
                    .textFieldStyle(SearchTextFieldStyle())
                    .listRowBackground(Color.black)
                    .padding(.bottom)
                    .listRowInsets(.init())
                    .environment(\.colorScheme, .dark)

                ZStack {
                    List {
                        ForEach(viewModel.filteredItems) { message in
                            MessagesCell(message: message).padding(.horizontal, 16)
                                .listRowInsets(.init())
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    self.selectedMessage = message
                                    if Common.premium() == true {
                                        Common.setMessageLoaded(loaded: true)
                                        ChatAPI.shared.message_read(to_user_id: message.id) { (error) in
                                            if (error == nil) {
                                                
                                            }
                                        }
                                    } else {
                                        self.app.showPremium.toggle()
                                    }
                                    UIApplication.shared.endEditing()
                                }
                            }.onDelete(perform: self.viewModel.deleteContersation)
                            .background(Color.black)
                    }.listStyle(DefaultListStyle())
                    .withoutBar()
                    .background(Color.black)
                        .appearenceModifier(path: \UITableView.backgroundColor, value: .black)
                        .appearenceModifier(path: \UITableView.separatorStyle, value: .none)
                    
//                    if (keyboardHeight > 0) {
//                        VStack {
//                            Spacer()
//                        }
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
//                        .background(Color.black.opacity(0.04))
//                        .onTapGesture {
//                            UIApplication.shared.endEditing()
//                        }
//                    }
                }                
            }
            
            HushIndicator(showing: self.viewModel.isShowingIndicator)

        }.actionSheet(isPresented: self.$viewModel.showMessageFilter) {
            ActionSheet(title: Text("Filter Messages"), message: nil, buttons: MessagesFilter.allCases.map { filter in
                .default(Text(filter.title), action: {
                    self.viewModel.filter = filter
                    self.viewModel.showMessageFilter = false
                })
            } + [.cancel()])
        }
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MessagesView(viewModel: MessagesViewModel())
            }
        }
    }
}
