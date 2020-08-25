//
//  DiscoveryView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import QGrid
import PartialSheet
import Combine

let TAB_MARGIN: CGFloat = CGFloat(10)
let TAB_WIDTH: CGFloat = CGFloat((SCREEN_WIDTH - TAB_MARGIN) / 5 - (ISiPhonePlus ? 15 : 2))
let TAB_HEIGHT: CGFloat = CGFloat(25)

struct DiscoveryView<ViewModel: DiscoveryViewModeled>: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var app: App
    @ObservedObject var viewModel: ViewModel
    @State private var showUserProfile = false
    @State var isShowing: Bool = false
    @State var currentViewIndex: Int = 0
    @State private var selectedIndex: Int = 0
    @State private var selectedUser: User = User()
    
    init(viewModel: ViewModel, showingSetting: Bool) {
        self.viewModel = viewModel
        self.viewModel.setSettingsModel()
        
        if !showingSetting {
            self.viewModel.page_num = 0
            self.viewModel.loadDiscover(page: self.viewModel.page_num) { (result) in
                if (result) {
                    
                }
            }
        }
      
    }
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button(action: {
                            if self.currentViewIndex == 0 {
                                return
                            }
                            
                            self.currentViewIndex = 0
                            self.viewModel.loadDiscover(page: self.viewModel.page_num) { result in

                            }
                        }) {
                            ZStack {
                                Text("Browse")
                                    .font(.regular(16))
                                    .foregroundColor(self.currentViewIndex == 0 ? Color.yellow : Color.white)
                                Rectangle().frame(height: 1)
                                    .foregroundColor(Color.yellow)
                                    .padding(.top, TAB_HEIGHT - 2)
                                    .opacity(self.currentViewIndex == 0 ? 1 : 0)
                            }
                        
                        }.frame(width: 55, height: TAB_HEIGHT, alignment: .center)
                        
                        Rectangle().frame(width: 1).foregroundColor(Color.white).padding(.vertical, 4)

                        Button(action: {
                            if self.currentViewIndex == 1 {
                                return
                            }
                            
                            self.currentViewIndex = 1
                            
                            self.viewModel.loadMatches { result in

                            }
                        }) {
                            ZStack {
                                Text("Matched")
                                    .font(.regular(16))
                                    .foregroundColor(self.currentViewIndex == 1 ? Color.yellow : Color.white)
                                Rectangle().frame(height: 1)
                                    .foregroundColor(Color.yellow)
                                    .padding(.top, TAB_HEIGHT - 2)
                                    .opacity(self.currentViewIndex == 1 ? 1 : 0)

                            }
                        }.frame(width: 60, height: TAB_HEIGHT, alignment: .center)
                        
                        Rectangle().frame(width: 1).foregroundColor(Color.white).padding(.vertical, 4)

                        Button(action: {
                            if self.currentViewIndex == 2 {
                                return
                            }
                            self.currentViewIndex = 2
                            
                            self.viewModel.loadVisitedMe { result in

                            }
                        }) {
                            ZStack {
                                Text("Visited Me")
                                    .font(.regular(16))
                                    .foregroundColor(self.currentViewIndex == 2 ? Color.yellow : Color.white)
                                Rectangle().frame(height: 1)
                                    .foregroundColor(Color.yellow)
                                    .padding(.top, TAB_HEIGHT - 2)
                                    .opacity(self.currentViewIndex == 2 ? 1 : 0)

                            }
                        }.frame(width: 72, height: TAB_HEIGHT, alignment: .center)
                        
                        Rectangle().frame(width: 1).foregroundColor(Color.white).padding(.vertical, 4)

                        Button(action: {
                            if self.currentViewIndex == 3 {
                                return
                            }
                            self.currentViewIndex = 3
                            
                            self.viewModel.loadMyLikes { result in
                            }
                        }) {
                            ZStack {
                                Text("My Likes")
                                    .font(.regular(16))
                                    .foregroundColor(self.currentViewIndex == 3 ? Color.yellow : Color.white)
                                Rectangle().frame(height: 1)
                                    .foregroundColor(Color.yellow)
                                    .padding(.top, TAB_HEIGHT - 2)
                                    .opacity(self.currentViewIndex == 3 ? 1 : 0)

                            }
                        }.frame(width: 60, height: TAB_HEIGHT, alignment: .center)
                        
                        Rectangle().frame(width: 1).foregroundColor(Color.white).padding(.vertical, 4)

                        Button(action: {
                            if self.currentViewIndex == 4 {
                                return
                            }
                            self.currentViewIndex = 4
                            
                            self.viewModel.loadLikesMe { result in

                            }
                        }) {
                            ZStack {
                                Text("Likes Me")
                                    .font(.regular(16))
                                    .foregroundColor(self.currentViewIndex == 4 ? Color.yellow : Color.white)
                                Rectangle().frame(height: 1)
                                    .foregroundColor(Color.yellow)
                                    .padding(.top, TAB_HEIGHT - 2)
                                    .opacity(self.currentViewIndex == 4 ? 1 : 0)

                            }
                        }.frame(width: 60, height: TAB_HEIGHT, alignment: .center)
                    }.frame(height: TAB_HEIGHT, alignment: .leading)
                }
                .frame(width: SCREEN_WIDTH - 20, height: TAB_HEIGHT, alignment: .leading)
                .padding(.leading, ISiPhonePlus ? 20 : 10)
                Spacer()
            }
            
            if currentViewIndex == 0 && viewModel.discoveries.count > 0 {
                List {
                    ForEach(0...(viewModel.discoveries.count / 2), id: \.self) { index in
                        self.row(at: index).onAppear {
                            if index == (self.viewModel.discoveries.count / 2) {
                                if (self.viewModel.discoveries.count > 8) {
                                    self.viewModel.page_num += 1
                                    self.viewModel.loadDiscover(page: self.viewModel.page_num) { (result) in
                                        if (result) {
                                            
                                        }
                                    }
                                }
                            }
                        }.background(Color.black)
                        .listRowBackground(Color.black)
                    }
                }.listStyle(DefaultListStyle())
                .padding(.top, TAB_HEIGHT + 10)
                    .padding(.leading, -15)
                .background(Color.clear)
                .appearenceModifier(path: \UITableView.backgroundColor, value: .black)
            }
            
            if currentViewIndex == 1 && viewModel.matches.count > 0 {
                List {
                    ForEach(0...(viewModel.matches.count / 2), id: \.self) { index in
                        self.row(at: index)
                        .background(Color.black)
                        .listRowBackground(Color.black)
                    }
                }.listStyle(DefaultListStyle())
                .padding(.top, TAB_HEIGHT + 10)
                    .padding(.leading, -15)
                .background(Color.clear)
                .appearenceModifier(path: \UITableView.backgroundColor, value: .black)
            }
            
            if currentViewIndex == 2 && viewModel.visitedmes.count > 0 {
                List {
                    ForEach(0...(viewModel.visitedmes.count / 2), id: \.self) { index in
                        self.row(at: index)
                        .background(Color.black)
                        .listRowBackground(Color.black)
                    }
                }.listStyle(DefaultListStyle())
                .padding(.top, TAB_HEIGHT + 10)
                    .padding(.leading, -15)
                .background(Color.clear)
                .appearenceModifier(path: \UITableView.backgroundColor, value: .black)
            }
            
            if currentViewIndex == 3 && viewModel.mylikes.count > 0 {
                List {
                    ForEach(0...(viewModel.mylikes.count / 2), id: \.self) { index in
                        self.row(at: index)
                        .background(Color.black)
                        .listRowBackground(Color.black)
                    }
                }.listStyle(DefaultListStyle())
                .padding(.top, TAB_HEIGHT + 10)
                    .padding(.leading, -15)
                .background(Color.clear)
                .appearenceModifier(path: \UITableView.backgroundColor, value: .black)
            }
            
            if currentViewIndex == 5 && viewModel.likemes.count > 0 {
                List {
                    ForEach(0...(viewModel.likemes.count / 2), id: \.self) { index in
                        self.row(at: index)
                        .background(Color.black)
                        .listRowBackground(Color.black)
                    }
                }.listStyle(DefaultListStyle())
                .padding(.top, TAB_HEIGHT + 10)
                    .padding(.leading, -15)
                .background(Color.clear)
                .appearenceModifier(path: \UITableView.backgroundColor, value: .black)
            }
            
            NavigationLink(
                destination: UserProfileView(viewModel: UserProfileViewModel(user: selectedUser)),
                isActive: $showUserProfile,
                label: EmptyView.init
            )
            
            HushIndicator(showing: self.viewModel.isShowingIndicator)
            
        }
    }
     
    func row(at i: Int) -> some View {
        HStack(spacing: -18) {
            ForEach(0..<2, id: \.self) { j in
                HStack {
                    if (i * 2 + j < self.viewModel.discoveries.count) {
                        self.polaroidCard(i, j)
                            .onTapGesture {
                                self.selectedIndex = i * 2 + j
                                let discover = self.viewModel.discoveries[self.selectedIndex]
                                if let userId = discover.id {

                                    self.viewModel.isShowingIndicator = true

                                    AuthAPI.shared.cuser(userId: userId) { (user, error) in
                                        self.viewModel.isShowingIndicator = false
                                        if error == nil {

                                            UserAPI.shared.add_visit(toUserID: userId) { (error) in
                                            }

                                            self.selectedUser = user!
                                            self.showUserProfile = true
                                        }
                                    }
                                }
                            }
                    } else {
                        Spacer()
                    }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }.zIndex(Double(100 - i))
    }
    
    func polaroidCard(_ i: Int, _ j: Int) -> some View {
        PhotoCard(image: self.viewModel.discoveries[i*2+j].photo!, cardWidth: SCREEN_WIDTH / 2 + 15, bottom: self.bottomView(i, j), blured: false)
        .offset(x: j % 2 == 0 ? -10 : 10, y: 0)
        .zIndex(Double(i % 2 == 0 ? j : -j))
        .rotationEffect(.degrees(self.isRotated(i, j) ? 0 : -5), anchor: UnitPoint(x: 0.5, y: i % 2 == 1 ? 0.4 : 0.75))
    }
    
    func leading(_ j: Int) -> CGFloat {
        j % 2 == 0 ? 25 : 0
    }
    
    func trailing(_ j: Int) -> CGFloat {
        j % 2 == 0 ? 0 : 23
    }
    
    func isRotated(_ i: Int, _ j: Int) -> Bool {
        let index = i * 2 + j
        return index % 4 == 0 || stride(from: 3, through: index, by: 4).contains(index)
    }
    
    func bottomView(_ i: Int, _ j: Int) -> some View {
        let discovery = viewModel.discovery(i, j)
        
        return HStack {
            (Text(discovery.name ?? "John") + Text(", ") + Text("\(discovery.age ?? "20")"))
                .font(.regular(14))
                .foregroundColor(Color(0x8E8786))
            Spacer()
            Button(action: { self.viewModel.like(i, j) }) {
                Image("red_heart")
                    .resizable()
                    .renderingMode(discovery.liked! ? .original : .template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .foregroundColor(.gray)
                    .padding(15)
            }
        }.padding(.leading, j == 0 ? 0 : 15).padding(.trailing, j == 0 ? 15 : 0)
        .padding(.leading, self.leading(j))
        .padding(.trailing, self.trailing(j))
    }
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView {
//            DiscoveryView(viewModel: DiscoveryViewModel())
//        }
        Group {
            NavigationView {
                DiscoveryView(viewModel: DiscoveryViewModel(), showingSetting: false)
            }.previewDevice(.init(rawValue: "iPhone 11"))
            NavigationView {
                DiscoveryView(viewModel: DiscoveryViewModel(), showingSetting: false)
            }.previewDevice(.init(rawValue: "iPhone X"))
//            NavigationView {
//                DiscoveryView(viewModel: DiscoveryViewModel())
//            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
