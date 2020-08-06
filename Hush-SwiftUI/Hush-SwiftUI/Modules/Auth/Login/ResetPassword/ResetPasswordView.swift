//
//  ResetPasswordView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 07.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct ResetPasswordView<ViewModel: ResetPasswordViewModeled>: View, AuthAppScreens {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var app: App
    
    var body: some View {
        ZStack {
            onBackButton(presentationMode)
            
            VStack {
                logo()
                    .padding(.top, 55)
                Spacer()
                
                Text("Reset Password")
                    .font(.light(22))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                Text("Passwords must be at least 6 characters")
                    .font(.light(18))
                    .foregroundColor(Color(0xF2C94C))
                    .padding(.bottom, 20)
                
                SignUpTextField(placeholder: "New Password",
                                icon: Image("signup_password_icon"),
                                isSecured: true,
                                text: .constant(""))
                    .padding(.horizontal, 30)
                SignUpTextField(placeholder: "Confirm New Password",
                                icon: Image("signup_password_icon"),
                                isSecured: true,
                                text: .constant(""))
                    .padding(.horizontal, 30)
                
                borderedButton(action: {
                    self.app.logedIn = true
                }, title: "Submit")
                    .padding(.vertical, 29)
                    .padding(.horizontal, 30)
                
                HapticButton(action: {
                    self.viewModel.showSignUp.toggle()
                }) {
                    Text("No Account? ").foregroundColor(.white) +
                    Text("Sign Up Now!").foregroundColor(Color(0x56cbf2))
                }.padding(.bottom, 36)
                
            }
            
            NavigationLink(destination: SignUpView(viewModel: SignUpViewModel()), isActive: $viewModel.showSignUp, label: EmptyView.init)
            
        }.background(background(name: "back1"))
        .withoutBar()
    }
}

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResetPasswordView(viewModel: ResetPasswordViewModel())
        }
    }
}
