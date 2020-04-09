//
//  ContentView.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var app: App
    
    var body: some View {
        Group {
            if app.logedIn {
                RootTabBarView(viewModel: RootTabBarViewModel()).withoutBar()
            } else {
                SignUpView(viewModel: SignUpViewModel()).withoutBar()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
