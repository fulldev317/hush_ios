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
    
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var app: App
    @ObservedObject var viewModel: ViewModel
    @State var isShowing: Bool = false
    @State var showingTopPopup: Bool = false
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
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
                    }.padding(.horizontal, 36)
                }
                
                SignUpTextField(placeholder: "Email", icon: Image("signup_email_icon"), text: $viewModel.email).padding(.horizontal, 30)
                SignUpTextField(placeholder: "Password", icon: Image("signup_password_icon"), isSecured: true, text: $viewModel.password).padding(.horizontal, 30)
                
                borderedButton(action: {
                    //self.app.logedIn.toggle()
                    
                    if self.viewModel.email.count == 0 {
                        return
                    }
                    
                    if self.viewModel.password.count == 0 {
                        return
                    }
                    
                    self.isShowing = true

                    self.viewModel.submit(result: { result in
                        self.isShowing = false
                        if (result) {
                            self.app.logedIn.toggle()
                            self.app.loadingData = true
                        }
                    })
                }, title: "Submit")
                    .padding(.vertical, 29)
                    .padding(.horizontal, 30)
                
                resetPasswordButton()
                    .padding(.bottom, 36)
            }.keyboardAdaptive()
            
            onBackButton(mode)
            
            HushIndicator(showing: self.isShowing)
            
        }
        .background(NavigationLink(destination: ForgotPasswordView(viewModel: viewModel.forgotPasswordViewModel),
                                    isActive: $viewModel.showForgotPassword,
                                    label: EmptyView.init))
        .background(background())
            
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)

    }
    
    private func resetPasswordButton() -> some View {
        HapticButton(action: {
            self.viewModel.showForgotPassword.toggle()
        }) {
            Text("Forgot Pasword? ").foregroundColor(.white) + Text("Reset now!").foregroundColor(Color(0x56cbf2))
        }
    }
}

struct LoginWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                LoginWithEmailView(viewModel: LoginWithEmailViewModel(), isShowing: false)
            }.previewDevice(.init(rawValue: "iPhone SE"))
            
        }
    }
}
