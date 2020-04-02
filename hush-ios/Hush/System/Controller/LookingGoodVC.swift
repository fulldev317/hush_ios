//
//  LookingGoodVC.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit

class LookingGoodVC: UIViewController {

    @IBOutlet weak var viewFirst: UIView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var imgViewBack: UIImageView!
    @IBOutlet weak var imgViewFront: UIImageView!
    
    @IBOutlet weak var btnDone: UIButton!
    
    static func create(for image: UIImage) -> LookingGoodVC {
        let vc = UIStoryboard(name: "OldFaceDetection", bundle: nil).instantiateViewController(withIdentifier: "LookingGoodVC") as! LookingGoodVC
        vc.userImage = image
        return vc
    }
    
    fileprivate var userImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgViewBack.image = userImage
        imgViewFront.image = userImage
        viewFirst.rotate(angle:-23 )
        viewBack.rotate(angle: -10)
        
        btnDone.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btnDone.layer.borderWidth = 1
        btnDone.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionDone(_ sender: Any) {
        
        
    }
}
