//
//  Re-setpasswordViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/21/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class Re_setpasswordViewController: UIViewController {
    
    @IBOutlet weak var resetemail: UITextField!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var loadingView: UIView!
    
    
    var email: String =  ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Reset btn properties
        btnReset.layer.borderWidth = 1.0
        btnReset.layer.borderColor = UIColor.white.cgColor
        btnReset.layer.cornerRadius = self.btnReset.bounds.height / 2
        //End of reset button
        
        //Cancel btn properties
        cancel.layer.borderWidth = 1.0
        cancel.layer.borderColor = UIColor.white.cgColor
        cancel.layer.cornerRadius = self.cancel.bounds.height / 2
        //End of Cancel button
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ResetPassword(_ sender: Any) {
        
        self.email = self.resetemail.text!
        
        //Get and check email
        if self.email == "" {
        
            print("Enter Email Address..")
        
            let alert = UIAlertController(title: "Warning !", message: "Enter valid email...!", preferredStyle: .alert)
        
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        //End get and check email
        
        //Send password reset link
        
        self.showLoading()
        Auth.auth().sendPasswordReset(withEmail: self.email) { error in
            // ...
            if error != nil {
                
                self.hideLoading()
                print(error?.localizedDescription)
                let alert = UIAlertController(title: "Re-set password error !", message: error?.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                
                let alert = UIAlertController(title: "Password Re-set link send !", message: "Check email for re-setpassword...!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.hideLoading()
                self.dismiss(animated: true, completion: nil)
            }
        }
        //End of Sending EMail
    }
    
    @IBAction func Cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //Loading Ivent
    func showLoading() {
        self.loadingView.alpha = 1.0
        self.view.bringSubviewToFront(self.loadingView)
    }
    
    func hideLoading() {
        self.loadingView.alpha = 0
        self.view.sendSubviewToBack(self.loadingView)
    }
    //End of loading ivent
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
