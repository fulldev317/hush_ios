//
//  newLoginVC.swift
//  Hush
//
//  Created by Ravi Padshala on 21/01/20.
//  Copyright © 2020 Reveralto. All rights reserved.
//

import UIKit

class newLoginVC: UIViewController {

    @IBOutlet weak var lbl_noAccount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func click_signUPMyEmail(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "signInWithEmailVC") as! signInWithEmailVC
        self.navigationController?.pushViewController(vc, animated: true)
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
