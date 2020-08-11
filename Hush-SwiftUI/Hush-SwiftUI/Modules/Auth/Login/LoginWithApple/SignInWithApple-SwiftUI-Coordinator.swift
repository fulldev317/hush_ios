//
//  SignInWithApple-SwiftUI-Coordinator.swift
//  Hush-SwiftUI
//
//  Created by fulldev on 6/16/20.
//  Copyright © 2020 AppServices. All rights reserved.
//

import AuthenticationServices


class Coordinator: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    let parent: SignInWithAppleView?

    init(_ parent: SignInWithAppleView) {
        self.parent = parent
        super.init()
    }
    
    @objc func didTapButton() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.presentationContextProvider = self
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        let vc = UIApplication.shared.windows.last?.rootViewController
        return (vc?.view.window!)!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential else {
            print("credentials not found....")
            return
        }
        
        let defaults = UserDefaults.standard
        defaults.set(credentials.user, forKey: "userId")
        let fname = credentials.fullName?.givenName ?? "Any"
        let lname = credentials.fullName?.familyName ?? "Any"
        let name = fname + " " + lname
        let email = credentials.email ?? "test@email.com"
        //parent?.name = "\(credentials.fullName?.givenName ?? "")"
        //parent?.isLoggedIn = true
        
        parent?.action(true, name, email)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        parent?.action(false, "apple_user", "appel_email")
        
        
    }
}
