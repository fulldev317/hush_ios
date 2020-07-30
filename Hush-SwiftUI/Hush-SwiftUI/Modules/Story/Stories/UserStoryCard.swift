//
//  UserStory.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 7/23/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

//
//  PolaroidCard.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct UserStoryCard: View {
    let username: String?
    let isMyStory: Bool
    let isFirstStory: Bool
    let storyImage: UIImage?
    let imagePath: String?
    let iconPath: String?

    var body: some View {
        ZStack(alignment: .top) {
            Color.white
                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
            
            VStack(spacing: 0) {
                GeometryReader { proxy in
                    WebImage(url: URL(string: self.imagePath ?? ""))
                    .resizable()
                    
//                    (self.storyImage == nil || !self.isMyStory ? Image("stories_placeholder") : Image(uiImage: self.storyImage!))
//                        .resizable()
//                        .scaledToFill()
                }.clipped()
                .overlay(overlay)
                .padding(8)
                .aspectRatio(1, contentMode: .fit)
                
                Text(isMyStory ? "Your Story" : username!)
                    .font(.light(14))
                    .foregroundColor(Color(0x8E8786))
            }
        }.aspectRatio(124 / 148, contentMode: .fit)
        .border(Color(0xE0E0E0), width: 1)
        .scaledToFill()
    }
    
    private var overlay: some View {
        Group {
            if isMyStory {
                Color.black.opacity(isFirstStory ? 1 : 0.7)
                    .overlay(Text("+")
                        .font(.system(.largeTitle))
                        .foregroundColor(.hOrange))
            } else {
                GeometryReader { p in
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            WebImage(url: URL(string: self.iconPath ?? ""))
                            .resizable()
                            .frame(width: p.size.width / 2.4, height: p.size.height / 2.4)
                            .background(Circle().fill(Color.white).padding(-3))
                            .clipShape(Circle())
//                            Image("image4")
//                                .resizable()
//                                .scaledToFill()
//                                .clipShape(Circle())
//                                .frame(width: p.size.width / 2.4, height: p.size.height / 2.4)
//                                .background(Circle().fill(Color.white).padding(-3))
                        }
                    }
                }
            }
        }
    }
}
