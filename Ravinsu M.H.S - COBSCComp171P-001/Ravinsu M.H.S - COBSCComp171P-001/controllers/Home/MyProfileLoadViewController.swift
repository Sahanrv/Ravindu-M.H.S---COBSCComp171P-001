//
//  MyProfileLoadViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/24/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Alamofire
import Kingfisher
import TJBioAuthentication

class MyProfileLoadViewController: UIViewController {

    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var modeDetailsButton: UIButton!
    
    //let IDauth = BiometricIDAuth()
    override func viewDidLoad() {
        super.viewDidLoad()
         LoadUser()
        self.hideKeyboard()
        
        // Do any additional setup after loading the view.
    }
    
    //Load user data
    func LoadUser(){
        let userID = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("user/profile/").child(userID!).observeSingleEvent(of: .value, with: {(DataSnapshot) in
            
            print(DataSnapshot)
            if let userProf = DataSnapshot.value as? [String : AnyObject]{
                
                let imgURL = URL(string: userProf["uProfileImage"] as! String)
                self.profileImage.kf.setImage(with: imgURL)
                self.fullName.text! = userProf["uName"] as! String
                
            }
        }, withCancel: nil)
        
    }
    //End of load userdata
    

    @IBAction func MorDetails(_ sender: Any) {
       // touchIdLoginAction()
       
        TJBioAuthenticator.shared.authenticateUserWithBiometrics(success: {
            // Biometric Authentication success
            //self.showSuccessAlert()
             self.performSegue(withIdentifier: "myprofile", sender: nil)
            self.showSuccessAlert()

            
        }) { (error) in
            // Biometric Authentication unsuccessful
            switch error{
            case .biometryLockedout:
                self.executePasscodeAuthentication()
            default:
                self.presentAlert(withTitle: "Error", message: error.getMessage())
                break
            }
        }
    }
    
    func executePasscodeAuthentication()
    {
        TJBioAuthenticator.shared.authenticateUserWithPasscode(success: {
            //self.showSuccessAlert()
             self.performSegue(withIdentifier: "myprofile", sender: nil)
            
        }) { (error) in
            self.presentAlert(withTitle: "Error", message: error.getMessage())
        }
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
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
extension MyProfileLoadViewController
{
    func showSuccessAlert() {
        DispatchQueue.main.async {
            self.presentAlert(withTitle: "Success", message: "Login successful")
             self.performSegue(withIdentifier: "myprofile", sender: nil)
        }
        
    }
}
extension MyProfileLoadViewController {
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

