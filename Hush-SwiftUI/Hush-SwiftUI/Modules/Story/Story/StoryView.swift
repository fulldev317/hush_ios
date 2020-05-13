//
//  StoryView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 11.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct StoryView<ViewModel: StoryViewModeled>: View {
    @ObservedObject var viewModel: ViewModel
    
    @State private var keyboardHeight: CGFloat = 0
    @State private var showReport = false
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var modalPresenterManager: ModalPresenterManager
    @EnvironmentObject private var app: App
    
    var body: some View {
        GeometryReader(content: content)
    }
    
    private func content(_ proxy: GeometryProxy) -> some View {
        ZStack {
            viewModel.stories[viewModel.currentStoryIndex]
                .resizable()
                .scaledToFill()
                .clipped()
                .edgesIgnoringSafeArea(.all)
                .frame(proxy)
                .onTapGesture {
                    if self.viewModel.canTapNext {
                        self.viewModel.showNext()
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
                        ForEach(viewModel.stories.indices, id: \.self) { i in
                            Rectangle()
                                .foregroundColor(i <= self.viewModel.currentStoryIndex ? .hOrange : Color.white.opacity(0.5))
                                .frame(width: 5)
                                .frame(maxHeight: 84)
                        }
                        
                        Spacer()
                    }.padding(.trailing, 25)
                    .frame(height: proxy.size.height / 2)
                }
                
                Spacer()
                
                VStack {
                    if viewModel.canReport {
                        HStack {
                            Spacer()
                            Button(action: { self.showReport.toggle() }) {
                                Image(systemName: "ellipsis")
                                    .font(.largeTitle)
                                    .foregroundColor(.white)
                                    .padding()
                            }.shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)
                            .padding(.trailing)
                        }
                    }
                    
                    if viewModel.canSendMessages {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .foregroundColor(Color(0xF2F2F2).opacity(0.5))
                            
                            HStack {
                                TextField("", text: $viewModel.storyMessage)
                                    .font(.system(size: 17))
                                    .background(
                                        Text("Say something")
                                            .opacity(viewModel.storyMessage.isEmpty ? 1 : 0),
                                        alignment: .leading
                                    ).foregroundColor(Color.black.opacity(0.5))
                                Spacer()
                                Button(action: sendMessage) {
                                    Image("paperplane")
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                }.disabled(viewModel.storyMessage.isEmpty)
                            }.padding(.leading, 14)
                            .offset(x: 0, y: 2)
                        }.padding(.leading, 21)
                        .padding(.trailing, 16)
                        .frame(height: 40)
                        .padding(.bottom)
                        .offset(x: 0, y: -keyboardHeight)
                        .observeKeyboardHeight($keyboardHeight, withAnimation: .default)
                    }
                }
            }
        }.actionSheet(isPresented: $showReport) {
            ActionSheet(title: Text("Report an issue"), message: nil, buttons: [
                .default(Text("Block User"), action: self.viewModel.blockUser),
                .default(Text("Report Profile"), action: self.viewModel.reportProfile),
                .cancel()
            ])
        }
    }
    
    private func sendMessage() {
        app.messages.createConversation(message: viewModel.storyMessage)
        viewModel.storyMessage = ""
        UIApplication.shared.endEditing()
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(viewModel: StoryViewModel())
    }
}