//
//  SceneDelegate.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import UIKit
import SwiftUI
import PartialSheet
import BackgroundTasks
import PushNotifications

extension UINavigationController {
    
    open override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        
        setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        viewControllers.forEach {
            $0.view.backgroundColor = .black
        }
    }
}

extension UITabBarController {
    
    open override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        
        view.backgroundColor = .black
        viewControllers?.forEach {
            $0.view.backgroundColor = .black
        }
    }
}

import Combine
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    let app = App()
    var pub: AnyCancellable!
    var pub1: AnyCancellable!
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        if userActivity.activityType ==  NSUserActivityTypeBrowsingWeb {
            if let url = userActivity.webpageURL {
                let urlString = url.absoluteString
                if (urlString == "https://hushdating.app/reset-password") {
                    self.app.resetPasswordPage = true
                }
             }
         }
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
        let isLoggedIn = UserDefault(.isLoggedIn, default: false)
        
        if (isLoggedIn.wrappedValue) {
            let user = Common.userInfo()
            if let userId = user.id {
                AuthAPI.shared.get_user_data(userId: userId) { (user, error) in
                    if error == nil {
                        if let user = user {
                            if let premium = user.premium {
                                if premium == "1" {
                                    Common.setPremium(true)
                                } else {
                                    Common.setPremium(false)
                                }
                            }
                        }
                    }
                }
            }
        }
//        let nType = Common.notificationType()
//        if (nType == "chat") {
//            self.app.currentTab = HushTabs.chats
//            Common.setCurrentTab(tab: HushTabs.chats)
//            Common.setUnreadChatEnabled(enabled: true)
//            Common.setNotificationType(type: "none")
//        } else if (nType == "like" || nType == "match") {
//            self.app.currentTab = HushTabs.carusel
//            Common.setCurrentTab(tab: HushTabs.carusel)
//        }
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        //(UIApplication.shared.delegate as! AppDelegate).scheduleUnreadChatfetcher()
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let userID = UserDefaults.standard.object(forKey: "userId") as? String {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userID) { (state, error) in
                
                DispatchQueue.main.async {
                    switch state
                    {
                    case .authorized: // valid user id
                        self.app.logedIn.toggle()
                        //self.settings.authorization = 1
                        break
                    case .revoked: // user revoked authorization
                        //self.settings.authorization = -1
                        break
                    case .notFound: //not found
                        //self.settings.authorization = 0
                        break
                    default:
                        break
                    }
                }
            }
        }
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            window.makeKeyAndVisible()

            if let userActivity = connectionOptions.userActivities.first {
                //self.scene(scene, continue: userActivity)
               if let url = userActivity.webpageURL {
                   let urlString = url.absoluteString
                   if (urlString == "https://hushdating.app/reset-password") {
                       self.app.resetPasswordPage.toggle()
                   }
                }
            }
        }
              
        //registerBackgroundTaks()

        let isLoggedIn = UserDefault(.isLoggedIn, default: false)
        
        if (isLoggedIn.wrappedValue) {
            
            let currentUser = UserDefault(.currentUser, default: "")
            let userString: String = currentUser.wrappedValue
            
            if userString.count > 0 {
                let jsonData = userString.data(using: .utf8)
                let user = try! JSONDecoder().decode(User.self, from: jsonData!)
                //Common.setUserInfo(user)
                self.app.logedIn = true
                self.app.loadingData = false
                
                Common.setAddressInfo(user.address ?? "")
                
                auto_login(userId: user.id ?? "1")
            }
        }
        
        load_langauge()
        
        pub1 = app.$resetPasswordPage.sink { bool in
            if bool {
                self.window?.rootViewController = UIHostingController(rootView:
                    NavigationView {
                        ResetPasswordView(viewModel: ResetPasswordViewModel()).withoutBar()
                    }
                    .environmentObject(PartialSheetManager())
                    .environmentObject(self.app)
                )
            }
        }
        
        pub = app.$logedIn.sink { bool in
            if bool {
                if self.app.loadingData {
                    self.window?.rootViewController = UIHostingController(rootView:
                        NavigationView {
                            RootTabBarView(viewModel: RootTabBarViewModel())
                                .hostModalPresenter()
                                .edgesIgnoringSafeArea(.all)
                                .withoutBar()
                        }
                        .environmentObject(PartialSheetManager())
                        .environmentObject(self.app)
                    )
                } else {
                    self.window?.rootViewController = UIHostingController(rootView:
                        NavigationView {
                            SplashView()
                                //.hostModalPresenter()
                                .edgesIgnoringSafeArea(.all)
                                .withoutBar()
                        }
                        .environmentObject(PartialSheetManager())
                        .environmentObject(self.app)
                    )
                }
            } else {
                self.window?.rootViewController = UIHostingController(rootView:
                    NavigationView {
                        SignUpView(viewModel: SignUpViewModel()).withoutBar()
                        //SignUpEmail(viewModel: SignUpEmailViewModel()).withoutBar()
                        //LoginView(viewModel: LoginViewModel(), showSignupButtons: .constant(false)).withoutBar()
                        //ForgotPasswordView(viewModel: ForgotPasswordViewModel()).withoutBar()
                        //ResetPasswordView(viewModel: ResetPasswordViewModel()).withoutBar()
                        //LoginWithEmailView(viewModel: LoginWithEmailViewModel()).withoutBar()
                        //GetMoreDetailsView(viewModel:       GetMoreDetailsViewModel(name: "Maksym", username: "max4", email: "max4@gmail.com", password: "111111", image: UIImage(), imagePath: "", imageThumb: "")).withoutBar()
                        //AddPhotosView(viewModel: AddPhotosViewModel(name: "Maksym", username: "max3", email: "max3@gmail.com", password: "123456")).withoutBar()
                        
                    }
                    .environmentObject(PartialSheetManager())
                    .environmentObject(self.app)
                
                )
            }
        }
    }
    
    func auto_login(userId: String) {
        AuthAPI.shared.get_user_data(userId: userId) { (user, error) in
            if error != nil {
                self.app.loadingData = false
                self.app.logedIn = false
            } else if let user = user {
              
                let isLoggedIn = UserDefault(.isLoggedIn, default: false)
                isLoggedIn.wrappedValue = true
                
                Common.setUserInfo(user)
                
                let jsonData = try! JSONEncoder().encode(user)
                let jsonString = String(data:jsonData, encoding: .utf8)!
                
                let currentUser = UserDefault(.currentUser, default: "")
                currentUser.wrappedValue = jsonString
                
                self.app.loadingData = true
                self.app.logedIn = true
                
                if let premium = user.premium {
                    if premium == "1" {
                        Common.setPremium(true)
                    } else {
                        Common.setPremium(false)
                    }
                }
                if let s_gender = user.sGender {
                    Common.setSGenderString(gender: s_gender)
                }
                //self.setPusherId(userId: user.id!)
                
                Common.setUnreadChatEnabled(enabled: false)
           }
        }
    }
    
    func setPusherId(userId: String) {
        let tokenProvider = BeamsTokenProvider(authURL: "https://www.hushdating.app/requests/appapi.php") { () -> AuthData in
            let sessionToken = "E9AF1A15E2F1369770BCCE93A8B8EEC46A41ABE2617E43DC17F5337603A239D8"
            let headers = ["Authorization": "Bearer \(sessionToken)"] // Headers your auth endpoint needs
            let queryParams: [String: String] = ["action":"getBeamsToken", "uid":userId] // URL query params your auth endpoint needs
            return AuthData(headers: headers, queryParams: queryParams)
        }
        
        pushNotifications.setUserId(userId, tokenProvider: tokenProvider, completion: { error in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            print("Successfully authenticated with Pusher Beams")
        })
    }
    
    func load_langauge() {
        UserAPI.shared.get_language_list { (list, error) in
            if error == nil {
                if let list = list {
                    for language in list {
                        if let language = language {
                            self.app.languageList.append(language)
                            if let name = language.name {
                                self.app.languageNames.append(name)
                            }
                        }
                    }
                }
            }
        }
    }
}
