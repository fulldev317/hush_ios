////
////  LoginVC.swift
////  Hush
////
//  Created by Golden Worker on 16/01/20.
//  Copyright © 2020 GoldenWork Ltd. All rights reserved.

//
//import UIKit
//
//class LoginVC: UIViewController {
//
//
//    @IBOutlet weak var imgHeart: UIImageView!
//    @IBOutlet weak var lblHush: UILabel!
//
////    @IBOutlet weak var btnSignup: UIButton!
////    @IBOutlet weak var btnLogin: UIButton!
////
////    @IBOutlet weak var lblInfo: UILabel!
////    @IBOutlet weak var lblTermsConditions: UILabel!
////
////    @IBOutlet weak var constraintSignUpBottom: NSLayoutConstraint! //113.0, 341.0
////    @IBOutlet weak var constraintSocialButtonContainerBottom: NSLayoutConstraint!//19.0, -400.0
////
////    @IBOutlet weak var constraintHeartTop: NSLayoutConstraint!//90.0, 40.0
////    @IBOutlet weak var constraintLoginBottom: NSLayoutConstraint!//38.0, 10.0
////    @IBOutlet weak var constraintTermsBottom: NSLayoutConstraint!//0.0, 10.0
//
//    var isSignupExpanded: Bool = false
//
//    //Social Button
//    @IBOutlet weak var viewSocialButtonContainer: UIView!
//    @IBOutlet weak var btnSignupByEmail: UIButton!
//    @IBOutlet weak var btnSignupByGoogle: UIButton!
//    @IBOutlet weak var btnSignupByFacebook: UIButton!
//    @IBOutlet weak var btnSignupByApple: UIButton!
//    @IBOutlet weak var btnSignupBySnapchat: UIButton!
//    @IBOutlet weak var lbl_noAccount: UILabel!
//
//    //MARK:- Life Cycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.setNeedsStatusBarAppearanceUpdate()
//
//        let myString:String = "No Account? "
//        let myString1:String = "Sign Up Now!"
//        var myMutableString = NSMutableAttributedString()
//        myMutableString = NSMutableAttributedString(string: myString + myString1, attributes: nil)
//        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 86.0/255.0, green: 204.0/255.0, blue: 242.0/255.0, alpha: 1.0), range: NSRange(location:myString.count,length:myString1.count))
//        // set label Attribute
//        self.lbl_noAccount.attributedText = myMutableString
//
//        self.updateUI()
//    }
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//
//    func updateUI(){
//
//        if UIDevice.current.isLessThaniPhoneX {
//            //Older than iPhoneX device.
////            self.constraintHeartTop.constant = 30.0
////            self.constraintLoginBottom.constant = 10.0
////            self.constraintTermsBottom.constant = 10.0
//        }
//
////        self.setInitialSignupButton()
//
////        let attributedInfo = NSAttributedString(string: "We don't post anything on Facebook or Snapchat.", attributes: [NSAttributedString.Key.kern: 0.5])
////        self.lblInfo.attributedText = attributedInfo
//
////        let fullString: String = "By registering and using Hush you agree to\nour Terms & Conditions and Privacy Policy."
////
////        let range1 = (fullString as NSString).range(of: "Terms & Conditions")
////        let range2 = (fullString as NSString).range(of: "Privacy Policy")
////
////        let attributedTermsConditions = NSMutableAttributedString(string: fullString, attributes: [NSAttributedString.Key.kern: 0.5])
////
////        attributedTermsConditions.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
////        attributedTermsConditions.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.white, range: range1)
////
////        attributedTermsConditions.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
////        attributedTermsConditions.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.white, range: range2)
//
////        self.lblTermsConditions.attributedText = attributedTermsConditions
//
//        self.btnSignupByEmail.layer.cornerRadius = 5.0
//        self.btnSignupByEmail.layer.masksToBounds = true
//
//        self.btnSignupByApple.layer.cornerRadius = 5.0
//        self.btnSignupByApple.layer.masksToBounds = true
//
//        self.btnSignupByGoogle.layer.cornerRadius = 5.0
//        self.btnSignupByGoogle.layer.masksToBounds = true
//
//        self.btnSignupBySnapchat.layer.cornerRadius = 5.0
//        self.btnSignupBySnapchat.layer.masksToBounds = true
//
//        self.btnSignupByFacebook.layer.cornerRadius = 5.0
//        self.btnSignupByFacebook.layer.masksToBounds = true
//
//    }
//
//    func setInitialSignupButton(){
//
//        UIView.animate(withDuration: 0.5) {
//            self.imgHeart.image = UIImage(named: "ic_heart_white")
////            self.btnSignup.setImage(UIImage(named: "ic_arrow_white_up"), for: .normal)
////            let titleInsets = UIEdgeInsets(top: 25.0, left: 0, bottom: 0.0, right: 16.0)
////            self.btnSignup.titleEdgeInsets = titleInsets
////            let imageInsets = UIEdgeInsets(top: 0, left: 50.0, bottom: 44.0, right: 0)
////            self.btnSignup.imageEdgeInsets = imageInsets
////            self.btnSignup.alpha = 1.0
//            self.lblHush.isHidden = false
////            self.constraintSignUpBottom.constant = 113.0
//        }
//
//        UIView.animate(withDuration: 1.0) {
//            self.viewSocialButtonContainer.isHidden = true
////            self.constraintSocialButtonContainerBottom.constant = -400.0
//        }
//
//    }
//
//    func setExpandedSignupButton(){
//
//        UIView.animate(withDuration: 0.5) {
//            self.lblHush.isHidden = true
////            self.btnSignup.setImage(UIImage(named: "ic_arrow_white_down"), for: .normal)
//            let titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 25.0, right: 16.0)
////            self.btnSignup.titleEdgeInsets = titleInsets
//            let imageInsets = UIEdgeInsets(top: 44.0, left: 50.0, bottom: 0.0, right: 0)
////            self.btnSignup.imageEdgeInsets = imageInsets
////            self.btnSignup.alpha = 0.5
//            self.imgHeart.image = UIImage(named: "ic_heart_gray")
//
////            if UIDevice.current.isLessThaniPhoneX {
////                self.constraintSignUpBottom.constant = 325.0
////            }else{
////                self.constraintSignUpBottom.constant = 341.0
////            }
//        }
//
//        UIView.animate(withDuration: 1.0) {
////            self.viewSocialButtonContainer.isHidden = false
////            self.constraintSocialButtonContainerBottom.constant = 19.0
//        }
//
//    }
//
//    //MARK:- onSignUp Tap
//    @IBAction func onSignUpTap(_ sender: UIButton){
//
//        self.isSignupExpanded = !self.isSignupExpanded
//
//        if isSignupExpanded {
//            self.setExpandedSignupButton()
//        }else{
//            self.setInitialSignupButton()
//        }
//
//    }
//
//    @IBAction func click_signUpEmail(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "signInWithEmailVC") as! signInWithEmailVC
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}
//
//
//extension UIDevice {
//
//    var isLessThaniPhoneX: Bool {
//        return UIScreen.main.bounds.height <= 736.0
//    }
//
//    var iNotchDevices: Bool {
//        return UIScreen.main.bounds.height == 896.0 || UIScreen.main.bounds.height == 812.0
//    }
//
//}
//
//


//
//  LoginVC.swift
//  Hush
//
//  Created by Golden Worker on 16/01/20.
//  Copyright © 2020 GoldenWork Ltd. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet weak var imgHeart: UIImageView!
    @IBOutlet weak var lblHush: UILabel!
    
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblTermsConditions: UILabel!
    
    @IBOutlet weak var constraintSignUpBottom: NSLayoutConstraint! //113.0, 341.0
    @IBOutlet weak var constraintSocialButtonContainerBottom: NSLayoutConstraint!//19.0, -400.0
    
    @IBOutlet weak var constraintHeartTop: NSLayoutConstraint!//90.0, 40.0
    @IBOutlet weak var constraintLoginBottom: NSLayoutConstraint!//38.0, 10.0
    @IBOutlet weak var constraintTermsBottom: NSLayoutConstraint!//0.0, 10.0
    
    var isSignupExpanded: Bool = false
    
    //Social Button
    @IBOutlet weak var viewSocialButtonContainer: UIView!
    @IBOutlet weak var btnSignupByEmail: UIButton!
    @IBOutlet weak var btnSignupByGoogle: UIButton!
    @IBOutlet weak var btnSignupByFacebook: UIButton!
    @IBOutlet weak var btnSignupByApple: UIButton!
    @IBOutlet weak var btnSignupBySnapchat: UIButton!
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNeedsStatusBarAppearanceUpdate()
        
        let myString:String = "Already have an account? "
        let myString1:String = "Login"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString + myString1, attributes: nil)
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 86.0/255.0, green: 204.0/255.0, blue: 242.0/255.0, alpha: 1.0), range: NSRange(location:myString.count,length:myString1.count))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:myString.count))
        self.btnLogin.setAttributedTitle(myMutableString, for: .normal)
        
        self.updateUI()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func updateUI(){
        
        if UIDevice.current.isLessThaniPhoneX {
            //Older than iPhoneX device.
            self.constraintHeartTop.constant = 30.0
            self.constraintLoginBottom.constant = 10.0
            self.constraintTermsBottom.constant = 10.0
        }
        
        self.setInitialSignupButton()
        
        let attributedInfo = NSAttributedString(string: "We don't post anything on Facebook or Snapchat.", attributes: [NSAttributedString.Key.kern: 0.5])
        self.lblInfo.attributedText = attributedInfo
        
        let fullString: String = "By registering and using Hush you agree to\nour Terms & Conditions and Privacy Policy."
        
        let range1 = (fullString as NSString).range(of: "Terms & Conditions")
        let range2 = (fullString as NSString).range(of: "Privacy Policy")
        
        let attributedTermsConditions = NSMutableAttributedString(string: fullString, attributes: [NSAttributedString.Key.kern: 0.5])
        
        attributedTermsConditions.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        attributedTermsConditions.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.white, range: range1)
        
        attributedTermsConditions.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
        attributedTermsConditions.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.white, range: range2)
        
        self.lblTermsConditions.attributedText = attributedTermsConditions
     
        self.btnSignupByEmail.layer.cornerRadius = 5.0
        self.btnSignupByEmail.layer.masksToBounds = true
        
        self.btnSignupByApple.layer.cornerRadius = 5.0
        self.btnSignupByApple.layer.masksToBounds = true
        
        self.btnSignupByGoogle.layer.cornerRadius = 5.0
        self.btnSignupByGoogle.layer.masksToBounds = true
        
        self.btnSignupBySnapchat.layer.cornerRadius = 5.0
        self.btnSignupBySnapchat.layer.masksToBounds = true
        
        self.btnSignupByFacebook.layer.cornerRadius = 5.0
        self.btnSignupByFacebook.layer.masksToBounds = true
        
    }
    
    func setInitialSignupButton(){
        
        UIView.animate(withDuration: 0.5) {
            self.imgHeart.image = UIImage(named: "ic_heart_white")
            self.btnSignup.setImage(UIImage(named: "ic_arrow_white_up"), for: .normal)
            let titleInsets = UIEdgeInsets(top: 25.0, left: 0, bottom: 0.0, right: 16.0)
            self.btnSignup.titleEdgeInsets = titleInsets
            let imageInsets = UIEdgeInsets(top: 0, left: 50.0, bottom: 44.0, right: 0)
            self.btnSignup.imageEdgeInsets = imageInsets
            self.btnSignup.alpha = 1.0
            self.lblHush.isHidden = false
            self.constraintSignUpBottom.constant = 113.0
        }
        
        UIView.animate(withDuration: 1.0) {
            self.viewSocialButtonContainer.isHidden = true
            self.constraintSocialButtonContainerBottom.constant = -400.0
        }
        
    }
    
    func setExpandedSignupButton(){
        
        UIView.animate(withDuration: 0.5) {
            self.lblHush.isHidden = true
            self.btnSignup.setImage(UIImage(named: "ic_arrow_white_down"), for: .normal)
            let titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 25.0, right: 16.0)
            self.btnSignup.titleEdgeInsets = titleInsets
            let imageInsets = UIEdgeInsets(top: 44.0, left: 50.0, bottom: 0.0, right: 0)
            self.btnSignup.imageEdgeInsets = imageInsets
            self.btnSignup.alpha = 0.5
            self.imgHeart.image = UIImage(named: "ic_heart_gray")
            
            if UIDevice.current.isLessThaniPhoneX {
                self.constraintSignUpBottom.constant = 325.0
            }else{
                self.constraintSignUpBottom.constant = 341.0
            }
        }
        
        UIView.animate(withDuration: 1.0) {
            self.viewSocialButtonContainer.isHidden = false
            self.constraintSocialButtonContainerBottom.constant = 19.0
        }
        
    }
    
    //MARK:- onSignUp Tap
    @IBAction func onSignUpTap(_ sender: UIButton){
        
        self.isSignupExpanded = !self.isSignupExpanded
        
        if isSignupExpanded {
            self.setExpandedSignupButton()
        }else{
            self.setInitialSignupButton()
        }
        
    }

    @IBAction func click_login(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "newLoginVC") as! newLoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func click_signUpByEmail(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "signUpVC") as! signUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension UIDevice {
    
    var isLessThaniPhoneX: Bool {
        return UIScreen.main.bounds.height <= 736.0
    }
    
    var iNotchDevices: Bool {
        return UIScreen.main.bounds.height == 896.0 || UIScreen.main.bounds.height == 812.0
    }
    
}


