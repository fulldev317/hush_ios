//
//  SignInWithApple.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 6/16/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct SignInWithAppleView: UIViewRepresentable {
    
    @EnvironmentObject var app: App
    @Binding var name : String
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
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline)
        button.cornerRadius = 6
        button.addTarget(context.coordinator, action:  #selector(Coordinator.didTapButton), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    
    }
}
