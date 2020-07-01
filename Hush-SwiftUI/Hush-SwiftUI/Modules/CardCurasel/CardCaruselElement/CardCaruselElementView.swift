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
    let name: String
    let age: String
    let address: String
    let photo: Photo
    @State private var rectSize: CGSize = .zero
    @State private var showMessages = false
    @State private var showUserProfile = false
    @EnvironmentObject private var app: App
    
    private let imageScale: CGFloat = 450 / 511
    private let deviceScale = SCREEN_WIDTH / 411
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .observeSize($rectSize)
                .shadow(radius: 10)
            
            VStack {
                AsyncImage(url: URL(string:photo.photo)!, cache: iOSApp.cache, placeholder: Image("AppLogo")) { image in
                        image.resizable()
                    }
                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 220, height: 320)
                    .scaledToFill()
                    .frame(width: (ISiPhoneX ? 420 : 320) * deviceScale, height: (ISiPhoneX ? 420 : 320) * deviceScale)
                    .clipped()
                    .padding(.top, 30 * deviceScale)
                    
                Spacer()
            }
        }.frame(width: (ISiPhoneX ? 511 : 361) * deviceScale, height: (ISiPhoneX ? 570 : 470) * deviceScale)
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
                        Text(name)
                            .foregroundColor(Color.black)
                        Text(age).foregroundColor(Color.black)
                    }.font(.thin(ISiPhoneX ? 28 : 22)).lineLimit(1)
                    Text(address).font(.thin(ISiPhoneX ? 16 : 14)).foregroundColor(Color.black)
                    Circle().fill(Color(0x6FCF97)).square(15)
                        .padding(.top, 4)
                }.padding(.leading, ISiPhoneX ? 0 : rotation.degrees > 0 ? 20 : -10 )
                
                Spacer()
                
                VStack {
                    NavigationLink(destination: MessageDetailView(viewModel: MessageDetailViewModel(self.app.messages.item(at: 0))).withoutBar(), isActive: self.$showMessages) {
                        Image("message_card_icon").aspectRatio().frame(width: ISiPhoneX ? 45 : 36, height: ISiPhoneX ? 45 : 36)
                    }.buttonStyle(PlainButtonStyle())
                }.padding(.bottom, 10)
                
                VStack {
                    NavigationLink(destination: UserProfileView(viewModel: UserProfileViewModel(user: nil)).withoutBar(), isActive: self.$showUserProfile) {
                        Image("profile_icon_carusel").aspectRatio().frame(width: ISiPhoneX ? 45 : 36, height: ISiPhoneX ? 45 : 36)
                    }.buttonStyle(PlainButtonStyle())
                }.padding(.bottom, 10).padding(.trailing, ISiPhoneX ? 0 : 15)
            }.padding(.bottom, rotation.degrees > 0 ? 0: 10)
                .padding(.leading, 15)
                .padding(.trailing, rotation.degrees > 0 ? -10: 15)
            
        }.padding(.horizontal, ISiPhoneX ? 70 * deviceScale : 0)
        .padding(.vertical)
    }
}

struct CardCaruselElement_Previews: PreviewProvider {
    static var previews: some View {
        CardCaruselElementView(rotation: .degrees(-5), name: "Bobby", age: "23", address: "London, UK", photo: try! Photo.init(id: "123", thumb: "story1", photo: "story1", approved: "1", profile: "story1", blocked: "0"))
            .previewEnvironment()
            .padding()
    }
}
