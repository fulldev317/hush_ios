//
//  MyProfileView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 07.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

extension View {
    var centred: some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}

struct MyProfileView<ViewModel: MyProfileViewModeled>: View, HeaderedScreen {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var app: App
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                ScrollView {
                    scrollContent
                }
            }.keyboardAdaptive().padding(.top, top + 100)
            VStack(spacing: 10) {
                HStack {
                    header([Text("My Profile")
                        .font(.thin(48))
                        .foregroundColor(.hOrange)])
                    HapticButton(action: {}) {
                        Image("editProfile_icon")
                            .aspectRatio(.fit)
                            .frame(width: 30, height: 30).padding(.trailing, 26)
                            .foregroundColor(.white)
                    }
                }
                Rectangle()
                    .frame(height: 0.9)
                    .foregroundColor(Color(0x4F4F4F))
            }.padding(.top, top)
        }.background(Color.hBlack.edgesIgnoringSafeArea(.all))
    }
    
    var scrollContent: some View {
        
        VStack(alignment: .leading, spacing: 45) {
            imagesView
                .padding(.top, 30)
            Text("Username, 32")
                .font(.bold(28))
                .foregroundColor(.white)
                .centred
            premiumButton
            profileActivity
            profileBasics
            notifications
            legal
        }
    }
    
    // MARK: - Image
    
    var imagesView: some View {
        ZStack {
            HStack {
                PolaroidCard<EmptyView>(image: UIImage(named: "image3")!, cardWidth: smallCardSize.width)
                    .rotationEffect(.degrees(5))
                Spacer()
                PolaroidCard<EmptyView>(image: UIImage(named: "image3")!, cardWidth: smallCardSize.width).rotationEffect(.degrees(5))
                
            }.padding(.horizontal, 37)
            PolaroidCard(image: UIImage(named: "image3")!, cardWidth: bigCardSize.width, bottom:
                HStack {
                    Spacer()
                    HapticButton(action: {}, label: {
                        Image("editProfile_icon")
                            .aspectRatio(.fit)
                            .frame(width: 25, height: 25)
                            .padding(.trailing, 20)
                            .padding(.bottom, 10)
                            .foregroundColor(Color(0xE0E0E0))
                    })
                }
                .frame(height: bigCardSize.height - bigCardSize.width))
                .rotationEffect(.degrees(-5))
        }
    }
    var smallCardSize: CGSize {
        
        let w = 110 * SCREEN_WIDTH / 414
        let h = 140 * w / 110
        return .init(width: w, height: h)
    }
    var bigCardSize: CGSize {
        
        let w = 190 * SCREEN_WIDTH / 414
        let h = 235 * w / 190
        return .init(width: w, height: h)
    }
    
    
    // MARK: - Premium
    
    var premiumButton: some View {
        HapticButton(action: {
            self.app.showPremium.toggle()
        }) {
            ZStack(alignment: .leading) {
                Text("Activate Premium")
                    .kerning(-0.41)
                    .font(.bold(24))
                    .padding(.all, 20)
                    .padding(.leading, 65)
                    .padding(.trailing, 25)
                    .background(Color.hOrange.cornerRadius(8))
                    .frame(height: 54)
                Image("premiumMask_icon").padding(.bottom, 30)
            }
        }.centred
    }
    
    
    // MARK: - Activity
    
    var profileActivity: some View {
        
        VStack(alignment: .leading, spacing: 25) {
            Text("Profile Activity")
                .font(.regular(28))
                .foregroundColor(Color(0x4F4F4F))
            VStack(spacing: 25) {
                tableRow("New Friends", value: "0")
                tableRow("Visited my Profile", value: "0")
                tableRow("Likes me", value: "0")
                tableRow("My likes", value: "0")
            }
        }.padding(.horizontal, 36)
    }
    
    
    // MARK: - Basics
    
    var profileBasics: some View {
        
        VStack(alignment: .leading, spacing: 25) {
            Text("Profile Basics")
                .font(.regular(28))
                .foregroundColor(Color(0x4F4F4F))
            VStack(spacing: 25) {
                tableRow("User Name", value: "username")
                tableRow("Premium User", value: "Yes")
                tableRow("Verified?", value: "No")
                tableRow("Age", value: "25")
                tableRow("Gender", value: "Female")
                tableRow("Sexuality", value: "No Data")
                tableRow("Living", value: "No Data")
                tableRow("Bio", value: nil)
                Text("kasfhla;klsdjfk;lsdjfla;sdfjlasdfas;ldfjas;dlfjadls;fjads;jas")
                    .font(.regular(17)).foregroundColor(.white)
                tableRow("Language", value: "English")
            }
        }.padding(.horizontal, 36)
    }
    
    
    // MARK: - Notifications
    
    @State var newMatches = false
    @State var messageLikes = false
    @State var messages = false
    @State var nearby = false
    
    var notifications: some View {
        
        VStack(alignment: .leading, spacing: 25) {
            Text("Notifications")
                .font(.regular(28))
                .foregroundColor(Color(0x4F4F4F))
            VStack(spacing: 25) {
                tableRow("New Matches", $newMatches)
                tableRow("Message Likes", $messageLikes)
                tableRow("Messages", $messages)
                tableRow("People Nearby", $nearby)
            }
        }
        .padding(.leading, 36)
        .padding(.trailing, 25)
    }
    
    
    // MARK: - Legal
    
    var legal: some View {
        
        VStack(alignment: .leading, spacing: 25) {
            Text("Legal")
                .font(.regular(28))
                .foregroundColor(Color(0x4F4F4F))
            VStack(spacing: 25) {
                tableRow("Privacy Policy") {
                    iOSApp.open(URL(string: "https://google.com")!)
                }
                tableRow("Privacy Policy") {
                    iOSApp.open(URL(string: "https://google.com")!)
                }
                
                HapticButton(action: {
                    self.app.logedIn.toggle()
                }) {
                    Text("Logout").font(.regular(17)).foregroundColor(.white)
                }.padding(.vertical, 30)
            }
        }
        .padding(.leading, 36)
        .padding(.trailing, 25)
    }
    
    
    // MARK: - Helper
    
    private func tableRow(_ title: String, value: String?) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            if value != nil {
                Text(value!).font(.regular(17)).foregroundColor(.white)
            }
        }
    }
    
    private func tableRow(_ title: String, _ bool: Binding<Bool>) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            
            Toggle("", isOn: bool).toggleStyle(HToggleStyle(onColor: Color(0x7ED321), offColor: Color(0xEB5757)))
        }
    }
    
    private func tableRow(_ title: String, _ action: @escaping () -> Void) -> some View {
        HapticButton(action: action) {
            HStack {
                Text(title).font(.regular(17)).foregroundColor(.white)
                Spacer()
                
                Image("arrow_next_icon")
                    .aspectRatio(.fit)
                    .foregroundColor(.white)
                .frame(width: 15, height: 15)
            }
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                MyProfileView(viewModel: MyProfileViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                MyProfileView(viewModel: MyProfileViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                MyProfileView(viewModel: MyProfileViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
