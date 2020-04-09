//
//  CardCuraselView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct CardCuraselView<ViewModel: CardCuraselViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    @State var showClose = false
    @State var showHeart = false
    @State var percent: CGFloat = 0
    
    var opacity: Double {
        if percent > 70 {
            return 70 / 100
        }
        return Double(percent) / 100
    }
    
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            VStack {
                KolodaViewHolder({ index in
                    CardCuraselElementView(viewModel: self.viewModel.viewModel(for: index))
                }, moveLeft: { percent in
                    withAnimation {
                        self.percent = percent
                        self.showClose = percent > 15
                        self.showHeart = false
                        
                    }
                }, moveRight: { percent in
                    withAnimation {
                        self.percent = percent
                        self.showHeart = percent > 15
                        self.showClose = false
                    }
                }) {
                    withAnimation {
                        self.percent = 0
                        self.showClose = false
                        self.showHeart = false
                    }
                }.frame(width: SCREEN_WIDTH)
            }
            Rectangle().foregroundColor(Color.black.opacity(opacity))
            HStack {
                if showClose {
                    Image("close_icon").aspectRatio(.fit).frame(width: 100, height: 100).opacity(opacity)
                    Spacer()
                }
                if showHeart {
                    Spacer()
                    Image("heart_icon").aspectRatio(.fit).frame(width: 100, height: 100).opacity(opacity)
                }
            }
        }
    }
}

struct CardCuraselView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                CardCuraselView(viewModel: CardCuraselViewModel())
            }.previewDevice(.init(rawValue: "iPhone SE"))
            NavigationView {
                CardCuraselView(viewModel: CardCuraselViewModel())
            }.previewDevice(.init(rawValue: "iPhone 8"))
            NavigationView {
                CardCuraselView(viewModel: CardCuraselViewModel())
            }.previewDevice(.init(rawValue: "iPhone XS Max"))
        }
    }
}
