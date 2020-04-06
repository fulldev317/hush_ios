//
//  ContentMessageView.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 06.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct ContentMessageView: View {
    
    var contentMessage: String
    var isCurrentUser: Bool
    
    var body: some View {
        HStack {
            Text(contentMessage)
            .padding(10)
            .foregroundColor(Color.white)
            Spacer()
        }
            .background(background())
            .padding(.leading, isCurrentUser ? 80 : 30)
            .padding(.trailing, isCurrentUser ? 30 : 80)
    }
    
    private func background() -> some View {
        
        let color = isCurrentUser ? Color(0x242A38) : Color(0x4CDA64)
        let bl: CGFloat = isCurrentUser ? 0 : 20
        let br: CGFloat  = isCurrentUser ? 20 : 0
        
        return RoundedCorners(color: color, tl: 20, tr: 20, bl: bl, br: br)
    }
}

struct ContentMessageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentMessageView(contentMessage: "Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend", isCurrentUser: false)
            ContentMessageView(contentMessage: "Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend Hi, I am your friend", isCurrentUser: true)
        }
    }
}
