//
//  SignUpScreens.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

protocol MainAppScreens {

}

extension MainAppScreens where Self: View {
    
    func logo() -> some View {
        Image("AppLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 155, height: 190)
    }
    
    private var size: CGSize {
        UIScreen.main.bounds.size
    }
    
    func background() -> some View {
        Image("SignUp-background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea([.top, .bottom])
            .frame(width: size.width, height: size.height)
    }
}
