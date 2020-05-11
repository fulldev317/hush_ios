//
//  StoryView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 11.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct StoryView: View {
    @State var currentStory = 0
    @State var storyItems = ["stories_placeholder", "story1", "story2", "story3"]
    @State var message = ""
    @State private var keyboardHeight: CGFloat = 0
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var modalPresenterManager: ModalPresenterManager
    
    var body: some View {
        GeometryReader(content: content)
    }
    
    private func content(_ proxy: GeometryProxy) -> some View {
        ZStack {
            Image(storyItems[currentStory])
                .resizable()
                .scaledToFill()
                .clipped()
                .edgesIgnoringSafeArea(.all)
                .frame(proxy)
                .onTapGesture {
                    if self.currentStory < self.storyItems.count - 1 {
                        self.currentStory += 1
                    } else {
                        self.modalPresenterManager.dismiss()
                    }
                }
            
            VStack {
                HStack(spacing: 0) {
                    Image("image4")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 52, height: 52)
                        .background(Circle().fill(Color.white).padding(-5))
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Long Username").font(.bold(24))
                        Text("21 minutes ago").font(.regular())
                    }.shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                    Spacer()
                    Button(action: {}) {
                        Image("heart_icon")
                    }
                    Spacer()
                    Button(action: modalPresenterManager.dismiss) {
                        Image("close_icon")
                    }
                }.foregroundColor(.white)
                .padding(.horizontal, 20)
                
                HStack {
                    Spacer()
                    VStack {
                        ForEach(storyItems.indices, id: \.self) { i in
                            Rectangle()
                                .foregroundColor(i <= self.currentStory ? .hOrange : Color.white.opacity(0.5))
                                .frame(width: 5)
                        }
                    }.padding(.trailing, 25)
                    .frame(height: proxy.size.height / 2)
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding()
                        }.shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                        .padding(.trailing)
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color(0xF2F2F2).opacity(0.5))
                        
                        HStack {
                            TextField("", text: $message)
                                .font(.system(size: 17))
                                .background(Text("Say something")
                                    .opacity(message.isEmpty ? 1 : 0), alignment: .leading)
                                .foregroundColor(Color.black.opacity(0.5))
                            Spacer()
                            Button(action: {}) {
                                Image("paperplane")
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                            }
                        }.padding(.leading, 14)
                        .offset(x: 0, y: 2)
                    }.padding(.leading, 21)
                    .padding(.trailing, 16)
                    .frame(height: 40)
                    .offset(x: 0, y: -keyboardHeight)
                    .animation(.default)
                    .observeKeyboardHeight($keyboardHeight)
                }
            }
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
    }
}
