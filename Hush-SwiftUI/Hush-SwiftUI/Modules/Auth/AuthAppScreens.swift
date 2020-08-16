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
    
    func background(name: String) -> some View {
        Image(name)
            .resizable()
            .frame(width: UIScreen.main.bounds.width)
            .overlay(Color.black.opacity(0.4))
            .edgesIgnoringSafeArea(.all)
            .background(Color.black)
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
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white, lineWidth: 0)
                    .foregroundColor(.clear)
                    .frame(minHeight: 45, maxHeight: 48)
                    Text("1234").font(.light()).foregroundColor(.clear)
                    Image("onBack_icon").frame(width: 60, height: 60)
                }
            }.frame(width: 60, height: 60).padding(.top, 6).padding(.leading, 6)
                Spacer()
            }
            Spacer()
        }
    }
    
    func borderedButton(action: @escaping () -> Void, title: String) -> some View {
        HapticButton(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white, lineWidth: 0.5)
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
                MainAppScreens_Previews().background(name: "")
                MainAppScreens_Previews().logo()
            }
            
            ZStack {
                MainAppScreens_Previews().background(name: "")
                MainAppScreens_Previews().logo()
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
