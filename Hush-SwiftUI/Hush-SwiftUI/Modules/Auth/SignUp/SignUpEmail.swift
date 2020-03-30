//
//  SignUpEmail.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

protocol SignUpEmailViewPresenter: ObservableObject {
    
    var name: String { get set }
    var username: String { get set }
    var email: String { get set }
    var password: String { get set }
    var hasError: Bool { get set }
}

class SignUpEmailPresenter: SignUpEmailViewPresenter {
    
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var hasError: Bool = false
}

struct SignUpEmail<Presenter: SignUpEmailViewPresenter>: View, MainAppScreens {
    
    @ObservedObject var presenter: Presenter
    @ObservedObject var keyboardObserver = KeyboardObserver()
    @State var sss = ""
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                ScrollView {
                    self.body(with: proxy)
                        .padding(.bottom, self.keyboardObserver.height)
                }
            }
        }.navigationBarBackButtonHidden(true).background(background())
    }
    
    private func body(with proxy: GeometryProxy) -> some View {
        
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                logo()
                
                Text("Sign up with email").foregroundColor(.white).font(.thin(22))
                    .padding(.bottom, 40).padding(.top, 60)
                if presenter.hasError {
                    errorLabel().padding(.bottom, 22)
                }
                
                fields().padding(.horizontal, 30)
                HapticButton(action: { }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .cornerRadius(6)
                            .border(Color.white, width: 1)
                            .frame(height: 48)
                        Text("SUBMIT").font(.light()).foregroundColor(.white)
                    }.padding(.horizontal, 30)
                }.padding(.top, 30)
                .padding(.bottom, 26)
                HapticButton(action: { }, label: {
                    Text("Already have an account?")
                        .font(.medium(16))
                        .foregroundColor(.white)
                })
                    .padding(.bottom, 50)
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
}

struct SignUpEmail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUpEmail(presenter: SignUpEmailPresenter())
        }
    }
}
