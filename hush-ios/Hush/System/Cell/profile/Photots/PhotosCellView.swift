//
//  PhotosCellView.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import Foundation
import UIKit

class PhottosCellView: UICollectionViewCell
{
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        self.img.layer.cornerRadius = 10
        self.img.clipsToBounds = true
    }
}
