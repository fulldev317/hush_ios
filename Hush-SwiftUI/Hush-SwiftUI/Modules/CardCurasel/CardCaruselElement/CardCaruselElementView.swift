//
//  CardCaruselElementView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 13.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct CardCaruselElementView: View {
    let rotation: Angle
    
    @State private var rectSize: CGSize = .zero
    @State private var showMessages = false
    @State private var showUserProfile = false
    @EnvironmentObject private var app: App
    
    private let imageScale: CGFloat = 450 / 511
    private let deviceScale = SCREEN_WIDTH / 414
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .observeSize($rectSize)
                .shadow(radius: 10)
            
            VStack {
                Image("story1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: rectSize.width * imageScale, height: rectSize.width * imageScale)
                    .clipped()
                    .padding(.top, 30 * deviceScale)
                
                Spacer()
            }
        }.frame(width: 511 * deviceScale, height: 628 * deviceScale)
        .overlay(overlay.rotationEffect(rotation), alignment: .bottom)
        .rotationEffect(-rotation)
        .tapGesture(toggls: $showUserProfile)
    }
    
    var overlay: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Verylongname goes here")
                        Text("29")
                    }.font(.thin(30)).lineLimit(1)
                    Text("Los Angeles").font(.thin(18))
                    Circle().fill(Color(0x6FCF97)).square(15)
                        .padding(.top, 4)
                }
                
                NavigationLink(destination: MessageDetailView(viewModel: MessageDetailViewModel(self.app.messages.item(at: 0))).withoutBar(), isActive: self.$showMessages) {
                    Image("message_card_icon").aspectRatio().frame(width: 45, height: 45)
                }.buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: UserProfileView(viewModel: UserProfileViewModel()).withoutBar(), isActive: self.$showUserProfile) {
                    Image("profile_icon_carusel").aspectRatio().frame(width: 45, height: 45)
                }.buttonStyle(PlainButtonStyle())
            }.padding()
        }.padding(.horizontal, 70 * deviceScale)
        .padding(.vertical)
    }
}

struct CardCaruselElement_Previews: PreviewProvider {
    static var previews: some View {
        CardCaruselElementView(rotation: .degrees(5))
            .previewEnvironment()
            .padding()
    }
}
