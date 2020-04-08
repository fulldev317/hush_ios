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
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { proxy in
                    PolaroidCard(image: self.viewModel.image, cardWidth: proxy.size.width - 60, bottom: HStack {
                        Spacer()
                        VStack {
                            Text("Tammy, 29").font(.thin(30)).foregroundColor(.hBlack)
                            Text("Los Angeles").font(.thin()).foregroundColor(.hBlack)
                        }
                        Spacer()
                        HapticButton(action: {
                            
                        }, label: {
                            Image("message_card_icon").aspectRatio().frame(width: 45, height: 45)
                        })
                        HapticButton(action: {
                            
                        }, label: {
                            Image("more_card_icon").aspectRatio().frame(width: 45, height: 45)
                        })
                        Spacer()
                    }.padding(.vertical)
                    ).background(Color.white.shadow(radius: 8))
                }
            }
        }
    }
}

struct CardCuraselElementView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                CardCuraselElementView(viewModel: CardCuraselElementViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                CardCuraselElementView(viewModel: CardCuraselElementViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                CardCuraselElementView(viewModel: CardCuraselElementViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
