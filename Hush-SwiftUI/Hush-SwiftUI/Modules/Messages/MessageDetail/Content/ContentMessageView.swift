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
    let shouldShowDate: Bool
    
    var body: some View {
        VStack(alignment: isCurrentUser ? .trailing : .leading, spacing: 4) {
            HStack {
                Text(contentMessage)
                    .padding(10)
                    .foregroundColor(Color.white)
                Spacer()
            }.background(background())
        
            if shouldShowDate {
                if !isCurrentUser {
                    Text(getTime()).font(.regular(13)).foregroundColor(Color(0xB9BFCA))
                } else {
                    (Text(getTime()) + Text(" | Delivered")).font(.regular(13)).foregroundColor(Color(0xB9BFCA))
                }
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
        formatter.dateFormat = "MM:dd:yyyy HH:MM"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        return formatter.string(from: date)
    }
}

struct ContentMessageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            ContentMessageView(time: 43567890, contentMessage: "Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend", isCurrentUser: false, shouldShowDate: false).padding(.trailing, 70)
            ContentMessageView(time: 43567890, contentMessage: "Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend", isCurrentUser: false, shouldShowDate: true).padding(.trailing, 70)
            ContentMessageView(time: 43547890, contentMessage: "Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend", isCurrentUser: true, shouldShowDate: true).padding(.leading, 70)
        }.background(Color.black).previewLayout(.sizeThatFits)
    }
}
