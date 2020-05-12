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

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    let app = App()
    var pub: AnyCancellable!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            window.makeKeyAndVisible()
        }
        
        pub = app.$logedIn.sink { bool in
            self.window?.rootViewController = UIHostingController(rootView:
                NavigationView {
//                    if bool {
//                        RootTabBarView(viewModel: RootTabBarViewModel()).withoutBar()
//                    } else {
//                        SignUpView(viewModel: SignUpViewModel()).withoutBar()
//                    }
                    
                    RootTabBarView(viewModel: RootTabBarViewModel())
                        .hostModalPresenter()
                        .edgesIgnoringSafeArea(.all)
                        .withoutBar()
                    
//                    NewFaceDetection(viewModel: NewFaceDetectionViewModel()).withoutBar()
//                    FaceDetectionView(viewModel: FaceDetectionViewModel()).withoutBar()
                }.environmentObject(self.app)
                .environmentObject(PartialSheetManager())
            )
        }
    }
}
