//
//  signInWithEmailVC.swift
//  Hush
//
//  Created by RAVI on 17/01/20.
//  Copyright © 2020 Reveralto. All rights reserved.
//

import UIKit

class signInWithEmailVC: UIViewController {

    @IBOutlet weak var lbl_noAccount: UILabel!
    @IBOutlet weak var lbl_error: UILabel!
    @IBOutlet weak var btn_subMit: UIButtonX!
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lbl_error.textColor = UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
        self.txt_email.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.txt_password.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        
        let myString:String = "Forgot Pasword? "
        let myString1:String = "Reset now"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString + myString1, attributes: nil)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 86.0/255.0, green: 204.0/255.0, blue: 242.0/255.0, alpha: 1.0), range: NSRange(location:myString.count,length:myString1.count))
        // set label Attribute
        self.lbl_noAccount.attributedText = myMutableString
    }
    
    @IBAction func click_subMit(_ sender: UIButton) {
        
        if self.txt_email.text!.count == 0{
            self.lbl_error.text = "Enter Email"
            return
        }else if self.txt_password.text!.count == 0{
            self.lbl_error.text = "Enter password"
            return
        }else {
            if self.isValidEmail(self.txt_email.text!){
                print("Service call")
            }else{
                self.lbl_error.text = "Enter valid Email"
                return
            }
        }
        
    }
    
    @IBAction func click_back(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func click_forgotPassword(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK:- validation Function
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
