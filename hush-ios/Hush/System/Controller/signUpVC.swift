//
//  signUpVC.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit

class signUpVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txt_name: UITextField!
    @IBOutlet weak var txt_userName: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var lbl_error: UILabel!
    @IBOutlet weak var lbl_noAccount: UILabel!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        hidekeyboard()
        self.lbl_error.textColor = UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
        self.txt_name.attributedPlaceholder = NSAttributedString(string:"Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.txt_userName.attributedPlaceholder = NSAttributedString(string:"Choose a Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.txt_email.attributedPlaceholder = NSAttributedString(string:"Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        self.txt_password.attributedPlaceholder = NSAttributedString(string:"Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        let myString:String = "Already have an account? "
        let myString1:String = "Log In"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString + myString1, attributes: nil)
        let extractedExpr = UIColor(red: 86.0/255.0, green: 204.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: extractedExpr, range: NSRange(location:myString.count,length:myString1.count))
        // set label Attribute
        self.lbl_noAccount.attributedText = myMutableString
        
        txt_name.delegate = self
        txt_userName.delegate = self
        txt_email.delegate = self
        txt_password.delegate = self
        
       //for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //MARK: keyboard hide show
    @objc func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.ScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        ScrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        ScrollView.contentInset = contentInset
    }
    

    @IBAction func click_subMit(_ sender: UIButton) {
        
//        if self.txt_name.text!.count == 0{
//            self.lbl_error.text = "Enter Name"
//            return
//        }else if self.txt_userName.text!.count == 0{
//            self.lbl_error.text = "Enter Username"
//            return
//        }else if self.txt_email.text!.count == 0{
//            self.lbl_error.text = "Enter Email"
//            return
//        }else if self.txt_password.text!.count == 0{
//            self.lbl_error.text = "Enter Password"
//            return
//        }else{
//            if self.isValidEmail(self.txt_email.text!){
//                print("service call")
//            }else{
//                self.lbl_error.text = "Enter Valid Email"
//                return
//            }
//        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "addPhotoVC") as! addPhotoVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func click_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func click_login(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "newLoginVC") as! newLoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- validation Function
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
extension signUpVC : UITableViewDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txt_name
        {
            txt_userName.becomeFirstResponder()
        }
        if textField == txt_userName
        {
            txt_email.becomeFirstResponder()
        }
        if textField == txt_email
        {
            txt_password.becomeFirstResponder()
        }
        if textField == txt_password
               {
                   txt_password.resignFirstResponder()
               }
        return true
    }
}
extension UIViewController {
    func hidekeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
