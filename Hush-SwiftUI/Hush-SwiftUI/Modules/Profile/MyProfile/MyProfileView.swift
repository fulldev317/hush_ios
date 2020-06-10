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
    @State var showMatchesView = false
    @State var showVisitedMeView = false
    @State var showLikesMeView = false
    @State var showMyLikeView = false
    @State private var height: CGFloat = 50

    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                HStack {
                    header([Text("My Profile")
                        .font(.thin(48))
                        .foregroundColor(.hOrange)])
                        .padding(.bottom)
                    HapticButton(action: {
                        withAnimation {
                            self.app.onProfileEditing = !self.app.onProfileEditing
                        }
                    }) {
                        Text(self.app.onProfileEditing ? "Done" : "Edit")
                            .font(.regular(17))
                            .foregroundColor(Color.white)
                            .padding(.all)
//                        Image("editProfile_icon")
//                            .aspectRatio(.fit)
//                            .frame(width: 30, height: 30).padding(.trailing, 26)
//                            .foregroundColor(.white)
                    }
                }
//                Rectangle()
//                    .frame(height: 0.9)
//                    .foregroundColor(Color(0x4F4F4F))
                ScrollView {
                    scrollContent
                }.keyboardAdaptive()
            }
        }.background(Color.hBlack.edgesIgnoringSafeArea(.all))
    }
    
    var scrollContent: some View {
        
        VStack(alignment: .leading, spacing: 25) {
            imagesView
                .padding(.top, 0)
            Text("\(viewModel.basicsViewModel.username), \(viewModel.basicsViewModel.age)")
                .font(.bold(28))
                .foregroundColor(.white)
                .centred
            if !app.onProfileEditing {
                premiumButton.animation(.spring())
                profileActivity.animation(.spring())
            }
            profileBasics
            if !app.onProfileEditing {
                notifications.animation(.spring())
                legal.animation(.spring())
            }
        }.padding(.vertical, 10 + SafeAreaInsets.bottom)
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
                    .font(.regular(22))
                    .padding(.all, 20)
                    .padding(.leading, 60)
                    .padding(.trailing, 50)
                    .background(Color.hOrange.cornerRadius(8))
                    .foregroundColor(Color.black)
                    .frame(height: 54)
                Image("unlock").padding(.leading, 25)
            }
        }.centred
    }
    
    
    // MARK: - Activity
    
    var profileActivity: some View {
        
        VStack(alignment: .leading, spacing: 30) {
            Text("Profile Activity")
                .font(.regular(28))
                .foregroundColor(Color(0x4F4F4F))
            VStack(spacing: 25) {
                tableRow("Matches", "0") {
                    self.showMatchesView.toggle()
                }.background(
                    NavigationLink(
                        destination: MatchView(viewModel: MatchViewModel(), title: "Matches", image_url: "image5", blured: false).environmentObject(self.app).withoutBar(),
                        isActive: $showMatchesView,
                        label: EmptyView.init
                    )
                )
                
                tableRow("Visited my Profile", "0") {
                    self.showVisitedMeView.toggle()
                }.background(
                    NavigationLink(
                        destination: MatchView(viewModel: MatchViewModel(), title: "Visited Me", image_url: "image2", blured: true).environmentObject(self.app).withoutBar(),
                       isActive: $showVisitedMeView,
                       label: EmptyView.init
                    )
                )
                
                tableRow("Likes me", "0") {
                    self.showLikesMeView.toggle()
                }.background(
                    NavigationLink(
                        destination: MatchView(viewModel: MatchViewModel(), title: "Likes Me", image_url: "image3", blured: true).environmentObject(self.app).withoutBar(),
                       isActive: $showLikesMeView,
                       label: EmptyView.init
                    )
                )
                
                tableRow("My likes", "0") {
                    self.showMyLikeView.toggle()
                }.background(
                    NavigationLink(
                        destination: MatchView(viewModel: MatchViewModel(), title: "My Likes", image_url: "image4", blured: false).environmentObject(self.app).withoutBar(),
                       isActive: $showMyLikeView,
                       label: EmptyView.init
                    )
                )
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
                tableRow("User Name", value: $viewModel.basicsViewModel.username)
                tableRow("Premium User", value: $viewModel.basicsViewModel.isPremium)
                tableRow("Verified?", value: $viewModel.basicsViewModel.isVerified)
                tablePickerRow("Age", selected: viewModel.basicsViewModel.age) { birthday in
                    let now = Date()
                    let calendar = Calendar.current
                    let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
                    let age = ageComponents.year!
                    self.$viewModel.basicsViewModel.age.wrappedValue = "\(age)"
                }
                tablePickerRow("Gender", selected: viewModel.basicsViewModel.gender.title, titles: Gender.allTitles) {
                    self.$viewModel.basicsViewModel.gender.wrappedValue = Gender(rawValue: $0.lowercased())!
                }
                tablePickerRow("Sexuality", selected: viewModel.basicsViewModel.sexuality.title, titles: Gender.allTitles) {
                    self.$viewModel.basicsViewModel.sexuality.wrappedValue = Gender(rawValue: $0.lowercased())!
                }
                tableRow("Living", value: $viewModel.basicsViewModel.living)
                tableRow("Bio", value: nil)
                if app.onProfileEditing {
                    
                    MultilineTextField("Bio", text: $viewModel.basicsViewModel.bio, height: $height)
                                 .foregroundColor(.white)
                    
//                    TextField("Bio", text: $viewModel.basicsViewModel.bio).multilineTextAlignment(.leading).font(.regular(17)).foregroundColor(.white)
                } else {
                    Text(viewModel.basicsViewModel.bio).font(.regular(17)).foregroundColor(.white)
                }
                tableRow("Language", value: $viewModel.basicsViewModel.language)
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
                    self.app.logedIn = false
                    let isLoggedIn = UserDefault(.isLoggedIn, default: false)
                    isLoggedIn.wrappedValue = false
                }) {
                    Text("Logout").font(.regular(17)).foregroundColor(.white)
                }
            }
        }
        .padding(.leading, 36)
        .padding(.trailing, 25)
    }
    
    
    // MARK: - Helper
    
    private func tableRow(_ title: String, value: Binding<String>?) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            if value != nil {
                if app.onProfileEditing {
                    TextField(title, text: value!).multilineTextAlignment(.trailing).font(.regular(17)).foregroundColor(.white)
                } else {
                    Text(value!.wrappedValue).font(.regular(17)).foregroundColor(.white)
                }
            }
        }
    }
    private func tablePickerRow(_ title: String, selected: String, titles: [String], picked: @escaping (String) -> Void) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            if app.onProfileEditing {
                PickerTextField(title: selected, titles: titles, picked: picked, editabled: { edit in
                    //self.app.onProfileEditing = edit
                })
                
            } else {
                Text(selected).font(.regular(17)).foregroundColor(.white)
            }
        }
    }
    
    private func tablePickerRow(_ title: String, selected: String, picked: @escaping (Date) -> Void) -> some View {
        HStack {
            Text(title).font(.regular(17)).foregroundColor(.white)
            Spacer()
            if app.onProfileEditing {
                DateTextField(title: selected, picked: picked)
                
            } else {
                Text(selected).font(.regular(17)).foregroundColor(.white)
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
    
    private func tableRow(_ title: String, _ value: String, _ action: @escaping () -> Void) -> some View {
        HapticButton(action: action) {
            HStack {
                Text(title).font(.regular(17)).foregroundColor(.white)
                Spacer()
                Text(value).font(.regular(17)).foregroundColor(.white).padding(.trailing, 5)

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
                MyProfileView(viewModel: MyProfileViewModel()).withoutBar().environmentObject(App())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                MyProfileView(viewModel: MyProfileViewModel()).withoutBar().environmentObject(App())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                MyProfileView(viewModel: MyProfileViewModel()).withoutBar().environmentObject(App())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
