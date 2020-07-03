//
//  SignUpEmail.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct SignUpEmail<ViewModel: SignUpEmailViewModeled>: View, AuthAppScreens {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var keyboardHeight: CGFloat = 0
    @State var isShowing: Bool = false

    var body: some View {
        ZStack {
            GeometryReader { proxy in
                ZStack {
                        
                        self.body(with: proxy)
                            .frame(minHeight: proxy.size.height)
                }
            }.offset(x: 0, y: -keyboardHeight)
            onBackButton(self.mode)
                .offset(x: 0, y: -keyboardHeight)
            NavigationLink(destination:
                AddPhotosView(viewModel: AddPhotosViewModel(name: viewModel.name, username: viewModel.username, email: viewModel.email, password: viewModel.password)).withoutBar(),
//                GetMoreDetailsView(viewModel: GetMoreDetailsViewModel(name: viewModel.name, username: viewModel.username, email: viewModel.email, password: viewModel.password, image: UIImage())).withoutBar(),
                isActive: $viewModel.showAddPhotoScreen, label: { Text("") })
            NavigationLink(destination: LoginView(viewModel: LoginViewModel()), isActive: $viewModel.showLoginScreen) {
                Text("")
            }
            
            HushIndicator(showing: self.isShowing)
            
        }.withoutBar().background(background())
        .observeKeyboardHeight($keyboardHeight, withAnimation: .default)
    }
    
    private func body(with proxy: GeometryProxy) -> some View {
        
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                logo()
                    .opacity(keyboardHeight > 0 ? 0.3 : 1)
                    .padding(.top, 55)

                Spacer()
                
                Text("Sign up with email").foregroundColor(.white).font(.thin(22))
                .frame(maxHeight: 90).frame(minHeight: 60)
                    .opacity(keyboardHeight > 0 ? 0.3 : 1)
             
                if viewModel.hasError {
                    errorLabel().padding(.bottom, 22)
                }
                
                Spacer()
                
                if viewModel.hasErrorMessage {
                    HStack {
                        Spacer()
                        Text(viewModel.errorMessage).font(.thin()).foregroundColor(.hOrange)
                        Spacer()
                    }
                }
                
                fields().padding(.horizontal, 30)
                Spacer()
                submitButton()
                    .padding(.bottom, 26)
                HapticButton(action: viewModel.login, label: {
                    Text("Already have an account?")
                        .font(.medium(16))
                        .foregroundColor(.white)
                })
                    .padding(.bottom, 30)
            }
            
        }
    }
    
    private func fields() -> some View {
        Group {
            SignUpTextField(placeholder: "Name", icon: Image("user_icon"), text: $viewModel.name)
            SignUpTextField(placeholder: "Choose a Username", icon: Image("user_icon"), text: $viewModel.username)
            SignUpTextField(placeholder: "Email", icon: Image("signup_email_icon"), text: $viewModel.email)
            SignUpTextField(placeholder: "Password", icon: Image("signup_password_icon"), isSecured: true, text: $viewModel.password)
        }
    }
    
    private func errorLabel() -> some View {
        Text("Username already taken, try another one").font(.thin()).foregroundColor(Color(0xF2C94C))
    }
    
    private func submitButton() -> some View {
        
        borderedButton(action: {
            
            if self.viewModel.name.count == 0 {
                self.viewModel.hasErrorMessage = true
                self.viewModel.errorMessage = "Please input Name"
                return
            }
            
            if self.viewModel.username.count == 0 {
                self.viewModel.hasErrorMessage = true
                self.viewModel.errorMessage = "Please input Username"
                return
            }
            
            if self.viewModel.email.count == 0 {
                self.viewModel.hasErrorMessage = true
                self.viewModel.errorMessage = "Please input Email"
                return
            }
                      
            if self.viewModel.password.count == 0 {
                self.viewModel.hasErrorMessage = true
                self.viewModel.errorMessage = "Please input Password"
                return
            }
            
            self.isShowing = true

            self.viewModel.submit(result: { result in
                
                self.isShowing = false

                if (result) {
                }
            })
        }, title: "Submit").padding(.horizontal, 30)
    }
}


// MARK: - Previews

struct SignUpEmail_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView { SignUpEmail(viewModel: SignUpEmailViewModel()) }
    }
}
