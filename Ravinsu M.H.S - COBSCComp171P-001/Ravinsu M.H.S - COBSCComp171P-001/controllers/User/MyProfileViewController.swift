//
//  MyProfileViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/23/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import Alamofire
import Kingfisher

class MyProfileViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userDob: UILabel!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userPhoneNumber: UILabel!
    
    var userData: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set profile image view properties
        self.userImage.layer.cornerRadius = self.userImage.bounds.height / 2
        self.userImage.clipsToBounds = true
        //End of setting profile image view properties
        
        //User Load function Call
        self.LoadUser()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Load user data
    func LoadUser(){
        let userID = Auth.auth().currentUser?.uid
        
        Database.database().reference().child("user/profile/").child(userID!).observeSingleEvent(of: .value, with: {(DataSnapshot) in
            
            print(DataSnapshot)
            if let userProf = DataSnapshot.value as? [String : AnyObject]{
               
                let imgURL = URL(string: userProf["uProfileImage"] as! String)
                self.userImage.kf.setImage(with: imgURL)
                self.userName.text! = userProf["uName"] as! String
                self.userAge.text! = "Age : \(String(userProf["uAge"] as! Int))"
                self.userDob.text! = "Date of birth : \(userProf["uBod"] as! String)"
                self.userPhoneNumber.text! = "Phone Number : \(String(userProf["uPhone"] as! Int))"

            }
        }, withCancel: nil)
        
    }
    //End of load userdata
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
