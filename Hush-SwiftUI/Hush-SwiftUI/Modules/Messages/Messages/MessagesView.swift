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
    
    @ObservedObject var viewModel: ViewModel
    @State private var selectedMessage: HushConversation?
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            if selectedMessage != nil {
                NavigationLink(destination: MessageDetailView(viewModel: MessageDetailViewModel(selectedMessage!))
                    .withoutBar()
                    .onDisappear { self.selectedMessage = nil }, isActive: .constant(true), label: EmptyView.init)
            }
            
            VStack(spacing: 0) {
                List {
                    TextField("Search...", text: $viewModel.searchQuery).foregroundColor(Color(0x9B9B9B))
                        .textFieldStyle(SearchTextFieldStyle())
                        .listRowBackground(Color.black)
                        .padding(.bottom)
                        .listRowInsets(.init())
                    
                    ForEach(viewModel.items) { message in
                        MessagesCell(message: message).padding(.horizontal, 16)
                        .listRowInsets(.init())
                            .onTapGesture {
                                self.selectedMessage = message
                        }
                        }.onDelete(perform: self.viewModel.deleteContersation)
                        .background(Color.black)
                }.listStyle(DefaultListStyle())
                .withoutBar()
                .background(Color.black)
                    .appearenceModifier(path: \UITableView.backgroundColor, value: .black)
                    .appearenceModifier(path: \UITableView.separatorStyle, value: .none)
            }
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
