//
//  MessagesView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import CoreLogic

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
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ScrollView {
        VStack(spacing: 16) {
            header([Text("Messages").font(.thin(48)).foregroundColor(.hOrange)])
                .padding(.bottom, 25)
            Rectangle().frame(height: 0.9).foregroundColor(Color(0x4F4F4F))
            TextField("Search...", text: $viewModel.searchQuery).foregroundColor(Color(0x9B9B9B))
                .textFieldStyle(SearchTextFieldStyle())
            
                VStack(spacing: 0) {
                    ForEach(viewModel.items) { message in
                        NavigationLink(destination: MessageDetailView(viewModel: MessageDetailViewModel(message)).withoutBar()) {
                            MessagesCell(message: message).padding(.horizontal, 16)
                        }
                    }.onDelete { (set) in
                        print(set)
                    }
                }
            }
        }.background(Color.hBlack.edgesIgnoringSafeArea(.all))
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MessagesView(viewModel: MessagesViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                MessagesView(viewModel: MessagesViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                MessagesView(viewModel: MessagesViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
