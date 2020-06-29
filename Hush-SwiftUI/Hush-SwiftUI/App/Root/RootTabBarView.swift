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
                            UNUserNotificationCenter.current()
                                .requestAuthorization(options: [.alert, .sound]) { _, _ in }
                        }
                    }
                    
                    if self.currentTab == .discoveries {
                        NavigationView {
                            self.discovery().withoutBar()
                        }.zIndex(self.currentTab == .discoveries ? 1 : 0)
                    } else {
                        ZStack {
                            Text("123")
                        }
                    }
                    
                    self.stories().zIndex(self.currentTab == .stories ? 1 : 0)
                    
                    NavigationView {
                        if self.currentTab == .carusel {
                            CardCaruselView(viewModel: CardCuraselViewModel()).withoutBar()
                        } else {
                            VStack {
                                Spacer()
                            }
                        }
                    }.zIndex(self.currentTab == .carusel ? 1 : 0)
                    
                    if self.currentTab == .chats {
                        self.messages().zIndex(self.currentTab == .chats ? 1 : 0)
                    }
                    
                    if self.currentTab == .profile {
                        MyProfileView(viewModel: MyProfileViewModel()).zIndex(self.currentTab == .profile ? 1 : 0)
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
            if isFirstLaunch.wrappedValue && currentTab == .carusel {
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
            VStack(spacing: 20) {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Messages").foregroundColor(.hOrange).font(.ultraLight(48))
                    }.padding(.leading, 25)
                    Spacer()
                    HapticButton(action: { self.selectMessagesFilter.toggle() }) {
                        Image("settings_icon").resizable().frame(width: 25, height: 25).padding(30)
                    }.offset(x: 0, y: 10)
                }.padding(.top, -10)
                
                MessagesView(viewModel: app.messages)
            }.withoutBar()
        }.actionSheet(isPresented: $selectMessagesFilter) {
            ActionSheet(title: Text("Filter Messages"), message: nil, buttons: MessagesFilter.allCases.map { filter in
                .default(Text(filter.title), action: { self.app.messages.filter = filter })
            } + [.cancel()])
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
                HapticButton(action: self.showStoriesSettings) {
                    Image("settings_icon").resizable().frame(width: 25, height: 25).padding(30)
                }
            }
            
            StoriesView(viewModel: StoriesViewModel())
        }.addPartialSheet()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    func discovery() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Discovery").foregroundColor(.hOrange).font(.ultraLight(48))
                    Text("Location").foregroundColor(.white).font(.thin())
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
                //self.app.discovery.settingsViewModel.gender = gender
                self.app.discovery.settingsViewModel.setGender(gender: gender)
//                AuthAPI.shared.update_gender(gender: gender.rawValue) { (error) in
//                    var user = Common.userInfo()
//                    user.gender = Common.getGenderIntValue(gender.rawValue)
//                    Common.setUserInfo(user)
//                }
            }
        } + [UIAlertAction(toggling: $app.selectingGender, title: "Cancel", style: .cancel)]))
        .addPartialSheet()
    }
    
    func matches() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Matches").foregroundColor(.hOrange).font(.ultraLight(48))
                    Text("Location").foregroundColor(.white).font(.thin())
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
                //self.app.discovery.settingsViewModel.gender = gender
            }
        } + [UIAlertAction(toggling: $app.selectingGender, title: "Cancel", style: .cancel)]))
        .addPartialSheet()
    }
    
    func showDiscoverySettings() {
        self.app.isShowingSetting = true
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
