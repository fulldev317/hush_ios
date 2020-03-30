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
    var userImage = #imageLiteral(resourceName: "image4")
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
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "CardsTabbarViewController") as! CardsTabbarViewController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
