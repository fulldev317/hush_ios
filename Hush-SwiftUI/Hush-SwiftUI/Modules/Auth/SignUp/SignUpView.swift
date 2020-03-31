//
//  SignUpView.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct SignUpView<Presenter: SignUpViewPresenter>: View, MainAppScreens {
    
    @State var showSignupButtons = false
    
    @ObservedObject var presenter: Presenter
    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                logo()
                    .opacity(showSignupButtons ? 0 : 1)
                Spacer()
                Spacer()
                Spacer()
            }
            VStack {
                Spacer()
                signupButton()
                    .padding(.bottom, showSignupButtons ? 140 : 220)
            }
            VStack(spacing: 28) {
                
                Spacer()
                
                HapticButton(action: presenter.login, label: {
                    Text("Already have an account? Log In")
                        .font(.medium(16))
                        .foregroundColor(.white)
                })
                
                bottomText()
            }
            .padding(.bottom, 20)
            NavigationLink(destination: SignUpEmail(presenter: presenter.emailPresenter), isActive: $presenter.showEmailScreen) {
                Text("")
            }
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
                LoginButtons(presenter: presenter).transition(buttonsTransition())
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
        
        Text("Terms & Conditions").underline().onTapGesture(perform: presenter.terms)
    }
    
    private func policy() -> some View {
        
        Text("Privacy Policy.").underline().onTapGesture(perform: presenter.privacy)
    }
}


// MARK: - Previews

struct SignUpView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SignUpView(presenter: SignUpPresenter())
                .previewDevice(.init(rawValue: "iPhone XS Max"))
            SignUpView(presenter: SignUpPresenter())
                .previewDevice(.init(rawValue: "iPhone 8"))
            SignUpView(presenter: SignUpPresenter())
                .previewDevice(.init(rawValue: "iPhone SE"))
        }
    }
}
