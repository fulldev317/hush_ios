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
            NavigationLink(destination:
                SignUpView(viewModel: SignUpViewModel())
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(true),
                           isActive: $viewModel.goToRoot, label: { Text("") })
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
                Text("Forgot password")
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
                borderedButton(action: viewModel.submit, title: "Submit")
                    .padding(.vertical, 29).padding(.horizontal, 30)
                popToRoot()
            }
        }
    }
    
    private func popToRoot() -> some View {
        
        HapticButton(action: {
            self.viewModel.goToRoot.toggle()
        }) {
            Group { Text("No Account? ").foregroundColor(.white) + Text("Sign Up Now!").foregroundColor(Color(0x56cbf2)) }.padding(.bottom, 30)
        }
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
