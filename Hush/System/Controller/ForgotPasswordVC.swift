//
//  ForgotPasswordVC.swift
//  Hush
//
//  Created by RAVI on 17/01/20.
//  Copyright © 2020 Reveralto. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var lbl_noAccount: UILabel!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var lbl_error: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lbl_error.textColor = UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
        self.txt_email.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let myString:String = "No Account? "
        let myString1:String = "Sign Up Now!"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString + myString1, attributes: nil)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 86.0/255.0, green: 204.0/255.0, blue: 242.0/255.0, alpha: 1.0), range: NSRange(location:myString.count,length:myString1.count))
        // set label Attribute
        self.lbl_noAccount.attributedText = myMutableString
    }
    
    @IBAction func click_signUpNow(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func click_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func click_subMit(_ sender: UIButton) {
//        if self.txt_email.text!.count == 0{
//            self.lbl_error.text = "Enter Email"
//            return
//        }else {
//            if self.isValidEmail(self.txt_email.text!){
//                print("service call")
//            }else{
//                self.lbl_error.text = "Enter Valid Email"
//                return
//            }
//        }
        let vc = self.storyboard?.instantiateViewController(identifier: "resetPasswordVC") as! resetPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK:- validation Function
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
