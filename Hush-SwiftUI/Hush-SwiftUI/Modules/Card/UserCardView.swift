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
   
    private let cardHeight = 280 * (SCREEN_WIDTH / 2) / 237
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                GeometryReader { proxy in
                    Image(uiImage: self.viewModel.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width - 20)
                        .clipShape(Rectangle())
                        .padding([.top, .leading, .trailing], 10)
                }
                Spacer()
                HStack {
                    (Text(viewModel.name) + Text(", ") + Text("\(viewModel.age)")).font(.regular(14)).foregroundColor(Color(0x8E8786))
                    if viewModel.selected {
                        Spacer()
                        Image("red_heart").resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                    } else {
                        Spacer()
                    }
                }.padding(15)
            }
        }.frame(width: SCREEN_WIDTH / 2, height: cardHeight)
    }
}

struct UserCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                UserCardView(viewModel: UserCardViewModel()).padding().padding().background(Color.black)
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                UserCardView(viewModel: UserCardViewModel()).padding().padding().background(Color.black)
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                UserCardView(viewModel: UserCardViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max")).padding().padding().background(Color.black)
        }
    }
}
