//
//  LoginButtons.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct LoginButtons<Presenter: SignUpViewModeled>: View {
    
    @ObservedObject var presenter: Presenter
    @State var name : String = ""
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        VStack(spacing: 14) {
            LoginButton(title: "Sign Up with Email", img: Image("mail_icon"), color: Color(0x56CCF2)) {
                self.presenter.emailPressed()
            }.padding(.horizontal, 24)
            
            LoginButton(title: "Connect with Facebook", img: Image("facebook_icon"), color: Color(0x2672CB)) {
                self.presenter.facebookPressed()
            }.padding(.horizontal, 24)
            
            SignInWithAppleView(name: $name, isLoggedIn: $isLoggedIn)
            .frame(width: SCREEN_WIDTH - 48, height: 48)

//            LoginButton(title: "Sign in with Apple", titleColor: .black, img: Image("apple_icon"), color: Color(0xFFFFFF)) {
//                self.presenter.applePressed()
//            }.padding(.horizontal, 24)
        }
    }
}

struct LoginButton: View {
    
    let title: String
    var titleColor: Color = .white
    let img: Image
    let color: Color
    let action: () -> Void
    
    var body: some View {
        HapticButton(action: action) {
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 48)
                    .cornerRadius(6)
                    .foregroundColor(color)
                HStack {
                    img
                        .resizable()
                        .foregroundColor(titleColor)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                    Text(title)
                        .font(.medium(20))
                        .padding(.trailing, 20)
                        .minimumScaleFactor(0.7)
                    .lineLimit(1)
                        .foregroundColor(titleColor)
                }.padding(.leading, 50)
            }
        }
    }
}

struct LoginButtons_Previews: PreviewProvider {
    static var previews: some View {
        LoginButtons(presenter: SignUpViewModel())
    }
}
