//
//  ResetPasswordView.swift
//  Hush-SwiftUI
//
//  Created by Serge Vysotsky on 07.05.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import PartialSheet

struct ResetPasswordView<ViewModel: ResetPasswordViewModeled>: View, AuthAppScreens {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var app: App
    @State private var keyboardHeight: CGFloat = 0
    @State var isShowing: Bool = false
    @State var showAlert = false
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
                
                if viewModel.hasErrorMessage {
                    HStack {
                        Spacer()
                        Text(viewModel.errorMessage).font(.thin()).foregroundColor(.hOrange)
                        Spacer()
                    }.padding(.horizontal, 30)
                }
                                
                SignUpTextField(placeholder: "New Password",
                                icon: Image("signup_password_icon"),
                                isSecured: true,
                                text: $viewModel.password)
                    .padding(.horizontal, 30)
                SignUpTextField(placeholder: "Confirm New Password",
                                icon: Image("signup_password_icon"),
                                isSecured: true,
                                text: $viewModel.repeatPassword)
                    .padding(.horizontal, 30)
                
                borderedButton(action: {
                    
                    if self.viewModel.password.count == 0 {
                        self.viewModel.hasErrorMessage = true
                        self.viewModel.errorMessage = "Passwords input password"
                        return
                    }
                    
                    if self.viewModel.repeatPassword.count == 0 {
                        self.viewModel.hasErrorMessage = true
                        self.viewModel.errorMessage = "Passwords input confirm password"
                        return
                    }
                    
                    if self.viewModel.password.count < 6 {
                        self.viewModel.hasErrorMessage = true
                        self.viewModel.errorMessage = "Passwords must be at least 6 characters"
                        return
                    }
                    
                    if self.viewModel.password != self.viewModel.repeatPassword {
                        self.viewModel.hasErrorMessage = true
                        self.viewModel.errorMessage = "Password are not matching"
                        return
                    }
                    
                    UIApplication.shared.endEditing()
                    
            
                    if let email = UserDefaults.standard.string(forKey: "forgotEmail") {
                        self.isShowing = true

                        self.viewModel.submit(email: email, password: self.viewModel.password) { (result) in
                            self.isShowing = false

                            if (result) {
                                self.viewModel.hasErrorMessage = false
                                self.showAlert.toggle()
                            }
                        }
                    }
                    
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
            
            NavigationLink(destination: LoginWithEmailView(viewModel: LoginWithEmailViewModel()), isActive: $viewModel.showLogin, label: EmptyView.init)

            
            NavigationLink(destination: SignUpView(viewModel: SignUpViewModel()), isActive: $viewModel.showSignUp, label: EmptyView.init)
            
            HushIndicator(showing: self.isShowing)

        }.background(background(name: "back1"))
        .withoutBar()
        .keyboardAdaptive()
        .alert(isPresented: $showAlert) { () -> Alert in
            Alert(title: Text(""), message: Text("Your password is reset successfully").font(.regular(24)), dismissButton: .default(Text("OK"), action: {
                self.viewModel.showLogin.toggle()
            }))
        }
    }
}

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResetPasswordView(viewModel: ResetPasswordViewModel())
        }
    }
}
