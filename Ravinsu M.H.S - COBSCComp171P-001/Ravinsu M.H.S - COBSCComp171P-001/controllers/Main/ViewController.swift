//
//  ViewController.swift
//  Ravinsu M.H.S - COBSCComp171P-001
//
//  Created by Sahan Ravindu on 5/16/19.
//  Copyright © 2019 Sahan Ravindu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

  var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
     //Check User Siged In?
    override func viewWillAppear(_ animated: Bool) {
        Apptempdata.userHandle = Auth.auth().addStateDidChangeListener {(auth, user) in
            
            if user == nil {
                // If the user didn't login
                self.performSegue(withIdentifier: "login", sender: nil)
                
            }
                
            else {
                //If the user has been logged
                self.performSegue(withIdentifier: "home", sender: nil)
                
            }
        }
        
    }
    //End of Checking User Siged In?
    
    //
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(Apptempdata.userHandle!)
    }
    
//

}

