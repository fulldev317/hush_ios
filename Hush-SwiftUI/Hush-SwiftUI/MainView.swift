//
//  ContentView.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            SignUpView(viewModel: SignUpViewModel()).withoutBar()
//            RootTabBarView(viewModel: RootTabBarViewModel()).withoutxBar()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
