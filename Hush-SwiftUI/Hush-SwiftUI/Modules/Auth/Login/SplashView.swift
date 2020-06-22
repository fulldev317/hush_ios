//
//  SignUpView.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct SplashView: View, AuthAppScreens {
    
    @EnvironmentObject var app: App
    @State var isShowing: Bool = true

    var body: some View {
        
        ZStack {
            VStack {
                logo()
                    .opacity(app.showSignupButtons ? 0.3 : 1)
                    .padding(.top, 55)
                Spacer()
            }
            VStack {
                Spacer()

            }
            
            VStack(spacing: 28) {
                
                Spacer()
                
               
                
            }.padding(.bottom, 20)
            
           
            
            HushIndicator(showing: self.isShowing)
            
        }.background(background())
        .withoutBar()

    }
}

// MARK: - Previews

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
