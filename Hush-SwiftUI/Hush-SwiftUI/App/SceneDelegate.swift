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
        }
        
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
                
                Common.setAddressInfo(user.address!)
                
                auto_login(userId: user.id!)
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
                                .hostModalPresenter()
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
                        //SignUpView(viewModel: SignUpViewModel()).withoutBar()
                        //SignUpEmail(viewModel: SignUpEmailViewModel()).withoutBar()
                        //LoginView(viewModel: LoginViewModel()).withoutBar()
                        //LoginWithEmailView(viewModel: LoginWithEmailViewModel()).withoutBar()
                        GetMoreDetailsView(viewModel:       GetMoreDetailsViewModel(name: "Maksym", username: "max4", email: "max4@gmail.com", password: "111111", image: UIImage(), imagePath: "", imageThumb: "")).withoutBar()
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
            }
        }
    }
}
