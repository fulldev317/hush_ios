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
    
    func makeUIView(context: Context) -> UIView  {
//        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline)
//        button.cornerRadius = 6
//        button.addTarget(context.coordinator, action:  #selector(Coordinator.didTapButton), for: .touchUpInside)
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 48, height: 48)
        let button = UIButton(frame: frame)
        button.addTarget(context.coordinator, action: #selector(Coordinator.didTapButton), for: .touchUpInside)
        button.backgroundColor = UIColor.clear
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        let imageView = UIImageView(frame: CGRect(x: 50, y: 14, width: 20, height: 20))
        imageView.image = UIImage(named: "apple_icon")
        
        let font = UIFont(name: "SFProDisplay-Regular", size: 20)
        
        let textView = UILabel(frame: CGRect(x: 79, y:0, width: SCREEN_WIDTH - 140, height: 48))
        textView.text = "Sign in with Apple"
        textView.font = font
        textView.textColor = UIColor.black
        
        view.addSubview(imageView)
        view.addSubview(textView)
        view.addSubview(button)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    
    }
}
