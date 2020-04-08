//
//  KolodeViewHolder.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 03.04.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import SwiftUI
import Koloda

typealias KolodaViewDelegate = Koloda.KolodaViewDelegate
typealias KolodaViewDataSource = Koloda.KolodaViewDataSource
typealias KolodaView = Koloda.KolodaView

class OwnKoloda: KolodaView {
    
    var w: CGFloat {
        SCREEN_WIDTH * 510 / 447
    }
    var h: CGFloat {
        w
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        alphaValueSemiTransparent = 1
        alphaValueTransparent = 1
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        alphaValueSemiTransparent = 1
        alphaValueTransparent = 1
        backgroundCardsScalePercent = 1
    }
    
    override func frameForCard(at index: Int) -> CGRect {
        
        var frame = super.frameForCard(at: index)
        let hh = frame.height - h - 50
        frame = CGRect(x: 0,
                       y: hh > 0 ? hh : 0,
                       width: w,
                       height: h)
        return frame
    }
}

struct KolodaViewHolder<Content: View>: UIViewRepresentable {
    
    let content: (Int) -> Content
    let moveLeft: (CGFloat) -> Void
    let moveRight: (CGFloat) -> Void
    let onEnd: () -> Void
    
    private var coordinator: Coordinator!
    
    public init(_ content: @escaping (Int) -> Content, moveLeft: @escaping (CGFloat) -> Void, moveRight: @escaping (CGFloat) -> Void, onEnd: @escaping () -> Void) {
        self.content = content
        self.moveLeft = moveLeft
        self.moveRight = moveRight
        self.onEnd = onEnd
        self.coordinator = Coordinator(self)
    }
    
    func makeUIView(context: Context) -> KolodaView {
    
        let view = OwnKoloda(frame: .zero)
        view.delegate = context.coordinator
        view.dataSource = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: KolodaView, context: Context) {
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        
        return coordinator
    }
}


// MARK: - Coordinator

extension KolodaViewHolder {

    
    class Coordinator: KolodaViewDelegate, KolodaViewDataSource {
        
        let parent: KolodaViewHolder
        
        init(_ koloda: KolodaViewHolder) {
            parent = koloda
        }
        
        func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
            
            let view = UIView(frame: koloda.frameForCard(at: index))
            view.backgroundColor = .clear
            view.rotate(angle: index.isMultiple(of: 2) ? 5 : -5)
            view.addSubview(parent.content(index))
            
            return view
        }
        
        func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
            20
        }
        
        func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
            
            UISelectionFeedbackGenerator().selectionChanged()
            parent.onEnd()
        }
        
        func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {
            
            switch direction {
            case .left, .topLeft, .bottomLeft: parent.moveLeft(finishPercentage)
            case .right, .topRight, .bottomRight: parent.moveRight(finishPercentage)
            default: parent.onEnd()
            }
        }
        
        func kolodaPanFinished(_ koloda: KolodaView, card: DraggableCardView) {
            
            parent.onEnd()
        }
    }
}
