//
//  SwipeCardView.swift
//  TinderStack
//
//  Created by Osama Naeem on 16/03/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import UIKit

class SwipeCardView : UIView {
   
    //MARK: - Properties
    var swipeView : UIView!
    var shadowView : UIView!
    var imageView: UIImageView!
  
    var label = UILabel()
    var labelSubtitle = UILabel()
    var moreButton = UIButton()
    var msgButton = UIButton()
    var dislikeimg: UIImageView!
    var likeimg: UIImageView!
    
    var delegate : SwipeCardsDelegate?

    var divisor : CGFloat = 0
    let baseView = UIView()

    
    
    var dataSource : CardsDataModel? {
        didSet {
            swipeView.backgroundColor = UIColor.white
            label.text = dataSource?.text
            labelSubtitle.text = dataSource?.subtitle
            guard let image = dataSource?.image else { return }
            imageView.image = UIImage(named: image)
           
            let a: Double = Double(dataSource!.rotate)
            swipeView.transform = CGAffineTransform(rotationAngle: CGFloat(a * (M_PI/360)));
           
            
        }
    }
    
    
    //MARK: - Init
     override init(frame: CGRect) {
        super.init(frame: .zero)
        configureShadowView()
        configureSwipeView()
        configureImageView()
        configurelikeImageView()
        configureDislikeImageView()
      //  configureLabelView()
      //  configuresubLabelView()
      //  configureMoreButton()
       // configureChatButton()
        addPanGestureOnCards()
        configureTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    
    func configureShadowView() {
        shadowView = UIView()
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowRadius = 4.0
        addSubview(shadowView)
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 80).isActive = true
        shadowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func configureSwipeView() {
        swipeView = UIView()
       // swipeView.layer.cornerRadius = 15
        swipeView.clipsToBounds = true
        shadowView.addSubview(swipeView)
        
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.leftAnchor.constraint(equalTo: shadowView.leftAnchor).isActive = true
        swipeView.rightAnchor.constraint(equalTo: shadowView.rightAnchor).isActive = true
        swipeView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor).isActive = true
        swipeView.topAnchor.constraint(equalTo: shadowView.topAnchor).isActive = true
    }
    
    
    func configureImageView() {
        imageView = UIImageView()
        swipeView.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

       imageView.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: swipeView.topAnchor, constant: 30).isActive = true
        imageView.leftAnchor.constraint(equalTo: shadowView.leftAnchor, constant: 30).isActive = true
        imageView.rightAnchor.constraint(equalTo: shadowView.rightAnchor, constant: -30).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: 30).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 440).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height * (50/100))).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width)).isActive = true
    }
    func configureDislikeImageView() {
        dislikeimg = UIImageView()
        swipeView.addSubview(dislikeimg)
        dislikeimg.contentMode = .scaleAspectFit
        dislikeimg.image = UIImage(named: "like")
        dislikeimg.translatesAutoresizingMaskIntoConstraints = false
        dislikeimg.alpha = 0.0
        dislikeimg.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        dislikeimg.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 50).isActive = true
        dislikeimg.widthAnchor.constraint(equalToConstant: 70).isActive = true
        dislikeimg.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    func configurelikeImageView() {
        likeimg = UIImageView()
        swipeView.addSubview(likeimg)
        likeimg.contentMode = .scaleAspectFit
        likeimg.image = UIImage(named: "dislike")
        likeimg.translatesAutoresizingMaskIntoConstraints = false
        likeimg.alpha = 0.0
        likeimg.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        likeimg.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -50).isActive = true
        likeimg.widthAnchor.constraint(equalToConstant: 50).isActive = true
        likeimg.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
//    func configureLabelView() {
//        swipeView.addSubview(label)
//        label.backgroundColor = .white
//        label.textColor = .black
//        label.textAlignment = .left
//        label.font = UIFont.init(name: "SFProDisplay-Thin", size: 30)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.leftAnchor.constraint(equalTo: swipeView.leftAnchor,constant: 50).isActive = true
//        label.rightAnchor.constraint(equalTo: swipeView.rightAnchor).isActive = true
//        label.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 30).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
//    }
//    func configuresubLabelView() {
//           swipeView.addSubview(labelSubtitle)
//           labelSubtitle.backgroundColor = .white
//           labelSubtitle.textColor = .black
//           labelSubtitle.textAlignment = .left
//           labelSubtitle.font = UIFont.init(name: "SFProDisplay-Thin", size: 18)
//           labelSubtitle.translatesAutoresizingMaskIntoConstraints = false
//           labelSubtitle.leftAnchor.constraint(equalTo: label.leftAnchor,constant: 0).isActive = true
//           labelSubtitle.rightAnchor.constraint(equalTo: swipeView.rightAnchor).isActive = true
//           labelSubtitle.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 5).isActive = true
//           labelSubtitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
//       }
//    func configureMoreButton() {
//           swipeView.addSubview(moreButton)
//           moreButton.translatesAutoresizingMaskIntoConstraints = false
//           let image = UIImage(named: "addMore")
//           moreButton.setImage(image, for: .normal)
//           moreButton.tintColor = UIColor.red
//           
//           moreButton.rightAnchor.constraint(equalTo: swipeView.rightAnchor, constant: -50).isActive = true
//           moreButton.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 30).isActive = true
//           moreButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//           moreButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//       
//       }
//    func configureChatButton() {
//        swipeView.addSubview(msgButton)
//        msgButton.translatesAutoresizingMaskIntoConstraints = false
//        let image = UIImage(named: "chat")
//        msgButton.setImage(image, for: .normal)
//        msgButton.tintColor = UIColor.red
//        
//        msgButton.rightAnchor.constraint(equalTo: moreButton.leftAnchor, constant: -20).isActive = true
//        msgButton.topAnchor.constraint(equalTo: moreButton.topAnchor).isActive = true
//        msgButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        msgButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//    
//    }
   

    func configureTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    
    func addPanGestureOnCards() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    //MARK: - Handlers
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        let card = sender.view as! SwipeCardView
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
        
        let distanceFromCenter = ((UIScreen.main.bounds.width / 2) - card.center.x)
        divisor = ((UIScreen.main.bounds.width / 2) / 0.61)
       
        switch sender.state {
        case .ended:
            if (card.center.x) > 400 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x + 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    
                    self.layoutIfNeeded()
                }
                return
            }else if card.center.x < 100 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x - 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                  
                    self.layoutIfNeeded()
                }
                return
            }
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                 card.likeimg.alpha = 0.0
                card.dislikeimg.alpha = 0.0
            
                self.layoutIfNeeded()
            }
        case .changed:
            let rotation = tan(point.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
            if card.center.x <= self.frame.width / 2
            {
                card.likeimg.alpha = 1.0
                card.dislikeimg.alpha = 0.0
            }
            else if card.center.x >= self.frame.width / 2
            {
                card.dislikeimg.alpha = 1.0
                card.likeimg.alpha = 0.0
            }
            else
            {
                 card.likeimg.alpha = 0.0
                card.dislikeimg.alpha = 0.0
            }
        default:
            break
        }
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer){
    }
    
  
}
