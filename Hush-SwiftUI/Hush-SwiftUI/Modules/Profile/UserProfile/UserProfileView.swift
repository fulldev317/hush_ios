//
//  UserProfileView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 09.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import SwiftUIPager
import SDWebImageSwiftUI

struct IMG: Identifiable, Equatable {
    let id = UUID()
    let image: UIImage
    
    static func == (l: Self, r: Self) -> Bool {
        l.id == r.id
    }
}

struct STG: Identifiable, Equatable {
    let id = UUID()
    let imageUrl: String
    
    static func == (l: Self, r: Self) -> Bool {
        l.imageUrl == r.imageUrl
    }
}

struct Rect: Shape {
    
    let width: CGFloat
    let height: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        Rectangle().path(in: .init(x: 0, y: 0, width: width, height: height))
    }
}

struct UserProfileView<ViewModel: UserProfileViewModeled>: View, HeaderedScreen {
    
    // MARK: - Properties
    
    @State var currentPage = 0
    @State var shouldReport = false
    @State var goToMessage = false
    @State var showUpgrade = false
    @State var profileTapped = false
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var app: App
    
    @State var unlockedStories: Set<Int> = []
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        Group {
            if viewModel.mode == .photo {
                photoView.background(Color.hBlack).edgesIgnoringSafeArea(.all).withoutBar()
            }
            
            if viewModel.mode == .info {
                infoView.background(Color.hBlack.edgesIgnoringSafeArea(.all)).withoutBar()
            }
            
            if (self.$goToMessage.wrappedValue) {
                NavigationLink(
                    destination: MessageDetailView(viewModel: MessageDetailViewModel(MessageItem(user_id: self.viewModel.userId, name: self.viewModel.name, image: self.viewModel.profilePhoto, online: 1))).withoutBar(),
                    isActive: self.$goToMessage,
                    label: EmptyView.init
                )
            }
        }.actionSheet(isPresented: $shouldReport) {
            ActionSheet(title: Text("Report an issue"), message: nil, buttons: [
                .default(Text("Block User"), action: {}),
                .default(Text("Report Profile"), action: {}),
                .cancel()
            ])
        }.background(NavigationLink(
            destination: UpgradeView(viewModel: UpgradeMessageViewModel()).withoutBar(),
            isActive: self.$showUpgrade,
            label: EmptyView.init
        ))
    }
    
    var photoView: some View {
        GeometryReader { proxy in
            VStack {
                HStack(alignment: .top) {
                    Button(action: { self.mode.wrappedValue.dismiss() }) {
                        Image("onBack_icon").padding()
                    }.buttonStyle(PlainButtonStyle())
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(self.viewModel.name).font(.ultraLight(32)).foregroundColor(.hOrange)
                        Text(self.viewModel.address).font(.thin()).foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 14) {
                        Circle().fill(Color(0x6FCF97)).square(22)
                        Image("verified_user_badge")
                    }.padding(.vertical)
                    .padding(.trailing, 23)
                    .offset(x: 0, y: 4)
                }.padding(.leading, 10)
                    .padding(.top, SafeAreaInsets.top)
                
                ZStack {
                    if self.viewModel.photoUrls.count > 0 {
                        Pager(page: self.$currentPage, data: self.viewModel.photoUrls) { img in
                            GeometryReader { pr in
                                
                                WebImage(url: URL(string: img))
                                .resizable()
                                .placeholder {
                                    Image("placeholder_l")
                                }
                                .background(Color.white)
                                .scaledToFill()
                                .frame(width: pr.size.width, height: pr.size.height)

                            }
                        }
                        .itemSpacing(30)
                        .padding(0)
                        .overlay(Button(action: { self.shouldReport.toggle() }) {
                            Image("3dot")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 23)
                        }, alignment: .topTrailing)
                    }
                    
                    self.overlay
                    VStack(spacing: 0) {
                        Spacer()
                        HStack {
                            ForEach(0..<self.viewModel.photoUrls.count) {
                                Circle().foregroundColor( $0 == self.currentPage ? .hOrange : Color.white.opacity(0.3)).square(7)
                            }
                        }.padding(.bottom, 16)
                        
                        VStack(spacing: 0) {
                            HStack(spacing: 25) {
                                
                                HapticButton(action:
                                    self.viewModel.switchMode) {
                                    Image("profile_profile")
                                        .renderingMode(.template)
                                        .foregroundColor(.white)
                                            //self.profileTapped ? .red : .white)
                                }
                               
                                HapticButton(action: {
                                    let like = self.viewModel.isFan ? "0" : "1"
                                    self.viewModel.userLike(like: like)
                                    self.viewModel.isFan.toggle()
                                    
                                }) {
                                    Image("profile_heart")
                                        .renderingMode(.template)
                                        .foregroundColor(self.viewModel.isFan ? .red : .white)
                                }
                                
                                HapticButton(action: {
                                    self.showUpgrade.toggle()
                                    //Common.setMessageLoaded(loaded: true)
                                    //self.goToMessage.toggle()
                                }) {
                                    Image("profile_message")
                                        .resizable()
                                        .foregroundColor(.white).aspectRatio(contentMode: .fill)
                                        .frame(width: 34, height: 34)
                                }
                            
                            }
                            
                            HapticButton(action: self.viewModel.switchMode) {
                                Image("profile_chevron_down")
                                    .foregroundColor(.white)
                                .padding()
                                .offset(x: 0, y: 0)
                            }
                        }
                    }.padding(10)
                }.frame(width: proxy.size.width)
            }
        }
    }
    
    var overlay: some View {
        LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .center).contentShape(Zero())
    }
    
    var infoView: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                HStack(spacing: 25) {
                    Spacer()
                    HapticButton(action: {
                        //self.showUpgrade.toggle()
                        Common.setMessageLoaded(loaded: true)
                        self.goToMessage.toggle()
                    }) {
                        Image("profile_message")
                            .foregroundColor(.white)
                    }
                    
                    HapticButton(action: {
                        let like = self.viewModel.isFan ? "0" : "1"
                        self.viewModel.userLike(like: like)
                        self.viewModel.isFan.toggle()
                    }) {
                        Image("profile_heart")
                            .renderingMode(.template)
                            .foregroundColor(self.viewModel.isFan ? .red : .white)
                    }
                    
                    HapticButton(action: self.viewModel.switchMode
                        //{
                        //self.profileTapped.toggle()
                        //}
                    ) {
                        Image("profile_profile")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }.padding()
                    .overlay(HapticButton(action: self.viewModel.switchMode) {
                        Image("profile_chevron_down").foregroundColor(.white)
                            .rotationEffect(.radians(.pi), anchor: .center)
                            .padding(24)
                    }, alignment: .trailing)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        self.textBlock("About Me", subTitle: self.viewModel.bio)
                        self.textBlock("Current Location", subTitle: self.viewModel.address)
                        self.carusel("Photos", unlocked: self.$viewModel.unlockedPhotos, images: self.viewModel.photoUrls).padding(.vertical, -10)

                        //self.carusel("Stories", unlocked: self.$unlockedStories, images: self.viewModel.stories)
                        HStack {
                            VStack(alignment: .leading, spacing: 25) {
                                self.textBlock("Relationship", subTitle: self.viewModel.relationship)
                                self.textBlock("Sexuality", subTitle: self.viewModel.sex)
                                self.textBlock("Body Type", subTitle: self.viewModel.body_type)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 25) {
                                self.textBlock("Smoking", subTitle: self.viewModel.smoke)
                                self.textBlock("Ethnicity", subTitle: self.viewModel.ethnicity)
                                self.textBlock("Living", subTitle: self.viewModel.living)
                            }
                            
                            Spacer()
                        }
                        
                        VStack(spacing: 0) {
                            HStack(spacing: 30) {
                                Spacer()
                                HapticButton(action: {
                                    self.app.showPremium.toggle()
                                }) {
                                    Image("msg_profile_icon")
                                        .aspectRatio(.fit)
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.hOrange)
                                        .padding(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 32.5)
                                                .stroke(Color.hOrange, lineWidth: 3)
                                        )
                                    
                                }
                                HapticButton(action: {}) {
                                    Image("heart_profile_icon")
                                    .aspectRatio(.fit)
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(.hOrange)
                                    .padding(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 32.5)
                                            .stroke(Color.hOrange, lineWidth: 3)
                                    )
                                }
                                Spacer()
                            }.padding(.bottom, 30)
                            
                            Button(action: { self.shouldReport.toggle() }) {
                                Text("Block or report profile")
                                    .font(.regular(14))
                                    .foregroundColor(.white)
                            }
                        }.padding(.top, 5)
                    }
                }.padding(.horizontal, 25)
            }
        }
    }
    
    func textBlock(_ title: String, subTitle: String) -> some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text(title).font(.regular(24)).foregroundColor(.white)
            Text(subTitle).font(.regular()).foregroundColor(.white)
        }
    }
    
    func carusel(_ title: String, unlocked: Binding<Set<Int>>, images: [String]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title).font(.regular(24)).foregroundColor(.white)
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(0 ..< MAX_PHOTOS) { index in
                        
                        if index < images.count {
                            PhotoCard<EmptyView>(
                                image: images[index],
                                cardWidth: 92
                            )
                            .rotationEffect(.degrees(index.isMultiple(of: 2) ? -5 : 5))
                            .animation(.default)

                        } else {
                        
                            PhotoCard<EmptyView>(
                                image: "empty",
                                cardWidth: 92
                            )
                            .overlay(Color.black.opacity(unlocked.wrappedValue.contains(index) ? 0 : 0.7))
                            .rotationEffect(.degrees(index.isMultiple(of: 2) ? -5 : 5))
                            .onTapGesture {
                                if unlocked.wrappedValue.contains(index) {
                                    unlocked.wrappedValue.remove(index)
                                } else {
                                    unlocked.wrappedValue.insert(index)
                                }
                            }
                            .animation(.default)

                        }
                    }
                }.padding(.vertical, 15)
                    .padding(.horizontal, 5)
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserProfileView(viewModel: UserProfileViewModel(user: nil))
                .previewEnvironment()
                .hostModalPresenter()
                .withoutBar()
        }
    }
}
