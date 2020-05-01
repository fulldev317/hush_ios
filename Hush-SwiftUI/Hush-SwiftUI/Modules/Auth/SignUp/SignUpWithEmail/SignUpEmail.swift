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
    @State private var keyboardPresented: Bool = false
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                ZStack {
                        
                        self.body(with: proxy)
                            .frame(minHeight: proxy.size.height)
                }
            }.keyboardAdaptive($keyboardPresented)
            onBackButton(self.mode)
            NavigationLink(destination: AddPhotosView(viewModel: viewModel.addPhotoViewModel).withoutBar(), isActive: $viewModel.showAddPhotoScreen, label: { Text("") })
            NavigationLink(destination: LoginView(viewModel: LoginViewModel()), isActive: $viewModel.showLoginScreen) {
                Text("")
            }
        }.withoutBar().background(background())
    }
    
    private func body(with proxy: GeometryProxy) -> some View {
        
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                
                Spacer()
                
                logo()
                    .opacity(keyboardPresented ? 0 : 1)
                Spacer()
                
                Text("Sign up with email").foregroundColor(.white).font(.thin(22))
                    .frame(maxHeight: 90).frame(minHeight: 60)
                if viewModel.hasError {
                    errorLabel().padding(.bottom, 22)
                }
                
                Spacer()
                
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
        
        borderedButton(action: viewModel.submit, title: "Submit").padding(.horizontal, 30)
    }
}


// MARK: - Previews

struct SignUpEmail_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            NavigationView { SignUpEmail(viewModel: SignUpEmailViewModel()) }.previewDevice(.init(rawValue: "iPhone XS Max"))
            NavigationView { SignUpEmail(viewModel: SignUpEmailViewModel()) }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView { SignUpEmail(viewModel: SignUpEmailViewModel()) }.previewDevice(.init(rawValue: "iPhone SE"))
        }
    }
}
