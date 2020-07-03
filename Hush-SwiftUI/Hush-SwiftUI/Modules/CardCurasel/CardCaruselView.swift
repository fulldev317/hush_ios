//
//  CardCaruselView.swift
//  Hush-SwiftUI
//
//  Created Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI

struct CardCaruselView<ViewModel: CardCuraselViewModeled>: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: ViewModel
    
    @GestureState private var opacity: Double = 0
    @GestureState private var degrees: Double = 0
    @State private var translation: CGSize = .zero
    @State private var cardIndex = 0
    @State private var shouldLike = false
    @State private var shouldClose = false
    @State private var shouldAnimate = false
    @State var isShowing: Bool = false

    private var showClose: Bool { translation.width < 0 }
    private var showHeart: Bool { translation.width > 0 }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
      
        self.viewModel.loadDiscover { (result) in
            
        }
    }

    private func movePercent(_ translation: CGSize) -> CGFloat {
        translation.width / (SCREEN_WIDTH / 2)
    }
    
    private var topCardDrag: some Gesture {
        DragGesture().onChanged { value in
            self.translation = value.translation
        }.onEnded { value in
            self.translation = .zero
            let percent = self.movePercent(value.translation)
            if percent > 1 {
                self.animateLike()
            } else if percent < -1 {
                self.animateClose()
            }
        }.updating($opacity) { value, opacity, _ in
            opacity = abs(Double(self.movePercent(value.translation))) * 0.4
        }.updating($degrees) { value, degrees, _ in
            let percent = self.movePercent(value.translation)
            degrees = 15 * Double(percent)
        }
    }
    
    private func offset(_ card: Int) -> CGFloat {
        -10 * CGFloat((card - cardIndex) % 3)
    }
    
    private func flyAwayOffset(_ index: Int) -> CGFloat {
        var result: CGFloat = 0
        if shouldLike && index == cardIndex {
            result = SCREEN_WIDTH * 2
        } else if shouldClose && index == cardIndex {
            result = -SCREEN_WIDTH * 2
        }

        return result
    }
    
    private func animateLike() {
        shouldLike = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.shouldLike = false
            withAnimation(.default) {
                self.cardIndex += 1
            }
        }
    }
    
    private func animateClose() {
        shouldClose = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.shouldClose = false
            withAnimation(.default) {
                self.cardIndex += 1
            }
        }
    }
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("PhotoBooth")
                        .font(.ultraLight(48))
                        .foregroundColor(.hOrange)
                        
                }.padding(.leading, 25)
                    .frame(height: 65)
                    
                //.padding(.top, ISiPhone11 ? 30 : ISiPhoneX ? 50 : ISiPhone5 ? 55 : 105)
                Spacer()
                ZStack {
                    ForEach((cardIndex..<(cardIndex + viewModel.photos.count)).reversed(), id: \.self) { index in
                            self.caruselElement(index)
                        }

                }.frame(width: SCREEN_WIDTH)
                .padding(.bottom, ISiPhoneX ? 20 : 0)
                .padding(.top, ISiPhoneX ? 40 : 20)
                Spacer()

            }.overlay(overlay)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.shouldAnimate = true
                }
            }
            HushIndicator(showing: self.viewModel.isShowingIndicator)
        }
        
    }
    
    private func caruselElement(_ index: Int) -> some View {

        CardCaruselElementView(rotation: .degrees(index.isMultiple(of: 2) ? -5 : 5),
                               user: viewModel.discoveries[index % viewModel.photos.count], showIndicator: $viewModel.isShowingIndicator)
            .offset(index == self.cardIndex ? self.translation : .zero)
            .offset(x: 0, y: self.offset(index))
            .gesture(index == self.cardIndex ? self.topCardDrag : nil)
            .offset(x: self.flyAwayOffset(index), y: 0)
            .transition(.opacity)
            .rotationEffect(.degrees(index == self.cardIndex ? self.degrees : 0), anchor: .bottom)
            .animation(self.shouldAnimate ? .easeOut(duration: 0.3) : nil)
    }
    
    private var overlay: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                if showClose {
                    Image("close_icon").aspectRatio(.fit).frame(width: 100, height: 100)
                    Spacer()
                }
                if showHeart {
                    Spacer()
                    Image("heart_icon").aspectRatio(.fit).frame(width: 100, height: 100)
                }
            }
        }.opacity(opacity)
    }
}

struct CardCuraselView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CardCaruselView(viewModel: CardCuraselViewModel())
                .withoutBar()
                .previewDevice(.init(rawValue: "iPhone SE 1"))
        }
    }
}
