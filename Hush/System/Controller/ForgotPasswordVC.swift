//
//  ForgotPasswordVC.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lbl_noAccount: UILabel!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var lbl_error: UILabel!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        hidekeyboard()
        self.lbl_error.textColor = UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
        self.txt_email.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let myString:String = "No Account? "
        let myString1:String = "Sign Up Now!"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString + myString1, attributes: nil)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 86.0/255.0, green: 204.0/255.0, blue: 242.0/255.0, alpha: 1.0), range: NSRange(location:myString.count,length:myString1.count))
        // set label Attribute
        self.lbl_noAccount.attributedText = myMutableString
        
        txt_email.delegate = self
        
        //for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: keyboard hide show
       @objc func keyboardWillShow(notification:NSNotification){
           
           var userInfo = notification.userInfo!
           var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
           keyboardFrame = self.view.convert(keyboardFrame, from: nil)
           
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
           contentInset.bottom = keyboardFrame.size.height
           scrollView.contentInset = contentInset
       }
       
       @objc func keyboardWillHide(notification:NSNotification){
           
           let contentInset:UIEdgeInsets = UIEdgeInsets.zero
           scrollView.contentInset = contentInset
       }
    
    @IBAction func click_signUpNow(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "resetPasswordVC") as! resetPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK:- validation Function
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension ForgotPasswordVC : UITableViewDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_email
        {
            txt_email.resignFirstResponder()
        }
        return true
    }
}

