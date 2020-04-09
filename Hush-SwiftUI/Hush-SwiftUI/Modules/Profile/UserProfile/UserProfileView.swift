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
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var mode
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        
        switch viewModel.mode {
        case .photo: return AnyView(photoView.background(Color.hBlack).edgesIgnoringSafeArea(.all)).withoutBar()
        case .info: return AnyView(infoView.background(Color.hBlack.edgesIgnoringSafeArea(.all))).withoutBar()
        }
    }
    
    var photoView: some View {
        GeometryReader { proxy in
            VStack {
                HStack {
                    HapticButton(action: {
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Image("arrow_next_icon").aspectRatio().frame(width: 15, height: 15).foregroundColor(.white).rotationEffect(.degrees(180))
                    }.padding(.leading, 20)
                    self.header([
                        Text("Wendy").font(.ultraLight(48)).foregroundColor(.hOrange),
                        Text("Wendy").font(.thin()).foregroundColor(.white)
                    ])
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
                    VStack {
                        Spacer()
                        Rectangle()
                            .foregroundColor(.clear).frame(height: 130 + SafeAreaInsets.bottom)
                            .background(LinearGradient(gradient: .init(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top))
                    }.edgesIgnoringSafeArea(.bottom)
                    VStack {
                        Spacer()
                        HStack {
                            ForEach(0..<self.viewModel.photos.count) {
                                Circle().foregroundColor( $0 == self.currentPage ? .hOrange : Color.white.opacity(0.3)).frame(width: 10, height: 10)
                            }
                        }
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
                    VStack(alignment: .leading, spacing: 25) {
                        self.textBlock("About Me", subTitle: self.viewModel.aboutMe)
                        self.textBlock("Current Location", subTitle: self.viewModel.location)
                        self.carusel("Photos", images: self.viewModel.photos)
                        self.carusel("Stories", images: self.viewModel.stories)
                        HStack {
                            VStack(spacing: 25) {
                                self.textBlock("Looking For", subTitle: self.viewModel.aboutMe)
                                self.textBlock("Sexuality", subTitle: self.viewModel.aboutMe)
                                self.textBlock("Body Type", subTitle: self.viewModel.aboutMe)
                            }
                            VStack(spacing: 25) {
                                self.textBlock("Smoking", subTitle: self.viewModel.aboutMe)
                                self.textBlock("Ethnicity", subTitle: self.viewModel.aboutMe)
                                self.textBlock("Living", subTitle: self.viewModel.aboutMe)
                            }
                        }
                        
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
                    }
                }.padding(.horizontal)
            }
        }
    }
    
    func textBlock(_ title: String, subTitle: String) -> some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text(title).font(.regular(24)).foregroundColor(.white)
            Text(subTitle).font(.regular()).foregroundColor(.white)
        }
    }
    
    func carusel(_ title: String, images: [UIImage]) -> some View {
        
        VStack(alignment: .leading) {
            Text(title).font(.regular(24)).foregroundColor(.white)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0 ..< images.count) {
                        PolaroidCard<EmptyView>(image: images[$0], cardWidth: 92).rotationEffect(.degrees($0.isMultiple(of: 2) ? 5 : -5))
                    }
                }.padding(.vertical, 15)
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                UserProfileView(viewModel: UserProfileViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                UserProfileView(viewModel: UserProfileViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                UserProfileView(viewModel: UserProfileViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
