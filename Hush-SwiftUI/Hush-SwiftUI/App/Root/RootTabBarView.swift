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
    
    @State var currentTab = HushTabs.carusel
    @ObservedObject var isFirstLaunch = UserDefault(.isFirstLaunch, default: true)
    @State private var selectMessagesFilter = false

    init(viewModel model: ViewModel) {
        viewModel = model
        UITabBar.appearance().barTintColor = .black
    }
    
    // MARK: - Lifecycle
    
    var body: some View {
        GeometryReader { proxy in
            TabBarView(selectedTab: self.$currentTab) {
                ZStack {
                    
                    if self.currentTab == .chats {
                        Color.clear.onAppear {
                            pushNotifications.registerForRemoteNotifications()
                        }
                    }
                    
                    if self.currentTab == .chats {
                        self.messages().zIndex(self.currentTab == .chats ? 1 : 0)
                    } else {
                        ZStack {
                           Spacer()
                        }
                    }
                    
                    if self.currentTab == .discoveries {
                        NavigationView {
                            self.discovery().withoutBar()
                        }.zIndex(self.currentTab == .discoveries ? 1 : 0)
                    } else {
                        ZStack {
                            Spacer()
                        }
                    }
                    
                    if self.currentTab == .stories {
                        NavigationView {
                            self.stories().withoutBar()
                        }.zIndex(self.currentTab == .stories ? 1 : 0)
                    } else {
                        ZStack {
                            Spacer()
                        }
                    }
                    
                    if self.currentTab == .carusel {
                        NavigationView {
                            self.carousel().withoutBar()
                        }.zIndex(self.currentTab == .carusel ? 1 : 0)
                    } else {
                        ZStack {
                            Spacer()
                        }
                    }
                    
                    if self.currentTab == .profile {
                        Color.clear.onAppear {
                            Common.setProfileEditing(false)
                        }
                        NavigationView {
                            MyProfileView(viewModel: MyProfileViewModel()).withoutBar().addPartialSheet()
                        }.zIndex(self.currentTab == .profile ? 1 : 0)
                    }
                }
            }.frame(width: proxy.size.width, height: proxy.size.height)
            .accentColor(.hOrange)
            .sheet(isPresented: self.$app.showPremium) {
                UpgradeView(viewModel: UpgradeViewModel())
            }.onAppear {
                //self.app.discovery.settingsViewModel.closeAPISelectorCompletion = self.showDiscoverySettings
                self.app.stories.settingsViewModel.closeAPISelectorCompletion = self.showStoriesSettings
            }
            .overlay(self.photoBoothOverlay)
            .withoutBar()
        }
    }
    
    var photoBoothOverlay: some View {
        Group {
            if isFirstLaunch.wrappedValue && self.currentTab == .carusel {
                CardCaruselTutorialView()
                    .onTapGesture { self.isFirstLaunch.wrappedValue.toggle() }
            }
        }.onAppear {
            // force refresh layout
            self.isFirstLaunch.objectWillChange.send()
        }
    }
    
    func messages() -> some View {
        NavigationView {
            VStack(spacing: ISiPhone5 ? 0 : 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Messages").foregroundColor(.hOrange).font(.ultraLight(48))
                    }.padding(.leading, 25)
                    Spacer()
                    HapticButton(action: { self.app.messages.showMessageFilter.toggle() }) {
                        Image("settings_icon").resizable().frame(width: 25, height: 25).padding(30)
                    }.offset(x: 0, y: 10)
                }.padding(.top, -10)
                
                MessagesView(viewModel: app.messages)
            }.withoutBar()
        }
    }
    
    func stories() -> some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Story Wall").foregroundColor(.hOrange).font(.ultraLight(48))
                    Text("User stories near you").foregroundColor(.white).font(.thin())
                }.padding(.leading, 25)
                Spacer()
                HapticButton(action: self.showDiscoverySettings) {
                    Image("settings_icon").resizable().frame(width: 25, height: 25).padding(30)
                }
            }
            
            StoriesView(viewModel: StoriesViewModel(), showingSetting: self.app.isShowingSetting)
        }.withoutBar()
        .addPartialSheet()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .alert(isPresented: $app.selectingGender, TextAlert(style: .actionSheet, title: nil, message: nil, actions: Gender.allCases.map { gender in
            UIAlertAction(toggling: $app.selectingGender, title: gender.title, style: .default) { _ in
                //self.app.discovery.settingsViewModel.setGender(gender: gender)
            }
        } + [UIAlertAction(toggling: $app.selectingGender, title: "Cancel", style: .cancel)]))
        
    }
    
    func discovery() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Discovery").foregroundColor(.hOrange).font(.ultraLight(48))
                    Text(Common.addressInfo()).foregroundColor(.white).font(.thin())
                }
                Spacer()
                HapticButton(action: self.showDiscoverySettings) {
                    Image("settings_icon").resizable().frame(width: 25, height: 25).padding(30)
                }
            }.padding(.leading, 25)
            DiscoveryView(viewModel:  self.app.discovery, showingSetting: self.app.isShowingSetting)
        }.frame(width: SCREEN_WIDTH)
        .withoutBar()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .alert(isPresented: $app.selectingGender, TextAlert(style: .actionSheet, title: nil, message: nil, actions: Gender.allCases.map { gender in
            UIAlertAction(toggling: $app.selectingGender, title: gender.title, style: .default) { _ in
                //self.app.discovery.settingsViewModel.setGender(gender: gender)
            }
        } + [UIAlertAction(toggling: $app.selectingGender, title: "Cancel", style: .cancel)]))
        .addPartialSheet()
    }
    
    func carousel() -> some View {
        VStack {
            HStack {
                Text("PhotoBooth").foregroundColor(.hOrange).font(.ultraLight(48))
                Spacer()
                HapticButton(action: self.showDiscoverySettings) {
                    Image("settings_icon").resizable().frame(width: 25, height: 25).padding(30)
                }
            }.padding(.leading, 25).padding(.top, -10)
            
            CardCaruselView(viewModel: CardCuraselViewModel(), showingSetting: self.app.isShowingSetting)

        }.frame(width: SCREEN_WIDTH)
        .withoutBar()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .alert(isPresented: $app.selectingGender, TextAlert(style: .actionSheet, title: nil, message: nil, actions: Gender.allCases.map { gender in
            UIAlertAction(toggling: $app.selectingGender, title: gender.title, style: .default) { _ in
                //self.app.discovery.settingsViewModel.setGender(gender: gender)
            }
        } + [UIAlertAction(toggling: $app.selectingGender, title: "Cancel", style: .cancel)]))
        .addPartialSheet()
    }
    
//    func matches() -> some View {
//        VStack {
//            HStack {
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("Matches").foregroundColor(.hOrange).font(.ultraLight(48))
//                    Text("Location").foregroundColor(.white).font(.thin())
//                }
//                Spacer()
//                HapticButton(action: self.showDiscoverySettings) {
//                    Image("settings_icon").resizable().frame(width: 25, height: 25).padding(30)
//                }
//            }.padding(.leading, 25)
//
//            DiscoveryView(viewModel:  self.app.discovery, showingSetting: self.app.isShowingSetting)
//        }.frame(width: SCREEN_WIDTH)
//        .withoutBar()
//        .background(Color.black.edgesIgnoringSafeArea(.all))
//        .alert(isPresented: $app.selectingGender, TextAlert(style: .actionSheet, title: nil, message: nil, actions: Gender.allCases.map { gender in
//            UIAlertAction(toggling: $app.selectingGender, title: gender.title, style: .default) { _ in
//                //self.app.discovery.settingsViewModel.gender = gender
//            }
//        } + [UIAlertAction(toggling: $app.selectingGender, title: "Cancel", style: .cancel)]))
//        .addPartialSheet()
//    }
    
    func showDiscoverySettings() {
        self.app.isShowingSetting = true
        self.app.discovery.setSettingsModel()
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
        NavigationView {
            RootTabBarView(viewModel: RootTabBarViewModel())
                .hostModalPresenter()
                .edgesIgnoringSafeArea(.all)
                .withoutBar()
        }.previewEnvironment()
    }
}
