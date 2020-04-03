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
    
    init(viewModel model: ViewModel) {
        viewModel = model
        UITabBar.appearance().barTintColor = .black
    }
    
    // MARK: - Lifecycle
    
    var body: some View {
        TabView {
            DiscoveryView(viewModel: DiscoveryViewModel()).tabItem {
                
                Image("discoverySelected").resizable().frame(width: 38, height: 38)
                Text("")
            }
            StoriesView(viewModel: StoriesViewModel()).tabItem {
                
                Image("bookmarks").resizable().frame(width: 38, height: 38)
                Text("")
            }
            Text("3").tabItem {
                
                Image("cards").resizable().frame(width: 38, height: 38)
                Text("")
            }
            Text("4").tabItem {
                
                Image("messages").resizable().frame(width: 38, height: 38)
                Text("")
            }
            Text("5").tabItem {
                
                Image("user-circle").resizable().frame(width: 38, height: 38)
                Text("")
            }
        }
        .accentColor(.hOrange)
        .withoutBar()
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
