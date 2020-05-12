//
//  RootTabBarView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import PartialSheet

struct RootTabBarView<ViewModel: RootTabBarViewModeled>: View, HeaderedScreen {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var app: App
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @EnvironmentObject var modalPresenterManager: ModalPresenterManager
    
    @State var currentTab = HushTabs.stories
    @State var isFirstLaunch = true
    
    init(viewModel model: ViewModel) {
        viewModel = model
        UITabBar.appearance().barTintColor = .black
    }
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        GeometryReader { proxy in
            TabBarView(selectedTab: self.$currentTab) {
                if self.currentTab == .discoveries {
                    self.discovery()
                }

                if self.currentTab == .stories {
                    self.stories()
                }

                if self.currentTab == .carusel {
                    self.photoBoth()
                }

                if self.currentTab == .chats {
                    MessagesView(viewModel: self.app.messages)
                }

                if self.currentTab == .profile {
                    MyProfileView(viewModel: self.app.profile)
                }
            }.frame(width: proxy.size.width, height: proxy.size.height)
            .accentColor(.hOrange)
            .sheet(isPresented: self.$app.showPremium) {
                UpgradeView(viewModel: UpgradeViewModel())
            }.onAppear {
                self.app.discovery.settingsViewModel.closeAPISelectorCompletion = self.showDiscoverySettings
                self.app.stories.settingsViewModel.closeAPISelectorCompletion = self.showStoriesSettings
            }
            .overlay(self.photoBothOverlay)
        }
    }
    
    var photoBothOverlay: some View {
        Group {
            if isFirstLaunch && currentTab == .carusel {
                CardCaruselTutorialView()
                    .onTapGesture { self.isFirstLaunch.toggle() }
            }
        }
    }
    
    func photoBoth() -> some View {
        HeaderedView(header: {
            VStack(alignment: .leading, spacing: 0) {
                Text("Photo").foregroundColor(.hOrange).font(.bold(48))
                +
                Text("Booth").foregroundColor(.white).font(.ultraLight(48))
            }
        }, content: {
            CardCuraselView(viewModel: CardCuraselViewModel())
        })
    }
    
    func stories() -> some View {
        
        HeaderedView(header: {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Story Wall").foregroundColor(.hOrange).font(.ultraLight(48)).padding(.leading, 30)
                    Text("User stories near you").foregroundColor(.white).font(.thin()).padding(.leading, 30)
                }
                Spacer()
                HapticButton(action: self.showStoriesSettings) {
                    Image("settings_icon").resizable().frame(width: 25, height: 25).padding(30)
                }
            }
        }, content: {
            StoriesView(viewModel: StoriesViewModel())
        }).addPartialSheet()
    }
    
    func discovery() -> some View {
        
        HeaderedView(header: {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Discovery").foregroundColor(.hOrange).font(.ultraLight(48)).padding(.leading, 30)
                    Text("Location").foregroundColor(.white).font(.thin()).padding(.leading, 30)
                }
                Spacer()
                HapticButton(action: self.showDiscoverySettings) {
                    Image("settings_icon").resizable().frame(width: 25, height: 25).padding(30)
                }
            }
        }, content: {
            DiscoveryView(viewModel:  self.app.discovery)
        }).padding(.top, 0)
        .withoutBar()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .alert(isPresented: $app.selectingGender, TextAlert(style: .actionSheet, title: nil, message: nil, actions: Gender.allCases.map { gender in
            UIAlertAction(toggling: $app.selectingGender, title: gender.title, style: .default) { _ in
                self.app.discovery.settingsViewModel.gender = gender
            }
        } + [UIAlertAction(toggling: $app.selectingGender, title: "Cancel", style: .cancel)]))
        .addPartialSheet()
    }
    
    func showDiscoverySettings() {
        partialSheetManager.showPartialSheet {
            DiscoveriesSettingsView(viewModel: self.app.discovery.settingsViewModel)
        }
    }
    
    func showStoriesSettings() {
        partialSheetManager.showPartialSheet {
            StoriesSettingsView(viewModel: self.app.stories.settingsViewModel)
        }
    }
}

struct RootTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                RootTabBarView(viewModel: RootTabBarViewModel())
            }
//            NavigationView {
//                RootTabBarView(viewModel: RootTabBarViewModel())
//            }.previewDevice(.init(rawValue: "iPhone XS Max"))
//            NavigationView {
//                RootTabBarView(viewModel: RootTabBarViewModel())
//            }.previewDevice(.init(rawValue: "iPhone 8"))
        }.previewEnvironment()
    }
}
