//
//  UserProfileView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 09.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import SwiftUIPager

struct IMG: Identifiable, Equatable {
    let id = UUID()
    let image: UIImage
    
    static func == (l: Self, r: Self) -> Bool {
        l.id == r.id
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
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var mode
    @State var unlockedImage = 0
    @State var unlockedStory = -1
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        Group {
            if viewModel.mode == .photo {
                photoView.background(Color.hBlack).edgesIgnoringSafeArea(.all).withoutBar()
            }
            
            if viewModel.mode == .info {
                infoView.background(Color.hBlack.edgesIgnoringSafeArea(.all)).withoutBar()
            }
        }.actionSheet(isPresented: $shouldReport) {
            ActionSheet(title: Text("Report an issue"), message: nil, buttons: [
                .default(Text("Block User"), action: {}),
                .default(Text("Report Profile"), action: {}),
                .cancel()
            ])
        }
    }
    
    var photoView: some View {
        GeometryReader { proxy in
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Wendy").font(.ultraLight(48)).foregroundColor(.hOrange)
                        HStack(spacing: 10) {
                            Button(action: { self.mode.wrappedValue.dismiss() }) {
                                Image("onBack_icon")
                            }.buttonStyle(PlainButtonStyle())
                            
                            Text("Los Angeles").font(.thin()).foregroundColor(.white)
                            Spacer()
                        }
                    }.padding(.horizontal)
                    
                    Spacer()
                    
                    VStack(spacing: 14) {
                        Circle().fill(Color(0x6FCF97)).square(22)
                        Image("verified_user_badge")
                    }.padding(.vertical)
                    .padding(.trailing, 23)
                    .offset(x: 0, y: 4)
                }.padding(.top, SafeAreaInsets.top)
                ZStack {
                    Pager(page: self.$currentPage, data: self.viewModel.photos.map { IMG(image: $0) }) { img in
                        GeometryReader { pr in
                            Image(uiImage: img.image)
                            .aspectRatio()
                            .frame(width: pr.size.width, height: pr.size.height)
                            .clipShape(Rect(width: pr.size.width, height: pr.size.height))
                        }
                    }
                    .itemSpacing(30)
                    .padding(0)
                    .overlay(Button(action: { self.shouldReport.toggle() }) {
                        Image(systemName: "ellipsis")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 23)
                    }, alignment: .topTrailing)
                    VStack {
                        Spacer()
                        Rectangle()
                            .foregroundColor(.clear).frame(height: 130 + SafeAreaInsets.bottom)
                            .background(LinearGradient(gradient: .init(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top))
                    }.edgesIgnoringSafeArea(.bottom)
                    VStack(spacing: 0) {
                        Spacer()
                        HStack {
                            ForEach(0..<self.viewModel.photos.count) {
                                Circle().foregroundColor( $0 == self.currentPage ? .hOrange : Color.white.opacity(0.3)).square(7)
                            }
                        }.padding(.bottom, 16)
                        
                        HapticButton(action: self.viewModel.switchMode) {
                            VStack(spacing: 25) {
                                HStack(spacing: 25) {
                                    Image("msg_profile_icon")
                                        .aspectRatio(.fit).frame(width: 25, height: 25).foregroundColor(.white)
                                    Image("heart_profile_icon")
                                        .aspectRatio(.fit).frame(width: 30, height: 30).foregroundColor(.white)
                                    Image("profile_icon")
                                        .aspectRatio(.fit).frame(width: 25, height: 25).foregroundColor(.white)
                                }
                                Image("arrow_down_icon")
                                    .aspectRatio(.fit).frame(width: 25, height: 25).foregroundColor(.white)
                            }
                        }
                    }.padding(20)
                }.frame(width: proxy.size.width)
            }
        }
    }
    
    var infoView: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                VStack {
                    HapticButton(action: self.viewModel.switchMode) {
                        
                        ZStack {
                            HStack(spacing: 25) {
                                Image("msg_profile_icon")
                                    .aspectRatio(.fit).frame(width: 25, height: 25).foregroundColor(.white)
                                Image("heart_profile_icon")
                                    .aspectRatio(.fit).frame(width: 30, height: 30).foregroundColor(.white)
                                Image("profile_icon")
                                    .aspectRatio(.fit).frame(width: 25, height: 25).foregroundColor(.white)
                            }
                            HStack {
                                Spacer()
                                Image("arrow_down_icon")
                                    .aspectRatio(.fit).frame(width: 25, height: 25).foregroundColor(.white).padding(.horizontal, 25).rotationEffect(.degrees(180))
                            }
                        }
                    }
                    Spacer()
                }.frame(height: 44 + SafeAreaInsets.top)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        self.textBlock("About Me", subTitle: self.viewModel.aboutMe)
                        self.textBlock("Current Location", subTitle: self.viewModel.location)
                        self.carusel("Photos", unlocked: self.$unlockedImage, images: self.viewModel.photos).padding(.vertical, -10)
                        self.carusel("Stories", unlocked: self.$unlockedStory, images: self.viewModel.stories)
                        HStack {
                            VStack(alignment: .leading, spacing: 25) {
                                self.textBlock("Looking For", subTitle: self.viewModel.aboutMe)
                                self.textBlock("Sexuality", subTitle: self.viewModel.aboutMe)
                                self.textBlock("Body Type", subTitle: self.viewModel.aboutMe)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 25) {
                                self.textBlock("Smoking", subTitle: self.viewModel.aboutMe)
                                self.textBlock("Ethnicity", subTitle: self.viewModel.aboutMe)
                                self.textBlock("Living", subTitle: self.viewModel.aboutMe)
                            }
                            
                            Spacer()
                        }
                        
                        VStack(spacing: 0) {
                            HStack(spacing: 30) {
                                Spacer()
                                HapticButton(action: {}) {
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
    
    func carusel(_ title: String, unlocked: Binding<Int>, images: [UIImage]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title).font(.regular(24)).foregroundColor(.white)
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(0 ..< images.count) { index in
                        PolaroidCard<EmptyView>(
                            image: images[index],
                            cardWidth: 92,
                            overlay: Color.black.aspectRatio(1, contentMode: .fit)
                                .opacity(index <= unlocked.wrappedValue ? 0 : 1)
                                .overlay(Text("+")
                                    .font(.ultraLight(48))
                                    .foregroundColor(.hOrange)
                                    .offset(x: 0, y: -4)
                                    .opacity(self.caruselItemEnabledForOpening(index, unlockedIndex: unlocked.wrappedValue) ? 1 : 0)).onTapGesture {
                                        if self.caruselItemEnabledForOpening(index, unlockedIndex: unlocked.wrappedValue) {
                                            unlocked.wrappedValue += 1
                                        }
                            }
                        ).rotationEffect(.degrees(index.isMultiple(of: 2) ? -5 : 5))
                    }
                }.padding(.vertical, 15)
                    .padding(.horizontal, 5)
            }
        }
    }
    
    func caruselItemEnabledForOpening(_ index: Int, unlockedIndex: Int) -> Bool {
        index == unlockedIndex + 1
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserProfileView(viewModel: UserProfileViewModel()).withoutBar()
        }.previewEnvironment()
    }
}
