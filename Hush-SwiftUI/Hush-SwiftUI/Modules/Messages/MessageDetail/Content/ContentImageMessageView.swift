//
//  ContentImageMessageView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 15.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentImageMessageView: View {
    let image: String
    let time: Date
    let isCurrentUser: Bool
    let shouldShowDate: Bool
    
    @Environment(\.deviceScale) private var deviceScale
    
    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            VStack (alignment: isCurrentUser ? .trailing : .leading, spacing: 4) {
                if shouldShowDate {
                    HStack {
                        if !isCurrentUser {
                            Text(getTime()).font(.regular(13)).foregroundColor(Color(0xB9BFCA))
                        } else {
                            (Text(getTime()) + Text(" | Delivered")).font(.regular(13)).foregroundColor(Color(0xB9BFCA))
                        }
                    }
                }
                WebImage(url: URL(string: image))
                .resizable()
                .placeholder {
                    Image("placeholder_s")
                }
                .background(Color.white)
                .frame(width: 150 * deviceScale, height: 150 * deviceScale)
            }
            if !isCurrentUser {
                Spacer()
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
        ContentImageMessageView(image: "https://www.hushdating.app/assets/sources/uploads/thumb_5f3bd624e621b_image1.jpg", time: Date(), isCurrentUser: false, shouldShowDate: true)
    }
}
