//
//  SignUpEmail.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct SignUpEmail<Presenter: SignUpEmailViewPresenter>: View, MainAppScreens {
    
    @ObservedObject var presenter: Presenter
    @ObservedObject var keyboardObserver = KeyboardObserver()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                ZStack {
                        
                        self.body(with: proxy)
                            .frame(minHeight: proxy.size.height)
                            .padding(.bottom, self.keyboardObserver.height)
                }
            }
            VStack {
                HStack {   HapticButton(action: { self.mode.wrappedValue.dismiss() }) {
                    Image("onBack_icon").frame(width: 44, height: 44)
                }.frame(width: 44, height: 44).padding(.top, 20).padding(.leading, 16)
                    Spacer()
                }
                Spacer()
            }
        }.navigationBarTitle("", displayMode: .inline).navigationBarHidden(true).background(background())
    }
    
    private func body(with proxy: GeometryProxy) -> some View {
        
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                
                Spacer()
                
                logo()
                Spacer()
                
                Text("Sign up with email").foregroundColor(.white).font(.thin(22))
                    .frame(maxHeight: 90).frame(minHeight: 60)
                if presenter.hasError {
                    errorLabel().padding(.bottom, 22)
                }
                
                Spacer()
                
                fields().padding(.horizontal, 30)
                Spacer()
                submitButton()
                    .padding(.bottom, 26)
                HapticButton(action: { }, label: {
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
            SignUpTextField(placeholder: "Name", icon: Image("user_icon"), text: $presenter.name)
            SignUpTextField(placeholder: "Choose a Username", icon: Image("user_icon"), text: $presenter.username)
            SignUpTextField(placeholder: "Email", icon: Image("signup_email_icon"), text: $presenter.email)
            SignUpTextField(placeholder: "Password", icon: Image("signup_password_icon"), isSecured: true, text: $presenter.password)
        }
    }
    
    private func errorLabel() -> some View {
        Text("Username already taken, try another one").font(.thin()).foregroundColor(Color(0xF2C94C))
    }
    
    private func submitButton() -> some View {
        HapticButton(action: { }) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white, lineWidth: 1)
                    .foregroundColor(.clear)
                    .frame(minHeight: 40, maxHeight: 48)
                Text("SUBMIT").font(.light()).foregroundColor(.white)
            }.padding(.horizontal, 30)
        }
    }
}


// MARK: - Previews

struct SignUpEmail_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            NavigationView { SignUpEmail(presenter: SignUpEmailPresenter()) }.previewDevice(.init(rawValue: "iPhone XS Max"))
            NavigationView { SignUpEmail(presenter: SignUpEmailPresenter()) }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView { SignUpEmail(presenter: SignUpEmailPresenter()) }.previewDevice(.init(rawValue: "iPhone SE"))
        }
    }
}
