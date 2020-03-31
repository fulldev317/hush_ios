//
//  LoginWithEmailView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct LoginWithEmailView<ViewModel: LoginWithEmailViewModeled>: View, AuthAppScreens {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var observer = KeyboardObserver()
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                ZStack {
                        
                        self.body(with: proxy)
                            .frame(minHeight: proxy.size.height)
                            .padding(.bottom, self.observer.height)
                }
            }
            onBackButton(mode)
            NavigationLink(destination: ForgotPasswordView(viewModel: viewModel.forgotPasswordViewModel), isActive: $viewModel.showForgotPassword, label: { Text("") })
        }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
    
    func body(with: GeometryProxy) -> some View {
        
        ZStack {
            
            bluredBackground()
            VStack {
                Spacer()
                logo()
                Spacer()
                Spacer()
                Text("Log in with email")
                    .font(.thin(22))
                    .foregroundColor(.white)
                    .padding(.bottom, 16)
                if viewModel.hasErrorMessage {
                    HStack {
                        Text(viewModel.errorMessage).font(.thin()).foregroundColor(.hOrange)
                        Spacer()
                    }.padding(.horizontal, 30)
                }
                SignUpTextField(placeholder: "Email", icon: Image("signup_email_icon"), text: $viewModel.email).padding(.horizontal, 30)
                SignUpTextField(placeholder: "Password", icon: Image("signup_password_icon"), isSecured: true, text: $viewModel.password).padding(.horizontal, 30)
                borderedButton(action: viewModel.submit, title: "Submit")
                    .padding(.vertical, 29).padding(.horizontal, 30)
                resetPasswordButton()
            }
        }
    }
    
    private func resetPasswordButton() -> some View {
        
        HapticButton(action: {
            self.viewModel.showForgotPassword.toggle()
        }) {
            Group { Text("Forgot Pasword? ").foregroundColor(.white) + Text("Reset now!").foregroundColor(Color(0x56cbf2)) }.padding(.bottom, 30)
        }
    }
}

struct LoginWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                LoginWithEmailView(viewModel: LoginWithEmailViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                LoginWithEmailView(viewModel: LoginWithEmailViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                LoginWithEmailView(viewModel: LoginWithEmailViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
