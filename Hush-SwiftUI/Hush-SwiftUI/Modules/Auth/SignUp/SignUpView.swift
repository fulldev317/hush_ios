//
//  SignUpView.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct SignUpView<ViewModel: SignUpViewModeled>: View, AuthAppScreens {
    
    @State var showSignupButtons = false
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        ZStack {
            VStack {
                logo()
                    .opacity(showSignupButtons ? 0.3 : 1)
                    .padding(.top, 55)
                Spacer()
            }
            VStack {
                Spacer()
                signupButton()
                    .padding(.bottom, showSignupButtons ? 140 : 220)
            }
            
            VStack(spacing: 28) {
                
                Spacer()
                
                HapticButton(action: viewModel.login, label: {
                    Text("Already have an account? Log In")
                        .font(.medium(16))
                        .foregroundColor(.white)
                })
                
                bottomText()
            }.padding(.bottom, 20)
            
            NavigationLink(destination: SignUpEmail(viewModel: viewModel.emailPresenter), isActive: $viewModel.showEmailScreen, label: EmptyView.init)
            NavigationLink(destination: LoginView(viewModel: LoginViewModel()), isActive: $viewModel.showLoginScreen, label: EmptyView.init)
        }.background(background())
    }
}


// MARK: - Signup button

extension SignUpView {
    
    func signupButton() -> some View {
        
        VStack(spacing: 17) {
            HapticButton(action: { withAnimation { self.showSignupButtons.toggle() } }) {
                if !showSignupButtons {
                    Image("arrowUp_icon").resizable().aspectRatio(contentMode: .fit).frame(width: 18, height: 18)
                }
                Text("SignUp")
                    .foregroundColor(.white)
                if showSignupButtons {
                    Image("arrowDown_icon").resizable().aspectRatio(contentMode: .fit).frame(width: 18, height: 18)
                }
            }.opacity(showSignupButtons ? 0.5 : 1)
            if showSignupButtons {
                LoginButtons(presenter: viewModel).transition(buttonsTransition())
            }
        }
    }
    
    private func buttonsTransition() -> AnyTransition {
        AnyTransition.move(edge: .bottom).combined(with: .opacity)
    }
}


// MARK: - Bottom text

extension SignUpView {
    
    private func bottomText() -> some View {
        VStack(spacing: 0) {
            Text("We dont post anything on Facebook or Snapchat.\n By registering and using Hush you agree to")
            HStack(spacing: 0) {
                Text(" our ")
                terms()
                Text(" and ")
                policy()
            }
        }
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .font(.regular(12))
        .opacity(0.8)
    }
    
    private func terms() -> some View {
        
        Text("Terms & Conditions").underline().onTapGesture(perform: viewModel.terms)
    }
    
    private func policy() -> some View {
        
        Text("Privacy Policy.").underline().onTapGesture(perform: viewModel.privacy)
    }
}


// MARK: - Previews

struct SignUpView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SignUpView(viewModel: SignUpViewModel())
                .previewDevice(.init(rawValue: "iPhone XS Max"))
            SignUpView(viewModel: SignUpViewModel())
                .previewDevice(.init(rawValue: "iPhone 8"))
            SignUpView(viewModel: SignUpViewModel())
                .previewDevice(.init(rawValue: "iPhone SE"))
        }
    }
}
