//
//  CardsViewController.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var bottomView = UIView()
    var label = UILabel()
    var labelSubtitle = UILabel()
    var moreButton = UIButton()
    var msgButton = UIButton()
    
    //MARK: - Properties
    var viewModelData = [CardsDataModel(bgColor: UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0), text: "Tammy29",subtitle:"Los Angeles", image: "image5",rotate: -8,left: -10),
                         CardsDataModel(bgColor: UIColor(red:0.29, green:0.64, blue:0.96, alpha:1.0), text: "Tammy30",subtitle:"Los Angeles", image: "image2", rotate: -20,left: 20),
                         CardsDataModel(bgColor: UIColor(red:0.29, green:0.63, blue:0.49, alpha:1.0), text: "Tammy31",subtitle:"Los Angeles", image: "image3", rotate: 9,left: -15),
                         CardsDataModel(bgColor: UIColor(red:0.69, green:0.52, blue:0.38, alpha:1.0), text: "Tammy32",subtitle:"Los Angeles", image: "image4", rotate: 20,left: 20),
                         CardsDataModel(bgColor: UIColor(red:0.90, green:0.99, blue:0.97, alpha:1.0), text: "Tammy33",subtitle:"Los Angeles", image: "image5", rotate: -30,left: 20)]
    var stackContainer : StackContainerView!
    var titleView: UIStackView!
    //MARK: - Init
       
       override func loadView() {
           view = UIView()
            view.backgroundColor = UIColor.white
           stackContainer = StackContainerView()
           view.addSubview(stackContainer)
           configureStackContainer()
        
           stackContainer.translatesAutoresizingMaskIntoConstraints = false
           
       }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

            configuretitleView()
        ConfigureBottomDetailView()
      //  self.navigationItem.title = "Photo Booth"
        stackContainer.dataSource = self
        
        print((UIScreen.main.bounds.height * (60/100)))
       
    }
    //MARK: - Configurations
       func configureStackContainer() {
           stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 0).isActive = true
           stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20).isActive = true
           stackContainer.widthAnchor.constraint(equalToConstant: 500).isActive = true
           stackContainer.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height * (60/100))).isActive = true
       }
    
    func configuretitleView()
    {
        titleView = UIStackView()
        let lbl1 = UILabel()
        lbl1.text = "Photo"
        lbl1.frame.size = CGSize(width: 122, height: 50)
        lbl1.font = UIFont.init(name: "SFProDisplay-medium", size: 48)
        lbl1.textColor = UIColor.black
        titleView.addArrangedSubview(lbl1)
        let lbl2 = UILabel()
        lbl2.text = "Booth"
        lbl2.frame.size = CGSize(width: 114, height: 50)
        lbl2.font = UIFont.init(name: "SFProDisplay-thin", size: 48)
        lbl2.textColor = UIColor.black
        titleView.addArrangedSubview(lbl2)
        titleView.backgroundColor = UIColor.red
        titleView.frame.size = CGSize(width: lbl1.frame.size.width + lbl2.frame.size.width + 5, height: 50)
        self.view.addSubview(titleView)
        self.view.bringSubviewToFront(titleView)
        
         titleView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 20).isActive = true
        titleView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: (self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleView.widthAnchor.constraint(equalToConstant:  titleView.frame.size.width).isActive = true
    }
    
    func ConfigureBottomDetailView()
    {
        // bottomView = UIView()
        bottomView.backgroundColor = UIColor.clear
       // bottomView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 2 + 100 , width: UIScreen.main.bounds.width, height: 200)
        self.view.addSubview(bottomView)
        self.view.bringSubviewToFront(bottomView)
         bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 0).isActive = true
        bottomView.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: 0).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,constant: 0).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height * (25/100))).isActive = true
        
        configureLabelView()
        configuresubLabelView()
        configureMoreButton()
        configureChatButton()
    }
    
    func configureLabelView() {
           bottomView.addSubview(label)
           label.backgroundColor = .clear
           label.textColor = .black
           label.textAlignment = .left
            label.text = "Tummy 29"
           label.font = UIFont.init(name: "SFProDisplay-Thin", size: 30)
           label.translatesAutoresizingMaskIntoConstraints = false
           label.leftAnchor.constraint(equalTo: bottomView.leftAnchor,constant: 20).isActive = true
           label.rightAnchor.constraint(equalTo: bottomView.rightAnchor).isActive = true
           label.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: 90).isActive = true
           label.heightAnchor.constraint(equalToConstant: 30).isActive = true
       }
       func configuresubLabelView() {
              bottomView.addSubview(labelSubtitle)
              labelSubtitle.backgroundColor = .clear
              labelSubtitle.textColor = .black
              labelSubtitle.textAlignment = .left
             labelSubtitle.text = "Los Angeles"
              labelSubtitle.font = UIFont.init(name: "SFProDisplay-Thin", size: 18)
              labelSubtitle.translatesAutoresizingMaskIntoConstraints = false
              labelSubtitle.leftAnchor.constraint(equalTo: label.leftAnchor,constant: 0).isActive = true
              labelSubtitle.rightAnchor.constraint(equalTo: bottomView.rightAnchor).isActive = true
              labelSubtitle.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 5).isActive = true
              labelSubtitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
          }
       func configureMoreButton() {
              bottomView.addSubview(moreButton)
              moreButton.translatesAutoresizingMaskIntoConstraints = false
              let image = UIImage(named: "addMore")
              moreButton.setImage(image, for: .normal)
              moreButton.addTarget(self, action: #selector(OpenProfile(_:)), for: .touchUpInside)
              moreButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -20).isActive = true
              moreButton.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: 90).isActive = true
              moreButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
              moreButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
          
          }
       func configureChatButton() {
           bottomView.addSubview(msgButton)
           msgButton.translatesAutoresizingMaskIntoConstraints = false
           let image = UIImage(named: "chat")
           msgButton.setImage(image, for: .normal)
           
           msgButton.rightAnchor.constraint(equalTo: moreButton.leftAnchor, constant: -20).isActive = true
           msgButton.topAnchor.constraint(equalTo: moreButton.topAnchor).isActive = true
           msgButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
           msgButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
       
       }
    
    @objc func OpenProfile(_ sender: Any)
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(VC, animated: false)
    }
}

extension CardsViewController : SwipeCardsDataSource {

    func numberOfCardsToShow() -> Int {
        return viewModelData.count
    }
    
    func card(at index: Int,from: String) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = viewModelData[index]
        card.tag = index
        
        if from == "add"
        {
            label.text = viewModelData[0].text
            labelSubtitle.text = viewModelData[0].subtitle
        }
        else
        {
            print(card.tag + 1)
            if card.tag < 4
            {
                label.text = viewModelData[card.tag + 1].text
                           labelSubtitle.text = viewModelData[card.tag + 1].subtitle
            }
            else
            {
                label.text = viewModelData[0].text
                labelSubtitle.text = viewModelData[0].subtitle
            }
           
        }
        return card
    }
    
    func emptyView() -> UIView? {
        return nil
    }
    

}
