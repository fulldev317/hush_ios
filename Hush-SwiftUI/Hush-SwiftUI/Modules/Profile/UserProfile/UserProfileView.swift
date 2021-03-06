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
import Purchases

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
    @State var shouldReportReason = false
    @State var goToMessage = false
    @State var showUpgrade = false
    @State var profileTapped = false
    @State var heartOpacity = 1.0

    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var app: App
    
    @State var unlockedStories: Set<Int> = []
    @State var reportReasonButton: [ActionSheet.Button] = []
    enum ReportSheet { case main, reason }
    @State var reportSheet: ReportSheet = .main
    @State private var rectSize: CGSize = .zero
    
    private let imageScale: CGFloat = 450 / 511
    private let deviceScale = SCREEN_WIDTH / 411
    
    private let imageHeight = SCREEN_HEIGHT - 100
    private let imageWidth = (SCREEN_HEIGHT - 100)
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
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
                if (self.reportSheet == .main) {
                    return ActionSheet(title: Text("Report an issue"), message: nil, buttons: [
                        .default(Text("Block User"), action: {
                            self.viewModel.blockUser { (result) in
                                if (result == true) {
                                    Common.setUserBlocked(true)
                                    self.mode.wrappedValue.dismiss()
                                }
                            }
                        }),
                        .default(Text("Report Profile"), action: {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                self.viewModel.getReportList { (reason_list) in
                                    self.shouldReport = true
                                    self.reportSheet = .reason
                                    var aryButton:[ActionSheet.Button] = []
                                    let aryReason:[String] = reason_list
                                    for reason in aryReason {
                                        let button: ActionSheet.Button = .default(Text(reason), action: {
                                            self.viewModel.reportUser(reason: reason) { (result) in
                                                if (result == true) {
                                                    Common.setUserBlocked(true)
                                                    self.mode.wrappedValue.dismiss()
                                                }
                                            }
                                        })
                                        aryButton.append(button)
                                    }
                                    aryButton.append(.cancel())
                                    self.reportReasonButton = aryButton
                                }
                            })
                           
                        }),
                        .cancel()
                    ])
                }
        
                return ActionSheet(title: Text("Report reason"), message: nil, buttons: self.reportReasonButton)
            }
            .background(NavigationLink(
                destination: UpgradeView(viewModel: UpgradeViewModel()).withoutBar().onDisappear(perform: {
                    if (Common.premium()) {
                        Common.setMessageLoaded(loaded: true)
                        self.goToMessage.toggle()
                    }
                }),
                isActive: self.$showUpgrade,
                label: EmptyView.init
            ))
            
            HushIndicator(showing: self.viewModel.isShowingIndicator)

        }
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
                        if self.viewModel.online == "1" {
                            Circle().fill(Color(0x6FCF97)).square(22)
                        }
                        if self.viewModel.verfied == "1" {
                            Image("verified_user_badge")
                        }
                    }.padding(.vertical)
                    .padding(.trailing, 23)
                    .offset(x: 0, y: 4)
                }.padding(.leading, 10)
                    .padding(.top, SafeAreaInsets.top)
                
                ZStack {
                    if self.viewModel.photoUrls.count > 0 {
                        Pager(page: self.$currentPage, data: self.viewModel.photoUrls) { img in
                            //GeometryReader { pr in
                                ZStack {
                                    Rectangle()
                                    .fill(Color.white)
                                        .frame(width: self.imageWidth , height: self.imageHeight )
                                    
                                    WebImage(url: URL(string: img))
                                    .resizable()
                                    .placeholder {
                                        Image("placeholder_l")
                                    }
                                    .background(Color.white)
                                    .frame(width: self.imageWidth, height: self.imageHeight - 20)
                                    .padding(.top, ISiPhone11 ? 30 * self.deviceScale : ISiPhoneX ? 30 : 20)
                                    

                                    //.scaledToFill()
                                    //.frame(width: pr.size.width, height: pr.size.height)
                                }
                                    .rotationEffect(.degrees(-3))
                                .padding(.top, ISiPhoneX ? 140 : 50)
                            //}
                        }
                        .itemSpacing(ISiPhone11 ? 200 : ISiPhoneX ? 180 : 110)
                        .padding(0)
                        
                    }
                    
                    self.overlay.overlay(Button(action: {
                        self.shouldReport.toggle()
                        self.reportSheet = .main
                    }) {
                        Image("3dot")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.vertical, 36)
                            .padding(.horizontal, 23)
                    }, alignment: .bottomTrailing)
                    
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
                                    self.heartOpacity = 0.0
                                    withAnimation(.easeInOut) {
                                        self.heartOpacity = 1.0
                                    }
                                    
                                }) {
                                    Image("profile_heart")
                                        .renderingMode(.template)
                                        .foregroundColor(self.viewModel.isFan ? .red : .white)
                                }.opacity(self.heartOpacity)
                                
                                HapticButton(action: {
                                    if (Common.premium()) {
                                        Common.setMessageLoaded(loaded: true)
                                        self.goToMessage.toggle()
                                    } else {
                                        self.viewModel.isShowingIndicator = true
                                        
                                        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
                                            self.viewModel.isShowingIndicator = false
                                            if purchaserInfo?.entitlements["pro"]?.isActive == true {
                                                Common.setPremium(true)
                                                Common.setMessageLoaded(loaded: true)
                                                self.goToMessage.toggle()
                                            } else {
                                                Common.setPremiumType(isUser: false)
                                                self.app.showPremium.toggle()
                                            }
                                        }
                                    }
                                }) {
                                    Image("profile_message")
                                        .resizable()
                                        .foregroundColor(.white).aspectRatio(contentMode: .fill)
                                        .frame(width: 34, height: 34)
                                }
                            
                            }.padding(.bottom, 20)
                            
//                            HapticButton(action: self.viewModel.switchMode) {
//                                Image("profile_chevron_down")
//                                    .foregroundColor(.white)
//                                .padding()
//                                .offset(x: 0, y: 0)
//                            }
                        }
                    }.padding(10)
                }.frame(width: proxy.size.width)
            }
        }
    }
    
    var overlay: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: UnitPoint(x: 0.0, y: 1.0), endPoint: UnitPoint(x: 0.0, y: 0.8)).contentShape(Zero())
            //LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 0.0, y: 0.2)).contentShape(Zero())
        }
    }
    
    var infoView: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                HStack(spacing: 25) {
                    Spacer()
                    HapticButton(action: {
                        if (Common.premium()) {
                            Common.setMessageLoaded(loaded: true)
                            self.goToMessage.toggle()
                        } else {
                            self.viewModel.isShowingIndicator = true
                            
                            Purchases.shared.purchaserInfo { (purchaserInfo, error) in
                                self.viewModel.isShowingIndicator = false
                                if purchaserInfo?.entitlements["pro"]?.isActive == true {
                                    Common.setPremium(true)
                                    Common.setMessageLoaded(loaded: true)
                                    self.goToMessage.toggle()
                                } else {
                                    self.showUpgrade.toggle()
                                }
                            }
                        }
                    }) {
                        Image("profile_message")
                            .foregroundColor(.white)
                    }
                    
                    HapticButton(action: {
                        let like = self.viewModel.isFan ? "0" : "1"
                        self.viewModel.userLike(like: like)
                        self.viewModel.isFan.toggle()
                        self.heartOpacity = 0.0
                        withAnimation(.easeInOut) {
                            self.heartOpacity = 1.0
                        }
                    }) {
                        Image("profile_heart")
                            .renderingMode(.template)
                            .foregroundColor(self.viewModel.isFan ? .red : .white)
                    }.opacity(self.heartOpacity)
                    
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

                        self.carusel("Stories", unlocked: self.$viewModel.unlockedStories, images: self.viewModel.storyUrls).padding(.vertical, -10)
                        
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
                                    
                                    if (Common.premium()) {
                                        Common.setMessageLoaded(loaded: true)
                                        self.goToMessage.toggle()
                                    } else {
                                        self.viewModel.isShowingIndicator = true
                                        
                                        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
                                            self.viewModel.isShowingIndicator = false
                                            if purchaserInfo?.entitlements["pro"]?.isActive == true {
                                                Common.setPremium(true)
                                                Common.setMessageLoaded(loaded: true)
                                                self.goToMessage.toggle()
                                            } else {
                                                self.showUpgrade.toggle()
                                            }
                                        }
                                    }
                                }) {
                                    Image("msg_profile_icon")
                                        .aspectRatio(.fit)
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.hOrange)
                                        .padding(18)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 32.5)
                                                .stroke(Color.hOrange, lineWidth: 3)
                                        )
                                    
                                }
                                HapticButton(action: {
                                    self.viewModel.userLike(like: "1")
                                    self.viewModel.isFan = !self.viewModel.isFan
                                    self.heartOpacity = 0.0
                                    withAnimation(.easeInOut) {
                                        self.heartOpacity = 1.0
                                    }
                                }) {
                                    Image("heart_profile_icon")
                                    .aspectRatio(.fit)
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(self.viewModel.isFan ? .red : .hOrange)
                                    .padding(15)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 32.5)
                                            .stroke(self.viewModel.isFan ? .red : Color.hOrange, lineWidth: 3)
                                    )
                                }
                                Spacer()
                            }.padding(.bottom, 30)
                            
                            Button(action: {
                                self.shouldReport.toggle()
                                self.reportSheet = .main
                            }) {
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
                .withoutBar()
                .previewDevice(.init(rawValue: "iPhone 8"))
        }
    }
}
