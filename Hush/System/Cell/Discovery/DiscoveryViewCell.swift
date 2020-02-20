//
//  DiscoveryViewCell.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit

class DiscoveryViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var CellImageView: UIImageView!
    
    @IBOutlet weak var CellTitle: UILabel!
    
    @IBOutlet weak var CellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CellView.layer.shadowColor = UIColor.init(red: 224, green: 224, blue: 224, alpha: 1.0).cgColor
        CellView.layer.shadowOpacity = 1
        CellView.layer.shadowOffset = CGSize.zero
        CellView.layer.shadowRadius = 2
        CellView.layer.masksToBounds = true
                self.CellView.transform = CGAffineTransform.init(rotationAngle: CGFloat(-10 * Double.pi/360))
    }
    
    func setRotation(cell: Int)
    {
        let position = cell % 4
        
        if(position == 0)
        {
            CellView.transform = CGAffineTransform.init(rotationAngle: CGFloat(10 * Double.pi/360))
        }else if(position == 1)
        {
            CellView.transform = CGAffineTransform.init(rotationAngle: CGFloat(-10 * Double.pi/360))
        }
        else if(position == 2)
        {
            CellView.transform = CGAffineTransform.init(rotationAngle: CGFloat(-10 * Double.pi/360))
        }
        else if(position == 3)
        {
            CellView.transform = CGAffineTransform.init(rotationAngle: CGFloat(10 * Double.pi/360))
        }
    }
}
