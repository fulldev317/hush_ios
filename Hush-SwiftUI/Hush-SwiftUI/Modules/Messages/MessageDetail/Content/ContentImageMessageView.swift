//
//  ContentImageMessageView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 15.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct ContentImageMessageView: View {
    let image: UIImage
    let time: Date
    let isCurrentUser: Bool
    let shouldShowDate: Bool
    
    @Environment(\.deviceScale) private var deviceScale
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 146 * deviceScale, height: 183 * deviceScale)
                    .clipped()
            }.padding(.trailing, 28 * deviceScale)
            
            if shouldShowDate {
                if !isCurrentUser {
                    Text(getTime()).font(.regular(13)).foregroundColor(Color(0xB9BFCA))
                } else {
                    (Text(getTime()) + Text(" | Delivered")).font(.regular(13)).foregroundColor(Color(0xB9BFCA))
                }
            }
        }
    }
    
    private func getTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM:dd:yyyy HH:MM"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        return formatter.string(from: time)
    }
}

struct ContentImageMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentImageMessageView(image: UIImage(named: "story1")!, time: Date(), isCurrentUser: true, shouldShowDate: true)
    }
}
