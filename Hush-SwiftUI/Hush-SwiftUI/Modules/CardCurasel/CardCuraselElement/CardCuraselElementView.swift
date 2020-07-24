//
//  CardCuraselElementView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct CardCuraselElementView<ViewModel: CardCuraselElementViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    @State private var showMessages = false
    @State private var showUserProfile = false
    @EnvironmentObject private var app: App
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { proxy in
                    PolaroidCard(image: self.viewModel.image, cardWidth: SCREEN_WIDTH, bottom: HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Tammy, 29").font(.thin(30)).foregroundColor(.hBlack)
                            Text("Los Angeles").font(.thin()).foregroundColor(.hBlack)
                            HStack {
                                Circle().fill(Color(0x6FCF97)).square(15)
                                Spacer()
                            }
                        }.padding(.leading, 30)
                        Spacer()
                        NavigationLink(destination: MessageDetailView(viewModel: MessageDetailViewModel(self.app.messages.item(at: 0), imagePath: "")).withoutBar(), isActive: self.$showMessages) {
                            Image("message_card_icon").aspectRatio().frame(width: 45, height: 45)
                        }.buttonStyle(PlainButtonStyle())
//                        HapticButton(action: {
//                            self.showMessages.toggle()
//                        }, label: {
//                            Image("message_card_icon").aspectRatio().frame(width: 45, height: 45)
//                        })
                        
                        NavigationLink(destination: UserProfileView(viewModel: UserProfileViewModel(user: nil)).withoutBar(), isActive: self.$showUserProfile) {
                            Image("more_card_icon").aspectRatio().frame(width: 45, height: 45)
                        }.buttonStyle(PlainButtonStyle())
                        Spacer()
                    }.padding(.vertical)
                    ).background(Color.white.shadow(radius: 8))
                }
            }
        }.tapGesture(toggls: $showUserProfile)
    }
}

struct CardCuraselElementView_Previews: PreviewProvider {
    static var previews: some View {
        CardCuraselElementView(viewModel: CardCuraselElementViewModel())
        .previewEnvironment()
    }
}
