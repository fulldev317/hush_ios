//
//  resetPasswordVC.swift
//  Hush
//
//  Created by RAVI on 17/01/20.
//  Copyright © 2020 Reveralto. All rights reserved.
//

import UIKit

class resetPasswordVC: UIViewController {

    @IBOutlet weak var txt_confirmnewPassword: UITextField!
    @IBOutlet weak var txt_newPassword: UITextField!
    @IBOutlet weak var lbl_noAccount: UILabel!
    @IBOutlet weak var lbl_error: UILabel!
    @IBOutlet weak var btn_back: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lbl_error.textColor = UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
        self.txt_newPassword.attributedPlaceholder = NSAttributedString(string:"New Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.txt_confirmnewPassword.attributedPlaceholder = NSAttributedString(string:"Confirm New Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let myString:String = "No Account? "
        let myString1:String = "Sign Up Now!"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString + myString1, attributes: nil)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 86.0/255.0, green: 204.0/255.0, blue: 242.0/255.0, alpha: 1.0), range: NSRange(location:myString.count,length:myString1.count))
        // set label Attribute
        self.lbl_noAccount.attributedText = myMutableString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        self.lbl_noAccount.addGestureRecognizer(tap)
        self.lbl_noAccount.isUserInteractionEnabled = true
    }
    
    @objc func tapFunction() {
        let vc = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func click_subMit(_ sender: UIButton) {
    }
    
    @IBAction func click_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
