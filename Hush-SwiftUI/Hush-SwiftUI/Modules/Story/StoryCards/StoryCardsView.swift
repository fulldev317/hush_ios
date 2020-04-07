//
//  StoryCardsView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct StoryCardsView<ViewModel: StoryCardsViewModeled>: View {

    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            UserCardView(viewModel: viewModel).layoutPriority(1)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(uiImage: viewModel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 5))
                    .frame(width: 52, height: 52)
                    .padding(.trailing, 10)
                    .padding(.bottom, 43)
                
                }
            }
        }
    }
}

struct StoryCardsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                StoryCardsView(viewModel: StoryCardsViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                StoryCardsView(viewModel: StoryCardsViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                StoryCardsView(viewModel: StoryCardsViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
