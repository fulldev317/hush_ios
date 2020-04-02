//
//  UserCardView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 02.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

let SCREEN_WIDTH = UIScreen.main.bounds.width

struct UserCardView<ViewModel: UserCardViewModeled>: View {

    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            Color.white
            
        }.frame(width: SCREEN_WIDTH / 2 + 20, height: 280).padding().padding().background(Color.black)
    }
}

struct UserCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                UserCardView(viewModel: UserCardViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                UserCardView(viewModel: UserCardViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                UserCardView(viewModel: UserCardViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
