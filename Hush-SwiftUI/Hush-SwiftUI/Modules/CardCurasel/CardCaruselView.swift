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
    @State private var overlay_opacity: Double = 0

    @State var isShowing: Bool = false
    
    private var degreeIndex = 0
    private var showClose: Bool { translation.width < 0 }
    private var showHeart: Bool { translation.width > 0 }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
      
        self.viewModel.loadDiscover { (result) in
            
        }
    }

    private func movePercent(_ translation: CGSize) -> CGFloat {
        translation.width / (SCREEN_WIDTH / 3)
    }
    
    private var topCardDrag: some Gesture {
        DragGesture().onChanged { value in
            withAnimation(.linear) {
                self.translation = value.translation
            }
        }.onEnded { value in
            
            let percent = self.movePercent(value.translation)
            if -1 <= percent && percent <= 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0) {

                    withAnimation(.default) {
                        self.translation = .zero
                        self.overlay_opacity = 0.0
                    }
                }
            } else {

                if percent > 1 {
                    self.animateLike()
                } else if percent < -1 {
                    self.animateClose()
                }
            }
        }.updating($opacity) { value, opacity, _ in
            withAnimation(.linear) {
                //opacity = abs(Double(self.movePercent(value.translation))) * 0.4
                self.overlay_opacity = abs(Double(self.movePercent(value.translation))) * 0.4
            }
        }
//        .updating($degrees) { value, degrees, _ in
//            let percent = self.movePercent(value.translation)
//            degrees = 15 * Double(percent)
//        }
    }
    
    private func offset(_ card: Int) -> CGFloat {
        -10 * CGFloat((card - cardIndex) % 3)
    }
    
    private func flyAwayOffset(_ index: Int) -> CGFloat {
        var result: CGFloat = 0
        if shouldLike && index == self.getLastIndex(cardIndex) - 1 {
            result = SCREEN_WIDTH
        } else if shouldClose && index == self.getLastIndex(cardIndex) - 1 {
            result = -SCREEN_WIDTH
        }

        return result
    }
    
    private func animateLike() {

        withAnimation(.default) {
            let size:CGSize = self.translation
            self.translation = CGSize(width: size.width + SCREEN_WIDTH, height: size.height + 100)
            self.overlay_opacity = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.translation = .zero
            withAnimation(.default) {
                self.cardIndex += 1
                self.overlay_opacity = 0.0
            }
        }
    }
    
    private func animateClose() {
        
        withAnimation(.default) {
           let size:CGSize = self.translation
           self.translation = CGSize(width: size.width - SCREEN_WIDTH, height: size.height + 100)
           self.overlay_opacity = 1.0
       }
       
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
           self.translation = .zero

           withAnimation(.default) {
               self.cardIndex += 1
               self.overlay_opacity = 0.0
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
                    
                Spacer()
                    
                ZStack {
                    ForEach((cardIndex..<self.getLastIndex(cardIndex)), id: \.self) { index in
                        self.caruselElement(index)
                    }

                }.frame(width: SCREEN_WIDTH)
                .padding(.bottom, ISiPhoneX ? 20 : 0)
                .padding(.top, ISiPhoneX ? 30 : 20)
                
                Spacer()

            }.overlay(overlay)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.shouldAnimate = true
                }
            }
            HushIndicator(showing: self.viewModel.isShowingIndicator).padding(.top, 70)
        }
    }
    
    private func getDegree(_ index: Int ) -> Double {
        var degree:Double = -5

        switch( (index - cardIndex) % 4) {
            case 0:
                degree = -10
                break
            case 1:
                degree = 10
                break
            case 2:
                if cardIndex % 2 == 0 {
                    degree = -5
                } else {
                    degree = 5
                }
                break
            case 3:
                if cardIndex % 2 == 0 {
                    degree = 5
                } else {
                    degree = -5
                }
                break
            default:
                degree = -5
                break
        }
        
        return degree
    }
    
    private func getLastIndex(_ index: Int) -> Int {
        let retIndex = index + (viewModel.discoveries.count > 3 ? 4 : viewModel.discoveries.count)
        return retIndex
   }
    
    private func getOffset(_ index: Int) -> CGFloat {
        var offset:CGFloat = 0;
        let offIndex: Int = (index - cardIndex) % 4
        
        switch(offIndex) {
        case 0:
            offset = 0
            break
        case 1:
            offset = 3
            break
        case 2:
            offset = 6
            break
        case 3:
            offset = 9
            break
        default:
            offset = 0
        }
        
        return offset
    }
    
    private func caruselElement(_ index: Int) -> some View {
        
        CardCaruselElementView(rotation: .degrees(
                                //index.isMultiple(of: 2) ? -5 : 5),
                                    self.getDegree(index)),
                               user: viewModel.discoveries[(2 * self.cardIndex - index + 3) % viewModel.discoveries.count])
        {
            self.viewModel.loadDiscover { (result) in
                
            }
        }
        .offset(index == self.getLastIndex(self.cardIndex) - 1 ? self.translation : .zero)
        .offset(x: 0, y: self.getOffset(index))
        .gesture(index == self.getLastIndex(self.cardIndex) - 1 ? self.topCardDrag : nil)
        //.offset(x: self.flyAwayOffset(index), y: 0)
        .transition(.opacity)
        .rotationEffect(.degrees(index == self.getLastIndex(self.cardIndex) - 1 ? self.degrees : 0), anchor: .bottom)
        //.animation(self.shouldAnimate ? .easeOut(duration: 0.3) : nil)
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
        }.opacity(overlay_opacity)
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
