//
//  ForgotPasswordView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 31.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct ForgotPasswordView<ViewModel: ForgotPasswordViewModeled>: View, AuthAppScreens {
    
    
    // MARK: - Properties

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var app: App
    @State private var keyboardHeight: CGFloat = 0
    @State var isShowing: Bool = false
    @State var showAlert = false

    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                ZStack {
                        
                        self.body(with: proxy)
                            .frame(minHeight: proxy.size.height)
                }
            }.keyboardAdaptive()
            onBackButton(mode).padding(.top, keyboardHeight > 0 ? -100 : 0)
            NavigationLink(destination:
                SignUpView(viewModel: SignUpViewModel())
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true),
                           isActive: $viewModel.goToRoot, label: { Text("") })
        }.background(background(name: "back1"))
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
    
    func body(with: GeometryProxy) -> some View {
        
        ZStack {
            VStack {
                Spacer()
                logo()
                Spacer()
                Spacer()
                Text("Forgot password")
                    .font(.thin(22))
                    .foregroundColor(.white)
                    .padding(.bottom, 16)
                if viewModel.hasErrorMessage {
                    HStack {
                        Spacer()
                        Text(viewModel.errorMessage).font(.thin()).foregroundColor(.hOrange)
                        Spacer()
                    }.padding(.horizontal, 30)
                }
                SignUpTextField(placeholder: "Email", icon: Image("signup_email_icon"), text: $viewModel.email).padding(.horizontal, 30)
                borderedButton(action: {
                    //viewModel.submit
                    //self.viewModel.showResetPassword.toggle()
                    UIApplication.shared.endEditing()

                    let email = self.viewModel.email
                    if (email.count == 0) {
                        self.viewModel.hasErrorMessage = true
                        self.viewModel.errorMessage = "Please input Email"
                        return
                    }
                    self.isShowing = true
                    self.viewModel.submit(email: self.viewModel.email) { (result) in
                        self.isShowing = false
                        if (result) {
                            self.viewModel.hasErrorMessage = false
                            self.showAlert.toggle()
                            UserDefaults.standard.set(self.viewModel.email, forKey: "forgotEmail")
                            return
                        }
                    }
                    
                }, title: "Submit")
                    .padding(.vertical, 29).padding(.horizontal, 30)
                popToRoot()
            }.padding(.top, keyboardHeight > 0 ? -150 : 0)
            
            HushIndicator(showing: self.isShowing)

        }.background(NavigationLink(destination: ResetPasswordView(viewModel: ResetPasswordViewModel()),
        isActive: $viewModel.showResetPassword,
        label: EmptyView.init))
        .observeKeyboardHeight($keyboardHeight, withAnimation: .default)
        .alert(isPresented: $showAlert) { () -> Alert in
            Alert(title: Text(""), message: Text("Reset password link is sent successfully").font(.regular(24)), dismissButton: .default(Text("OK"), action: {
            }))
        }
    }
    
    private func popToRoot() -> some View {
        
        HapticButton(action: {
            self.app.showSignupButtons = true
            self.viewModel.goToRoot.toggle()
        }) {
            Group { Text("No Account? ").foregroundColor(.white) + Text("Sign Up Now!").foregroundColor(Color(0x56cbf2)) }
        }.padding(.bottom, 36)
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ForgotPasswordView(viewModel: ForgotPasswordViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                ForgotPasswordView(viewModel: ForgotPasswordViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                ForgotPasswordView(viewModel: ForgotPasswordViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
