//
//  SignInWithApple.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 6/16/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import FBSDKLoginKit

struct SignInWithFBView: UIViewRepresentable {
    
    @EnvironmentObject var app: App
    @Binding var isLoggedIn : Bool {
        didSet {
            if isLoggedIn == true {
                app.logedIn.toggle()
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> FBLoginButton {
        let loginButton = FBLoginButton()
        return loginButton
    }
    
    func updateUIView(_ uiView: FBLoginButton, context: Context) {
    
    }
}

extension SignInWithFBView {
    
    class Coordinator: NSObject {
        
        let parent: SignInWithFBView?
        
        init(_ parent: SignInWithFBView) {
            self.parent = parent
            super.init()
        }
        
        @objc func didTapButton() {
            
        }
    }
}

