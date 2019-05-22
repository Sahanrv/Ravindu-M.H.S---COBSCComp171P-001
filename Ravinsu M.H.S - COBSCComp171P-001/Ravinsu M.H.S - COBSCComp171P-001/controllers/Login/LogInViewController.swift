//
//  LogInViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/21/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextFields
import Firebase
import FirebaseAuth
import GoogleSignIn

class LogInViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
   

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var forgetPasswordOutlet: UIButton!
    @IBOutlet weak var signInBtnOutlet: UIButton!
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    @IBOutlet weak var GSIViewOutlet: UIView!
    
    //Variables
    var userName: String = ""
    var psword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Log in btn properties
        signInBtnOutlet.layer.borderWidth = 1.0
        signInBtnOutlet.layer.borderColor = UIColor.white.cgColor
        signInBtnOutlet.layer.cornerRadius = self.signInBtnOutlet.bounds.height / 2
        //End of login button
        
        //Google Sign In
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        //End google sign in
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        
        self.userName = self.email.text!
        self.psword = self.password.text!
        
        
        
        Auth.auth().signIn(withEmail: self.userName,password: self.psword)
        { [weak self] user, error in guard let strongSelf = self else { return }
            
            if error != nil{
                
                let alert = UIAlertController(title: "Login Error", message: error?.localizedDescription, preferredStyle:.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                strongSelf.present(alert, animated: true, completion: nil)
                
            } else{
                
                strongSelf.dismiss(animated: true, completion: nil)
                
            }
            
            // ...
        }

    }
    
    @IBAction func segmentChange(_ sender: Any) {
        
//
        
        switch segmentOutlet.selectedSegmentIndex
        {
        case 0:
            break
        case 1:
            
           self.performSegue(withIdentifier: "signupsegue", sender: nil)
            
        case 2:
            
            cancelBtnClick()
            //
        default:
            break
        }
    }
    
    func cancelBtnClick(){
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to close NIBM COnnect?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            
            exit(0)
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    //Google sign In
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // ...
        if let error = error {
            // ...
            print(error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                print(error)
                let alert = UIAlertController(title: "Login Error!", message: error.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            // User is signed in
            // ...
            self.dismiss(animated: true, completion: nil)
            print(authResult!.user.email!)
        }
        // ...
    }
    
    //End of google sign In
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
