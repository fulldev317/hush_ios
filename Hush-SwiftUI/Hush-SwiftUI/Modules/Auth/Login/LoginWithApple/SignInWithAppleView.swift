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
    var action: (_ login: Bool, _ userName: String,_ email: String) -> Void

    func makeCoordinator() -> Coordinator {
        let coordinator = Coordinator(self)
        return coordinator
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
        
        let imgX: Int = ISiPhone5 ? 20 : 50
        let imageView = UIImageView(frame: CGRect(x: imgX, y: 14, width: 20, height: 20))
        imageView.image = UIImage(named: "apple_icon")
        
        let font = UIFont(name: "SFProDisplay-Regular", size: 20)
        
        let textX: Int = ISiPhone5 ? 49 : 79
        let textView = UILabel(frame: CGRect(x: textX, y: 0, width: Int(SCREEN_WIDTH) - 140, height: 48))
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
