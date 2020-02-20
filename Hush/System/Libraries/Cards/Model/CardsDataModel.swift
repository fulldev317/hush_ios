//
//  cardsDataModel.swift
//  TinderStack
//
//  Created by Osama Naeem on 16/03/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import UIKit
struct CardsDataModel {
    
    var bgColor: UIColor
    var text : String
    var image : String
    var rotate: Int
    var left: Int
    var subtitle: String
      
    init(bgColor: UIColor, text: String,subtitle: String, image: String, rotate: Int, left: Int) {
        self.bgColor = bgColor
        self.text = text
        self.image = image
        self.rotate = rotate
        self.left = left
        self.subtitle = subtitle
    }
}


