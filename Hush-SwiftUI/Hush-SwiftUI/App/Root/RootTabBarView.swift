//
//  RootTabBarView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

protocol AppTabView {
    var top: CGFloat { get }
}

extension AppTabView {
    
    var top: CGFloat {
        if let top = UIApplication.shared.windows.first?.rootViewController?.view.safeAreaInsets.top {
            return top
        }
        return 0
    }
}

struct RootTabBarView<ViewModel: RootTabBarViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var app: App
    
    @State var currentTab = 2
    
    init(viewModel model: ViewModel) {
        viewModel = model
        UITabBar.appearance().barTintColor = .black
    }
    
    // MARK: - Lifecycle
    
    var body: some View {
        TabView(selection: $currentTab) {
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
        .accentColor(.hOrange)
        .withoutBar()
        .sheet(isPresented: $app.showPremium) {
            UpgradeView(viewModel: UpgradeViewModel())
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
