//
//  StackContainerController.swift
//  TinderStack
//
//  Created by Osama Naeem on 16/03/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import UIKit


class StackContainerView: UIView, SwipeCardsDelegate {

    //MARK: - Properties
    var numberOfCardsToShow: Int = 0
    var cardsToBeVisible: Int = 5
    var cardViews : [SwipeCardView] = []
    var remainingcards: Int = 0
    
    let horizontalInset: CGFloat = 20.0
    let verticalInset: CGFloat = 10.0
    
    var visibleCards: [SwipeCardView] {
        return subviews as? [SwipeCardView] ?? []
    }
    var dataSource: SwipeCardsDataSource? {
        didSet {
            reloadData()
        }
    }
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reloadData() {
        removeAllCardViews()
        guard let datasource = dataSource else { return }
        setNeedsLayout()
        layoutIfNeeded()
        numberOfCardsToShow = datasource.numberOfCardsToShow()
        remainingcards = numberOfCardsToShow
        
        print("remain...\(remainingcards)")
        for i in 0..<min(numberOfCardsToShow,cardsToBeVisible) {
            addCardView(cardView: datasource.card(at: i, from: "add"), atIndex: i)
        }
    }

    //MARK: - Configurations

    private func addCardView(cardView: SwipeCardView, atIndex index: Int) {
        cardView.delegate = self
       addCardFrame(index: index, cardView: cardView)
       
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
        remainingcards -= 1
    }
    
    func addCardFrame(index: Int, cardView: SwipeCardView) {
        var cardViewFrame = bounds
        let horizontalInset = (CGFloat(index) * self.horizontalInset)
        let verticalInset = CGFloat(index) * self.verticalInset
      
        let left = CGFloat(cardView.dataSource!.left)
        cardViewFrame.origin.x = left
       // cardViewFrame.origin.x += horizontalInset
       // cardViewFrame.origin.y -= verticalInset
       // cardViewFrame.size.width += 2 * horizontalInset
        //cardViewFrame.size.height += 2 * verticalInset
       
        cardView.frame = cardViewFrame
        
    }
    
    private func removeAllCardViews() {
        for cardView in visibleCards {
            cardView.removeFromSuperview()
        }
        cardViews = []
    }
    
    func swipeDidEnd(on view: SwipeCardView) {
        guard let datasource = dataSource else { return }
        view.removeFromSuperview()
        print(view.tag)
      
//        if remainingcards > 0 {
            let newIndex = datasource.numberOfCardsToShow() - remainingcards
        addCardView(cardView: datasource.card(at: view.tag, from: "swipe"), atIndex: 4)
            
            for (cardIndex, cardView) in visibleCards.reversed().enumerated() {
                UIView.animate(withDuration: 0.2, animations: {
                cardView.center = self.center
               
                  self.addCardFrame(index: cardIndex, cardView: cardView)
                    self.layoutIfNeeded()
                })
            }

//        }else {
//             
//            for (cardIndex, cardView) in visibleCards.reversed().enumerated() {
//                UIView.animate(withDuration: 0.2, animations: {
//                    cardView.center = self.center
//                    self.addCardFrame(index: cardIndex, cardView: cardView)
//                    self.layoutIfNeeded()
//                })
//            }
//        }
    }
    

}

