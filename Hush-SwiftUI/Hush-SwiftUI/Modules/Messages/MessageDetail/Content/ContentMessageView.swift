//
//  ContentMessageView.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct ContentMessageView: View {
    
    var time: Double
    var contentMessage: String
    var isCurrentUser: Bool
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 20) {
            
            if isCurrentUser {
                Text(getTime()).font(.regular(13)).foregroundColor(Color(0xB9BFCA))
            }
        
            HStack {
                Text(contentMessage)
                    .padding(10)
                    .foregroundColor(Color.white)
                Spacer()
            }.background(background())
        
            if !isCurrentUser {
                Text(getTime()).font(.regular(13)).foregroundColor(Color(0xB9BFCA))
            }
        }.padding(.horizontal, 16)
    }
    
    private func background() -> some View {
        
        let color = isCurrentUser ? Color(0x242A38) : Color(0x4CDA64)
        let bl: CGFloat = isCurrentUser ? 0 : 20
        let br: CGFloat  = isCurrentUser ? 20 : 0
        
        return RoundedCorners(color: color, tl: 20, tr: 20, bl: bl, br: br)
    }
    
    private func getTime() -> String {
        
        let date = Date(timeIntervalSince1970: time)
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        return formatter.string(from: date)
    }
}

struct ContentMessageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentMessageView(time: 43567890, contentMessage: "Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend", isCurrentUser: false)
            ContentMessageView(time: 43547890, contentMessage: "Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend", isCurrentUser: true)
        }
    }
}
