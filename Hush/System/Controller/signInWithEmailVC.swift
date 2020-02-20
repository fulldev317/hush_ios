//
//  signInWithEmailVC.swift
//  Hush
//
//  Created by Jeep Worker on 07/02/20.
//  Copyright © 2020 Jeep Worker Ltd. All rights reserved.
//

import UIKit

class signInWithEmailVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var topSpaceConstraints: NSLayoutConstraint!
    @IBOutlet weak var lbl_noAccount: UILabel!
    @IBOutlet weak var lbl_error: UILabel!
    @IBOutlet weak var btn_subMit: UIButtonX!
    
    @IBOutlet weak var txt_email: UITextField!
    
    @IBOutlet weak var txt_password: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidekeyboard()
        setConstraints()
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
        
        txt_email.delegate = self
        txt_password.delegate=self
        
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
    
    func setConstraints()
    {
      if UIDevice().userInterfaceIdiom == .phone{
        switch UIScreen.main.nativeBounds.height{
        case 1136:
          print("iPhone 5 or 5S or 5C")
           topSpaceConstraints.constant = 10
        case 1334:
          print("iPhone 6/6S/7/8")
           topSpaceConstraints.constant = 100
        case 2208:
          print("iPhone 6+/6S+/7+/8+")
          topSpaceConstraints.constant = 150
        case 2436:
          print("iPhone X/Xs")
         
        case 2688:
          print("IPHONE XS_MAX")
         
        case 1792:
          print("IPHONE XR")
          
        default:
          print("defaults")
           
        }
      }
      else
      {
         
      }
    }
    
    @IBAction func click_subMit(_ sender: UIButton) {
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "CardsTabbarViewController") as! CardsTabbarViewController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
//        if self.txt_email.text!.count == 0{
//            self.lbl_error.text = "Enter Email"
//            return
//        }else if self.txt_password.text!.count == 0{
//            self.lbl_error.text = "Enter password"
//            return
//        }else {
//            if self.isValidEmail(self.txt_email.text!){
//                print("Service call")
//            }else{
//                self.lbl_error.text = "Enter valid Email"
//                return
//            }
//        }
        
    }
    
    @IBAction func click_back(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func click_forgotPassword(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK:- validation Function
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension signInWithEmailVC : UITableViewDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
