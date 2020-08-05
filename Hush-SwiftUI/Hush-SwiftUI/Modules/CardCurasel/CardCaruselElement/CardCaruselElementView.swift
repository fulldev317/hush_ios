//
//  CardCaruselElementView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 13.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardCaruselElementView: View {
    let rotation: Angle
    let user: Discover
    var onRefresh: (() -> Void)?

    @EnvironmentObject private var app: App

    @State private var rectSize: CGSize = .zero
    @State private var showMessages = false
    @State private var showUserProfile = false
    @State private var selectedUser: User = User()
    //@Binding var showIndicator: Bool
    
    private let imageScale: CGFloat = 450 / 511
    private let deviceScale = SCREEN_WIDTH / 411
        
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .observeSize($rectSize)
                .shadow(radius: 10)
            
            VStack {
                
                WebImage(url: URL(string: user.photo ?? ""))
                    .resizable()
                    .placeholder {
                      Image("placeholder_l")
                    }
                    .background(Color.white)
                    .frame(width: (ISiPhoneX ? 420 : 320) * deviceScale, height: (ISiPhoneX ? 400 : 320) * deviceScale)
                    .padding(.top, 30 * deviceScale)

                Spacer()
            }
        }.frame(width: (ISiPhoneX ? 511 : 361) * deviceScale, height: (ISiPhoneX ? 550 : 470) * deviceScale)
        .overlay(overlay.rotationEffect(rotation), alignment: .bottom)
        .rotationEffect(-rotation)
        .onTapGesture {
            //self.showIndicator = true
            self.gotoUserProfilePage()
        }
        .tapGesture(
            
            toggls: $showUserProfile)
    }
    
    func gotoUserProfilePage() {
        if let userID = self.user.id {
            AuthAPI.shared.cuser(userId: userID) { (user, error) in
                //self.showIndicator = false
                UserAPI.shared.add_visit(toUserID: userID) { (error) in
                    
                }
                
                if error == nil {
                    self.selectedUser = user!
                    self.showUserProfile.toggle()
                }
            }
        }
    }
    
    var overlay: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(user.name ?? "Alex")
                            .foregroundColor(Color.black)
                            Text(user.age ?? "20").foregroundColor(Color.black)
                    }.font(.thin(ISiPhoneX ? 28 : 22)).lineLimit(1)
                    Text(user.city ?? "LosAngels, US").font(.thin(ISiPhoneX ? 16 : 14)).foregroundColor(Color.black)
                    Circle().fill(Color(0x6FCF97)).square(15)
                        .padding(.top, 4)
                }.padding(.leading, ISiPhoneX ? 0 : rotation.degrees > 0 ? 20 : -10 )
                
                Spacer()
                
                if (self.$showMessages.wrappedValue) {
                    VStack {
                        NavigationLink(destination: MessageDetailView(viewModel: MessageDetailViewModel(MessageItem(user_id: user.id!, name: user.name!, image: user.photo!, online: 1))).withoutBar(), isActive: self.$showMessages) {
                            Image("message_card_icon").aspectRatio().frame(width: ISiPhoneX ? 45 : 36, height: ISiPhoneX ? 45 : 36)
                                .onTapGesture {
                                    Common.setMessageLoaded(loaded: true)
                                    self.showMessages = true
                            }
                        }.buttonStyle(PlainButtonStyle())
                    }.padding(.bottom, 10)
                } else {
                    VStack {
                        Image("message_card_icon").aspectRatio().frame(width: ISiPhoneX ? 45 : 36, height: ISiPhoneX ? 45 : 36)
                            .onTapGesture {
                                Common.setMessageLoaded(loaded: true)
                                self.showMessages = true
                        }
                    }.padding(.bottom, 10)
                }
                
                VStack {
                    NavigationLink(destination: UserProfileView(viewModel: UserProfileViewModel(user: selectedUser))
                        .withoutBar()
                        .onDisappear {
                            let blocked = Common.userBlocked()
                            if (blocked) {
                                Common.setUserBlocked(true)
                                self.onRefresh?()
                            }
                        },
                                   isActive: self.$showUserProfile) {
                        Image("profile_icon_carusel").aspectRatio().frame(width: ISiPhoneX ? 45 : 36, height: ISiPhoneX ? 45 : 36)
                        .onTapGesture {
                            self.gotoUserProfilePage()
                        }
                    }.buttonStyle(PlainButtonStyle())
                }.padding(.bottom, 10).padding(.trailing, ISiPhoneX ? 0 : 15)
            }.padding(.bottom, rotation.degrees > 0 ? 0: 10)
                .padding(.leading, 15)
                .padding(.trailing, rotation.degrees > 0 ? -10: 15)
            
        }.padding(.horizontal, ISiPhoneX ? 70 * deviceScale : 0)
        .padding(.vertical)
    }
    
    
}
//
//struct CardCaruselElement_Previews: PreviewProvider {
//    static var previews: some View {
//
//        CardCaruselElementView(rotation: .degrees(-5), user: Discover())
//            .previewEnvironment()
//            .padding()
//    }
//}
