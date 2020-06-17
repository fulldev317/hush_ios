//
//  LoginView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import FBSDKLoginKit

struct LoginView<ViewModel: LoginViewModeled>: View, AuthAppScreens {
    
    // MARK: - Properties

    @ObservedObject var fbmanager = UserLoginManager()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var app: App
    @State var name : String = ""
    @State var isLoggedIn: Bool = false
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                logo()
                Spacer()
                Spacer()
                buttons().padding(.bottom, 30)
                signupButton()
            }
            
            onBackButton(mode)
            
            NavigationLink(destination: LoginWithEmailView(viewModel: viewModel.loginWithMailViewModel, isShowing: false), isActive: $viewModel.showEmailScreen, label: { Text("") })
            }.withoutBar().background(background())
    }
        
    private func signupButton() -> some View {
        
        HapticButton(action: {
            self.app.showSignupButtons = true
            self.mode.wrappedValue.dismiss()
        }) {
            Group { Text("No Account? ").foregroundColor(.white) + Text("Sign Up Now!").foregroundColor(Color(0x56cbf2)) }
        }.padding(.bottom, SafeAreaInsets.bottom + 30)
    }
    
    private func buttons() -> some View {
       
        VStack(spacing: 14) {
            LoginButton(title: "Login with Email", img: Image("mail_icon"), color: Color(0x56CCF2), action: viewModel.loginWithEmail)
            LoginButton(title: "Connect with Facebook", img: Image("facebook_icon"), color: Color(0x2672CB)) {
                self.fbmanager.facebookLogin(app: self.app)
            }
            
//            SignInWithFBView(isLoggedIn: $isLoggedIn)
//            .frame(width: SCREEN_WIDTH - 60, height: 48)
            
            SignInWithAppleView(isLoggedIn: $isLoggedIn)
            .frame(width: SCREEN_WIDTH - 60, height: 48)
            //.onTapGesture(perform: showAppleLogin)
            
            //            LoginButton(title: "Sign in with Apple", titleColor: .black, img: Image("apple_icon"), color: Color(0xFFFFFF)) {
//                //self.presenter.applePressed()
//            }
        }.padding(.horizontal, 30)
    }
}

class UserLoginManager: ObservableObject {
    let loginManager = LoginManager()
    func facebookLogin(app:App) {
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):

                print(error)
            case .cancelled:

                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
                
                app.logedIn = true
                
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        let fbDetails = result as! NSDictionary
                        print(fbDetails)
                    }
                })
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                LoginView(viewModel: LoginViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone SE"))
//            NavigationView {
//                LoginView(viewModel: LoginViewModel())
//            }.previewDevice(.init(rawValue: "iPhone 8")).withoutBar()
//            NavigationView {
//                LoginView(viewModel: LoginViewModel())
//            }.previewDevice(.init(rawValue: "iPhone XS Max")).withoutBar()
        }
    }
}
