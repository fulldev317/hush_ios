//
//  RootTabBarView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct RootTabBarView<ViewModel: RootTabBarViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var app: App
    
    @State var currentTab = 4
    
    var bottom: CGFloat {
        (44 + SafeAreaInsets.bottom + SafeAreaInsets.top)
    }
    
    init(viewModel model: ViewModel) {
        viewModel = model
        UITabBar.appearance().barTintColor = .black
    }
    
    // MARK: - Lifecycle
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                TabView(selection: self.$currentTab) {
                    DiscoveryView(viewModel: DiscoveryViewModel()).tabItem {
                        
                        Image("discoverySelected").resizable().frame(width: 38, height: 38)
                        Text("")
                    }.tag(0)
                    StoriesView(viewModel: StoriesViewModel()).tabItem {
                        
                        Image("bookmarks").resizable().frame(width: 38, height: 38)
                        Text("")
                    }.tag(1)
                    CardCuraselView(viewModel: CardCuraselViewModel()).tabItem {
                        
                        Image("cards").resizable().frame(width: 38, height: 38)
                        Text("")
                    }.tag(2)
                    MessagesView(viewModel: MessagesViewModel()).withoutBar().tabItem {
                        
                        Image("messages").resizable().frame(width: 38, height: 38)
                        Text("")
                    }.tag(3)
                    MyProfileView(viewModel: MyProfileViewModel()).withoutBar().tabItem {
                        
                        Image("user-circle").resizable().frame(width: 38, height: 38)
                        Text("")
                    }.tag(4)
                }
                .frame(width: proxy.size.width, height: proxy.size.height + (self.app.showTabbar ? 0 : self.bottom))
                .padding(.top, (self.app.showTabbar ? 0 : self.bottom))
                .accentColor(.hOrange)
                .sheet(isPresented: self.$app.showPremium) {
                    UpgradeView(viewModel: UpgradeViewModel())
                }
            }
        }
    }
}

struct RootTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                RootTabBarView(viewModel: RootTabBarViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                RootTabBarView(viewModel: RootTabBarViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                RootTabBarView(viewModel: RootTabBarViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
