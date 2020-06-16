//
//  LookingGoodVC.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit
import SwiftUI

class LookingGoodVC: UIViewController {

    @IBOutlet weak var viewFirst: UIView!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var imgViewBack: UIImageView!
    @IBOutlet weak var imgViewFront: UIImageView!
    
    @IBOutlet weak var btnDone: UIButton!
    
    @IBOutlet weak var topBackConst: NSLayoutConstraint!
    @IBOutlet weak var leftBackImgConst: NSLayoutConstraint!
    @IBOutlet weak var leftFrontImgConst: NSLayoutConstraint!
    @IBOutlet weak var topLookingGoodConst: NSLayoutConstraint!
    
    var dismiss: Binding<PresentationMode>?
    var isIphoneX = UIScreen.main.bounds.height > 667 ? true : false
    
    static func create(for image: UIImage, dismiss: Binding<PresentationMode>, completion: (() -> Void)? = nil) -> LookingGoodVC {
        let vc = UIStoryboard(name: "OldFaceDetection", bundle: nil).instantiateViewController(withIdentifier: "LookingGoodVC") as! LookingGoodVC
        vc.userImage = image
        vc.completion = completion
        vc.dismiss = dismiss
        
        return vc
    }
    
    fileprivate var userImage = UIImage()
    fileprivate var completion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (isIphoneX) {
            topBackConst.constant = 0
            leftBackImgConst.constant = 60
            leftFrontImgConst.constant = 60
            topLookingGoodConst.constant = 73
        } else {
            topBackConst.constant = 20
            leftBackImgConst.constant = 80
            leftFrontImgConst.constant = 80
            topLookingGoodConst.constant = 53
        }
        
        imgViewBack.image = userImage
        imgViewFront.image = userImage
        viewFirst.rotate(angle:-23 )
        viewBack.rotate(angle: -10)
        
        btnDone.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        btnDone.layer.borderWidth = 1
        btnDone.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        dismiss?.wrappedValue.dismiss()
    }
    
    @IBAction func actionDone(_ sender: Any) {
        
        completion?()
    }
}
