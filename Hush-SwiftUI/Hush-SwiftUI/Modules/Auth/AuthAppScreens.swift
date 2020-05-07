//
//  SignUpScreens.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

protocol AuthAppScreens {
    
}

extension AuthAppScreens {
    
    func logo() -> some View {
        Image("AppLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 130, height: 160)
            .foregroundColor(Color(0xF2C94C))
    }
    
    private var size: CGSize {
        UIScreen.main.bounds.size
    }
    
    func background() -> some View {
        Image("SignUp-background")
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width)
            .overlay(Color.black.opacity(0.2))
            .edgesIgnoringSafeArea(.all)
//        ZStack {
//
//
//                .edgesIgnoringSafeArea(.all)
//        }
    }
    
    func onBackButton(_ presentation: Binding<PresentationMode>) -> some View {
        
        VStack {
            HStack {   HapticButton(action: {
                presentation.wrappedValue.dismiss()
                
            }) {
                Image("onBack_icon").frame(width: 44, height: 44)
            }.frame(width: 44, height: 44).padding(.top, 20).padding(.leading, 16)
                Spacer()
            }
            Spacer()
        }
    }
    
    func borderedButton(action: @escaping () -> Void, title: String) -> some View {
        HapticButton(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white, lineWidth: 1)
                    .foregroundColor(.clear)
                    .frame(minHeight: 45, maxHeight: 48)
                Text(title).font(.light()).foregroundColor(.white)
            }.contentShape(Rectangle())
        }
    }
}

struct MainAppScreens_Previews: PreviewProvider, AuthAppScreens {
    static var previews: some View {
        Group {
            ZStack {
                MainAppScreens_Previews().background()
                MainAppScreens_Previews().logo()
            }
            
            ZStack {
                MainAppScreens_Previews().background()
                MainAppScreens_Previews().logo()
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
