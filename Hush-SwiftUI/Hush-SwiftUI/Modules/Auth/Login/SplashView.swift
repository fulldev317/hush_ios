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
                    .padding(.top, 55)
                Spacer()
            }
            VStack {
                Spacer()

            }
            
            HushIndicator(showing: self.isShowing)
            
        }.withoutBar().background(background(name: "back1"))
    }
}

// MARK: - Previews

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView().withoutBar()
    }
}
