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
    @State var name: String = ""
    @State var isLoggedIn: Bool = false
    @State var isShowing: Bool = false
    @Binding var showSignupButtons: Bool

    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                logo()
                Spacer()
                
                VStack {
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.medium(24))
                    Image("arrowDown_icon").resizable().aspectRatio(contentMode: .fit).frame(width: 18, height: 18)
                }.padding(.bottom, 10)
                    .opacity(0.5)
                
                buttons().padding(.bottom, 30)
                signupButton()
            }
            
            onBackButton(mode)
            
            NavigationLink(destination: LoginWithEmailView(viewModel: viewModel.loginWithMailViewModel, isShowing: false), isActive: $viewModel.showEmailScreen, label: { Text("") })
            
            HushIndicator(showing: self.isShowing)
           
        }.withoutBar().background(background(name: "back1"))
    }
        
    private func signupButton() -> some View {
        
        HapticButton(action: {
            //self.app.showSignupButtons = true
            self.showSignupButtons = true
            self.mode.wrappedValue.dismiss()
        }) {
            Group { Text("No Account? ").foregroundColor(.white) + Text("Sign Up Now!").foregroundColor(Color(0x56cbf2)) }
        }.padding(.bottom, SafeAreaInsets.bottom + 30)
    }
    
    private func buttons() -> some View {
       
        VStack(spacing: 14) {
            LoginButton(title: "Login with Email", img: Image("mail_icon"), color: Color(0x56CCF2), action: viewModel.loginWithEmail)
            LoginButton(title: "Connect with Facebook", img: Image("facebook_icon"), color: Color(0x2672CB)) {

                self.fbmanager.facebookLogin(login_result: { fbResult in
                    let result: String = fbResult["result"] as! String
                    if result == "success" {
                        //self.app.logedIn = true
                        self.isShowing = true

                        self.fbmanager.facebookConnect(data: fbResult) { result in
                            self.isShowing = false
                            if result == true {
                                self.app.loadingData.toggle()
                                self.app.logedIn.toggle()
                            }
                        }
                    }
                })
            }
                        
            SignInWithAppleView(action: { login, name, email in
                if (login == true) {
                    self.isShowing = true

                    self.viewModel.loginWithApple(email: email, name: name) { (result) in
                        self.isShowing = false

                        if (result) {
                            self.app.loadingData.toggle()
                            self.app.logedIn.toggle()
                        }
                    }
                }
            }).frame(width: SCREEN_WIDTH - 60, height: 48)

        }.padding(.horizontal, 30)

    }
}

class UserLoginManager: ObservableObject {
    let loginManager = LoginManager()
    
    func facebookConnect(data: NSDictionary, result: @escaping (Bool) -> Void ) {
        AuthAPI.shared.facebookConnect(facebookId: data["id"] as! String,
                                       email: data["email"] as! String,
                                       name: data["name"] as! String, gender: "0") { (user, error) in
                                        
            if error != nil {
                result(false)
            } else if let user = user {
              
                let isLoggedIn = UserDefault(.isLoggedIn, default: false)
                isLoggedIn.wrappedValue = true
                
                Common.setUserInfo(user)
                Common.setAddressInfo("Los Angels, CA, US")
                let jsonData = try! JSONEncoder().encode(user)
                let jsonString = String(data:jsonData, encoding: .utf8)!
                
                let currentUser = UserDefault(.currentUser, default: "")
                currentUser.wrappedValue = jsonString
                result(true)
            }
        }
        
    }
    
    func facebookLogin(login_result: @escaping (NSDictionary) -> Void) {
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):
                login_result(["result":"failed"])
                print(error)
            case .cancelled:
                login_result(["result":"cancelled"])
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
                
                //app.logedIn = true
                
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        let fbDetails = result as! NSDictionary
                        let fbResult: NSDictionary = ["result": "success",
                                                      "id": fbDetails["id"] ?? "123456789",
                                                      "name": fbDetails["name"] ?? "test",
                                                      "email": fbDetails["email"] ?? "test@email.com"]
                        
                        print(fbDetails)
                        login_result(fbResult)
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
                LoginView(viewModel: LoginViewModel(), showSignupButtons: .constant(false)).withoutBar()
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
