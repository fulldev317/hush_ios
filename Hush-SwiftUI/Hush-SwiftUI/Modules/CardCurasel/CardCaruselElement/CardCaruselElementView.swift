//
//  CardCaruselElementView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 13.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Purchases

struct CardCaruselElementView: View {
    let rotation: Angle
    let user: Game
    @Binding var showIndicator: Bool
    var onRefresh: (() -> Void)?
    
    @EnvironmentObject private var app: App

    @State private var rectSize: CGSize = .zero
    @State private var showMessages = false
    @State private var showUserProfile = false
    @State private var selectedUser: User = User()
    @State private var showUpgrade = false

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
                .frame(width: (ISiPhoneX ? 460 : 420) * deviceScale, height: (ISiPhone11 ? 480 : ISiPhoneX ? 450 : 395) * deviceScale)
                .padding(.top, ISiPhoneX ? 30 * deviceScale : 20 * deviceScale)

                Spacer()
            }
        }.frame(width: (ISiPhoneX ? 550 : 460) * deviceScale, height: (ISiPhone11 ? 620 : ISiPhoneX ? 590 : 505) * deviceScale)
        .overlay(overlay.rotationEffect(rotation), alignment: .bottom)
        .rotationEffect(-rotation)
        .onTapGesture {
            self.gotoUserProfilePage()
        }
    }
    
    func gotoUserProfilePage() {
        if let userID = self.user.id {
            AuthAPI.shared.cuser(userId: userID) { (user, error) in
                UserAPI.shared.add_visit(toUserID: userID) { (error) in

                }
                if error == nil {
                    self.selectedUser = user!
                    self.showUserProfile.toggle()
                }
            }
        }
    }
    
    func getDescLeading(degree: Double) -> CGFloat {
        if (degree >= 0) {
            return 20
        }
        return 20
    }
    
    func getDescBottom(degree: Double) -> CGFloat {
        
        if (degree >= 0) {
            return -30
        }
        return 0
    }
    
    func getDescTop(degree: Double) -> CGFloat {
        
        if (degree < 0) {
            return -50
        }
        return 0
    }
    
    func getIconTrailing(degree: Double) -> CGFloat {
        if (degree >= 0) {
            return 20
        }
        return 20
    }
    
    func getIconBottom(degree: Double) -> CGFloat {
        if (degree >= 0) {
            return 10
        }
        return -10
    }
    
    func getIconTop(degree: Double) -> CGFloat {
        if (degree >= 0) {
            return -10
        }
        return 0
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
                }.padding(.leading, getDescLeading(degree: rotation.degrees))
                    .padding(.bottom, getDescBottom(degree: rotation.degrees))
                .padding(.top, getDescTop(degree: rotation.degrees))
                
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
                                if (Common.premium()) {
                                    Common.setMessageLoaded(loaded: true)
                                    self.showMessages = true
                                } else {
                                    self.showIndicator = true
                                    
                                    Purchases.shared.purchaserInfo { (purchaserInfo, error) in
                                        self.showIndicator = false
                                        if purchaserInfo?.entitlements["pro"]?.isActive == true {
                                            Common.setPremium(true)
                                            Common.setMessageLoaded(loaded: true)
                                            self.showMessages = true
                                        } else {
                                            Common.setPremiumType(isUser: false)
                                            self.app.showPremium.toggle()
                                        }
                                    }
                                }
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
                }.padding(.bottom, 10).padding(.trailing, 30)
                
            }.padding(.top, getIconTop(degree: rotation.degrees))
            .padding(.bottom, getIconBottom(degree: rotation.degrees))
            .padding(.leading, getIconTrailing(degree: rotation.degrees))
            
        }.padding(.horizontal, ISiPhone11 ? 60 : ISiPhoneX ? 40 : 0)
        .padding(.vertical)
    }
    
    
}

struct CardCaruselElement_Previews: PreviewProvider {
    static var previews: some View {

         Group {
            NavigationView {
                CardCaruselElementView(rotation: .degrees(5), user: Game(), showIndicator: .constant(false))
                .previewEnvironment()
                .padding()
                .background(Color.black)
            }.previewDevice(.init(rawValue: "iPhone 8"))
            
            NavigationView {
                CardCaruselElementView(rotation: .degrees(5), user: Game(), showIndicator: .constant(false))
                .previewEnvironment()
                .padding()
                .background(Color.black)
            }.previewDevice(.init(rawValue: "iPhone X"))
            
//            NavigationView {
//                CardCaruselElementView(rotation: .degrees(5), user: Game(), showIndicator: .constant(false))
//                .previewEnvironment()
//                .padding()
//                .background(Color.black)
//            }.previewDevice(.init(rawValue: "iPhone 11"))
        }
        
    }
}
