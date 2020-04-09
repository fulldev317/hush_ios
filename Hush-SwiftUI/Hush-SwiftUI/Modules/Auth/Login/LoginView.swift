//
//  LoginView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModeled>: View, AuthAppScreens {
    
    // MARK: - Properties

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var viewModel: ViewModel
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                logo()
                Spacer()
                Spacer()
                buttons()
                Spacer()
                signupButton()
            }
            
            onBackButton(mode)
            
            NavigationLink(destination: LoginWithEmailView(viewModel: viewModel.loginWithMailViewModel), isActive: $viewModel.showEmailScreen, label: { Text("") })
            }.withoutBar().background(background())
    }
    
    private func signupButton() -> some View {
        
        HapticButton(action: {
            self.mode.wrappedValue.dismiss()
        }) {
            Group { Text("No Account? ").foregroundColor(.white) + Text("Sign Up Now!").foregroundColor(Color(0x56cbf2)) }
        }.padding(.bottom, SafeAreaInsets.bottom + 30)
    }
    
    private func buttons() -> some View {
       
        VStack(spacing: 14) {
            LoginButton(title: "Login with Email", img: Image("mail_icon"), color: Color(0x56CCF2), action: viewModel.loginWithEmail)
                .padding(.horizontal, 24)
            LoginButton(title: "Connect with Facebook", img: Image("facebook_icon"), color: Color(0x2672CB)) {
//                self.presenter.facebookPressed()
            }.padding(.horizontal, 24)
            LoginButton(title: "Sign in with Apple", titleColor: .black, img: Image("apple_icon"), color: Color(0xFFFFFF)) {
//                self.presenter.applePressed()
            }.padding(.horizontal, 24)
            LoginButton(title: "Continue with Snapchat", titleColor: .black, img: Image("snap_icon"), color: Color(0xFFFC01)) {
//                self.presenter.snapPressed()
            }.padding(.horizontal, 24)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                LoginView(viewModel: LoginViewModel()).withoutBar()
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                LoginView(viewModel: LoginViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8")).withoutBar()
            NavigationView {
                LoginView(viewModel: LoginViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max")).withoutBar()
        }
    }
}
