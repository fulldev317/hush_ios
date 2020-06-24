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
let TAB_WIDTH: CGFloat = CGFloat((SCREEN_WIDTH - TAB_MARGIN) / 5 - 2)
let TAB_HEIGHT: CGFloat = CGFloat(30)

struct DiscoveryView<ViewModel: DiscoveryViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject private var app: App
    @State private var showUserProfile = false
    @State var isShowing: Bool = false
    @State var currentViewIndex: Int = 0
    @State private var selectedItem: Int = 0
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        loadDiscover()
      
    }
    // MARK: - Lifecycle
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Button(action: {
                        self.currentViewIndex = 0

                    }) {
                        ZStack {
                            Text("Broswe")
                                .font(.regular(16))
                                .foregroundColor(self.currentViewIndex == 0 ? Color.yellow : Color.white)
                            Rectangle().frame(height: 1)
                                .foregroundColor(Color.yellow)
                                .padding(.top, TAB_HEIGHT - 2)
                                .opacity(self.currentViewIndex == 0 ? 1 : 0)
                        }
                    
                    }.frame(width: TAB_WIDTH, height: TAB_HEIGHT, alignment: .center)
                    
                    Rectangle().frame(width: 1).foregroundColor(Color.white).background(Color.yellow)
                    
                    Button(action: {
                        self.currentViewIndex = 1

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
                    }.frame(width: TAB_WIDTH, height: TAB_HEIGHT, alignment: .center)
                    
                    Rectangle().frame(width: 1).foregroundColor(Color.white).padding(.vertical, 2)

                    Button(action: {
                        self.currentViewIndex = 2

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
                    }.frame(width: TAB_WIDTH * 1.2, height: TAB_HEIGHT, alignment: .center)
                    
                    Rectangle().frame(width: 1).foregroundColor(Color.white).padding(.vertical, 2)

                    Button(action: {
                        self.currentViewIndex = 3
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
                    }.frame(width: TAB_WIDTH, height: TAB_HEIGHT, alignment: .center)
                    
                    Rectangle().frame(width: 1).foregroundColor(Color.white).padding(.vertical, 2)

                    Button(action: {
                        self.currentViewIndex = 4
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
                    }.frame(width: TAB_WIDTH, height: TAB_HEIGHT, alignment: .center)
                }.frame(height: TAB_HEIGHT, alignment: .leading)
            }.frame(width: SCREEN_WIDTH, height: TAB_HEIGHT, alignment: .leading)
            
            if viewModel.discoveries.count > 0 {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: -20) {
                        ForEach(0..<(viewModel.discoveries.count / 2), id: \.self) {
                            self.row(at: $0)
                        }
                    }.padding(.top, 10)
                    
                    
                }.background(
                    NavigationLink(
                        destination: UserProfileView(viewModel: UserProfileViewModel(user: self.viewModel.discoveries[self.selectedItem])),
                        isActive: $showUserProfile,
                        label: EmptyView.init
                    )
                )
                //HushIndicator(showing: self.viewModel.isShowingIndicator)


            } else {
                VStack {
                    
                    Spacer()
                    HushIndicator(showing: self.viewModel.isShowingIndicator)
                    Spacer()


                }
            }
            

        }
    }
     
    func row(at i: Int) -> some View {
        HStack(spacing: -18) {
            ForEach(0..<2, id: \.self) { j in
                self.polaroidCard(i, j)
                    .onTapGesture {
                        self.selectedItem = i * 2 + j
                        self.showUserProfile = true
                }
            }
        }.zIndex(Double(100 - i))
    }
    
    func polaroidCard(_ i: Int, _ j: Int) -> some View {
        PhotoCard(image: self.viewModel.discoveries[i*2+j].profilePhotoBig!, cardWidth: SCREEN_WIDTH / 2 + 15, bottom: self.bottomView(i, j), blured: false)
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
    
    #warning("Please update viewModel")
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
            }
        }.padding(15)
        .padding(.leading, self.leading(j))
        .padding(.trailing, self.trailing(j))
    }
    
    func loadDiscover() {

        let user = Common.userInfo()
        
        self.viewModel.isShowingIndicator = true
        
        AuthAPI.shared.discovery(uid: user.id!, location: user.address!, gender: "1", max_distance: "100", age_range: "18,30", check_online: "1") { (userList, error) in
            
            self.viewModel.isShowingIndicator = false

            
            if let error = error {
            } else if let userList = userList {
                for value in userList {
                    var user: User = value!
                    let nAge: Int = Int(user.age!)!
                    let name: String = user.name!
                    let photo: String = user.profilePhotoBig!
                    user.liked = false

                    self.viewModel.discoveries.append(user)
                }
                
            }
        }
    }
    
    
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DiscoveryView(viewModel: DiscoveryViewModel())
        }
//        Group {
//            NavigationView {
//                DiscoveryView(viewModel: DiscoveryViewModel())
//            }.previewDevice(.init(rawValue: "iPhone SE"))
//            NavigationView {
//                DiscoveryView(viewModel: DiscoveryViewModel())
//            }.previewDevice(.init(rawValue: "iPhone 8"))
//            NavigationView {
//                DiscoveryView(viewModel: DiscoveryViewModel())
//            }.previewDevice(.init(rawValue: "iPhone XS Max"))
//        }
    }
}
