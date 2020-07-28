//
//  MessagesCell.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessagesCell: View {
    
    let message: HushConversation
    var url: URL {
        URL(string: message.imageURL)!
    }
    
    var body: some View {
        HStack(spacing: 0) {
            WebImage(url: url)
                .resizable()
                .placeholder {
                    Image("placeholder_s").frame(width: 60, height: 60, alignment: .center)
                }
                .background(Color.white)
                .scaledToFill()
                .frame(width: 60, height: 60)
                .cornerRadius(30)
            
            VStack(alignment: .leading) {
                Text(message.username)
                    .font(.bold(17))
                    .foregroundColor(Color(0xBDBDBD))
                    .padding(.bottom, 6)
                Text(message.text)
                    .font(.regular(17))
                    .foregroundColor(Color(0xBDBDBD))
                    .lineLimit(2)
                Spacer()
            }.padding(.horizontal, 20)
            Spacer()
            VStack {
                Text(message.time).font(.regular(13)).foregroundColor(Color(0xACB1C0))
                Spacer()
            }
        }.buttonStyle(PlainButtonStyle()).frame(height: 90).listRowBackground(Color.hBlack)
    }
}

struct MessagesCell_Previews: PreviewProvider {
    static var previews: some View {
        MessagesCell(message: MessagesViewModel().item(at: 3))
    }
}
