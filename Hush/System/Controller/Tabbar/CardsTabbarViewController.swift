//
//  CardsTabbarViewController.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit

class CardsTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectedIndex = 2
        
        for item in self.tabBar.items!
        {
            item.title = ""
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    


}
